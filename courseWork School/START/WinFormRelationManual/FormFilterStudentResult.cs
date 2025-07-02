using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WinFormRelationManual
{
    public partial class FormFilterStudentResult : Form
    {
        private DatabaseManager _db;
        private DataTable _table;
        public FormFilterStudentResult(DatabaseManager db)
        {
            InitializeComponent();
            this._db = db;
            //Средний балл студентов каждой группы указанного факультета
            _db.LoadRequestedTable("showFacultyStudentWithAvgMark", "    SELECT\r\n        ACgroup.faculty as [Факультет],\r\n        ACgroup.pulpit as [Кафедра],\r\n        ACgroup.name as [Группа],\r\n        stu.last_name as [Фамилия],\r\n        stu.first_name as [Имя],\r\n        stu.middle_name as [Отчество],\r\n        AVG(CASE \r\n                WHEN gb.mark = 'Н' THEN 2 \r\n                ELSE CAST(gb.mark AS FLOAT) \r\n            END) AS [Средний балл]\r\n    FROM AcademicGroup AS ACgroup\r\n    JOIN Student AS stu ON ACgroup.AcademicGroupId = stu.AcademicGroupId\r\n    LEFT JOIN GradeBook AS gb ON stu.StudentId = gb.StudentId\r\n    GROUP BY \r\n        ACgroup.faculty,\r\n        ACgroup.pulpit,\r\n        ACgroup.name,\r\n        stu.last_name,\r\n        stu.first_name,\r\n        stu.middle_name");
            //Средний балл по каждому предмету
            _db.LoadRequestedTable("showAvgForAllDiscipline", "\tselect\r\n\t\t disci.name as [Дисциплина],\r\n        CAST\r\n\t\t\t(AVG(\r\n\t\t\t\tCASE \r\n\t\t\t\tWHEN gb.mark = 'Н' THEN 2 \r\n\t\t\t\tELSE CAST(gb.mark AS FLOAT) \r\n\t\t\t\tEND\r\n\t\t\t)AS DECIMAL(3,2)) AS [Средний балл]\r\n\tfrom Discipline as disci \r\n\tjoin GradeBook as gb on\r\n\t\tdisci.DisciplineId = gb.DisciplineId\r\n\tgroup by\r\n\t\tdisci.name");
            //Количество студентов факультета, не получающих стипендию, получающих обычную стипендию, с 50 % надбавкой и со 100 % надбавкой
            _db.LoadRequestedTable("showInfoAboutStipendStudent", "SELECT\r\n        AcGroup.faculty as [Факультет],\r\n        COUNT(CASE WHEN stu.stipendId = 1 THEN 1 END) AS [Кол-во студентов без стипендии],\r\n        COUNT(CASE WHEN stu.stipendId = 2 THEN 1 END) AS [Кол-во студентов получающих обычную стипендию],\r\n        COUNT(CASE WHEN stu.stipendId = 3 THEN 1 END) AS [Кол-во студентов с 50% надбавкой],\r\n        COUNT(CASE WHEN stu.stipendId = 4 THEN 1 END) AS [Кол-во студентов со 100% надбавкой]\r\n    FROM AcademicGroup AS AcGroup\r\n    JOIN Student AS stu ON stu.AcademicGroupId = AcGroup.AcademicGroupId\r\n    GROUP BY AcGroup.faculty");
            //По какому предмету больше всего неудовлетворительных оценок?
            _db.LoadRequestedTable("showDisciplineWithWorstAvgMark", "select\r\n\t\tdisci.name as [Дисциплина],\r\n\t\tcount(case \r\n\t\t\twhen gb.mark = '2' then 1\r\n\t\t\twhen gb.mark = 'Н' then 1 end) as [Кол-во неудовлетворительных оценок]\r\n\t\tfrom Discipline as disci\r\n\t\tjoin GradeBook as gb on\r\n\t\t\tdisci.DisciplineId = gb.DisciplineId\r\n\t\tgroup by disci.name");
            //Студенты, обучающиеся на определенной кафедре и не сдавшие хотя бы один экзамен
            _db.LoadRequestedTable("showStudentWithBadMarkForExam", "select\r\n\t\tAcGroup.pulpit as [Кафедра],\r\n\t\tAcGroup.name as [Группа],\r\n\t\tstu.last_name + ' ' +\r\n        stu.first_name+ ' ' +\r\n        stu.middle_name as [ФИО],\r\n\t\tdisci.name as [Дисциплина],\r\n\t\t(case \r\n\t\t\twhen el.assessment_of_knowledge = '2' then '2'\r\n\t\t\twhen el.assessment_of_knowledge = 'Не зачёт' then 'Не зачёт' end) as [Оценка знаний]\r\n\t\tfrom AcademicGroup as AcGroup\r\n\t\tjoin Student as stu on\r\n\t\t\tstu.AcademicGroupId = AcGroup.AcademicGroupId\r\n\t\tjoin ExamLog as el on\r\n\t\t\tel.StudentId = stu.StudentId\r\n\t\tjoin Discipline as disci on\r\n\t\t\tdisci.DisciplineId = el.DisciplineId\r\n\t\tWHERE \r\n\t\t\tel.assessment_of_knowledge NOT IN ('Зачет', '3', '4', '5')");
            //Какой предмет студенты сдали лучше, чем другие предметы?
            _db.LoadRequestedTable("showDisciplineWithBestAvgMark", "SELECT\r\n        disci.name as [Дисциплина],\r\n        CAST(AVG(\r\n                CASE \r\n                    WHEN gb.mark = 'Н' THEN 2 \r\n                    ELSE CAST(gb.mark AS FLOAT) \r\n                END) AS DECIMAL(3,2)) AS [Средняя оценка знаний]\r\n    FROM \r\n        Discipline AS disci\r\n    JOIN \r\n        GradeBook AS gb ON disci.DisciplineId = gb.DisciplineId\r\n    GROUP BY \r\n        disci.name\r\n    HAVING \r\n        AVG(CASE \r\n            WHEN gb.mark = 'Н' THEN 2 \r\n            ELSE CAST(gb.mark AS FLOAT) \r\n        END) = (\r\n            SELECT MAX(AverageMark)\r\n            FROM (\r\n                SELECT \r\n                    AVG(CASE \r\n                        WHEN gb_inner.mark = 'Н' THEN 2 \r\n                        ELSE CAST(gb_inner.mark AS FLOAT) \r\n                    END) AS AverageMark\r\n                FROM \r\n                    GradeBook AS gb_inner\r\n                GROUP BY \r\n                    gb_inner.DisciplineId\r\n            ) AS avgGrades\r\n        )");
            //Список студентов указанной кафедры, которые по итогам сессии могут получать стипендию?
            _db.LoadRequestedTable("showStudentWithStipend", "select\r\n\t\tAcGroup.pulpit as [Кафедра],\r\n\t\tstu.last_name + ' ' +\r\n        stu.first_name+ ' ' +\r\n        stu.middle_name as [ФИО],\r\n\t\t(case when el.assessment_of_knowledge in ('Зачет', '4', '5') then 'Может' end) \r\n\t\t\tas [Может ли студент получать стипендию по итогам сессии ?]\r\n\t\tfrom AcademicGroup as AcGroup\r\n\t\tjoin Student as stu on\r\n\t\t\tstu.AcademicGroupId = AcGroup.AcademicGroupId\r\n\t\tjoin ExamLog as el on\r\n\t\t\tstu.StudentId = el.StudentId\r\n\t\twhere\r\n\t\t\tel.assessment_of_knowledge not in ('Не зачёт', '3', '2', 'Н')");
            _db.SetGridProperties(showInfo_dataGrid);
            columnNames_combobox.SelectedValueChanged += columnNames_combobox_SelectedValueChanged;
        }

        private void SetStatusComboBox(bool isEnabled)
        {
            columnNames_combobox.Items.Clear();
            columnValues_comboBox.Items.Clear();
            columnNames_combobox.Enabled = isEnabled;
            columnValues_comboBox.Enabled = isEnabled;
        }
        private void SetColumnFilter(string[] mas)
        {
            columnNames_combobox.Items.Clear();
            for (int i = 0; i < mas.Length; i++)
            {
                columnNames_combobox.Items.Add(mas[i]);
            }
        }
        private void columnNames_combobox_SelectedValueChanged(object sender, EventArgs e)
        {
            columnValues_comboBox.Items.Clear();
            var uniqueColumnValues = _table
            .AsEnumerable()
            .Select(row => row.Field<string>(columnNames_combobox.SelectedItem.ToString()))
            .Distinct();
            foreach (var value in uniqueColumnValues)
            {
                columnValues_comboBox.Items.Add(value);
            }
        }
        private void columnValues_comboBox_SelectedValueChanged(object sender, EventArgs e)
        {
            if (columnValues_comboBox.SelectedItem != null)
            {
                string selectedFaculty = columnValues_comboBox.SelectedItem.ToString();
                _table.DefaultView.RowFilter = $"{columnNames_combobox.SelectedItem} = '{selectedFaculty}'";
            }
        }
        private void showFacultyStudentWithAvgMark_Click(object sender, EventArgs e)
        {
            var dataTable = _db.GetTable("showFacultyStudentWithAvgMark");
            _table = dataTable;
            SetStatusComboBox(isEnabled: true);
            SetColumnFilter(new string[] { "Факультет", "Группа", });
            // Средний балл студентов каждой группы указанного факультета
            showInfo_dataGrid.DataSource = dataTable.DefaultView;
        }

        private void showAvgForAllDiscipline_Click(object sender, EventArgs e)
        {
            var dataTable = _db.GetTable("showAvgForAllDiscipline");
            SetStatusComboBox(isEnabled: false);
            //Средний балл по каждому предмету
            showInfo_dataGrid.DataSource = dataTable.DefaultView;
        }

        private void showInfoAboutStipendStudent_Click(object sender, EventArgs e)
        {
            var dataTable = _db.GetTable("showInfoAboutStipendStudent");
            SetStatusComboBox(isEnabled: false);
            //Стипендия студентов
            showInfo_dataGrid.DataSource = dataTable.DefaultView;
        }

        private void showDisciplineWithWorstAvgMark_Click(object sender, EventArgs e)
        {
            var dataTable = _db.GetTable("showDisciplineWithWorstAvgMark");
            SetStatusComboBox(isEnabled: false);
            //Количество неудовлетворительных оценок по предметам
            showInfo_dataGrid.DataSource = dataTable.DefaultView;
        }

        private void showStudentWithBadMarkForExam_Click(object sender, EventArgs e)
        {
            var dataTable = _db.GetTable("showStudentWithBadMarkForExam");
            _table = dataTable;
            SetStatusComboBox(isEnabled: true);
            SetColumnFilter(new string[] { "Дисциплина", "Группа", });
            //Студенты с незакрытой сессией
            showInfo_dataGrid.DataSource = dataTable.DefaultView;
        }

        private void showDisciplineWithBestAvgMark_Click(object sender, EventArgs e)
        {
            var dataTable = _db.GetTable("showDisciplineWithBestAvgMark");
            SetStatusComboBox(isEnabled: false);
            //Какой предмет студенты сдали лучше, чем другие предметы?
            showInfo_dataGrid.DataSource = dataTable.DefaultView;
        }

        private void showStudentWithStipend_Click(object sender, EventArgs e)
        {
            var dataTable = _db.GetTable("showStudentWithStipend");
            _table = dataTable;
            SetStatusComboBox(isEnabled: true);
            SetColumnFilter(new string[] { "Кафедра", });
            //Список студентов указанной кафедры, которые по итогам сессии могут получать стипендию?
            showInfo_dataGrid.DataSource = dataTable.DefaultView;
        }

        private void btn_exit_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
