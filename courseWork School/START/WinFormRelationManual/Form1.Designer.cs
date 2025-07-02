namespace WinFormRelationManual
{
    partial class Form1
    {
        /// <summary>
        /// Обязательная переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Требуемый метод для поддержки конструктора — не изменяйте 
        /// содержимое этого метода с помощью редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.buttonLoad = new System.Windows.Forms.Button();
            this.dataGridView2 = new System.Windows.Forms.DataGridView();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.dictionaryMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.groupsMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.studentsMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.teacherMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.disciplineMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.stipendToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.btnGradeBook = new System.Windows.Forms.Button();
            this.btnStudentResult = new System.Windows.Forms.Button();
            this.btnExamLog = new System.Windows.Forms.Button();
            this.groupList_comboBox = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).BeginInit();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(16, 52);
            this.dataGridView1.Margin = new System.Windows.Forms.Padding(4);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowHeadersWidth = 51;
            this.dataGridView1.Size = new System.Drawing.Size(737, 94);
            this.dataGridView1.TabIndex = 0;
            // 
            // buttonLoad
            // 
            this.buttonLoad.Location = new System.Drawing.Point(761, 699);
            this.buttonLoad.Margin = new System.Windows.Forms.Padding(4);
            this.buttonLoad.Name = "buttonLoad";
            this.buttonLoad.Size = new System.Drawing.Size(308, 91);
            this.buttonLoad.TabIndex = 1;
            this.buttonLoad.Text = "Загрузка с Сервера";
            this.buttonLoad.UseVisualStyleBackColor = true;
            this.buttonLoad.Click += new System.EventHandler(this.buttonLoad_Click);
            // 
            // dataGridView2
            // 
            this.dataGridView2.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView2.Location = new System.Drawing.Point(16, 154);
            this.dataGridView2.Margin = new System.Windows.Forms.Padding(4);
            this.dataGridView2.Name = "dataGridView2";
            this.dataGridView2.RowHeadersWidth = 51;
            this.dataGridView2.Size = new System.Drawing.Size(737, 636);
            this.dataGridView2.TabIndex = 2;
            // 
            // menuStrip1
            // 
            this.menuStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.dictionaryMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(1082, 28);
            this.menuStrip1.TabIndex = 4;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // dictionaryMenuItem
            // 
            this.dictionaryMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.groupsMenuItem,
            this.studentsMenuItem,
            this.teacherMenuItem,
            this.disciplineMenuItem,
            this.stipendToolStripMenuItem});
            this.dictionaryMenuItem.Name = "dictionaryMenuItem";
            this.dictionaryMenuItem.Size = new System.Drawing.Size(117, 26);
            this.dictionaryMenuItem.Text = "Справочники";
            // 
            // groupsMenuItem
            // 
            this.groupsMenuItem.Name = "groupsMenuItem";
            this.groupsMenuItem.Size = new System.Drawing.Size(224, 26);
            this.groupsMenuItem.Text = "Группы";
            this.groupsMenuItem.Click += new System.EventHandler(this.groupsMenuItem_Click);
            // 
            // studentsMenuItem
            // 
            this.studentsMenuItem.Name = "studentsMenuItem";
            this.studentsMenuItem.Size = new System.Drawing.Size(224, 26);
            this.studentsMenuItem.Text = "Студенты";
            this.studentsMenuItem.Click += new System.EventHandler(this.studentsMenuItem_Click);
            // 
            // teacherMenuItem
            // 
            this.teacherMenuItem.Name = "teacherMenuItem";
            this.teacherMenuItem.Size = new System.Drawing.Size(224, 26);
            this.teacherMenuItem.Text = "Преподаватели";
            this.teacherMenuItem.Click += new System.EventHandler(this.teacherMenuItem_Click);
            // 
            // disciplineMenuItem
            // 
            this.disciplineMenuItem.Name = "disciplineMenuItem";
            this.disciplineMenuItem.Size = new System.Drawing.Size(224, 26);
            this.disciplineMenuItem.Text = "Дисциплины";
            this.disciplineMenuItem.Click += new System.EventHandler(this.disciplineMenuItem_Click);
            // 
            // stipendToolStripMenuItem
            // 
            this.stipendToolStripMenuItem.Name = "stipendToolStripMenuItem";
            this.stipendToolStripMenuItem.Size = new System.Drawing.Size(224, 26);
            this.stipendToolStripMenuItem.Text = "Стипендии";
            this.stipendToolStripMenuItem.Click += new System.EventHandler(this.stipendMenuItem_Click);
            // 
            // btnGradeBook
            // 
            this.btnGradeBook.Location = new System.Drawing.Point(761, 253);
            this.btnGradeBook.Margin = new System.Windows.Forms.Padding(4);
            this.btnGradeBook.Name = "btnGradeBook";
            this.btnGradeBook.Size = new System.Drawing.Size(308, 91);
            this.btnGradeBook.TabIndex = 5;
            this.btnGradeBook.Text = "Журнал оценок";
            this.btnGradeBook.UseVisualStyleBackColor = true;
            this.btnGradeBook.Click += new System.EventHandler(this.btnGradeBook_Click);
            // 
            // btnStudentResult
            // 
            this.btnStudentResult.Location = new System.Drawing.Point(761, 154);
            this.btnStudentResult.Margin = new System.Windows.Forms.Padding(4);
            this.btnStudentResult.Name = "btnStudentResult";
            this.btnStudentResult.Size = new System.Drawing.Size(308, 91);
            this.btnStudentResult.TabIndex = 7;
            this.btnStudentResult.Text = "Статистика успеваемости";
            this.btnStudentResult.UseVisualStyleBackColor = true;
            this.btnStudentResult.Click += new System.EventHandler(this.btnStudentResult_Click);
            // 
            // btnExamLog
            // 
            this.btnExamLog.Location = new System.Drawing.Point(761, 352);
            this.btnExamLog.Margin = new System.Windows.Forms.Padding(4);
            this.btnExamLog.Name = "btnExamLog";
            this.btnExamLog.Size = new System.Drawing.Size(308, 91);
            this.btnExamLog.TabIndex = 6;
            this.btnExamLog.Text = "Итоговый журнал";
            this.btnExamLog.UseVisualStyleBackColor = true;
            this.btnExamLog.Click += new System.EventHandler(this.btnExamLog_Click);
            // 
            // groupList_comboBox
            // 
            this.groupList_comboBox.FormattingEnabled = true;
            this.groupList_comboBox.Location = new System.Drawing.Point(760, 88);
            this.groupList_comboBox.Name = "groupList_comboBox";
            this.groupList_comboBox.Size = new System.Drawing.Size(270, 24);
            this.groupList_comboBox.TabIndex = 8;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(760, 52);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(95, 16);
            this.label1.TabIndex = 9;
            this.label1.Text = "Список групп";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1082, 803);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.groupList_comboBox);
            this.Controls.Add(this.btnStudentResult);
            this.Controls.Add(this.btnExamLog);
            this.Controls.Add(this.btnGradeBook);
            this.Controls.Add(this.dataGridView2);
            this.Controls.Add(this.buttonLoad);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.menuStrip1);
            this.MainMenuStrip = this.menuStrip1;
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).EndInit();
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Button buttonLoad;
        private System.Windows.Forms.DataGridView dataGridView2;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem dictionaryMenuItem;
        private System.Windows.Forms.ToolStripMenuItem groupsMenuItem;
        private System.Windows.Forms.ToolStripMenuItem studentsMenuItem;
        private System.Windows.Forms.ToolStripMenuItem teacherMenuItem;
        private System.Windows.Forms.ToolStripMenuItem disciplineMenuItem;
        private System.Windows.Forms.Button btnGradeBook;
        private System.Windows.Forms.ToolStripMenuItem stipendToolStripMenuItem;
        private System.Windows.Forms.Button btnStudentResult;
        private System.Windows.Forms.Button btnExamLog;
        private System.Windows.Forms.ComboBox groupList_comboBox;
        private System.Windows.Forms.Label label1;
    }
}

