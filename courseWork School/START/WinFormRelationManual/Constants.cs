using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;

namespace WinFormRelationManual
{
    public static class Constants
    {
        public static Dictionary<string, string> ColumnHeaders = new Dictionary<string, string>
        {
            // Академическая группа
            { "name", "Название" },
            { "faculty", "Факультет" },
            { "pulpit", "Кафедра" },
            { "speciality", "Специальность" },
            { "year", "Год" },

            // Стипендия
            { "stipend_name", "Название стипендии" },
            { "amount_payable", "Сумма выплаты" },

            // Студент
            { "last_name", "Фамилия" },
            { "first_name", "Имя" },
            { "middle_name", "Отчество" },
            { "residential_address", "Адрес проживания" },

            // Дисциплина
            { "knowledge_assessment_form", "Форма оценки знаний" },

            // Журнал оценок
            { "date", "Дата" },
            { "mark", "Оценка" },

            // Журнал экзаменов/зачётов
            { "assessment_of_knowledge", "Оценка знаний" },

            // Расписание
            { "ordinalNumber", "Порядковый номер" },
            { "cabinet", "Кабинет" }
        };
        public static string CreatedDate = "CreatedDate";

        public static string Calculated = "Calculated";

        public static class TableGrade
        {
            public static string Name = "GradeBook";
            public static string Id = "GradeId";
        }

        public static class TableExamLog
        {
            public static string Name = "ExamLog";
            public static string Id = "ExamLogId";
        }

        public static class TableStudent
        {
            public static string Name = "Student";
            public static string Id = "StudentId";
        }

        public static class TableTeacher
        {
            public static string Name = "Teacher";
            public static string Id = "TeacherId";
        }

        public static class TableDiscipline
        {
            public static string Name = "Discipline";
            public static string Id = "DisciplineId";
        }

        public static class TableStipend
        {
            public static string Name = "Stipend";
            public static string Id = "StipendId";
        }

        public static class TableGroup
        {
            public static string Name = "AcademicGroup";
            public static string Id = "AcademicGroupId";
        }

        public static class TableSchedule
        {
            public static string Name = "Schedule";
            public static string Id = "ScheduleId";
        }
    }
}
