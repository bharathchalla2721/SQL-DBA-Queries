/* 

The script doesn’t display all information in the tables. 
It contains enough  restore  information – to make some decisions. Such as:
a)       Which LSN was restored?
b)       What type of restore ?
c)       Has there been a SQL Restore ?

*/ 
select bus.server_name as 'server',rh.restore_date,bus.database_name as 'database',
  CAST(bus.first_lsn AS VARCHAR(50)) as LSN_First,
CAST(bus.last_lsn AS VARCHAR(50)) as LSN_Last,
CASE rh.[restore_type]
WHEN 'D' THEN 'Database'
WHEN 'F' THEN 'File'
WHEN 'G' THEN 'Filegroup'
WHEN 'I' THEN 'Differential'
WHEN 'L' THEN 'Log'
WHEN 'V' THEN 'Verifyonly'
END AS rhType
FROM msdb.dbo.backupset bus
INNER JOIN msdb.dbo.restorehistory rh ON rh.backup_set_id = bus.backup_set_id

 