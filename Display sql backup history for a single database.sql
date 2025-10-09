---- Display sql backup history for a single database 

/* 
For Backup history read  SQL Server - Display restore history for a single database

The backupset table contains backup sets. The backup set maintains backup information for a successful operation

The script doesn’t display all information in the tables. It contains enough  backup set information – to make some decisions. Such as:

a)       Which Differential Base backup to restore? Can the Differential be Restored?

b)       How many Differentials to roll forward?

c)       What backups are available to SQL database Restore?

d)       Has there been a SQL Backup ?

 e) SQL Server RESTORE DIFFERENTIAL BACKUP WITH SIMPLE RECOVERY

*/ 
--Display backup history for a single database 
use Azmath_two 
GO
SELECT bus.server_name as 'server',
bus.database_name as 'database',
CAST(bus.backup_size /1024/1024/1024 AS DECIMAL(10,2)) as 'buSize_GB',
CAST(DATEDIFF(ss, bus.backup_start_date,bus.backup_finish_date) AS VARCHAR(4)) as 'buDuration_Sec',
bus.backup_start_date as 'buDateStart',
CAST(bus.first_lsn AS VARCHAR(50)) as LSN_First,
CAST(bus.last_lsn AS VARCHAR(50)) as LSN_Last,
CASE bus.[type]
WHEN 'D' THEN 'Full'
WHEN 'I' THEN 'Differential'
WHEN 'L' THEN 'Transaction Log'
WHEN 'F' THEN 'File\FileGroup'
WHEN 'G' THEN 'Differential File'
WHEN 'P' THEN 'Partial'
WHEN 'Q' THEN 'Differential Partial'
END AS buType,
bus.begins_log_chain ,
bus.differential_base_lsn,
bus.recovery_model,
bume.physical_device_name
FROM msdb.dbo.backupset bus
INNER JOIN msdb.dbo.backupmediafamily bume ON bus.media_set_id = bume.media_set_id
WHERE bus.database_name = DB_NAME() 
ORDER BY bus.backup_start_date DESC, bus.backup_finish_date DESC
GO
