

-- Killing Active Sessions for Particular Database 

DECLARE @DatabaseName nVARCHAR(50) 
DECLARE @SPId int
DECLARE @SQL nvarchar(100)
SET @DatabaseName = 'RepPrinciaplDB'--DB NAME

DECLARE my_cursor CURSOR FAST_FORWARD FOR
SELECT SPId FROM MASTER..SysProcesses
WHERE DBId = DB_ID(@DatabaseName) AND SPId <> @@SPId

OPEN my_cursor

FETCH NEXT FROM my_cursor INTO @SPId

WHILE @@FETCH_STATUS = 0
BEGIN
SET @SQL = 'KILL ' + CAST(@SPId as nvarchar(50))
print @SQL
EXEC sp_executeSQL @SQL

FETCH NEXT FROM my_cursor INTO @SPId
END

CLOSE my_cursor
DEALLOCATE my_cursor

GO

