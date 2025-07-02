BEGIN -- �������� ���� ������
	IF DB_ID(N'deansOffice') IS NULL
		CREATE DATABASE [deansOffice]
	ELSE
		PRINT N'���� ������ deansOffice ��� ����������'
END
GO
begin -- �������� ������
	use[deansOffice]
	--������. ������
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
        PRINT N'������� Group ��� ����������'

	--���������
	IF OBJECT_ID(N'Stipend', N'U') IS NULL
        CREATE TABLE [Stipend](
            [StipendId] INT NOT NULL IDENTITY PRIMARY KEY,
			[stipend_name] nvarchar(100),
			[amount_payable] nvarchar(20),
        )
    ELSE
        PRINT N'������� Stipend ��� ����������'

	--�������
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
        PRINT N'������� Student ��� ����������'

	--�������
	IF OBJECT_ID(N'Teacher', N'U') IS NULL
        CREATE TABLE [Teacher](
            [TeacherId] INT NOT NULL IDENTITY PRIMARY KEY,
			[last_name] NVARCHAR(50),
            [first_name] NVARCHAR(50),
            [middle_name] NVARCHAR(50),
        )
    ELSE
        PRINT N'������� Teacher ��� ����������'

	--����������
	IF OBJECT_ID(N'Discipline', N'U') IS NULL
        CREATE TABLE [Discipline](
            [DisciplineId] INT NOT NULL IDENTITY PRIMARY KEY,
			[teacherId] INT
				foreign key references[Teacher]([teacherId]),
			[name] nvarchar(300),
			[knowledge_assessment_form] NVARCHAR(7) 
				check([knowledge_assessment_form] in (N'�������', N'�����'))
        )
    ELSE
        PRINT N'������� Discipline ��� ����������'

	--������ ������
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
        PRINT N'������� GradeBook ��� ����������'

	--������ ���������/�������
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
        PRINT N'������� ExamLog ��� ����������'

	--����������
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
        PRINT N'������� Schedule ��� ����������'
end
go
begin -- �������� ������
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
BEGIN -- ���������� ������
    USE [deansOffice];

    -- ���������� ������� AcademicGroup
    INSERT INTO AcademicGroup (name, faculty, pulpit, speciality, year) VALUES
    ('������1', '���������1', '�������1', '�������������1', 2023),
    ('������2', '���������1', '�������1', '�������������1', 2023),
    ('������3', '���������1', '�������2', '�������������1', 2023),
    ('������4', '���������1', '�������2', '�������������1', 2023),
    ('������5', '���������2', '�������3', '�������������2', 2023),
    ('������6', '���������2', '�������3', '�������������2', 2023),
    ('������7', '���������2', '�������4', '�������������2', 2023),
    ('������8', '���������2', '�������4', '�������������2', 2023);
	
    -- ���������� ������� Stipend
    INSERT INTO Stipend (stipend_name, amount_payable) VALUES
    ('��� ���������', '0'),
    ('��������� 1', '3000'),
    ('��������� 2', '4500'),
    ('��������� 3', '6000'),
    ('��������� 4', '7500'),
    ('��������� 5', '10000'),
    ('��������� 6', '20000');

    -- ���������� ������� Student
    INSERT INTO Student (AcademicGroupId, last_name, first_name, middle_name, residential_address, stipendId) VALUES
    (1, '������', '����', '��������', '�����1', 1),
    (1, '������', '����', '��������', '�����2', 2),
    (1, '�������', '�����', '���������', '�����3', 3),
    (2, '��������', '�������', '����������', '�����4', 1),
    (2, '��������', '����', '�������������', '�����5', 2),
    (2, '��������', '�����', '���������', '�����6', 3),
    (3, '�������', '�������', '����������', '�����7', 1),
    (3, '��������', '������', '���������', '�����8', 2),
    (3, '�������', '�������', '����������', '�����9', 3),
    (4, '�������', '��������', '�����������', '�����10', 1),
    (4, '���������', '������', '����������', '�����11', 2),
    (4, '�������', '�����', '��������', '�����12', 3),
    (5, '��������', '���������', '�������������', '�����13', 1),
    (5, '�������', '�����', '���������', '�����14', 2),
    (5, '�������', '�������', '�����������', '�����15', 3),
    (6, '��������', '�����', '���������', '�����16', 1),
    (6, '��������', '���������', '�����������', '�����17', 2),
    (6, '������', '���������', '�������������', '�����18', 3),
    (7, '������', '������', '����������', '�����19', 1),
    (7, '��������', '�����', '���������', '�����20', 2),
    (7, '��������', '�����', '��������', '�����21', 3),
    (8, '��������', '���������', '�������������', '�����22', 1),
    (8, '��������', '��������', '�����������', '�����23', 2),
    (8, '�������', '��������', '�����������', '�����24', 3);

    -- ���������� ������� Teacher
    INSERT INTO Teacher (last_name, first_name, middle_name) VALUES
    ('������', '������', '���������'),
    ('������', '���������', '�������������'),
    ('�������', '�������', '����������'),
    ('��������', '��������', '�����������');

    -- ���������� ������� Discipline
    INSERT INTO Discipline (teacherId, name, knowledge_assessment_form) VALUES
    (1, '����������', '�������'),
    (2, '������', '�����'),
    (3, '�����', '�������'),
    (4, '��������', '�����');

	-- ���������� ������� ExamLog
	insert into ExamLog (StudentId, DisciplineId, [date], assessment_of_knowledge) values
	(1,  1, '2025-05-25', '3'),
	(2,  2, '2025-05-25', '�����'),
	(3,  3, '2025-05-25', '3'),
	(4,  4, '2025-05-25', '�����'),
	(5,  1, '2025-05-25', '2'),
	(6,  2, '2025-05-25', '�����'),
	(7,  3, '2025-05-25', '2'),
	(8,  4, '2025-05-25', '�����'),
	(9,  1, '2025-05-25', '3'),
	(10, 2, '2025-05-25', '�����'),
	(11, 3, '2025-05-25', '3'),
	(12, 4, '2025-05-25', '�����'),
	(13, 1, '2025-05-25', '3'),
	(14, 2, '2025-05-25', '�����'),
	(15, 3, '2025-05-25', '3'),
	(16, 4, '2025-05-25', '�����'),
	(17, 1, '2025-05-25', '3'),
	(18, 2, '2025-05-25', '�����'),
	(19, 3, '2025-05-25', '3'),
	(20, 4, '2025-05-25', '�����'),
	(21, 1, '2025-05-25', '3'),
	(22, 2, '2025-05-25', '�����'),
	(23, 3, '2025-05-25', '3'),
	(24, 4, '2025-05-25', '�����');

    -- ���������� ������� GradeBook
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
            SET @mark = CASE WHEN RAND() < 0.5 THEN '�' ELSE CAST(2 + ABS(CHECKSUM(NEWID())) % 4 AS NVARCHAR(10)) END;
            INSERT INTO GradeBook (StudentId, DisciplineId, TeacherId, date, mark) VALUES
            (@StudentId, @DisciplineId, @TeacherId, GETDATE(), @mark);
            SET @j = @j + 1;
        END

        SET @i = @i + 1;
    END
END
GO

BEGIN -- �	������� ���� ��������� ������ ������ ���������� ����������
    SELECT
        ACgroup.faculty as [���������],
        ACgroup.pulpit as [�������],
        ACgroup.name as [������],
        stu.last_name as [�������],
        stu.first_name as [���],
        stu.middle_name as [��������],
        AVG(CASE 
                WHEN gb.mark = '�' THEN 2 
                ELSE CAST(gb.mark AS FLOAT) 
            END) AS [������� ����]
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

begin -- �	������� ���� �� ������� ��������
	select
		disci.name as [����������],
        CAST
			(AVG(
				CASE 
				WHEN gb.mark = '�' THEN 2 
				ELSE CAST(gb.mark AS FLOAT) 
				END
			)AS DECIMAL(3,2)) AS [������� ����]
	from Discipline as disci
	join GradeBook as gb on
		disci.DisciplineId = gb.DisciplineId
	group by
		disci.name
end
go

BEGIN -- �	���������� ��������� ����������, �� ���������� ���������, ���������� ������� ���������, � 50 % ��������� � �� 100 % ���������.
    SELECT
        AcGroup.faculty as [���������],
        COUNT(CASE WHEN stu.stipendId = 1 THEN 1 END) AS [���-�� ��������� ��� ���������],
        COUNT(CASE WHEN stu.stipendId = 2 THEN 1 END) AS [���-�� ��������� ���������� ������� ���������],
        COUNT(CASE WHEN stu.stipendId = 3 THEN 1 END) AS [���-�� ��������� � 50% ���������],
        COUNT(CASE WHEN stu.stipendId = 4 THEN 1 END) AS [���-�� ��������� �� 100% ���������]
    FROM AcademicGroup AS AcGroup
    JOIN Student AS stu ON stu.AcademicGroupId = AcGroup.AcademicGroupId
    GROUP BY AcGroup.faculty
END
GO

begin -- �	�� ������ �������� ������ ����� �������������������� ������?
	select
		disci.name as [����������],
		count(case 
			when gb.mark = '2' then 1
			when gb.mark = '�' then 1 end) as [���-�� �������������������� ������]
		from Discipline as disci
		join GradeBook as gb on
			disci.DisciplineId = gb.DisciplineId
		group by disci.name
end
go

begin -- ������� ���������� �������� ���������� ������� ������
	select
		gb.StudentId,
		gb.DisciplineId,
		disci.name,
		CAST(AVG(
				CASE 
				WHEN gb.mark = '�' THEN 2 
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

begin -- �	��������, ����������� �� ������������ ������� � �� ������� ���� �� ���� �������, 
	  --	� ��������� ������ � ��������, �� �������� ������ ����������� ��� ����� 2?

	select
		AcGroup.pulpit as [�������],
		AcGroup.name as [������],
		stu.last_name + ' ' +
        stu.first_name+ ' ' +
        stu.middle_name as [���],
		disci.name as [����������],
		(case 
			when el.assessment_of_knowledge = '2' then '2'
			when el.assessment_of_knowledge = '�� �����' then '�� �����' end) as [������ ������]
		from AcademicGroup as AcGroup
		join Student as stu on
			stu.AcademicGroupId = AcGroup.AcademicGroupId
		join ExamLog as el on
			el.StudentId = stu.StudentId
		join Discipline as disci on
			disci.DisciplineId = el.DisciplineId
		WHERE 
			el.assessment_of_knowledge NOT IN ('�����', '3', '4', '5')
end
go

BEGIN -- �	����� ������� �������� ����� �����, ��� ������ ��������?
    SELECT
        disci.name as [����������],
        CAST(AVG(
                CASE 
                    WHEN gb.mark = '�' THEN 2 
                    ELSE CAST(gb.mark AS FLOAT) 
                END) AS DECIMAL(3,2)) AS [������� ������ ������]
    FROM 
        Discipline AS disci
    JOIN 
        GradeBook AS gb ON disci.DisciplineId = gb.DisciplineId
    GROUP BY 
        disci.name
    HAVING 
        AVG(CASE 
            WHEN gb.mark = '�' THEN 2 
            ELSE CAST(gb.mark AS FLOAT) 
        END) = (
            SELECT MAX(AverageMark)
            FROM (
                SELECT 
                    AVG(CASE 
                        WHEN gb_inner.mark = '�' THEN 2 
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

begin -- �	������ ��������� ��������� �������, ������� �� ������ ������ ����� �������� ���������?
	select
		AcGroup.pulpit as [�������],
		stu.last_name + ' ' +
        stu.first_name+ ' ' +
        stu.middle_name as [���],
		(case when el.assessment_of_knowledge in ('�����', '4', '5') then '�����' end) 
			as [����� �� ������� �������� ��������� �� ������ ������ ?]
		from AcademicGroup as AcGroup
		join Student as stu on
			stu.AcademicGroupId = AcGroup.AcademicGroupId
		join ExamLog as el on
			stu.StudentId = el.StudentId
		where
			el.assessment_of_knowledge not in ('�� �����', '3', '2', '�')
end
go