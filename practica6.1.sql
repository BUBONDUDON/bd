BEGIN -- Создание базы данных
	IF DB_ID(N'practica6.1') IS NULL
		CREATE DATABASE [practica6.1]
	ELSE
		PRINT N'База данных practica6.1 уже существует'
END
GO

--Задание 1. Построить SQL-запрос для выборки сведений из БД, содержащей таблицы:
begin
	use[practica6.1]
	--•	Должность (id_должности, наименование, оклад);
	IF OBJECT_ID(N'job_title', N'U') IS NULL
        CREATE TABLE [job_title](
            [id] INT NOT NULL IDENTITY,
            [name] NVARCHAR(50) NOT NULL,
            [salary] MONEY
            CONSTRAINT [PK_job_title_id] PRIMARY KEY([id])
        )
    ELSE
        PRINT N'Таблица job_title уже существует'

	--•	Город (id_города, наименование);
	IF OBJECT_ID(N'city', N'U') IS NULL
        CREATE TABLE [city](
            [id] INT NOT NULL IDENTITY,
            [name] NVARCHAR(100) NOT NULL

            CONSTRAINT [PK_city_id] PRIMARY KEY([id])
        )
    ELSE
        PRINT N'Таблица city уже существует'

	--•	Отдел (id_отдела, наименование);
    IF OBJECT_ID(N'department', N'U') IS NULL
        CREATE TABLE [department](
            [id] INT NOT NULL IDENTITY,
            [name] NVARCHAR(100) NOT NULL

            CONSTRAINT [PK_department_id] PRIMARY KEY([id])
        )
    ELSE
        PRINT N'Таблица department уже существует'

	--•	Сотрудник (id_сотрудника, фамилия, имя, отчество, пол, дата рождения, id_отдела, id_города);
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
        PRINT N'Таблица employee уже существует'

	--•	История должностей (id_записи, id_сотрудника, id_должности, дата начала работы, дата окончания работы);
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
        PRINT N'Таблица history_of_positions уже существует'

	--•	Увольнение (id_сотрудника, дата, причина).
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
        PRINT N'Таблица dismissal уже существует'
end
go

begin
	insert into [job_title] ([name], [salary])
	values 
        (N'Программист', 110000),
        (N'Тестировщик', 80000),
        (N'Аналитик', 120000),
        (N'Менеджер', 90000),
        (N'Дизайнер', 85000),
        (N'Администратор', 75000),
        (N'Бухгалтер', 95000),
        (N'Маркетолог', 88000),
        (N'Директор', 200000),
        (N'Секретарь', 60000),
        (N'Инженер', 110000),
        (N'Технический писатель', 85000),
        (N'Системный администратор', 105000),
        (N'Продукт-менеджер', 130000),
        (N'HR-специалист', 90000),
        (N'Логист', 80000),
        (N'Юрист', 95000),
        (N'Архитектор', 140000),
        (N'Бизнес-аналитик', 125000),
        (N'DevOps-инженер', 150000)
		delete from [job_title]

	insert into [city] ([name])
	values
		(N'Челябинск'),
        (N'Санкт-Петербург'),
        (N'Курган'),
        (N'Казань'),
        (N'Сатка'),
        (N'Москва'),
        (N'Екатеринбург'),
        (N'Новосибирск'),
        (N'Владивосток'),
        (N'Краснодар'),
        (N'Сочи'),
        (N'Нижний Новгород'),
        (N'Ростов-на-Дону'),
        (N'Уфа'),
        (N'Пермь'),
        (N'Воронеж'),
        (N'Волгоград'),
        (N'Красноярск'),
        (N'Самара'),
        (N'Омск'),
		(N'Томск')
		delete from [city]

	insert into [department] ([name])
	values
		(N'IT-отдел'),
        (N'Бухгалтерия'),
        (N'Отдел кадров'),
        (N'Маркетинг'),
        (N'Продажи'),
        (N'Юридический отдел'),
        (N'Логистика'),
        (N'Производство'),
        (N'Исследования и разработки'),
        (N'Техническая поддержка'),
        (N'Финансовый отдел'),
        (N'Отдел контроля качества'),
        (N'Отдел закупок'),
        (N'Отдел персонала'),
        (N'PR-отдел'),
        (N'Отдел безопасности'),
        (N'Отдел аналитики'),
        (N'Отдел разработки'),
        (N'Отдел тестирования'),
        (N'Администрация')
		delete from [department]

	insert into [employee] ([last_name], [first_name], [middle_name], [gender], [date_of_birth], [department_id], [city_id])
	values
        (N'Иванов', N'Иван', N'Иванович', N'Мужской', N'1980-05-15', 1, 6),
        (N'Петрова', N'Мария', N'Сергеевна', N'Женский', N'1985-08-20', 2, 2),
        (N'Сидоров', N'Алексей', N'Петрович', N'Мужской', N'1990-03-10', 3, 1),
        (N'Кузнецова', N'Елена', N'Владимировна', N'Женский', N'1988-11-25', 4, 7),
        (N'Смирнов', N'Дмитрий', N'Александрович', N'Мужской', N'1975-07-30', 5, 6),
        (N'Федорова', N'Ольга', N'Игоревна', N'Женский', N'1992-02-14', 6, 3),
        (N'Попов', N'Сергей', N'Васильевич', N'Мужской', N'1983-09-18', 7, 8),
        (N'Васильева', N'Анна', N'Дмитриевна', N'Женский', N'1987-06-22', 8, 9),
        (N'Лебедев', N'Андрей', N'Олегович', N'Мужской', N'1978-04-05', 9, 10),
        (N'Новикова', N'Татьяна', N'Викторовна', N'Женский', N'1991-12-08', 10, 4),
        (N'Козлов', N'Павел', N'Сергеевич', N'Мужской', N'1986-01-17', 11, 5),
        (N'Морозова', N'Наталья', N'Алексеевна', N'Женский', N'1984-10-29', 12, 6),
        (N'Волков', N'Артем', N'Игоревич', N'Мужской', N'1979-07-03', 13, 7),
        (N'Алексеева', N'Юлия', N'Павловна', N'Женский', N'1993-05-19', 14, 8),
        (N'Семенов', N'Михаил', N'Владимирович', N'Мужской', N'1982-08-12', 15, 9),
        (N'Егорова', N'Екатерина', N'Андреевна', N'Женский', N'1989-03-27', 16, 10),
        (N'Павлов', N'Александр', N'Николаевич', N'Мужской', N'1977-11-14', 17, 1),
        (N'Орлова', N'Ирина', N'Витальевна', N'Женский', N'1981-09-08', 18, 2),
        (N'Борисов', N'Виктор', N'Геннадьевич', N'Мужской', N'1976-06-25', 19, 3),
        (N'Зайцева', N'Людмила', N'Романовна', N'Женский', N'1990-04-30', 20, 4),
		(N'Петров', N'Петр', N'Петрович', N'Мужской', N'1985-06-15', 1, 6), 
        (N'Иванова', N'Анна', N'Ивановна', N'Женский', N'1990-07-20', 1, 6), 
        (N'Сидорова', N'Ольга', N'Сергеевна', N'Женский', N'1988-03-12', 1, 6), 
        (N'Козлова', N'Елена', N'Владимировна', N'Женский', N'1987-11-05', 1, 6), 
        (N'Михайлов', N'Михаил', N'Михайлович', N'Мужской', N'1986-09-18', 1, 6), 
        (N'Николаев', N'Николай', N'Николаевич', N'Мужской', N'1985-12-30', 1, 6)
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
        (4, N'2021-03-15', N'По собственному желанию'),
        (6, N'2022-05-20', N'Сокращение штата'),
        (10, N'2023-01-10', N'По соглашению сторон'),
        (12, N'2021-11-30', N'По собственному желанию'),
        (14, N'2022-08-15', N'Нарушение трудовой дисциплины'),
        (16, N'2023-02-28', N'Сокращение штата'),
        (18, N'2021-07-22', N'По собственному желанию'),
        (20, N'2022-12-10', N'По соглашению сторон'),
		(22, N'2020-01-10', N'По собственному желанию'), 
        (21, N'2023-12-31', N'По собственному желанию')
		delete from [dismissal]
end
go

--Запросы:
--1)	Вывести список сотрудников и их должностей. Результат упорядочить по названию должности, а затем по ФИО.
begin
    select empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [ФИО],
		[job].[name] AS [Название должности]
	from [history_of_positions] AS [his] join [employee] AS [empl]
		on his.[employee_id] = empl.[id]
		join [job_title] AS [job]
		on his.[job_title_id] = job.[id]
		where 
			his.[end_date] is null or
			his.[end_date] > GETDATE()
		order by [Название должности], [ФИО]
end
go
--2)	Вывести ФИО сотрудников и их оклады. Результат упорядочить по убыванию оклада.
begin
    select empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [ФИО],
		[job].[salary] AS [Оклад]
	from [history_of_positions] AS [his] join [employee] AS [empl]
		on his.[employee_id] = empl.[id]
		join [job_title] AS [job]
		on his.[job_title_id] = job.[id]
		where 
			his.[end_date] is null or
			his.[end_date] > GETDATE()
		order by [Оклад] desc
end
go
--3)	Вывести всех сотрудников, которые были уволены за последние 3 года. Результат упорядочить по дате увольнения.
begin
    select empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [ФИО],
		[miss].[date] AS [Дата увольнения]
	from [dismissal] AS miss join [employee] AS empl
		on miss.employee_id = empl.id
		where
			miss.[date] >= DATEADD(YEAR, -3, GETDATE())
	order by [Дата увольнения]
end
go
--4)	Вывести список сотрудников и их отделов.
begin
    select empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [ФИО],
		[dep].[name] as [Отдел]
	from [department] as dep join [employee] as empl
		on dep.[id] = empl.[department_id]
		    where 
        NOT exists (
            select 1 
            from [dismissal] as miss 
            where miss.[employee_id] = empl.[id]
        )		
		order by [ФИО]
end
go
--5)	Вывести список отделов и количество сотрудников в них.
begin
	select 
		dep.[name] as [Отдел],
		count(empl.[id]) as [Количество сотрудников]
	from [employee] as empl join [department] as dep
	on dep.[id] = empl.[department_id]
	group by dep.[name]
end
go
--6)	Вывести всех программистов с окладом больше 100 000 и фамилией на букву «П».
begin
    select empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [ФИО],
		job.[salary] as [Оклад]
	from [employee] as empl join [history_of_positions] as his
	on empl.[id] = his.[employee_id] 
	join [job_title] as job
	on his.[job_title_id] = job.[id]
		where 
			job.[name] = N'Программист' and
			job.[salary] >= 100000 and
			empl.[last_name] like N'П%' and
			his.[end_date] is null or
			his.[end_date] > GETDATE()
	order by [ФИО]		
end
go
--7)	Вывести список сотрудников и их должностей. Учитывать только тех сотрудников, которые проработали 5 лет и более на одной должности.
begin
	    select empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [ФИО],
			job.[name] as [Должность],
			DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE())) as [Стаж]
		from [employee] as empl join [history_of_positions] as his
			on empl.[id] = his.[employee_id]
		join [job_title] as job
			on his.[job_title_id] = job.[id]
		where 
			DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE())) >=5
end
go
--8)	Вывести список должностей и стаж работы на должности сотрудника «Иванова Ивана Ивановича».
begin
	select 
		job.[name] as [Должность],
		DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE())) as [Стаж],
		empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [ФИО]
	from [employee] as empl join [history_of_positions] as his
		on empl.[id] = his.[employee_id]
	join [job_title] as job
		on his.[job_title_id] = job.[id]
	where 
		empl.[last_name] = N'Иванов' and
		empl.[first_name] = N'Иван' and
		empl.[middle_name] = N'Иванович'
end
go
--9)	Вывести количество должностей, которые занимал сотрудник «Иванов Иван Иванович», и общий стаж его работы.
begin
	select 
		count(job.[id]) as [Кол-во занимаемых должностей],
		sum(DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE()))) as [Общий стаж работы],
		empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [ФИО]
	from [employee] as empl join [history_of_positions] as his
		on empl.[id] = his.[employee_id]
	join [job_title] as job
		on his.[job_title_id] = job.[id]
	where 
		empl.[last_name] = N'Иванов' and
		empl.[first_name] = N'Иван' and
		empl.[middle_name] = N'Иванович'
	group by empl.[last_name], empl.[first_name], empl.[middle_name]
end
go
--10)	Вывести года увольнения и количество уволенных сотрудников за этот год. Результат упорядочить по убыванию годов увольнения.
begin
	select 
		year(miss.[date]) as [Год увольнения],
		count(miss.[employee_id]) as [Кол-во уволеных сотрудников]
	from [dismissal] as miss
	group by year(miss.[date])
end
go
--11)	Вывести список сотрудников и их родные города.
begin
	select
		empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [ФИО],
		city.[name] as [Город]
	from [employee] as empl join [city] as city
		on empl.[city_id] = city.[id]
	order by [ФИО]
end
go
--12)	Вывести всех сотрудников из города «Москва», которые отработали на должности «Программист» не менее 10 лет.
begin
	select
		empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [ФИО],
		city.[name] as [Город],
		job.[name] as [Должность],
		DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE())) as [Стаж]
	from [employee] as empl join [city] as city
		on empl.[city_id] = city.[id]
	join [history_of_positions] as his
		on empl.[id] = his.[employee_id]
	join [job_title] as job
		on his.[job_title_id] = job.[id]
	where
		city.[name] = N'Москва' and
		DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE())) >= 10
	order by DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE()))
end
go
--13)	Вывести город и количество сотрудников из этого города. 
--      Учитывать только те города, количество сотрудников в которых больше 4. 
--      Результат упорядочить по убыванию количества сотрудников.
begin
	select
		city.[name] as [Город],
		count(empl.[id]) as [Кол-во сотрудников]
	from [employee] as empl
	join [city] as city
		on empl.[city_id] = city.[id]
    group by [city].[name]
    having count([empl].[id]) > 4
    order by [Кол-во сотрудников] DESC
end
go
--14)	Вывести средний возраст уволенных сотрудников.
begin
	select
		AVG(DATEDIFF(YEAR, [empl].[date_of_birth], [miss].[date])) as [Средний возраст уволенных]
	from [employee] as empl
	join [dismissal] as miss
		on empl.[id] = miss.[employee_id]
end
go
--15)	Вывести ФИО в формате «Фамилия И.О.», пол, возраст и общий стаж работы сотрудника, который был уволен последним.
begin
	select
		empl.[last_name] + ' ' + empl.[first_name] + ' ' + empl.[middle_name] as [ФИО],
		empl.[gender] as [Пол], 
		DATEDIFF(YEAR, [empl].[date_of_birth], GETDATE()) as [Возраст],
		miss.[date] as [Дата увольнения],
		sum(DATEDIFF(YEAR, [his].[start_date], ISNULL([his].[end_date], GETDATE()))) as [Общий стаж работы]
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