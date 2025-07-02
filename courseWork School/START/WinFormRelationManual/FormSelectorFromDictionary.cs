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
    public partial class FormSelectorFromDictionary : Form
    {
        private readonly DatabaseManager _db;
        private readonly string _tableName;

        private DataGridViewRow _selectedRow;

        public DataGridViewRow SelectedRow 
            => _selectedRow;

        public FormSelectorFromDictionary(
            DatabaseManager db, string tableName)
        {
            InitializeComponent();

            _db = db;
            _tableName = tableName;
            dataGridView1.DataSource = _db.ViewTable(_tableName);
            _db.SetGridProperties(dataGridView1);

            dataGridView1.SelectionChanged += DataGridView1_SelectionChanged;
            dataGridView1.DoubleClick += DataGridView1_DoubleClick;
        }

        private void DataGridView1_DoubleClick(object sender, EventArgs e)
        {
            this.Close();
        }

        private void DataGridView1_SelectionChanged(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count > 0)
            {
                _selectedRow = dataGridView1.SelectedRows[0];
            }
        }
    }
}
