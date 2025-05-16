
--9) ������� ������ ������ ��� ����� ������ ��� �� ������ � 1 ���, 
--	 ������� ����� ��������� ������ ������, 
--   ������� ����� ��������� � �������� �������. 
--   ����-������ ������ ���� ��� �� ������������� � ����� ���� ������ ��� ������� �� 10 ��� ������. 
--   ��������� ������� � ����: 
--		��� �����, 
--		�������������, 
--		���� ������, 
--		������ ��������� �������� � ����: 
--			����_�������1 � ����_������_�������1, 
--			 ���_�������2 � ����_������_�������2, ��. 
--	 ����������� �� ��� �����, ����� �� ����� ������ �����.
--10) ������� ��������� ����� ������� ���� ��������� �� ������� ������ � ����: 
--		���� ������, 
--		����� ��������, 
--		����� ������, 
--		��� ��������. 
--    �� ��������� ���, � ������� � ����� ��� �������. 
--	  ����������� �� ��� ������ � �� ������� ������.

BEGIN -- �������� ���� ������
	IF DB_ID(N'practica7') IS NULL
		CREATE DATABASE [practica7]
	ELSE
		PRINT N'���� ������ practica7 ��� ����������'
END
GO
--�������. ��������� SQL-������ ��� ������� �������� �� ��, ���������� �������:
begin -- �������� ������
	USE [practica7]
	--�	������� (id_��������, ���, ���������, ���� ��������);
	IF OBJECT_ID(N'patient', N'U') IS NULL
        CREATE TABLE [patient](
            [id] INT NOT NULL IDENTITY PRIMARY KEY,
			[last_name] NVARCHAR(50),
            [first_name] NVARCHAR(50),
            [middle_name] NVARCHAR(50),
			[category] nvarchar(100),
			[b_date] date
        )
    ELSE
        PRINT N'������� patient ��� ����������'
	drop table [patient]
	--�	���� (id_�����, ���, �������������, ����, ���� ��������);
	IF OBJECT_ID(N'doctor', N'U') IS NULL
        CREATE TABLE [doctor](
            [id] INT NOT NULL IDENTITY PRIMARY KEY,
			[last_name] NVARCHAR(50),
            [first_name] NVARCHAR(50),
            [middle_name] NVARCHAR(50),
			[speciality] nvarchar(100),
			[work_experience] int,
			[b_date] date
        )
    ELSE
        PRINT N'������� doctor ��� ����������'
	drop table [doctor]
	--�	����� (id_������, id_��������, id_�����, ����/�����, �������).
	IF OBJECT_ID(N'doc_appointment', N'U') IS NULL
        CREATE TABLE [doc_appointment](
            [id] INT NOT NULL IDENTITY PRIMARY KEY,
			[patientId] int
				foreign key references[patient]([id]),
            [doctorId] int 
				foreign key references[doctor]([id]),
			[appointment_date] datetime2(0),
			[cabinet] smallint
        )
    ELSE
        PRINT N'������� doc_appointment ��� ����������'
	drop table [doc_appointment]
end
go

begin -- ���������� ������ �������
	-- �������
	INSERT INTO [patient] ([last_name], [first_name], [middle_name], [category], [b_date])
	values
		--10 �����������
		('���������', '�����',      '������������',  '���������',  '1940-07-22'),
		('���������', '����������', '���������',     '���������',  '1942-04-20'),
		('�������',   '�����',      '���������',     '���������',  '1945-03-30'),
		('������',    '�������',    '�������',       '���������',  '1947-06-22'),
		('�����',     '�����',      '����������',    '���������',  '1948-11-11'),
		('������',    '����',       '��������',      '���������',  '1950-01-15'),
		('�������',   '���������',  '��������',      '���������',  '1952-09-05'),
		('��������',  '������',     '����������',    '���������',  '1953-02-28'),
		('�������',   '�������',    '����������',    '���������',  '1955-05-25'),
		('������',    '�����',      '���������',     '���������',  '1958-08-30'),
		--11 ����������
		('�������',   '�������',    '�����������',   '����������', '1975-08-18'),
		('�����',     '��������',   '�������������', '����������', '1978-03-15'),
		('������',    '����',       '��������',      '����������', '1980-02-20'),
		('������',    '������',     '�����������',   '����������', '1981-05-10'),
		('���������', '�����',      '����������',    '����������', '1983-10-30'),
		('�����',     '������',     '��������',      '����������', '1985-06-12'),
		('�����',     '���������',  '��������',      '����������', '1986-09-18'),
		('�������',   '������',     '�������������', '����������', '1988-12-01'),
		('���������', '����',       '���������',     '����������', '1990-04-10'),
		('�������',   '�������',    '���������',     '����������', '1992-01-14'),
		('�������',   '�����',      '��������',      '����������', '1995-07-07'),
		--4 ���������
		('��������',  '�����',      '�������������', '���������',  '2000-02-03'),
		('��������',  '������',     '����������',    '���������',  '2001-03-04'),
		('���������', '���������',  '���������',     '���������',  '2002-04-05'),
		('������',    '�����',      '��������',      '���������',  '2003-05-06'),
		--5 ����������-��������������
		('������',    '���������',	'����������',	 '����������', '1965-02-15'),
		('�������',   '�����',		'�������������', '����������', '1966-04-10'),
		('��������',  '�����',		'��������',		 '����������', '1967-06-20'),
		('��������',  '�������',	'���������',	 '����������', '1968-08-30'),
		('�������',   '�����',		'����������',	 '����������', '1969-11-05');
		delete from [patient]
	-- ����
	INSERT INTO [doctor] ([last_name], [first_name], [middle_name], [speciality], [work_experience], [b_date]) 
	VALUES
		('�����',     '������',    '��������',     '��������',      0,         '1982-06-06'),
		('���������', '����',      '���������',    '��������',      0,         '1985-04-04'),
		('�������',   '�������',   '�����������',  '��������',      5,         '1983-08-08'),
		('������',    '����',      '��������',     '��������',      10,        '1970-01-01'),		
		('������',    '����',      '��������',     '��������',      15,        '1980-02-02'),
		('���������', '�����',     '����������',   '��������',      20,        '1976-10-10'),

		('���������', '�����',     '������������', '�������',       0,         '1978-07-07'),
		('�������',   '�����',     '���������',    '������',        11,        '1975-03-03'),
		
		('�������',   '�������',   '����������',   '��������',      8,         '1990-05-05'),

		('�������',   '���������', '��������',     '�������������', 3,         '1989-09-09');
		delete from [doctor]
	-- ����� � �����
	INSERT INTO [doc_appointment] ([patientId], [doctorId], [appointment_date], [cabinet]) 
	VALUES
		(1,  1,  '2024-01-05 10:00:00', 101),
		(1,  2,  '2024-02-06 10:30:00', 102),
		(2,  1,  '2024-03-07 11:00:00', 101),
		(3,  1,  '2024-03-05 10:00:00', 101),
		(4,  2,  '2024-04-06 10:30:00', 102),
		(5,  7,  '2024-04-07 11:00:00', 104),
		(4,  1,  '2024-05-05 10:00:00', 101),
		(5,  2,  '2024-05-06 10:30:00', 102),
		(6,  1,  '2024-05-07 11:00:00', 101),
		(7,  1,  '2024-06-05 10:00:00', 101),
		(8,  2,  '2024-06-06 10:30:00', 102),
		(9,  7,  '2024-07-06 11:00:00', 104),
		(1,  1,  '2024-07-06 10:00:00', 101),
		(1,  2,  '2024-07-06 10:30:00', 102),
		(2,  1,  '2024-07-07 11:00:00', 101),
		(1,  1,  '2024-07-07 10:00:00', 101),
		(1,  2,  '2024-07-07 10:30:00', 102),
		(1,  2,  '2024-07-07 10:30:00', 102),
		(3,  1,  '2024-08-05 10:00:00', 101),
		(4,  2,  '2024-09-03 10:30:00', 102),
		(5,  7,  '2024-09-03 11:00:00', 104),
		(4,  1,  '2024-09-05 10:00:00', 101),
		(5,  2,  '2024-10-01 10:30:00', 102),
		(6,  1,  '2024-10-01 11:00:00', 101),
		(7,  1,  '2024-11-05 10:00:00', 101),
		(8,  2,  '2024-12-09 10:30:00', 102),
		(9,  7,  '2024-12-09 11:00:00', 104),

		(3,  3,  '2025-04-08 09:00:00', 103),
		(4,  4,  '2025-04-09 10:00:00', 104),
		(5,  1,  '2025-04-10 11:30:00', 101),
		(6,  2,  '2025-04-11 09:30:00', 102),
		(7,  1,  '2025-04-12 10:30:00', 101),
		(8,  3,  '2025-04-13 11:00:00', 103),
		(9,  7,  '2025-04-14 09:00:00', 104),
		(10, 5,  '2025-04-15 10:00:00', 101),
		(11, 2,  '2025-04-16 11:30:00', 102),
		(12, 3,  '2025-04-17 09:30:00', 103),
		(13, 4,  '2025-04-18 10:00:00', 104),
		(14, 1,  '2025-04-19 11:00:00', 101),
		(15, 2,  '2025-04-20 09:00:00', 102),
		(16, 3,  '2025-04-21 10:30:00', 103),
		(17, 8,  '2025-04-22 11:00:00', 104),
		(18, 1,  '2025-04-23 09:00:00', 101),
		(19, 2,  '2025-04-24 10:00:00', 102),
		(20, 3,  '2025-04-25 11:30:00', 103),
		(21, 4,  '2025-04-26 10:00:00', 104),
		(22, 6,  '2025-04-27 11:00:00', 101),
		(23, 9,  '2025-04-28 09:30:00', 102),
		(24, 3,  '2025-04-29 10:00:00', 103),
		(25, 4,  '2025-04-30 11:30:00', 104),
		(26, 1,  '2025-04-30 11:30:00', 101),
		(26, 7,  '2025-04-30 12:00:00', 104),
		(27, 2,  '2025-04-30 11:30:00', 101),
		(27, 7,  '2025-04-30 11:30:00', 104),
		(28, 1,  '2025-04-30 11:30:00', 101),
		(28, 1,  '2025-05-30 11:30:00', 104),
		(28, 1,  '2025-06-30 11:30:00', 101),
		(29, 1,  '2025-04-30 11:30:00', 104),
		(29, 1,  '2025-05-30 11:30:00', 104),
		(29, 1,  '2025-06-30 11:30:00', 104),
		(16, 1,  '2025-04-05 10:00:00', 101),
		(17, 10, '2025-04-06 10:30:00', 102),
		(18, 3,  '2025-04-07 11:00:00', 103),
		(19, 9,  '2025-04-08 09:00:00', 104),
		(9,  7,  '2025-04-09 09:30:00', 104),
		(20, 7,  '2025-04-10 10:00:00', 101),
		(11, 4,  '2025-04-10 11:00:00', 104);
		delete from [doc_appointment]
end
go
--�������:
	--1) ������� ���������, ���������� ����� � ������� ����, � ������, ��������� ��������� ���� � ������� ����. 
	--   ��������� ������� � ����: 
	--		id (��������/ �����), 
	--		��� (��������/�����); 
	--		������� (����� ������� � ��������/�����); 
	--		��� (��������/ ������). 
	--   ����������� �� �����, ����� �� ���.
begin
	SELECT 
		pat.[id] AS [��� �����/��������],
		pat.[last_name] + ' ' + pat.[first_name] + ' ' + pat.[middle_name] AS [��� �����/��������],
		COUNT(doc_app.[id]) AS [���������� �������],
		'�������' AS [���]
	FROM [patient] as pat
	JOIN [doc_appointment] as doc_app 
		ON pat.[id] = doc_app.[patientId]
	WHERE 
		YEAR(doc_app.[appointment_date]) = YEAR(GETDATE())
	GROUP BY 
		pat.[id], 
		pat.[last_name], 
		pat.[first_name], 
		pat.[middle_name]
UNION
	SELECT 
		doc.[id] AS [��� �����/��������],
		doc.[last_name] + ' ' + doc.[first_name] + ' ' + doc.[middle_name] AS [��� �����/��������],
		COUNT(doc_app.id) AS [���������� �������],
		'����' AS [���]
	FROM [doctor] as doc
	JOIN [doc_appointment] as doc_app 
		ON doc.[id] = doc_app.[doctorId]
	WHERE 
		YEAR(doc_app.[appointment_date]) = YEAR(GETDATE())
	GROUP BY 
		doc.[id], 
		doc.[last_name], 
		doc.[first_name], 
		doc.[middle_name]
ORDER BY 
    [���], [��� �����/��������];

end
go
	--2) ������� �������� � ������-���������� � �������������� � ������ �������� ���� ������ 0,75. 
	--   �������: id, ���, ���������� �������� ���������. 
	--   ������������� = ���������� �������� ���������/200. 
	--   �� ��������� ��������� ��������� ����������. ����������� �� ��� ������.
begin
	select
		doc.[id] as [��� �����],
		doc.[last_name] + ' ' + 
		doc.[first_name] + ' ' + 
		doc.[middle_name] AS [���],
		count(doc_app.[id]) as [���������� �������� ���������]
	FROM [doctor] as doc
	JOIN [doc_appointment] as doc_app 
		ON doc.[id] = doc_app.[doctorId]
	where
		doc.[speciality] = '��������'
	group by
		doc.[id],
		doc.[last_name],
		doc.[first_name],
		doc.[middle_name]
	having
		count(doc_app.[id]) / 200 > 0.75
	order by
		[���]
end
go
	--3) ������� ���������� ���������: 
	--		��������� ���������, 
	--		���������� ������� ��������� ���� ���������, 
	--		���������� ������ ��������� ��������� ���� ���������. 
	--   �� ��������� ���������, ���������� �� 1 ������ 1976 ���� � ������ �� ������ ����� 1 ����. 
	--   ����������� �� ����������.
begin
	select
		pat.[category] as [��������� ��������],
		count(doc_app.[id]) as [���������� ������� ��������� ���� ���������],
		count(distinct doc.[id]) as [���������� ������ ��������� ��������� ���� ���������]
	from [patient] as pat
	join [doc_appointment] as doc_app
		on pat.[id] = doc_app.[patientId]
	join [doctor] as doc
		on doc.[id] = doc_app.[doctorId]
	where
		pat.[b_date] > '1976-01-01' and 
		doc.[work_experience] >= 1
	group by
		pat.[category]
	order by
		pat.[category]
end
go
	--4) ������� �������� � ������ ��� �� �������������, 
	--   ��� � ���� � ��� ������� ���� ���������, 
	--   �� ��������� � ������� ���� ������ ���������. 
	--   ������� id, ���, ����� �������� ���������.
begin
	select
		doc.[id] as [��� �������],
		doc.[last_name] + ' ' + 
		doc.[first_name] + ' ' + 
		doc.[middle_name] as [��� �����],
		count(doc_app.[id]) as [����� �������� ���������]
	from [doc_appointment] as doc_app
	join [doctor] as doc
		on doc.[id] = doc_app.[doctorId]
	where
		doc.[speciality] = 
		(
			select 
				doc.[speciality]
			from [doctor] as doc
			where 
				doc.[last_name] = '������' and
			    doc.[first_name] = '����' and
			    doc.[middle_name] = '��������'
		) and
		year(doc_app.[appointment_date]) = year(GETDATE())
	group by
		doc.[id],
		doc.[last_name],
		doc.[first_name],
		doc.[middle_name]
	having 
		count(doc_app.[id]) > 
	(
		select 
			count(doc_app.[id])
		from [doc_appointment] as doc_app
		join [doctor] as doc
			on doc.[id] = doc_app.[doctorId]
		where
			doc.[last_name] = '������' and
			doc.[first_name] = '����' and
			doc.[middle_name] = '��������' and
			year(doc_app.[appointment_date]) = year(getdate())
	)
	order by
		[��� �����];
end
go
	--5) ������� id � ��� ���������, �� ���������� � ������� ���� �� ������ ����� �� ���, 
	--   ������� ������� ������� ������� �.�.� 
	--   ������������� ��������� � �������� ������� �� id.
begin
	select distinct
		pat.[id] as [��� ��������],
		pat.[last_name] + ' ' + 
		pat.[first_name] + ' ' + 
		pat.[middle_name] as [��� ��������]
	from [patient] as pat
	join [doc_appointment] as [doc_app]
		on pat.[id] = doc_app.[patientId]
	where
		pat.[id] not in
		(
			select doc_app.[patientId]
			from [doc_appointment] as doc_app
			where 
				doc_app.[doctorId] in 
				(
					select
						doc_app.[doctorId]
					from [doc_appointment] as doc_app
					join [patient] as pat
						on doc_app.[patientId] = pat.[id]
					where
						pat.[last_name] = '������' and
						pat.[first_name] = '����' and
						pat.[middle_name] = '��������'
				) and
				year(doc_app.[appointment_date]) = year(getdate())
				)
			
	order by
		[��� ��������] desc
end
go
	--6) ������� id � ��� ��������� ��������� ����������, 
	--   ������� � ������� ���� ���� �� �������� �����-���������, 
	--   ���� �������� ������������ �����-��������. 
	--   ��������� ����������� �� ��� ��������.
begin
	select distinct
		pat.[id] as [��� ��������],
		pat.[last_name] + ' ' + 
		pat.[first_name] + ' ' + 
		pat.[middle_name] as [��� ��������]
	from [patient] as pat
	join [doc_appointment] as doc_app
		on doc_app.[patientId] = pat.[id]
	where
		pat.[category] = '���������' and
		doc_app.[doctorId] not in
		(
			select
				doc_app.[doctorId]
			from [doctor] as doc
			join [doc_appointment] as doc_app
				on doc_app.[doctorId] = doc.[id]
			where
				doc.[speciality] = '��������' and
				year(doc_app.[appointment_date]) = year(getdate())
		) and
		year(doc_app.[appointment_date]) = year(getdate())

end
go
--7) ������� ���� ��������� ��������������� �������� (55-60 ��� ������������), 
--   ������� � ���� ���� �������� ����� 2� ������, 
--   ��� 3 ���� � ������ �������� ������� ����� ���������. 
--   ��������� ������� � ����: 
--		��� ��������, 
--		���������� ���������, 
--		��������� �������� (���� �� 2�: 
--			������� 2 ������, 
--			������� 3 ���� ��� ����� ����� ������� �. �.�). 
--   ��������� ����������� �� ��������� ��������, � ����� �� ���������� ��������� �� ��������.
begin
	select
		pat.[last_name] + ' ' + 
		pat.[first_name] + ' ' + 
		pat.[middle_name] as [��� ��������],
		count(doc_app.id) as [2 ���������/3 ��������� ������]
	from patient as pat
	join doc_appointment as doc_app
		on pat.id = doc_app.patientId
	where
		year(GETDATE()) - year(pat.b_date) >= 55 and
		year(GETDATE()) - year(pat.b_date) <= 60
	group by
		pat.[last_name],
		pat.[first_name],
		pat.[middle_name]
	having
		count(doc_app.[id]) = 2
union
	select
		pat.[last_name] + ' ' + 
		pat.[first_name] + ' ' + 
		pat.[middle_name] as [��� ��������],
		count(doc_app.id) as [2 ���������/3 ��������� ������]
	from patient as pat
	join doc_appointment as doc_app
		on pat.id = doc_app.patientId
	join doctor as doc
		on doc.id = doc_app.doctorId
	where
		year(GETDATE()) - year(pat.b_date) >= 55 and
		year(GETDATE()) - year(pat.b_date) <= 60 and
		doc.id = (
			select
				doc.id
			from doctor as doc
			where
				doc.last_name = '�����' and
				doc.first_name = '������' and
				doc.middle_name = '��������'
		)

	group by
		pat.[last_name],
		pat.[first_name],
		pat.[middle_name]
	having
		count(doc_app.[id]) >= 3
order by
	[2 ���������/3 ��������� ������] desc
end
go
--8) ��� ������� ������ �������� ���� ������� ����� ����������� ���� �� ����������. 
--   ��������� ������� ����: 
--		�������� ������, 
--		���� (� ���� ������������, 12 �����), 
--		���������� ���������.
BEGIN
    SELECT
        DATENAME(MONTH, doc_app.appointment_date) AS [�����],
        FORMAT(doc_app.appointment_date, 'dddd, dd MMMM', 'ru-RU') AS [����],
        COUNT(doc_app.id) AS [���-�� ���������]
    FROM doc_appointment AS doc_app
    WHERE
        YEAR(doc_app.appointment_date) = YEAR(GETDATE()) - 1
    GROUP BY
        DATENAME(MONTH, doc_app.appointment_date),
        FORMAT(doc_app.appointment_date, 'dddd, dd MMMM', 'ru-RU'),
        MONTH(doc_app.appointment_date),
        DAY(doc_app.appointment_date)
    HAVING 
        COUNT(doc_app.id) = (
            SELECT MAX(VisitCount)
            FROM (
                SELECT 
                    COUNT(inner_doc.id) AS VisitCount,
                    MONTH(inner_doc.appointment_date) AS MonthNumber
                FROM 
                    doc_appointment AS inner_doc
                WHERE 
                    YEAR(inner_doc.appointment_date) = YEAR(GETDATE()) - 1
                GROUP BY 
                    DAY(inner_doc.appointment_date),
                    MONTH(inner_doc.appointment_date)
            ) AS SubQuery
            WHERE 
                SubQuery.MonthNumber = MONTH(doc_app.appointment_date)
        )
    ORDER BY 
        MONTH(doc_app.appointment_date),
        [����],
        [���-�� ���������] DESC;
END
GO

