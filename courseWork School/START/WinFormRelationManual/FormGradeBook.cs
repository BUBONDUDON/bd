using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WinFormRelationManual.GradeBook;

namespace WinFormRelationManual
{
    public partial class FormGradeBook : Form
    {
        private readonly DatabaseManager _db;

        private DataGridViewComboBoxCell _selectorGrade;
        private DataGridViewCell _previousCell;
        private int _previousColumnIndex = -1;
        private int _previousRowIndex = -1;

        private int _teacherId = -1;
        private int _disciplineId = -1;
        private int _academicGroupId = -1;
        private int _selectedYear = -1;
        private int _selectedMonth = -1;

        public FormGradeBook(DatabaseManager db)
        {
            InitializeComponent();
            _db = db;

            selectorTeacher.SetDatabaseManager(_db);
            selectorTeacher.SelectedIdChanged += (id) => { _teacherId = id; RequestDatabase(); };

            selectorDiscipline.SetDatabaseManager(_db);
            selectorDiscipline.SelectedIdChanged += (id) => { _disciplineId = id; RequestDatabase(); };

            selectorAcademicGroup.SetDatabaseManager(_db);
            selectorAcademicGroup.SelectedIdChanged += (id) => { _academicGroupId = id; RequestDatabase(); };

            comboBoxYear.SelectedIndexChanged += (o, e) =>
            {
                var comboBox = (o as ComboBox);
                if (comboBox != null)
                {
                    int.TryParse(
                        comboBox.SelectedItem.ToString(), 
                        out _selectedYear);
                    RequestDatabase();
                }
            };
                 
            comboBoxMonth.SelectedIndexChanged += (o, e) =>
            {
                var comboBox = (o as ComboBox);
                if (comboBox != null)
                    _selectedMonth = comboBox.SelectedIndex + 1;
                RequestDatabase();
            };
        }

        private void RequestDatabase()
        {
            // у нас выбраны все поля
            if (_teacherId > 0 &&
                _disciplineId > 0 &&
                _academicGroupId > 0 &&
                _selectedYear > 0 &&
                _selectedMonth > 0)
            {
                var request = new GradeRequest
                {
                    AcademicGroupId = _academicGroupId,
                    DisciplineId = _disciplineId,
                    Month = _selectedMonth,
                    Year = _selectedYear,
                    TeacherId = _teacherId  
                };
                _db.LoadGradeBook(request);
                PrepareGradeBook(_academicGroupId);
                /*dataGridView1.DataSource =
                    _db.ViewTable( Constants.TableGrade.Name );*/
            }
        }

        private void PrepareGradeBook(int Id)
        {
            var tableGrade = _db
                .GetTable(Constants.TableGrade.Name);

            var students = _db
                .ViewFilter( 
                Constants.TableStudent.Name, 
                $"{Constants.TableGroup.Id}={Id}" );

            dataGridView1.Columns.Clear();
            dataGridView1.Rows.Clear();

            dataGridView1.Columns.Add("Name", "ФИО");
            dataGridView1.Columns["Name"].Width = 200;

            int days = DateTime
                .DaysInMonth(_selectedYear, _selectedMonth);

            // цикл по дням в месяце - заполняем столбцы
            for ( int i = 1; i < days; i++)
            {
                dataGridView1.Columns.Add(
                    i.ToString(), i+"");

                dataGridView1.Columns[i + ""].Width = 30;
            }

            // цикл по студентам, заполняем оценки
            foreach (DataRowView student in students) 
            {
                string name = student[ Constants.Calculated ]
                    .ToString();
                string studentId = student[Constants.TableStudent.Id]
                    .ToString();

                int rowIndex = dataGridView1.Rows.Add(name);

                List<DataRow> rowsWithGrade = tableGrade.Rows
                    .Cast<DataRow>()
                    .Where(r => r["StudentId"].ToString().Equals(studentId))
                    .ToList();

                if (rowsWithGrade.Count > 0)
                {
                    foreach (DataRow rowGrade in rowsWithGrade)
                    {
                        var createdDate = (DateTime)rowGrade["CreatedDate"];
                        int day = createdDate.Day;

                        dataGridView1.Rows[rowIndex].Cells[day].Value =
                            rowGrade["Mark"].ToString();
                    }
                }
            }

            _db.SetGridProperties(dataGridView1);

            dataGridView1.ReadOnly = false;

            dataGridView1.Columns[0].Frozen = true;

            dataGridView1.CellClick 
                += DataGridView1_CellClick;

        }

        private void RestorePrevious()
        {
            if (_previousColumnIndex < 0)
                return;

            if (_selectorGrade != null)
            {
                _previousCell.Value = _selectorGrade.Value;
            }

            // возвращаем исходную ячейку
            if (dataGridView1.Rows[_previousRowIndex]
                .Cells[_previousColumnIndex] != _previousCell)
            {
                dataGridView1.Rows[_previousRowIndex]
                    .Cells[_previousColumnIndex] = _previousCell;

                _previousColumnIndex = -1;
            }
        }

        private void DataGridView1_CellClick(object sender, 
            DataGridViewCellEventArgs e)
        {
            RestorePrevious();

            if (e.ColumnIndex == 0)
                return;

            // запоминаем номер столбца и строки, по которой Клик
            _previousColumnIndex = e.ColumnIndex;
            _previousRowIndex = e.RowIndex;

            // запоминаем ячейку по кот Клик
            _previousCell = dataGridView1
                .Rows[e.RowIndex].Cells[e.ColumnIndex];

            // в эту ячейку вставляем КомбоБокс с оценками
            CreateSelector();
            dataGridView1.Rows[e.RowIndex]
                .Cells[e.ColumnIndex] = _selectorGrade;
        }

        private void CreateSelector()
        {
            _selectorGrade = new DataGridViewComboBoxCell();
            _selectorGrade.Items.Add("н");
            _selectorGrade.Items.Add("1");
            _selectorGrade.Items.Add("2");
            _selectorGrade.Items.Add("3");
            _selectorGrade.Items.Add("4");
            _selectorGrade.Items.Add("5");
        }

        private void buttonAccept_Click(object sender, EventArgs e)
        {
            // преподаватель
            int teacherId = selectorTeacher.SelectedId;
            // дисциплина
            int disciplineId = selectorDiscipline.SelectedId;
            // группа
            int academicGroupId = selectorAcademicGroup.SelectedId;

            // год
            int.TryParse(comboBoxYear.SelectedItem.ToString(),
                out int year);
            // месяц
            int.TryParse((comboBoxMonth.SelectedIndex+1).ToString(),
                out int month);

            var tableGrade = _db
                .GetTable(Constants.TableGrade.Name);

            var students = _db
                .ViewFilter(
                Constants.TableStudent.Name,
                $"{Constants.TableGroup.Id}={academicGroupId}");

            // пробегаем по журналу datagridview
            // цикл по студентам, заполняем оценки
            int rowIndex = 0;
            foreach (DataRowView student in students)
            {
                string studentId = student[Constants.TableStudent.Id]
                    .ToString();

                List<DataRow> rowsWithGrade = tableGrade.Rows
                    .Cast<DataRow>()
                    .Where(r => r["StudentId"].ToString().Equals(studentId))
                    .ToList();

                // для каждого студента пробегаем по столбцам
                // (дни месяца)
                for (int i = 1; i < dataGridView1.Columns.Count; i++) 
                { 
                    // оценку из нашей сетки
                    object markObject = dataGridView1
                        .Rows[rowIndex]
                        .Cells[i].Value;

                    if (markObject == null) 
                        continue; // оценки нет - пропуск

                    string mark = markObject.ToString();

                    // ищем строку из базы для студента
                    var createdDate = new DateTime(year, month, i);
                    // есть ли у студента оценка на эту дату?
                    DataRow row = GetRowOnDate(rowsWithGrade, createdDate);
                    if (row != null)
                    { // оценка есть - ЗАМЕНЯЕМ
                        row["Mark"] = mark; // Update
                    }
                    else
                    { // не было оценки на эту - добавляем
                        row = tableGrade.NewRow();
                        row[Constants.TableStudent.Id] = studentId;
                        row[Constants.TableDiscipline.Id] = disciplineId;
                        row[Constants.TableTeacher.Id] = teacherId;
                        row[Constants.CreatedDate] = createdDate;
                        row["Mark"] = mark;
                        tableGrade.Rows.Add(row); // Insert
                    }
                }

                rowIndex++;
            }

            if (_db.SendTableToServer(
                Constants.TableGrade.Name, Constants.TableGrade.Id))
            {
                MessageBox.Show("Успешно Отправлено!");
                Close();
            }
        }

        private DataRow GetRowOnDate(
            List<DataRow> rowsWithGrade, DateTime createdDate)
        {
            foreach (DataRow row in rowsWithGrade)
            {
                DateTime date = (DateTime) row[Constants.CreatedDate];
                
                // сравниваем только год, месяц, день - время игнорим
                if (date.Date == createdDate.Date)
                {
                    // нашли у студента оценку за эту дату
                    return row;
                }
            }
            // не нашли оценку за эту дату
            return null;
        }
    }
}
