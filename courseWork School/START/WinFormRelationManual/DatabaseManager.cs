using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Linq;
using WinFormRelationManual.GradeBook;
using WinFormRelationManual.Helpers;

namespace WinFormRelationManual
{
    public class DatabaseManager
    {
        protected Dictionary<Type, SqlDbType> _mapTypes = new Dictionary<Type, SqlDbType>
            {
                { typeof(int), SqlDbType.Int },
                { typeof(long), SqlDbType.BigInt },
                { typeof(string), SqlDbType.NVarChar },
                { typeof(DateTime), SqlDbType.DateTime },
            };

        /// <summary>
        /// строка подключения
        /// </summary>
        protected string _connectionString;

        /// <summary>
        /// Локальный кэш для хранения таблиц
        /// </summary>
        protected DataSet _dataSet;

        /// <summary>
        /// Адаптер - для запроса на сервер и синхронизации
        /// </summary>
        protected SqlDataAdapter _dataAdapter;

        /// <summary>
        /// канал связи с сервером
        /// </summary>
        protected SqlConnection _sqlConnection;

        public void AddItemsTo(string tableName, ComboBox groupList_comboBox)
        {
            // Получаем таблицу по имени
            var table = GetTable(tableName) ?? throw new ArgumentException($"Таблица с именем {tableName} не найдена.");

            // Очищаем текущие элементы в comboBox
            groupList_comboBox.Items.Clear();

            // Устанавливаем DisplayMember и ValueMember для comboBox
            groupList_comboBox.DisplayMember = "name"; // Имя столбца для отображения
            groupList_comboBox.ValueMember = tableName + "Id"; // Имя столбца для значения
            groupList_comboBox.Items.Add(new
            {
                Id = 0, // Или любое другое значение, которое будет использоваться для "Все группы"
                Name = "Все группы"
            });
            // Добавляем строки из таблицы в comboBox
            foreach (DataRow row in table.Rows)
            {
                // Создаем объект для добавления в comboBox
                var item = new
                {
                    Id = row[tableName + "Id"], // Идентификатор
                    Name = row["name"] // Название академической группы
                };

                // Добавляем элемент в comboBox
                groupList_comboBox.Items.Add(item);
            }
        }
        public void LoadGradeBook(GradeRequest request)
        {
            // 2025-02-01
            string dateStart = $"{request.Year}-{request.Month}-01";
            int day = DateTime.DaysInMonth(request.Year, request.Month);
            // 2025-02-28
            string dateEnd = $"{request.Year}-{request.Month}-{day}";
            string query =
                $@"select * from dbo.GradeBook Where 
                DisciplineId={request.DisciplineId} and 
                TeacherId={request.TeacherId} and
                cast(CreatedDate as date) >= '{dateStart}' and 
                cast(CreatedDate as date) <= '{dateEnd}' and
                StudentId in 
                (select StudentId from dbo.AcademicGroup 
                where AcademicGroupId={request.AcademicGroupId})";
            _sqlConnection.Open();

            // создаём запрос на выборку данных с сервера
            _dataAdapter.SelectCommand =
                new SqlCommand(query, _sqlConnection);

            // создаём таблицу для хранения ВЫБОРКИ
            var table = new DataTable(Constants.TableGrade.Name);

            // Выборку с сервера сохраняем в таблицу
            _dataAdapter.Fill(table);

            // если уже есть таблица с журналом - удаляем
            if (_dataSet.Tables.Contains(Constants.TableGrade.Name))
            {
                _dataSet.Tables.Remove(Constants.TableGrade.Name);
            }

            // таблицу добавляем в локальное хранилище
            _dataSet.Tables.Add(table);

            // завкрываем соединение
            _sqlConnection.Close();

        }

        public void AddCalculatedColumn(string tableName, List<string> names)
        {
            var table = _dataSet.Tables[tableName];

            // добавляем "Вычисляемый столбец"
            table.Columns.Add(new DataColumn(Constants.Calculated));

            // цикл - заполняем вычисляемый столбец
            foreach (DataRow row in table.Rows)
            {
                string value = string
                    .Join(" ", names.Select(x => row[x]));

                row[Constants.Calculated] = value;
            }
        }

        public DatabaseManager(string connection)
        {
            _connectionString = connection;
            _dataSet = new DataSet();
            _sqlConnection = new SqlConnection(connection);
            _dataAdapter = new SqlDataAdapter();
        }

        /// <summary>
        /// Загрузка таблицы с сервера 
        /// в локальный кэш
        /// </summary>
        public void LoadTable(string tableName)
        {
            // открываем соединение
            _sqlConnection.Open();

            // создаём запрос на выборку данных с сервера
            _dataAdapter.SelectCommand =
                new SqlCommand(
                $"select * from {tableName}",
                _sqlConnection);

            // создаём таблицу для хранения ВЫБОРКИ
            var table = new DataTable(tableName);

            // Выборку с сервера сохраняем в таблицу
            _dataAdapter.Fill(table);

            // таблицу добавляем в локальное хранилище
            _dataSet.Tables.Add(table);

            // завкрываем соединение
            _sqlConnection.Close();
        }

        public void LoadRequestedTable(string tableName, string request)
        {
            _sqlConnection.Open();
            _dataAdapter.SelectCommand = new SqlCommand(request, _sqlConnection);
            var table = new DataTable(tableName);
            _dataAdapter.Fill(table);
            _dataSet.Tables.Add(table);
            _sqlConnection.Close();
        }

        public DataView ViewTable(string tableName)
        {
            var table = _dataSet.Tables[tableName];

            return table.DefaultView;
        }

        public DataTable GetTable(string tableName)
        {
            var table = _dataSet.Tables[tableName];

            return table;
        }

        public DataView ViewFilter(string tableName, string filter)
        {
            var table = _dataSet.Tables[tableName];
            var view = table.DefaultView;

            view.RowFilter = filter;

            return view;
        }

        public void SetGridProperties(DataGridView grid)
        {
            grid.AllowUserToDeleteRows = false;
            grid.AllowUserToAddRows = false;
            grid.ReadOnly = true;
            grid.SelectionMode = DataGridViewSelectionMode
                .FullRowSelect;

            grid.MultiSelect = false;

            // прячем вычисляемый столбец
            var c = grid.Columns[Constants.Calculated];
            if (c != null) c.Visible = false;
        }

        private void PrepareHeaderTextColumns(string tableName, DataGridView dataGridView)
        {
            DataTable table = GetTable(tableName) ?? throw new ArgumentException($"Таблица с именем {tableName} не найдена.");

            foreach (DataColumn column in table.Columns)
            {
                if (Constants.ColumnHeaders.TryGetValue(column.ColumnName, out string headerText))
                {
                    if (dataGridView.Columns[column.ColumnName] != null)
                    {
                        dataGridView.Columns[column.ColumnName].HeaderText = headerText;
                    }
                }
            }
        }

        public void PrepareColumnsTable(DataGridView grid, string tableName)
        {
            if (tableName == Constants.TableGroup.Name)
            {
                grid.Columns[Constants.TableGroup.Id].Visible = false;
                PrepareHeaderTextColumns(tableName, grid);
            }
            else
            if (tableName == Constants.TableStudent.Name)
            {
                grid.Columns[Constants.TableStudent.Id].Visible = false;
                PrepareHeaderTextColumns(tableName, grid);

                //Группа
                grid.Columns[Constants.TableGroup.Id].Visible = false;
                grid.Columns.Insert(0, new DataGridViewTextBoxColumn
                {
                    Name = "GroupName",
                    HeaderText = "Группа"
                });

                DataTable groupTable = GetTable(Constants.TableGroup.Name);
                foreach (DataGridViewRow row in grid.Rows)
                {
                    if (row.Cells["AcademicGroupId"].Value != null)
                    {
                        int groupId = Convert.ToInt32(row.Cells["AcademicGroupId"].Value);
                        DataRow[] groupRows = groupTable.Select($"AcademicGroupId = {groupId}");
                        if (groupRows.Length > 0)
                            row.Cells["GroupName"].Value = groupRows[0]["name"].ToString();
                    }
                }
                //Стипендия
                grid.Columns["stipendId"].Visible = false;
                grid.Columns.Add("StipendName", "Стипендия");

                DataTable stipendTable = GetTable(Constants.TableStipend.Name);
                foreach (DataGridViewRow row in grid.Rows)
                {
                    if (row.Cells["stipendId"].Value != null)
                    {
                        int stipendId = Convert.ToInt32(row.Cells["stipendId"].Value);
                        DataRow[] stipendRows = stipendTable.Select($"StipendId = {stipendId}");

                        if (stipendRows.Length > 0)
                        {
                            row.Cells["StipendName"].Value = stipendRows[0]["name"].ToString();
                        }
                        else
                        {
                            row.Cells["StipendName"].Value = "Неизвестно";
                        }
                    }
                    else
                    {
                        row.Cells["StipendName"].Value = "Не указано";
                    }
                }
            }
        }

        /// <summary>
        /// Универсальный метод обновления строки в таблице
        /// </summary>
        /// <param name="tableName">имя таблицы</param>
        /// <param name="rowIndex">индекс строки</param>
        /// <param name="editFields">поля редактирования</param>
        public void UpdateRow(string tableName, int rowIndex, List<Control> editFields)
        {
            var table = _dataSet.Tables[tableName];
            var row = table.Rows[rowIndex];

            ComponentsHelper.CopyDataFromEditFields(
                editFields, row);
        }

        public void DeleteRow(string tableName, int rowIndex)
        {
            var table = _dataSet.Tables[tableName];
            var row = table.Rows[rowIndex];
            row.Delete();
        }

        /// <summary>
        /// Универсальный метод добавления строки в таблицу
        /// </summary>
        /// <param name="tableName">имя таблицы</param>
        /// <param name="editFields">поля редактирования</param>
        public void AddNewRow(string tableName, List<Control> editFields)
        {
            var table = _dataSet.Tables[tableName];
            var row = table.NewRow();

            ComponentsHelper.CopyDataFromEditFields(
                editFields, row);

            table.Rows.Add(row);
        }

        public List<DataColumn> GetTableAllColumns(string tableName)
        {
            var table = _dataSet.Tables[tableName];

            var columns = table
                .Columns
                .OfType<DataColumn>()
                .AsEnumerable()
                .Select(c => c) // целиком весь столбец
                .ToList();

            return columns;
        }

        public List<DataColumn> GetTableColumns(string tableName, string idName)
        {
            var table = _dataSet.Tables[tableName];

            var columns = table
                .Columns
                .OfType<DataColumn>()
                .AsEnumerable()
                .Where(c => c.ColumnName != idName) // не брать АйДи
                                                    // вычисляемый столбец игнорим
                .Where(c => c.ColumnName != Constants.Calculated)
                .Select(c => c) // целиком весь столбец
                .ToList();

            return columns;
        }

        private List<SqlParameter> GetCommonParameters(DataTable table, string idName)
        {
            var parameters = new List<SqlParameter>();
            var columns = GetTableColumns(table.TableName, idName);

            foreach (var c in columns)
            {
                var param = new SqlParameter();
                param.ParameterName = "@" + c.ColumnName;
                param.SourceColumn = c.ColumnName;
                param.Direction = ParameterDirection.Input;
                param.SqlDbType = _mapTypes[c.DataType];

                parameters.Add(param);
            }
            return parameters;
        }

        private SqlCommand GetCommonInsertCommand(string tableName, string idName)
        {
            var table = _dataSet.Tables[tableName];
            string commandText = $"insert into {tableName} ";

            var columnNames = GetCommonColumnNames(table, idName);

            commandText += $"({string.Join(", ", columnNames)}) ";
            commandText += "values ";
            commandText += $"(@{string.Join(", @", columnNames)}); ";
            commandText += "select @id = SCOPE_IDENTITY()";

            var insertCommand = new SqlCommand(commandText, _sqlConnection);

            var parameters = GetCommonParameters(table, idName);
            insertCommand.Parameters.AddRange(parameters.ToArray());
            insertCommand.Parameters.Add(GetCommonIdParameter(idName, ParameterDirection.Output));

            return insertCommand;
        }

        private SqlParameter GetCommonIdParameter(string idName, ParameterDirection direction)
        {
            return new SqlParameter
            {
                ParameterName = "@id",
                SourceColumn = idName,
                SqlDbType = SqlDbType.Int,
                Direction = direction
            };
        }

        public List<string> GetCommonColumnNames(DataTable table, string idName)
        {
            return table.Columns
                .OfType<DataColumn>()
                .AsEnumerable()
                .Where(c => c.ColumnName != idName) // не брать АйДи
                                                    // вычисляемый столбец игнорим
                .Where(c => c.ColumnName != Constants.Calculated)
                .Select(c => c.ColumnName)
                .ToList();
        }

        private SqlCommand GetCommonUpdateCommand(string tableName, string idName)
        {
            var table = _dataSet.Tables[tableName];
            string commandText = $"Update {tableName} Set ";

            var columnNames = GetCommonColumnNames(table, idName);

            commandText += string.Join(", ",
                columnNames.Select(s => $"{s} = @{s}"));
            commandText += $" where {idName} = @id";

            var updateCommand = new SqlCommand(commandText, _sqlConnection);
            var parameters = GetCommonParameters(table, idName);
            updateCommand.Parameters.AddRange(parameters.ToArray());

            updateCommand.Parameters.Add(GetCommonIdParameter(idName, ParameterDirection.Input));

            return updateCommand;
        }

        private SqlCommand GetCommonDeleteCommand(string tableName, string idName)
        {
            // создаём команду удаления
            var deleteCommand = new SqlCommand(
                $"delete {tableName} where {idName}=@id",
                _sqlConnection);

            // добавить в команду Переменные
            deleteCommand.Parameters.Add(
                GetCommonIdParameter(idName, ParameterDirection.Input));

            return deleteCommand;
        }

        /// <summary>
        /// Универсальный метод отправки изменений в таблице на сервер!
        /// </summary>
        /// <param name="tableName">имя таблицы</param>
        /// <param name="idName">имя столбца PK</param>
        public bool SendTableToServer(string tableName, string idName)
        {
            bool resultOk = false;
            try
            {
                // находим в лок кэше таблицу
                var table = _dataSet
                    .Tables[tableName];
                // открываем соединение с сервером
                _sqlConnection.Open();
                // прикрепляем команду к адаптеру
                _dataAdapter.InsertCommand =
                    GetCommonInsertCommand(tableName, idName);
                _dataAdapter.DeleteCommand =
                    GetCommonDeleteCommand(tableName, idName);
                _dataAdapter.UpdateCommand =
                    GetCommonUpdateCommand(tableName, idName);
                // отправляем изменения на сервер
                _dataAdapter.Update(table);
                // закрываем 
                _sqlConnection.Close();

                resultOk = true;
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    "Перехвачена ошибка, обратитесь к системному админу!" +
                    ex.ToString());
            }

            return resultOk;
        }

        public void CancelChanges(string tableName)
        {
            _dataSet.Tables[tableName]
                .RejectChanges();
        }
    }
}
