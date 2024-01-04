/*
Created by: Eduardo Fernandez
Date: 01/04/2024
email: eduardo15191@gmail.com

The  script detects the tablenames on the description field and replaces it with a MarkDown link to make it interactive. In this case, names starts with "vw_ODBC_", the script gets the whole word (no matter the length). 

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

-- Creating a #work table to find the original word (tablename) and the MD link
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

--replacing the word with the MD link	
UPDATE  WL
SET WL.description = REPLACE(WL.description,W.word, W.NEW_WORD)
FROM #WorkList WL,
		#work W
where WL.partitionID = W.PartitionID
and WL.ID = w.ID;

-- GENERATION START
DECLARE @id int = 1

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

       --here you would need to add the code to export each MD file on a defined destination.

	drop table #temp;
	set @id = @id + 1;
END


drop table #WorkList;
drop table #listOfTables;
drop table #work;

