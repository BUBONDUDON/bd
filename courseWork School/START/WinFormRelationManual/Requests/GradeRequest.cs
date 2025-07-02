using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WinFormRelationManual.GradeBook
{
    public class GradeRequest
    {
        public int TeacherId { get; set; }

        public int DisciplineId { get; set; }

        public int AcademicGroupId { get; set; }

        public int Month { get; set; }

        public int Year { get; set; }
    }
}
