BEGIN -- �������� ���� ������
	IF DB_ID(N'practica6.1') IS NULL
		CREATE DATABASE [practica6.1]
	ELSE
		PRINT N'���� ������ practica6.1 ��� ����������'
END
GO

--������� 1. ��������� SQL-������ ��� ������� �������� �� ��, ���������� �������:
begin
	use[practica6.1]
	--�	��������� (id_���������, ������������, �����);
	IF OBJECT_ID(N'job_title', N'U') IS NULL
        CREATE TABLE [job_title](
            [id] INT NOT NULL IDENTITY,
            [name] NVARCHAR(50) NOT NULL,
            [salary] MONEY
            CONSTRAINT [PK_job_title_id] PRIMARY KEY([id])
        )
    ELSE
        PRINT N'������� job_title ��� ����������'

	--�	����� (id_������, ������������);
	IF OBJECT_ID(N'city', N'U') IS NULL
        CREATE TABLE [city](
            [id] INT NOT NULL IDENTITY,
            [name] NVARCHAR(100) NOT NULL

            CONSTRAINT [PK_city_id] PRIMARY KEY([id])
        )
    ELSE
        PRINT N'������� city ��� ����������'

	--�	����� (id_������, ������������);
    IF OBJECT_ID(N'department', N'U') IS NULL
        CREATE TABLE [department](
            [id] INT NOT NULL IDENTITY,
            [name] NVARCHAR(100) NOT NULL

            CONSTRAINT [PK_department_id] PRIMARY KEY([id])
        )
    ELSE
        PRINT N'������� department ��� ����������'

	--�	��������� (id_����������, �������, ���, ��������, ���, ���� ��������, id_������, id_������);
    IF OBJECT_ID(N'employee', N'U') IS NULL
        CREATE TABLE [employee](
            [id] INT NOT NULL IDENTITY,
            [last_name] NVARCHAR(50),
            [first_name] NVARCHAR(50),
            [middle_name] NVARCHAR(50),
            [gender] NVARCHAR(10),
            [date_of_birth] DATE,
            [department_id] INT,
            [city_id] INT
            CONSTRAINT [PK_employee_id] PRIMARY KEY([id]),
            CONSTRAINT [FK_department_id] FOREIGN KEY([department_id])
                REFERENCES [department]([id]),
            CONSTRAINT [FK_city_id] FOREIGN KEY([city_id])
                REFERENCES [city]([id])
        )
    ELSE
        PRINT N'������� employee ��� ����������'

	--�	������� ���������� (id_������, id_����������, id_���������, ���� ������ ������, ���� ��������� ������);
    IF OBJECT_ID(N'history_of_positions', N'U') IS NULL
        CREATE TABLE [history_of_positions](
            [id] INT NOT NULL IDENTITY,
            [employee_id] INT,
            [job_title_id] INT,
            [start_date] DATE,
            [end_date] DATE

            CONSTRAINT [PK_history_of_positions_id] PRIMARY KEY([id]),
            CONSTRAINT [FK_employee_id] FOREIGN KEY([employee_id])
                REFERENCES [employee]([id]),
            CONSTRAINT [FK_job_title_id] FOREIGN KEY([job_title_id])
                REFERENCES [job_title]([id])
        )
    ELSE
        PRINT N'������� history_of_positions ��� ����������'

	--�	���������� (id_����������, ����, �������).
    IF OBJECT_ID(N'dismissal', N'U') IS NULL
        CREATE TABLE [dismissal](
            [id] INT NOT NULL IDENTITY,
            [employee_id] INT,
            [date] DATE,
            [cause] NVARCHAR(100),
            CONSTRAINT [PK_dismissal_id] PRIMARY KEY([id]),
            CONSTRAINT [FK_employee_dismissal_id] FOREIGN KEY([employee_id])
                REFERENCES [employee]([id])
        )
    ELSE
        PRINT N'������� dismissal ��� ����������'
end
go

begin
	insert into [job_title] ([name], [salary])
	values 
        (N'�����������', 110000),
        (N'�����������', 80000),
        (N'��������', 120000),
        (N'��������', 90000),
        (N'��������', 85000),
        (N'�������������', 75000),
        (N'���������', 95000),
        (N'����������', 88000),
        (N'��������', 200000),
        (N'���������', 60000),
        (N'�������', 110000),
        (N'����������� ��������', 85000),
        (N'��������� �������������', 105000),
        (N'�������-��������', 130000),
        (N'HR-����������', 90000),
        (N'������', 80000),
        (N'�����', 95000),
        (N'����������', 140000),
        (N'������-��������', 125000),
        (N'DevOps-�������', 150000)
		delete from [job_title]

	insert into [city] ([name])
	values
		(N'���������'),
        (N'�����-���������'),
        (N'������'),
        (N'������'),
        (N'�����'),
        (N'������'),
        (N'������������'),
        (N'�����������'),
        (N'�����������'),
        (N'���������'),
        (N'����'),
        (N'������ ��������'),
        (N'������-��-����'),
        (N'���'),
        (N'�����'),
        (N'�������'),
        (N'���������'),
        (N'����������'),
        (N'������'),
        (N'����'),
		(N'�����')
		delete from [city]

	insert into [department] ([name])
	values
		(N'IT-�����'),
        (N'�����������'),
        (N'����� ������'),
        (N'���������'),
        (N'�������'),
        (N'����������� �����'),
        (N'���������'),
        (N'������������'),
        (N'������������ � ����������'),
        (N'����������� ���������'),
        (N'���������� �����'),
        (N'����� �������� ��������'),
        (N'����� �������'),
        (N'����� ���������'),
        (N'PR-�����'),
        (N'����� ������������'),
        (N'����� ���������'),
        (N'����� ����������'),
        (N'����� ������������'),
        (N'�������������')
		delete from [department]

	insert into [employee] ([last_name], [first_name], [middle_name], [gender], [date_of_birth], [department_id], [city_id])
	values
        (N'������', N'����', N'��������', N'�������', N'1980-05-15', 1, 6),
        (N'�������', N'�����', N'���������', N'�������', N'1985-08-20', 2, 2),
        (N'�������', N'�������', N'��������', N'�������', N'1990-03-10', 3, 1),
        (N'���������', N'�����', N'������������', N'�������', N'1988-11-25', 4, 7),
        (N'�������', N'�������', N'�������������', N'�������', N'1975-07-30', 5, 6),
        (N'��������', N'�����', N'��������', N'�������', N'1992-02-14', 6, 3),
        (N'�����', N'������', N'����������', N'�������', N'1983-09-18', 7, 8),
        (N'���������', N'����', N'����������', N'�������', N'1987-06-22', 8, 9),
        (N'�������', N'������', N'��������', N'�������', N'1978-04-05', 9, 10),
        (N'��������', N'�������', N'����������', N'�������', N'1991-12-08', 10, 4),
        (N'������', N'�����', N'���������', N'�������', N'1986-01-17', 11, 5),
        (N'��������', N'�������', N'����������', N'�������', N'1984-10-29', 12, 6),
        (N'������', N'�����', N'��������', N'�������', N'1979-07-03', 13, 7),
        (N'���������', N'����', N'��������', N'�������', N'1993-05-19', 14, 8),
        (N'�������', N'������', N'������������', N'�������', N'1982-08-12', 15, 9),
        (N'�������', N'���������', N'���������', N'�������', N'1989-03-27', 16, 10),
        (N'������', N'���������', N'����������', N'�������', N'1977-11-14', 17, 1),
        (N'������', N'�����', N'����������', N'�������', N'1981-09-08', 18, 2),
        (N'�������', N'������', N'�����������', N'�������', N'1976-06-25', 19, 3),
        (N'�������', N'�������', N'���������', N'�������', N'1990-04-30', 20, 4),
		(N'������', N'����', N'��������', N'�������', N'1985-06-15', 1, 6), 
        (N'�������', N'����', N'��������', N'�������', N'1990-07-20', 1, 6), 
        (N'��������', N'�����', N'���������', N'�������', N'1988-03-12', 1, 6), 
        (N'�������', N'�����', N'������������', N'�������', N'1987-11-05', 1, 6), 
        (N'��������', N'������', N'����������', N'�������', N'1986-09-18', 1, 6), 
        (N'��������', N'�������', N'����������', N'�������', N'1985-12-30', 1, 6)
		delete from [employee]

	insert into [history_of_positions] ([employee_id], [job_title_id], [start_date], [end_date])
	values
        (1, 1, N'2015-01-10', N'2018-12-31'),
        (1, 3, N'2019-01-01', NULL),
        (2, 7, N'2016-03-15', NULL),
        (3, 15, N'2017-05-20', N'2020-06-30'),
        (3, 9, N'2020-07-01', NULL),
        (4, 4, N'2018-02-10', NULL),
        (5, 5, N'2015-11-05', N'2019-10-31'),
        (5, 14, N'2019-11-01', NULL),
        (6, 17, N'2017-08-12', NULL),
        (7, 11, N'2016-09-25', N'2021-08-30'),
        (7, 20, N'2021-09-01', NULL),
        (8, 8, N'2019-04-17', NULL),
        (9, 18, N'2015-07-22', NULL),
        (10, 10, N'2018-12-01', NULL),
        (11, 12, N'2017-03-08', N'2022-02-28'),
        (11, 19, N'2022-03-01', NULL),
        (12, 2, N'2016-10-15', NULL),
        (13, 13, N'2015-12-20', NULL),
        (14, 6, N'2019-07-30', NULL),
        (15, 16, N'2018-01-10', NULL),
        (16, 1, N'2017-05-15', N'2022-05-14'),
        (16, 3, N'2022-05-15', NULL),
        (17, 7, N'2016-08-20', NULL),
        (18, 9, N'2015-10-10', NULL),
        (19, 11, N'2018-03-25', NULL),
        (20, 14, N'2019-06-18', NULL),
		(21, 1, N'2015-01-10', NULL), 
        (22, 1, N'2010-01-10', N'2020-01-10'),
        (23, 1, N'2010-01-10', NULL), 
        (24, 1, N'2010-01-10', NULL), 
        (25, 1, N'2010-01-10', NULL),
        (26, 1, N'2010-01-10', NULL)
		delete from [history_of_positions]

	insert into [dismissal] ([employee_id], [date], [cause])
	values
        (4, N'2021-03-15', N'�� ������������ �������'),
        (6, N'2022-05-20', N'���������� �����'),
        (10, N'2023-01-10', N'�� ���������� ������'),
        (12, N'2021-11-30', N'�� ������������ �������'),
        (14, N'2022-08-15', N'��������� �������� ����������'),
        (16, N'2023-02-28', N'���������� �����'),
        (18, N'2021-07-22', N'�� ������������ �������'),
        (20, N'2022-12-10', N'�� ���������� ������'),
		(22, N'2020-01-10', N'�� ������������ �������'), 
        (21, N'2023-12-31', N'�� ������������ �������')
		delete from [dismissal]
end
go

--�������:
--1)	������� ������ ����������� � �� ����������. ��������� ����������� �� �������� ���������, � ����� �� ���.
begin
    select empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [���],
		[job].[name] AS [�������� ���������]
	from [history_of_positions] AS [his] join [employee] AS [empl]
		on his.[employee_id] = empl.[id]
		join [job_title] AS [job]
		on his.[job_title_id] = job.[id]
		where 
			his.[end_date] is null or
			his.[end_date] > GETDATE()
		order by [�������� ���������], [���]
end
go
--2)	������� ��� ����������� � �� ������. ��������� ����������� �� �������� ������.
begin
    select empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [���],
		[job].[salary] AS [�����]
	from [history_of_positions] AS [his] join [employee] AS [empl]
		on his.[employee_id] = empl.[id]
		join [job_title] AS [job]
		on his.[job_title_id] = job.[id]
		where 
			his.[end_date] is null or
			his.[end_date] > GETDATE()
		order by [�����] desc
end
go
--3)	������� ���� �����������, ������� ���� ������� �� ��������� 3 ����. ��������� ����������� �� ���� ����������.
begin
    select empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [���],
		[miss].[date] AS [���� ����������]
	from [dismissal] AS miss join [employee] AS empl
		on miss.employee_id = empl.id
		where
			miss.[date] >= DATEADD(YEAR, -3, GETDATE())
	order by [���� ����������]
end
go
--4)	������� ������ ����������� � �� �������.
begin
    select empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [���],
		[dep].[name] as [�����]
	from [department] as dep join [employee] as empl
		on dep.[id] = empl.[department_id]
		    where 
        NOT exists (
            select 1 
            from [dismissal] as miss 
            where miss.[employee_id] = empl.[id]
        )		
		order by [���]
end
go
--5)	������� ������ ������� � ���������� ����������� � ���.
begin
	select 
		dep.[name] as [�����],
		count(empl.[id]) as [���������� �����������]
	from [employee] as empl join [department] as dep
	on dep.[id] = empl.[department_id]
	group by dep.[name]
end
go
--6)	������� ���� ������������� � ������� ������ 100 000 � �������� �� ����� �ϻ.
begin
    select empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [���],
		job.[salary] as [�����]
	from [employee] as empl join [history_of_positions] as his
	on empl.[id] = his.[employee_id] 
	join [job_title] as job
	on his.[job_title_id] = job.[id]
		where 
			job.[name] = N'�����������' and
			job.[salary] >= 100000 and
			empl.[last_name] like N'�%' and
			his.[end_date] is null or
			his.[end_date] > GETDATE()
	order by [���]		
end
go
--7)	������� ������ ����������� � �� ����������. ��������� ������ ��� �����������, ������� ����������� 5 ��� � ����� �� ����� ���������.
begin
	    select empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [���],
			job.[name] as [���������],
			DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE())) as [����]
		from [employee] as empl join [history_of_positions] as his
			on empl.[id] = his.[employee_id]
		join [job_title] as job
			on his.[job_title_id] = job.[id]
		where 
			DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE())) >=5
end
go
--8)	������� ������ ���������� � ���� ������ �� ��������� ���������� �������� ����� ���������.
begin
	select 
		job.[name] as [���������],
		DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE())) as [����],
		empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [���]
	from [employee] as empl join [history_of_positions] as his
		on empl.[id] = his.[employee_id]
	join [job_title] as job
		on his.[job_title_id] = job.[id]
	where 
		empl.[last_name] = N'������' and
		empl.[first_name] = N'����' and
		empl.[middle_name] = N'��������'
end
go
--9)	������� ���������� ����������, ������� ������� ��������� ������� ���� ���������, � ����� ���� ��� ������.
begin
	select 
		count(job.[id]) as [���-�� ���������� ����������],
		sum(DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE()))) as [����� ���� ������],
		empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [���]
	from [employee] as empl join [history_of_positions] as his
		on empl.[id] = his.[employee_id]
	join [job_title] as job
		on his.[job_title_id] = job.[id]
	where 
		empl.[last_name] = N'������' and
		empl.[first_name] = N'����' and
		empl.[middle_name] = N'��������'
	group by empl.[last_name], empl.[first_name], empl.[middle_name]
end
go
--10)	������� ���� ���������� � ���������� ��������� ����������� �� ���� ���. ��������� ����������� �� �������� ����� ����������.
begin
	select 
		year(miss.[date]) as [��� ����������],
		count(miss.[employee_id]) as [���-�� �������� �����������]
	from [dismissal] as miss
	group by year(miss.[date])
end
go
--11)	������� ������ ����������� � �� ������ ������.
begin
	select
		empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [���],
		city.[name] as [�����]
	from [employee] as empl join [city] as city
		on empl.[city_id] = city.[id]
	order by [���]
end
go
--12)	������� ���� ����������� �� ������ �������, ������� ���������� �� ��������� ������������ �� ����� 10 ���.
begin
	select
		empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [���],
		city.[name] as [�����],
		job.[name] as [���������],
		DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE())) as [����]
	from [employee] as empl join [city] as city
		on empl.[city_id] = city.[id]
	join [history_of_positions] as his
		on empl.[id] = his.[employee_id]
	join [job_title] as job
		on his.[job_title_id] = job.[id]
	where
		city.[name] = N'������' and
		DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE())) >= 10
	order by DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE()))
end
go
--13)	������� ����� � ���������� ����������� �� ����� ������. 
--      ��������� ������ �� ������, ���������� ����������� � ������� ������ 4. 
--      ��������� ����������� �� �������� ���������� �����������.
begin
	select
		city.[name] as [�����],
		count(empl.[id]) as [���-�� �����������]
	from [employee] as empl
	join [city] as city
		on empl.[city_id] = city.[id]
    group by [city].[name]
    having count([empl].[id]) > 4
    order by [���-�� �����������] DESC
end
go
--14)	������� ������� ������� ��������� �����������.
begin
	select
		AVG(DATEDIFF(YEAR, [empl].[date_of_birth], [miss].[date])) as [������� ������� ���������]
	from [employee] as empl
	join [dismissal] as miss
		on empl.[id] = miss.[employee_id]
end
go
--15)	������� ��� � ������� �������� �.�.�, ���, ������� � ����� ���� ������ ����������, ������� ��� ������ ���������.
begin
	select
		empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [���],
		empl.[gender] as [���], 
		DATEDIFF(YEAR, [empl].[date_of_birth], GETDATE()) as [�������],
		miss.[date] as [���� ����������],
		sum(DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE()))) as [����� ���� ������]
	from [employee] as empl
	join [history_of_positions] as his
		on empl.[id] = his.[employee_id]
	join [dismissal] as miss
		on empl.[id] = miss.[employee_id]
	where
		miss.[date] = (select max([date])from [dismissal])
	group by
		[empl].[last_name], 
		[empl].[first_name], 
		[empl].[middle_name],
		[empl].[gender],
		[empl].[date_of_birth],
		[miss].[date]
end
go