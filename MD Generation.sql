/*
Source of Data:
create table PMStructure(
tableName varchar(100),
columnName varchar(100),
dataType varchar(100),
description varchar(6000)
)

to do in excel

=CONCAT("insert into PMStructure VALUES ('",A2,"','",B2,"','",C2,"','",D2,"');")

replicate table names on blank spaces

*/
create table #listOfTables
(ID int NOT NULL IDENTITY(1,1),
tableName varchar(100))

--list of tables to loop
insert into #listOfTables
select distinct tableName from PMStructure;

--list to work
create table #WorkList
(ID int,
 PartitionID int,
 tableName varchar(100),
 columnName varchar(100),
 dataType varchar(100),
 description varchar(6000))

insert into #WorkList
select (select distinct l.ID from #listOfTables l where l.tableName = PM.tableName),
		ROW_NUMBER() OVER(PARTITION BY tableName ORDER BY tableName asc) AS tableRows,
		*
from PMStructure PM;

select distinct  SUBSTRING(description, CHARINDEX('vw_ODBC_', description), 
                 CHARINDEX(' ', description + ' ', CHARINDEX('vw_ODBC_', description)) - CHARINDEX('vw_ODBC_', description)) AS WORD,
	   '['+SUBSTRING(description, CHARINDEX('vw_ODBC_', description), 
                 CHARINDEX(' ', description + ' ', CHARINDEX('vw_ODBC_', description)) - CHARINDEX('vw_ODBC_', description))+'](./'+
		SUBSTRING(description, CHARINDEX('vw_ODBC_', description), 
                 CHARINDEX(' ', description + ' ', CHARINDEX('vw_ODBC_', description)) - CHARINDEX('vw_ODBC_', description))+')' 
				 AS NEW_WORD,
		partitionID,
		id
INTO #work
from #WorkList
where SUBSTRING(description, CHARINDEX('vw_ODBC_', description), 
                 CHARINDEX(' ', description + ' ', CHARINDEX('vw_ODBC_', description)) - CHARINDEX('vw_ODBC_', description)) like 'vw_ODBC_%'

UPDATE  WL
SET WL.description = REPLACE(WL.description,W.word, W.NEW_WORD)
FROM #WorkList WL,
		#work W
where WL.partitionID = W.PartitionID
and WL.ID = w.ID;

-- GENERATION START
DECLARE @id int = 1,
	 @Text  VARCHAR(max),
	 @FileName  varchar(100),
	 @Cmd  VARCHAR(100);

WHILE ((select count(*) from #listOfTables where id = @id) > 0)
BEGIN
	
	create table #temp(script varchar(6000));
	--header 
	insert into #temp 
	select '# '+tableName from #listOfTables where id = @id
	--header space
	insert into #temp values('');
	insert into #temp values('');
	-- table header
	insert into #temp values('|Column Name|Data Type|Description|');
	insert into #temp values('|-|:-:|-|');
	-- table body
	insert into #temp
	select '|'+columnName+'|'+dataType+'|'+description+'|'
	from #WorkList where id = @id;
	--footer space
	insert into #temp values('');
	insert into #temp values('');
	-- footer
	insert into #temp values('[< Back to Index](../README.MD)');

	select * from #temp;

	drop table #temp;
	set @id = @id + 1;
END


drop table #WorkList;
drop table #listOfTables;
drop table #work;

