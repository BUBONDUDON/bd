using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WinFormRelationManual.Helpers
{
    public class ComponentsHelper
    {

        public static void CopyDataToEditFields(
            DataGridViewRow selectedRow,
            List<Control> controls)
        {
            foreach (var control in controls)
            {
                // 1) имя столбца берём из контрола (свойство Tag)
                string columnName = control.Tag.ToString();
                // 2) пол имени столбца в строке таблицы находим значение
                object value = selectedRow.Cells[columnName].Value;
                // 3) это значение нужно записать в контрол
                ControlSetValue(control, value);
            }
        }

        private static void ControlSetValue(
            Control control, object value)
        {
            if (control is TextBox)
            {
                TextBox textBox = (TextBox)control;
                textBox.Text = value.ToString();
            }
            else
            if (control is NumericUpDown numeric)
            {
                // NumericUpDown numeric = (NumericUpDown) control;
                numeric.Value = (int)value;
            }
            else
            if (control is ComboBox comboBox)
            {
                if (int.TryParse(value.ToString(), out int number))
                {
                    comboBox.SelectedValue = (int)value;
                }
            }
            else
            {
                throw new Exception("Not supported control");
            }
        }

        private static bool IsForeignKey(string columnName)
        {
            // в том случае, если название заканчивается на Id
            return columnName.EndsWith("Id");
        }

        public static List<Control> CreateEditFields(
            DatabaseManager db,
            Control parent,
            List<DataColumn> columns)
        {
            var list = new List<Control>();

            Size size = new Size(150, 30);
            Point point = new Point(10, 20);

            foreach (DataColumn column in columns)
            {
                Control control;

                if (IsForeignKey(column.ColumnName))
                {
                    control = CreateSelector(db, column, columns);
                }
                else
                if (column.DataType == typeof(int))
                {
                    control = CreateNumeric();
                }
                else
                if (column.DataType == typeof(string))
                {
                    // textBox
                    control = CreateTextBox();
                }
                else
                {
                    throw new ArgumentException("Not supported DataType");
                }

                list.Add(control);

                // чтобы контрол знал, с каким столбцом связан
                control.Tag = column.ColumnName;

                control.Size = size;


                var label = new Label();
                label.Text = column.ColumnName + ":";

                label.Location = new Point(point.X, point.Y);
                control.Location = new Point(point.X,
                    point.Y + label.Height + 2);

                parent.Controls.Add(label);
                parent.Controls.Add(control);
                // каждый следующий - ниже
                point.Y = control.Bottom + 20;
            }

            return list;
        }

        private static string GetTableNameFromFK(DataColumn column)
        {
            string tableName = column.ColumnName;

            if (tableName.EndsWith("Id"))
            {
                tableName = tableName
                    .Remove(tableName.Length - 2, 2);
            }
            return tableName;
        }

        public static Control CreateSelector(
            DatabaseManager db, DataColumn column,
            List<DataColumn> columns)
        {
            var control = new ComboBox();

            string tableName = GetTableNameFromFK(column);
            string columnName = "";
            control.DataSource = db.ViewTable(tableName);
            if (tableName == "Student" || tableName == "Teacher")
            {
                columnName = Constants.Calculated;
            } else
            {
                columnName = columns
                    .FirstOrDefault(c => c.ColumnName == "name") != null ? Constants.Calculated : "name";
            }
            control.DisplayMember = columnName;
            control.ValueMember = tableName + "Id";

            return control;
        }

        private static Control CreateTextBox()
        {
            var control = new TextBox();

            return control;
        }

        private static Control CreateNumeric()
        {
            var control = new NumericUpDown();
            // временное решение
            control.Minimum = 0;
            control.Maximum = int.MaxValue;

            return control;
        }

        public static void CopyDataFromEditFields(
            List<Control> editFields, DataRow row)
        {
            foreach (Control control in editFields)
            {
                string columnName = control.Tag.ToString();
                row[columnName] = GetValueFromControl(control);
            }
        }

        private static object GetValueFromControl(Control control)
        {
            object value = null;
            if (control is TextBox textBox)
            {
                value = textBox.Text;
            }
            else
            if (control is NumericUpDown numericUpDown)
            {
                value = numericUpDown.Value;
            }
            else
            if (control is ComboBox comboBox)
            {
                value = comboBox.SelectedValue;
            }
            else
            {
                throw new Exception("Not supported Control!");
            }
            return value;
        }
    }
}
