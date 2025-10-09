

/* I always run following DBCC command before I started to use my query. 
Following DBCC commands clears the cache of the server and starts fresh logging of the query running time.
*/ 
DBCC FREEPROCCACHE

/* Run following query to find longest running query using T-SQL. */ 

SELECT DISTINCT TOP 10
t.TEXT QueryName,
s.execution_count AS ExecutionCount,
s.max_elapsed_time AS MaxElapsedTime,
ISNULL(s.total_elapsed_time / s.execution_count, 0) AS AvgElapsedTime,
s.creation_time AS LogCreatedOn,
ISNULL(s.execution_count / DATEDIFF(s, s.creation_time, GETDATE()), 0) AS FrequencyPerSec
FROM sys.dm_exec_query_stats s
CROSS APPLY sys.dm_exec_sql_text( s.sql_handle ) t
ORDER BY
s.max_elapsed_time DESC
GO
/*
You can also add WHERE clause to above T-SQL query and filter additionally.

If you have not ran query like this previously on your server I strongly recommend to run this. I bet you will find surprising results.
*/ 