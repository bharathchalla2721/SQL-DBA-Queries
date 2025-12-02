-- Monitoring a Rollback and sys.dm_exec_requests

/* 

The dynamic management view (DMV) sys.dm_exec_requests returns information about each request that is executing within SQL Server.

Instead of using Activity Monitor to view the status of a Rollback , use this T-SQL code. 

Activity monitor is based on window panes and is cumbersome to export any information.

Using  t-sql allows extra flexibility in reporting.

*/ 
 

select 
der.session_id, 
der.command, 
der.status, 
der.percent_complete
from sys.dm_exec_requests as der
where command IN ('killed/rollback','rollback')

