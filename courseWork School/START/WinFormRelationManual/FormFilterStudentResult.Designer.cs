namespace WinFormRelationManual
{
    partial class FormFilterStudentResult
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
            this.showInfo_dataGrid = new System.Windows.Forms.DataGridView();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.columnValues_comboBox = new System.Windows.Forms.ComboBox();
            this.columnNames_combobox = new System.Windows.Forms.ComboBox();
            this.showStudentWithStipend = new System.Windows.Forms.Button();
            this.showDisciplineWithBestAvgMark = new System.Windows.Forms.Button();
            this.showStudentWithBadMarkForExam = new System.Windows.Forms.Button();
            this.showDisciplineWithWorstAvgMark = new System.Windows.Forms.Button();
            this.showInfoAboutStipendStudent = new System.Windows.Forms.Button();
            this.showAvgForAllDiscipline = new System.Windows.Forms.Button();
            this.showFacultyStudentWithAvgMark = new System.Windows.Forms.Button();
            this.btn_exit = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.showInfo_dataGrid)).BeginInit();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // showInfo_dataGrid
            // 
            this.showInfo_dataGrid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.showInfo_dataGrid.Location = new System.Drawing.Point(12, 12);
            this.showInfo_dataGrid.Name = "showInfo_dataGrid";
            this.showInfo_dataGrid.RowHeadersWidth = 51;
            this.showInfo_dataGrid.RowTemplate.Height = 24;
            this.showInfo_dataGrid.Size = new System.Drawing.Size(1153, 761);
            this.showInfo_dataGrid.TabIndex = 0;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.columnValues_comboBox);
            this.groupBox1.Controls.Add(this.columnNames_combobox);
            this.groupBox1.Controls.Add(this.showStudentWithStipend);
            this.groupBox1.Controls.Add(this.showDisciplineWithBestAvgMark);
            this.groupBox1.Controls.Add(this.showStudentWithBadMarkForExam);
            this.groupBox1.Controls.Add(this.showDisciplineWithWorstAvgMark);
            this.groupBox1.Controls.Add(this.showInfoAboutStipendStudent);
            this.groupBox1.Controls.Add(this.showAvgForAllDiscipline);
            this.groupBox1.Controls.Add(this.showFacultyStudentWithAvgMark);
            this.groupBox1.Location = new System.Drawing.Point(1171, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(399, 715);
            this.groupBox1.TabIndex = 4;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "groupBox1";
            // 
            // columnValues_comboBox
            // 
            this.columnValues_comboBox.FormattingEnabled = true;
            this.columnValues_comboBox.Location = new System.Drawing.Point(7, 540);
            this.columnValues_comboBox.Margin = new System.Windows.Forms.Padding(4, 400, 4, 4);
            this.columnValues_comboBox.Name = "columnValues_comboBox";
            this.columnValues_comboBox.Size = new System.Drawing.Size(385, 24);
            this.columnValues_comboBox.TabIndex = 9;
            this.columnValues_comboBox.SelectedValueChanged += new System.EventHandler(this.columnValues_comboBox_SelectedValueChanged);
            // 
            // columnNames_combobox
            // 
            this.columnNames_combobox.FormattingEnabled = true;
            this.columnNames_combobox.Location = new System.Drawing.Point(7, 479);
            this.columnNames_combobox.Margin = new System.Windows.Forms.Padding(4, 400, 4, 4);
            this.columnNames_combobox.Name = "columnNames_combobox";
            this.columnNames_combobox.Size = new System.Drawing.Size(385, 24);
            this.columnNames_combobox.TabIndex = 8;
            this.columnNames_combobox.SelectedValueChanged += new System.EventHandler(this.columnNames_combobox_SelectedValueChanged);
            // 
            // showStudentWithStipend
            // 
            this.showStudentWithStipend.Location = new System.Drawing.Point(7, 394);
            this.showStudentWithStipend.Margin = new System.Windows.Forms.Padding(4, 10, 4, 4);
            this.showStudentWithStipend.Name = "showStudentWithStipend";
            this.showStudentWithStipend.Size = new System.Drawing.Size(385, 47);
            this.showStudentWithStipend.TabIndex = 6;
            this.showStudentWithStipend.Text = "Подробная информация о стипендии студентов";
            this.showStudentWithStipend.UseVisualStyleBackColor = true;
            this.showStudentWithStipend.Click += new System.EventHandler(this.showStudentWithStipend_Click);
            // 
            // showDisciplineWithBestAvgMark
            // 
            this.showDisciplineWithBestAvgMark.Location = new System.Drawing.Point(7, 333);
            this.showDisciplineWithBestAvgMark.Margin = new System.Windows.Forms.Padding(4, 10, 4, 4);
            this.showDisciplineWithBestAvgMark.Name = "showDisciplineWithBestAvgMark";
            this.showDisciplineWithBestAvgMark.Size = new System.Drawing.Size(385, 47);
            this.showDisciplineWithBestAvgMark.TabIndex = 5;
            this.showDisciplineWithBestAvgMark.Text = "Предметы с максимальной средней оценкой";
            this.showDisciplineWithBestAvgMark.UseVisualStyleBackColor = true;
            this.showDisciplineWithBestAvgMark.Click += new System.EventHandler(this.showDisciplineWithBestAvgMark_Click);
            // 
            // showStudentWithBadMarkForExam
            // 
            this.showStudentWithBadMarkForExam.Location = new System.Drawing.Point(7, 272);
            this.showStudentWithBadMarkForExam.Margin = new System.Windows.Forms.Padding(4, 10, 4, 4);
            this.showStudentWithBadMarkForExam.Name = "showStudentWithBadMarkForExam";
            this.showStudentWithBadMarkForExam.Size = new System.Drawing.Size(385, 47);
            this.showStudentWithBadMarkForExam.TabIndex = 4;
            this.showStudentWithBadMarkForExam.Text = "Студенты с незакрытой сессией";
            this.showStudentWithBadMarkForExam.UseVisualStyleBackColor = true;
            this.showStudentWithBadMarkForExam.Click += new System.EventHandler(this.showStudentWithBadMarkForExam_Click);
            // 
            // showDisciplineWithWorstAvgMark
            // 
            this.showDisciplineWithWorstAvgMark.Location = new System.Drawing.Point(7, 211);
            this.showDisciplineWithWorstAvgMark.Margin = new System.Windows.Forms.Padding(4, 10, 4, 4);
            this.showDisciplineWithWorstAvgMark.Name = "showDisciplineWithWorstAvgMark";
            this.showDisciplineWithWorstAvgMark.Size = new System.Drawing.Size(385, 47);
            this.showDisciplineWithWorstAvgMark.TabIndex = 3;
            this.showDisciplineWithWorstAvgMark.Text = "Количество неудовлетворительных оценок по предметам";
            this.showDisciplineWithWorstAvgMark.UseVisualStyleBackColor = true;
            this.showDisciplineWithWorstAvgMark.Click += new System.EventHandler(this.showDisciplineWithWorstAvgMark_Click);
            // 
            // showInfoAboutStipendStudent
            // 
            this.showInfoAboutStipendStudent.Location = new System.Drawing.Point(7, 150);
            this.showInfoAboutStipendStudent.Margin = new System.Windows.Forms.Padding(4, 10, 4, 4);
            this.showInfoAboutStipendStudent.Name = "showInfoAboutStipendStudent";
            this.showInfoAboutStipendStudent.Size = new System.Drawing.Size(385, 47);
            this.showInfoAboutStipendStudent.TabIndex = 2;
            this.showInfoAboutStipendStudent.Text = "Стипендия студентов";
            this.showInfoAboutStipendStudent.UseVisualStyleBackColor = true;
            this.showInfoAboutStipendStudent.Click += new System.EventHandler(this.showInfoAboutStipendStudent_Click);
            // 
            // showAvgForAllDiscipline
            // 
            this.showAvgForAllDiscipline.Location = new System.Drawing.Point(7, 89);
            this.showAvgForAllDiscipline.Margin = new System.Windows.Forms.Padding(4, 10, 4, 4);
            this.showAvgForAllDiscipline.Name = "showAvgForAllDiscipline";
            this.showAvgForAllDiscipline.Size = new System.Drawing.Size(385, 47);
            this.showAvgForAllDiscipline.TabIndex = 1;
            this.showAvgForAllDiscipline.Text = "Средний балл по каждому предмету";
            this.showAvgForAllDiscipline.UseVisualStyleBackColor = true;
            this.showAvgForAllDiscipline.Click += new System.EventHandler(this.showAvgForAllDiscipline_Click);
            // 
            // showFacultyStudentWithAvgMark
            // 
            this.showFacultyStudentWithAvgMark.Location = new System.Drawing.Point(7, 28);
            this.showFacultyStudentWithAvgMark.Margin = new System.Windows.Forms.Padding(4, 10, 4, 4);
            this.showFacultyStudentWithAvgMark.Name = "showFacultyStudentWithAvgMark";
            this.showFacultyStudentWithAvgMark.Size = new System.Drawing.Size(385, 47);
            this.showFacultyStudentWithAvgMark.TabIndex = 0;
            this.showFacultyStudentWithAvgMark.Text = "Средний балл студентов";
            this.showFacultyStudentWithAvgMark.UseVisualStyleBackColor = true;
            this.showFacultyStudentWithAvgMark.Click += new System.EventHandler(this.showFacultyStudentWithAvgMark_Click);
            // 
            // btn_exit
            // 
            this.btn_exit.Location = new System.Drawing.Point(1171, 733);
            this.btn_exit.Name = "btn_exit";
            this.btn_exit.Size = new System.Drawing.Size(399, 40);
            this.btn_exit.TabIndex = 5;
            this.btn_exit.Text = "Выйти";
            this.btn_exit.UseVisualStyleBackColor = true;
            this.btn_exit.Click += new System.EventHandler(this.btn_exit_Click);
            // 
            // FormFilterStudentResult
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1582, 803);
            this.Controls.Add(this.btn_exit);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.showInfo_dataGrid);
            this.Name = "FormFilterStudentResult";
            this.Text = "FormExamLog";
            ((System.ComponentModel.ISupportInitialize)(this.showInfo_dataGrid)).EndInit();
            this.groupBox1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView showInfo_dataGrid;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button btn_exit;
        private System.Windows.Forms.Button showInfoAboutStipendStudent;
        private System.Windows.Forms.Button showAvgForAllDiscipline;
        private System.Windows.Forms.Button showFacultyStudentWithAvgMark;
        private System.Windows.Forms.Button showStudentWithBadMarkForExam;
        private System.Windows.Forms.Button showDisciplineWithWorstAvgMark;
        private System.Windows.Forms.Button showDisciplineWithBestAvgMark;
        private System.Windows.Forms.Button showStudentWithStipend;
        private System.Windows.Forms.ComboBox columnNames_combobox;
        private System.Windows.Forms.ComboBox columnValues_comboBox;
    }
}