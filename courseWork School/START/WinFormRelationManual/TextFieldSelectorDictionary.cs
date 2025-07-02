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
    public partial class TextFieldSelectorDictionary 
        : UserControl
    {
        /// <summary>
        /// Событие - изменение выбранного АйДи
        /// </summary>
        public event Action<int> SelectedIdChanged;

        private DatabaseManager _db;
        private int _selectedId = -1;

        public int SelectedId => _selectedId;

        public string TableName { get; set; }

        public string Header
        {
            get => label1.Text;
            set => label1.Text = value;
        }

        public void SetDatabaseManager(DatabaseManager db)
        {
            _db = db;
        }

        public TextFieldSelectorDictionary()
        {
            InitializeComponent();
            textBox1.ReadOnly = true;

            btnSelect.Click += BtnSelect_Click;
            btnClear.Click += BtnClear_Click;
        }

        private void BtnClear_Click(object sender, EventArgs e)
        {
            textBox1.Text = string.Empty;
        }

        private void BtnSelect_Click(object sender, EventArgs e)
        {
            var form = new FormSelectorFromDictionary(
                _db, TableName);

            form.ShowDialog();

            if (form.SelectedRow != null)
            {
                var columns = _db.GetTableAllColumns(TableName);
                
                if (columns.FirstOrDefault(x => x.ColumnName == "name") != null)
                {
                    textBox1.Text = form.SelectedRow.Cells["name"]
                        .Value
                        .ToString();
                }
                else
                {
                    textBox1.Text = form.SelectedRow.Cells[Constants.Calculated]
                        .Value
                        .ToString();
                }

                var str = form.SelectedRow.Cells[
                    TableName + "Id"].Value.ToString();

                int.TryParse(str, out _selectedId);

                if (_selectedId > 0 && SelectedIdChanged != null)
                {
                    // ЗАЖИГАЕМ СОБЫТИЕ
                    SelectedIdChanged?.Invoke(_selectedId);
                }
            }
        }
    }
}
