using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WinFormRelationManual.Helpers;

namespace WinFormRelationManual
{
    public partial class FormCommonDictionaryEditor : Form
    {
        private List<Control> _editFields;
        private readonly DatabaseManager _db;
        private readonly string _tableName;
        private readonly string _idName;

        private DataGridViewRow _selectedRow;

        private bool HasSelectedRow(bool showWarning = true)
        {
            if (dataGridView1.SelectedRows.Count > 0)
            {
                _selectedRow = dataGridView1.SelectedRows[0];
                return true;
            }

            if (showWarning)
                MessageBox.Show("Выберите строку в таблице!");

            return false;
        }

        public FormCommonDictionaryEditor(
            DatabaseManager db, string tableName, string idName)
        {
            InitializeComponent();
            this._db = db;
            this._tableName = tableName;
            this._idName = idName;

            _editFields = ComponentsHelper
                .CreateEditFields(
                _db,
                groupBox1, 
                _db.GetTableColumns(_tableName, _idName));

            dataGridView1.DataSource = _db
                .ViewTable(_tableName);
            _db.SetGridProperties(dataGridView1);
            dataGridView1.SelectionChanged += DataGridView1_SelectionChanged;
        }

        private void DataGridView1_SelectionChanged(object sender, EventArgs e)
        {
            if (!HasSelectedRow(showWarning: false)) return;

            ComponentsHelper.CopyDataToEditFields(
                _selectedRow, _editFields);
        }

        private void buttonSendToServer_Click(object sender, EventArgs e)
        {
            _db.SendTableToServer(
                _tableName,
                _idName);

            MessageBox.Show("Отправлено успешно!");
        }

        private void buttonCancel_Click(object sender, EventArgs e)
        {
            _db.CancelChanges(_tableName);
        }

        private void buttonAdd_Click(object sender, EventArgs e)
        {
            _db.AddNewRow(_tableName, _editFields);
        }

        private void buttonUpdate_Click(object sender, EventArgs e)
        {
            if (!HasSelectedRow(showWarning:true)) return;

            _db.UpdateRow(_tableName, 
                _selectedRow.Index, 
                _editFields);
        }

        private void buttonRemove_Click(object sender, EventArgs e)
        {
            if (! HasSelectedRow(showWarning:true)) return; 

            _db.DeleteRow(_tableName, _selectedRow.Index);
        }
    }
}
