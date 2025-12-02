-- Predict ALTER INDEX REORGANIZE finish time
/* 
Question: I’ve issued a ALTER INDEX REORGANIZE command on a CLUSTERED INDEX of approximately 300 million rows. 
How can I estimate the completion time?

Answer: Using the SQL Server DMV sys.dm_exec_requests , assists in estimating the finish time. 
The percent_complete and estimated_completion columns are useful.

I’ve included a sample query , which returns a percent complete and estimated completion. 
Use it for:  BACKUP \ RESTORE, DBCC CHECKDB , DBCC CHECKTABLE,DBCC SHRINKDB , dbcc SHRINKFILE,DBCC INDEXDEFRAG,ALTER INDEX REORGANIZE, ROLLBACK

*/ 

SELECT session_id,percent_complete,DATEADD(MILLISECOND,estimated_completion_time,CURRENT_TIMESTAMP) Estimated_finish_time,
(total_elapsed_time/1000)/60 Total_Elapsed_Time_MINS ,
DB_NAME(Database_id) Database_Name ,command,sql_handle
FROM sys.dm_exec_requests WHERE session_id=56

