using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;
using System.Reflection;
using WinFormRelationManual.Properties;
using WinFormRelationManual.Helpers;

namespace WinFormRelationManual
{
    public partial class Form1 : Form
    {
        private DatabaseManager _db;

        public Form1()
        {
            InitializeComponent();
            string connectionString = ConfigurationManager
                .ConnectionStrings["demo28ConnectionString"]
                .ToString();

            _db = new DatabaseManager(connectionString);

            dictionaryMenuItem.Enabled = false;
            btnGradeBook.Enabled = false;
            btnExamLog.Enabled = false;
            btnStudentResult.Enabled = false;
        }

        private void buttonLoad_Click(object sender, EventArgs e)
        {
            _db.LoadTable(Constants.TableGroup.Name);
            _db.LoadTable(Constants.TableStudent.Name);
            _db.LoadTable(Constants.TableTeacher.Name);
            _db.LoadTable(Constants.TableDiscipline.Name);
            _db.LoadTable(Constants.TableStipend.Name);
            _db.LoadTable(Constants.TableExamLog.Name);
            _db.LoadTable(Constants.TableSchedule.Name);
            _db.AddItemsTo(Constants.TableGroup.Name, groupList_comboBox);
            _db.AddCalculatedColumn(
                Constants.TableTeacher.Name,
                new List<string> { "last_name", "first_name", "middle_name" });

            _db.AddCalculatedColumn(
                Constants.TableStudent.Name,
                new List<string> { "last_name", "first_name", "middle_name" });

            dataGridView1.DataSource = _db.ViewTable(Constants.TableGroup.Name);
            dataGridView2.DataSource = _db.ViewTable(Constants.TableStudent.Name);

            _db.SetGridProperties(dataGridView1);
            _db.SetGridProperties(dataGridView2);

            _db.PrepareColumnsTable(dataGridView1, Constants.TableGroup.Name);
            _db.PrepareColumnsTable(dataGridView2, Constants.TableStudent.Name);
            buttonLoad.Enabled = false;
            dictionaryMenuItem.Enabled = true;
            btnGradeBook.Enabled = true;
            btnExamLog.Enabled = true;
            btnStudentResult.Enabled = true;
            dataGridView1.SelectionChanged += DataGridView1_SelectionChanged;
            groupList_comboBox.SelectedIndexChanged += GroupList_comboBox_SelectedIndexChanged;
        }

        private void GroupList_comboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Получаем выбранный элемент из comboBox
            var selectedItem = groupList_comboBox.SelectedItem;

            if (selectedItem != null)
            {
                // Получаем значение Id выбранной группы
                var selectedGroupId = (selectedItem.GetType().GetProperty("Id")?.GetValue(selectedItem, null)).ToString();

                if (selectedGroupId == "0") // Если выбрана "Все группы"
                {
                    // Показываем всех студентов
                    dataGridView2.DataSource = _db.ViewTable(Constants.TableStudent.Name);
                }
                else
                {
                    dataGridView1.DataSource = _db.ViewFilter(
                        Constants.TableGroup.Name, 
                        $"{Constants.TableGroup.Id}={selectedGroupId}");
                    // Показываем студентов, относящихся к выбранной группе
                    dataGridView2.DataSource = _db.ViewFilter(
                        Constants.TableStudent.Name,
                        $"{Constants.TableGroup.Id}={selectedGroupId}"
                    );
                }
            }
            else
            {
                // Если ничего не выбрано, показываем всех студентов
                dataGridView2.DataSource = _db.ViewTable(Constants.TableStudent.Name);
            }
        }

        private void DataGridView1_SelectionChanged(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count == 0)
                return;

            // первую из выбранных в таблице Строку
            var gridRow = dataGridView1.SelectedRows[0];

            string groupId = gridRow
                .Cells[Constants.TableGroup.Id]
                .Value
                .ToString();

            if (!string.IsNullOrEmpty(groupId))
            {
                // Обновляем comboBox, чтобы отобразить выбранную группу
                groupList_comboBox.SelectedItem = groupList_comboBox.Items
                    .Cast<dynamic>()
                    .FirstOrDefault(item => item.Id.ToString() == groupId);

                // Показываем студентов, относящихся к выбранной группе
                dataGridView2.DataSource = _db.ViewFilter(
                    Constants.TableStudent.Name,
                    $"{Constants.TableGroup.Id}={groupId}"
                );
            }
            else
            {
                // Если группа не выбрана, показываем всех студентов
                groupList_comboBox.SelectedIndex = -1; // Сбрасываем выбор в comboBox
                dataGridView2.DataSource = _db.ViewTable(Constants.TableStudent.Name);
            }
        }

        private void studentsMenuItem_Click(object sender, EventArgs e)
        {
            _db.ViewFilter(Constants.TableStudent.Name, "");

            var formEdit = new 
                FormCommonDictionaryEditor(_db, 
                Constants.TableStudent.Name,
                Constants.TableStudent.Id);

            formEdit.ShowDialog();
        }

        private void groupsMenuItem_Click(object sender, EventArgs e)
        {
            dataGridView1.ClearSelection();

            var formEdit = new
                FormCommonDictionaryEditor(_db,
                Constants.TableGroup.Name,
                Constants.TableGroup.Id);

            formEdit.ShowDialog();
        }

        private void teacherMenuItem_Click(object sender, EventArgs e)
        {
            dataGridView1.ClearSelection();

            var formEdit = new
                FormCommonDictionaryEditor(_db,
                Constants.TableTeacher.Name,
                Constants.TableTeacher.Id);

            formEdit.ShowDialog();
        }

        private void disciplineMenuItem_Click(object sender, EventArgs e)
        {
            dataGridView1.ClearSelection();

            var formEdit = new
                FormCommonDictionaryEditor(_db,
                Constants.TableDiscipline.Name,
                Constants.TableDiscipline.Id);

            formEdit.ShowDialog();
        }
        private void stipendMenuItem_Click(object sender, EventArgs e)
        {
            dataGridView1.ClearSelection();
            var formEdit = new
                FormCommonDictionaryEditor(_db,
                Constants.TableStipend.Name,
                Constants.TableStipend.Id);

            formEdit.ShowDialog();
        }

        private void btnGradeBook_Click(object sender, EventArgs e)
        {
            var form = new FormGradeBook(_db);
            form.ShowDialog();
        }

        private void btnExamLog_Click(object sender, EventArgs e)
        {
            var formEdit = new
                FormCommonDictionaryEditor(_db,
                Constants.TableExamLog.Name,
                Constants.TableExamLog.Id);

            formEdit.ShowDialog();
        }

        private void btnStudentResult_Click(object sender, EventArgs e)
        {
            var form = new FormFilterStudentResult(_db);
            form.ShowDialog();
        }
    }
}
