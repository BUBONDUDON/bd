namespace WinFormRelationManual
{
    partial class FormGradeBook
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.selectorAcademicGroup = new WinFormRelationManual.TextFieldSelectorDictionary();
            this.selectorDiscipline = new WinFormRelationManual.TextFieldSelectorDictionary();
            this.selectorTeacher = new WinFormRelationManual.TextFieldSelectorDictionary();
            this.comboBoxYear = new System.Windows.Forms.ComboBox();
            this.comboBoxMonth = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.buttonAccept = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(12, 148);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(723, 360);
            this.dataGridView1.TabIndex = 0;
            // 
            // selectorAcademicGroup
            // 
            this.selectorAcademicGroup.Header = "Группы:";
            this.selectorAcademicGroup.Location = new System.Drawing.Point(374, 12);
            this.selectorAcademicGroup.Name = "selectorAcademicGroup";
            this.selectorAcademicGroup.Size = new System.Drawing.Size(337, 51);
            this.selectorAcademicGroup.TabIndex = 3;
            this.selectorAcademicGroup.TableName = "AcademicGroup";
            // 
            // selectorDiscipline
            // 
            this.selectorDiscipline.Header = "Дисциплины:";
            this.selectorDiscipline.Location = new System.Drawing.Point(12, 69);
            this.selectorDiscipline.Name = "selectorDiscipline";
            this.selectorDiscipline.Size = new System.Drawing.Size(337, 51);
            this.selectorDiscipline.TabIndex = 2;
            this.selectorDiscipline.TableName = "Discipline";
            // 
            // selectorTeacher
            // 
            this.selectorTeacher.Header = "Преподаватели:";
            this.selectorTeacher.Location = new System.Drawing.Point(12, 12);
            this.selectorTeacher.Name = "selectorTeacher";
            this.selectorTeacher.Size = new System.Drawing.Size(337, 51);
            this.selectorTeacher.TabIndex = 1;
            this.selectorTeacher.TableName = "Teacher";
            // 
            // comboBoxYear
            // 
            this.comboBoxYear.FormattingEnabled = true;
            this.comboBoxYear.Items.AddRange(new object[] {
            "2020",
            "2021",
            "2022",
            "2023",
            "2024",
            "2025",
            "2026",
            "2027",
            "2028",
            "2029",
            "2030"});
            this.comboBoxYear.Location = new System.Drawing.Point(374, 91);
            this.comboBoxYear.Name = "comboBoxYear";
            this.comboBoxYear.Size = new System.Drawing.Size(121, 21);
            this.comboBoxYear.TabIndex = 4;
            // 
            // comboBoxMonth
            // 
            this.comboBoxMonth.FormattingEnabled = true;
            this.comboBoxMonth.Items.AddRange(new object[] {
            "Январь",
            "Февраль",
            "Март",
            "Апрель",
            "Май",
            "Июнь",
            "Июль",
            "Август",
            "Сентябрь",
            "Октябрь",
            "Ноябрь",
            "Декабрь"});
            this.comboBoxMonth.Location = new System.Drawing.Point(590, 91);
            this.comboBoxMonth.Name = "comboBoxMonth";
            this.comboBoxMonth.Size = new System.Drawing.Size(121, 21);
            this.comboBoxMonth.TabIndex = 5;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(371, 75);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(28, 13);
            this.label1.TabIndex = 6;
            this.label1.Text = "Год:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(587, 75);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(43, 13);
            this.label2.TabIndex = 7;
            this.label2.Text = "Месяц:";
            // 
            // buttonAccept
            // 
            this.buttonAccept.Location = new System.Drawing.Point(676, 535);
            this.buttonAccept.Name = "buttonAccept";
            this.buttonAccept.Size = new System.Drawing.Size(114, 39);
            this.buttonAccept.TabIndex = 8;
            this.buttonAccept.Text = "Принять";
            this.buttonAccept.UseVisualStyleBackColor = true;
            this.buttonAccept.Click += new System.EventHandler(this.buttonAccept_Click);
            // 
            // FormGradeBook
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(802, 586);
            this.Controls.Add(this.buttonAccept);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.comboBoxMonth);
            this.Controls.Add(this.comboBoxYear);
            this.Controls.Add(this.selectorAcademicGroup);
            this.Controls.Add(this.selectorDiscipline);
            this.Controls.Add(this.selectorTeacher);
            this.Controls.Add(this.dataGridView1);
            this.Name = "FormGradeBook";
            this.Text = "FormGradeBook";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridView1;
        private TextFieldSelectorDictionary selectorTeacher;
        private TextFieldSelectorDictionary selectorDiscipline;
        private TextFieldSelectorDictionary selectorAcademicGroup;
        private System.Windows.Forms.ComboBox comboBoxYear;
        private System.Windows.Forms.ComboBox comboBoxMonth;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button buttonAccept;
    }
}