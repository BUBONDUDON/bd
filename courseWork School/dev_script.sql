BEGIN -- Создание базы данных
	IF DB_ID(N'deansOffice') IS NULL
		CREATE DATABASE [deansOffice]
	ELSE
		PRINT N'База данных deansOffice уже существует'
END
GO
begin -- Создание таблиц
	use[deansOffice]
	--Академ. группа
	IF OBJECT_ID(N'AcademicGroup', N'U') IS NULL
        CREATE TABLE [AcademicGroup](
            [AcademicGroupId] INT NOT NULL IDENTITY PRIMARY KEY,
			[name] nvarchar(10),
			[faculty] NVARCHAR(250),
            [pulpit] NVARCHAR(250),
            [speciality] NVARCHAR(250),
			[year] int,
        )
    ELSE
        PRINT N'Таблица Group уже существует'

	--Стипендия
	IF OBJECT_ID(N'Stipend', N'U') IS NULL
        CREATE TABLE [Stipend](
            [StipendId] INT NOT NULL IDENTITY PRIMARY KEY,
			[stipend_name] nvarchar(100),
			[amount_payable] nvarchar(20),
        )
    ELSE
        PRINT N'Таблица Stipend уже существует'

	--Студент
	IF OBJECT_ID(N'Student', N'U') IS NULL
        CREATE TABLE [Student](
            [StudentId] INT NOT NULL IDENTITY PRIMARY KEY,
			[AcademicGroupId] int
				foreign key references[AcademicGroup]([AcademicGroupId]),
			[last_name] NVARCHAR(50),
            [first_name] NVARCHAR(50),
            [middle_name] NVARCHAR(50),
			[residential_address] nvarchar(300),
			[stipendId] INT
				foreign key references[Stipend]([StipendId]),
        )
    ELSE
        PRINT N'Таблица Student уже существует'

	--Учитель
	IF OBJECT_ID(N'Teacher', N'U') IS NULL
        CREATE TABLE [Teacher](
            [TeacherId] INT NOT NULL IDENTITY PRIMARY KEY,
			[last_name] NVARCHAR(50),
            [first_name] NVARCHAR(50),
            [middle_name] NVARCHAR(50),
        )
    ELSE
        PRINT N'Таблица Teacher уже существует'

	--Дисциплина
	IF OBJECT_ID(N'Discipline', N'U') IS NULL
        CREATE TABLE [Discipline](
            [DisciplineId] INT NOT NULL IDENTITY PRIMARY KEY,
			[teacherId] INT
				foreign key references[Teacher]([teacherId]),
			[name] nvarchar(300),
			[knowledge_assessment_form] NVARCHAR(7) 
				check([knowledge_assessment_form] in (N'Экзамен', N'Зачёт'))
        )
    ELSE
        PRINT N'Таблица Discipline уже существует'

	--Журнал оценок
	IF OBJECT_ID(N'GradeBook', N'U') IS NULL
        CREATE TABLE [GradeBook](
			[GradeBookId] int identity primary key,
			[StudentId] INT
				foreign key references[Student]([StudentId]),
			[DisciplineId] INT
				foreign key references[Discipline]([DisciplineId]),
			[TeacherId] INT
				foreign key references[Teacher]([TeacherId]),
			[date] datetime,
			[mark] NVARCHAR(10),
        )
    ELSE
        PRINT N'Таблица GradeBook уже существует'

	--Журнал экзаменов/зачётов
	IF OBJECT_ID(N'ExamLog', N'U') IS NULL
        CREATE TABLE [ExamLog](
			[ExamLogId] int identity primary key,
			[StudentId] INT
				foreign key references[Student]([StudentId]),
			[DisciplineId] INT
				foreign key references[Discipline]([DisciplineId]),
			[date] nvarchar(100),
			[assessment_of_knowledge] nvarchar(8)
        )
    ELSE
        PRINT N'Таблица ExamLog уже существует'

	--Расписание
	IF OBJECT_ID(N'Schedule', N'U') IS NULL
        CREATE TABLE [Schedule](
			[ScheduleId] int primary key,
			[AcademicGroupId] int
				foreign key references[AcademicGroup]([AcademicGroupId]),
			[ordinalNumber] int,
			[DisciplineId] INT
				foreign key references[Discipline]([DisciplineId]),
			[TeacherId] INT
				foreign key references[Teacher]([TeacherId]),
			[cabinet] int
        )
    ELSE
        PRINT N'Таблица Schedule уже существует'
end
go
begin -- Удаление таблиц
	drop table [AcademicGroup]
	drop table [Discipline]
	drop table [ExamLog]
	drop table [GradeBook]
	drop table [Stipend]
	drop table [Student]
	drop table [Teacher]
	drop table [Schedule]
end
go
BEGIN -- Заполнение таблиц
    USE [deansOffice];

    -- Заполнение таблицы AcademicGroup
    INSERT INTO AcademicGroup (name, faculty, pulpit, speciality, year) VALUES
    ('Группа1', 'Факультет1', 'Кафедра1', 'Специальность1', 2023),
    ('Группа2', 'Факультет1', 'Кафедра1', 'Специальность1', 2023),
    ('Группа3', 'Факультет1', 'Кафедра2', 'Специальность1', 2023),
    ('Группа4', 'Факультет1', 'Кафедра2', 'Специальность1', 2023),
    ('Группа5', 'Факультет2', 'Кафедра3', 'Специальность2', 2023),
    ('Группа6', 'Факультет2', 'Кафедра3', 'Специальность2', 2023),
    ('Группа7', 'Факультет2', 'Кафедра4', 'Специальность2', 2023),
    ('Группа8', 'Факультет2', 'Кафедра4', 'Специальность2', 2023);
	
    -- Заполнение таблицы Stipend
    INSERT INTO Stipend (stipend_name, amount_payable) VALUES
    ('Нет стипендии', '0'),
    ('Стипендия 1', '3000'),
    ('Стипендия 2', '4500'),
    ('Стипендия 3', '6000'),
    ('Стипендия 4', '7500'),
    ('Стипендия 5', '10000'),
    ('Стипендия 6', '20000');

    -- Заполнение таблицы Student
    INSERT INTO Student (AcademicGroupId, last_name, first_name, middle_name, residential_address, stipendId) VALUES
    (1, 'Иванов', 'Иван', 'Иванович', 'Адрес1', 1),
    (1, 'Петров', 'Петр', 'Петрович', 'Адрес2', 2),
    (1, 'Сидоров', 'Сидор', 'Сидорович', 'Адрес3', 3),
    (2, 'Кузнецов', 'Алексей', 'Алексеевич', 'Адрес4', 1),
    (2, 'Смирнова', 'Анна', 'Александровна', 'Адрес5', 2),
    (2, 'Федорова', 'Ольга', 'Федоровна', 'Адрес6', 3),
    (3, 'Морозов', 'Дмитрий', 'Дмитриевич', 'Адрес7', 1),
    (3, 'Васильев', 'Сергей', 'Сергеевич', 'Адрес8', 2),
    (3, 'Тихонов', 'Евгений', 'Евгеньевич', 'Адрес9', 3),
    (4, 'Лебедев', 'Анатолий', 'Анатольевич', 'Адрес10', 1),
    (4, 'Григорьев', 'Виктор', 'Викторович', 'Адрес11', 2),
    (4, 'Романов', 'Игорь', 'Игоревич', 'Адрес12', 3),
    (5, 'Николаев', 'Станислав', 'Станиславович', 'Адрес13', 1),
    (5, 'Ковалев', 'Тимур', 'Тимурович', 'Адрес14', 2),
    (5, 'Баранов', 'Ярослав', 'Ярославович', 'Адрес15', 3),
    (6, 'Соловьев', 'Денис', 'Денисович', 'Адрес16', 1),
    (6, 'Шевченко', 'Анастасия', 'Анатольевна', 'Адрес17', 2),
    (6, 'Климов', 'Александр', 'Александрович', 'Адрес18', 3),
    (7, 'Зайцев', 'Михаил', 'Михайлович', 'Адрес19', 1),
    (7, 'Семенова', 'Дарья', 'Семеновна', 'Адрес20', 2),
    (7, 'Савельев', 'Павел', 'Павлович', 'Адрес21', 3),
    (8, 'Кузьмина', 'Екатерина', 'Александровна', 'Адрес22', 1),
    (8, 'Тихонова', 'Вероника', 'Верониковна', 'Адрес23', 2),
    (8, 'Федотов', 'Анатолий', 'Анатольевич', 'Адрес24', 3);

    -- Заполнение таблицы Teacher
    INSERT INTO Teacher (last_name, first_name, middle_name) VALUES
    ('Иванов', 'Сергей', 'Сергеевич'),
    ('Петров', 'Александр', 'Александрович'),
    ('Сидоров', 'Дмитрий', 'Дмитриевич'),
    ('Кузнецов', 'Анатолий', 'Анатольевич');

    -- Заполнение таблицы Discipline
    INSERT INTO Discipline (teacherId, name, knowledge_assessment_form) VALUES
    (1, 'Математика', 'Экзамен'),
    (2, 'Физика', 'Зачёт'),
    (3, 'Химия', 'Экзамен'),
    (4, 'Биология', 'Зачёт');

	-- Заполнение таблицы ExamLog
	insert into ExamLog (StudentId, DisciplineId, [date], assessment_of_knowledge) values
	(1,  1, '2025-05-25', '3'),
	(2,  2, '2025-05-25', 'Зачет'),
	(3,  3, '2025-05-25', '3'),
	(4,  4, '2025-05-25', 'Зачет'),
	(5,  1, '2025-05-25', '2'),
	(6,  2, '2025-05-25', 'Зачет'),
	(7,  3, '2025-05-25', '2'),
	(8,  4, '2025-05-25', 'Зачет'),
	(9,  1, '2025-05-25', '3'),
	(10, 2, '2025-05-25', 'Зачет'),
	(11, 3, '2025-05-25', '3'),
	(12, 4, '2025-05-25', 'Зачет'),
	(13, 1, '2025-05-25', '3'),
	(14, 2, '2025-05-25', 'Зачет'),
	(15, 3, '2025-05-25', '3'),
	(16, 4, '2025-05-25', 'Зачет'),
	(17, 1, '2025-05-25', '3'),
	(18, 2, '2025-05-25', 'Зачет'),
	(19, 3, '2025-05-25', '3'),
	(20, 4, '2025-05-25', 'Зачет'),
	(21, 1, '2025-05-25', '3'),
	(22, 2, '2025-05-25', 'Зачет'),
	(23, 3, '2025-05-25', '3'),
	(24, 4, '2025-05-25', 'Зачет');

    -- Заполнение таблицы GradeBook
    DECLARE @StudentId INT, @DisciplineId INT, @TeacherId INT, @mark NVARCHAR(10);
    DECLARE @i INT = 1;

    WHILE @i <= 24
    BEGIN
        SET @StudentId = @i;
        SET @DisciplineId = ((@i - 1) % 4) + 1;
        SET @TeacherId = @DisciplineId;

        DECLARE @j INT = 1;
        WHILE @j <= 10
        BEGIN
            SET @mark = CASE WHEN RAND() < 0.5 THEN 'Н' ELSE CAST(2 + ABS(CHECKSUM(NEWID())) % 4 AS NVARCHAR(10)) END;
            INSERT INTO GradeBook (StudentId, DisciplineId, TeacherId, date, mark) VALUES
            (@StudentId, @DisciplineId, @TeacherId, GETDATE(), @mark);
            SET @j = @j + 1;
        END

        SET @i = @i + 1;
    END
END
GO

BEGIN -- •	Средний балл студентов каждой группы указанного факультета
    SELECT
        ACgroup.faculty as [Факультет],
        ACgroup.pulpit as [Кафедра],
        ACgroup.name as [Группа],
        stu.last_name as [Фамилия],
        stu.first_name as [Имя],
        stu.middle_name as [Отчество],
        AVG(CASE 
                WHEN gb.mark = 'Н' THEN 2 
                ELSE CAST(gb.mark AS FLOAT) 
            END) AS [Средний балл]
    FROM AcademicGroup AS ACgroup
    JOIN Student AS stu ON ACgroup.AcademicGroupId = stu.AcademicGroupId
    LEFT JOIN GradeBook AS gb ON stu.StudentId = gb.StudentId
    GROUP BY 
        ACgroup.faculty,
        ACgroup.pulpit,
        ACgroup.name,
        stu.last_name,
        stu.first_name,
        stu.middle_name
END
GO

begin -- •	Средний балл по каждому предмету
	select
		disci.name as [Дисциплина],
        CAST
			(AVG(
				CASE 
				WHEN gb.mark = 'Н' THEN 2 
				ELSE CAST(gb.mark AS FLOAT) 
				END
			)AS DECIMAL(3,2)) AS [Средний балл]
	from Discipline as disci
	join GradeBook as gb on
		disci.DisciplineId = gb.DisciplineId
	group by
		disci.name
end
go

BEGIN -- •	Количество студентов факультета, не получающих стипендию, получающих обычную стипендию, с 50 % надбавкой и со 100 % надбавкой.
    SELECT
        AcGroup.faculty as [Факультет],
        COUNT(CASE WHEN stu.stipendId = 1 THEN 1 END) AS [Кол-во студентов без стипендии],
        COUNT(CASE WHEN stu.stipendId = 2 THEN 1 END) AS [Кол-во студентов получающих обычную стипендию],
        COUNT(CASE WHEN stu.stipendId = 3 THEN 1 END) AS [Кол-во студентов с 50% надбавкой],
        COUNT(CASE WHEN stu.stipendId = 4 THEN 1 END) AS [Кол-во студентов со 100% надбавкой]
    FROM AcademicGroup AS AcGroup
    JOIN Student AS stu ON stu.AcademicGroupId = AcGroup.AcademicGroupId
    GROUP BY AcGroup.faculty
END
GO

begin -- •	По какому предмету больше всего неудовлетворительных оценок?
	select
		disci.name as [Дисциплина],
		count(case 
			when gb.mark = '2' then 1
			when gb.mark = 'Н' then 1 end) as [Кол-во неудовлетворительных оценок]
		from Discipline as disci
		join GradeBook as gb on
			disci.DisciplineId = gb.DisciplineId
		group by disci.name
end
go

begin -- Студент дисциплина Название дисциплины средняя оценка
	select
		gb.StudentId,
		gb.DisciplineId,
		disci.name,
		CAST(AVG(
				CASE 
				WHEN gb.mark = 'Н' THEN 2 
				ELSE CAST(gb.mark AS FLOAT) 
				END
			)AS DECIMAL(3,2)) AS AverageMark
		from GradeBook as gb
		join Discipline as disci on
			disci.DisciplineId = gb.DisciplineId
	group by 
		gb.StudentId,
		gb.DisciplineId,
		disci.name
	order by
		gb.StudentId
end
go

begin -- •	Студенты, обучающиеся на определенной кафедре и не сдавшие хотя бы один экзамен, 
	  --	с указанием группы и предмета, по которому оценка отсутствует или равна 2?

	select
		AcGroup.pulpit as [Кафедра],
		AcGroup.name as [Группа],
		stu.last_name + ' ' +
        stu.first_name+ ' ' +
        stu.middle_name as [ФИО],
		disci.name as [Дисциплина],
		(case 
			when el.assessment_of_knowledge = '2' then '2'
			when el.assessment_of_knowledge = 'Не зачёт' then 'Не зачёт' end) as [Оценка знаний]
		from AcademicGroup as AcGroup
		join Student as stu on
			stu.AcademicGroupId = AcGroup.AcademicGroupId
		join ExamLog as el on
			el.StudentId = stu.StudentId
		join Discipline as disci on
			disci.DisciplineId = el.DisciplineId
		WHERE 
			el.assessment_of_knowledge NOT IN ('Зачет', '3', '4', '5')
end
go

BEGIN -- •	Какой предмет студенты сдали лучше, чем другие предметы?
    SELECT
        disci.name as [Дисциплина],
        CAST(AVG(
                CASE 
                    WHEN gb.mark = 'Н' THEN 2 
                    ELSE CAST(gb.mark AS FLOAT) 
                END) AS DECIMAL(3,2)) AS [Средняя оценка знаний]
    FROM 
        Discipline AS disci
    JOIN 
        GradeBook AS gb ON disci.DisciplineId = gb.DisciplineId
    GROUP BY 
        disci.name
    HAVING 
        AVG(CASE 
            WHEN gb.mark = 'Н' THEN 2 
            ELSE CAST(gb.mark AS FLOAT) 
        END) = (
            SELECT MAX(AverageMark)
            FROM (
                SELECT 
                    AVG(CASE 
                        WHEN gb_inner.mark = 'Н' THEN 2 
                        ELSE CAST(gb_inner.mark AS FLOAT) 
                    END) AS AverageMark
                FROM 
                    GradeBook AS gb_inner
                GROUP BY 
                    gb_inner.DisciplineId
            ) AS avgGrades
        )
END
GO

begin -- •	Список студентов указанной кафедры, которые по итогам сессии могут получать стипендию?
	select
		AcGroup.pulpit as [Кафедра],
		stu.last_name + ' ' +
        stu.first_name+ ' ' +
        stu.middle_name as [ФИО],
		(case when el.assessment_of_knowledge in ('Зачет', '4', '5') then 'Может' end) 
			as [Может ли студент получать стипендию по итогам сессии ?]
		from AcademicGroup as AcGroup
		join Student as stu on
			stu.AcademicGroupId = AcGroup.AcademicGroupId
		join ExamLog as el on
			stu.StudentId = el.StudentId
		where
			el.assessment_of_knowledge not in ('Не зачёт', '3', '2', 'Н')
end
go