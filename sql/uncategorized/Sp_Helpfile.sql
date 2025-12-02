use Azmath_Two 
go 
dbcc checkconstraints(dbo.emp)

exec sp_server_info


use tempdb 
go 
sp_helpfile 

--tempdev	1	
--templog	2	

USE master
GO
ALTER DATABASE TempDB MODIFY FILE
(NAME = tempdev, FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MOMEN_TWO\MSSQL\DATA\tempdb.mdf')
GO
ALTER DATABASE TempDB MODIFY FILE
(NAME = templog, FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MOMEN_TWO\MSSQL\DATA\templog.ldf')
GO
