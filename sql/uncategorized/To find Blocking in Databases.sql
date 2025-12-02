

---- TYPE 1 :: To find Blocking in Databases using SP_who 
use master 
go 
sp_who2 --/sp_who

---- TYPE 2 :: To find Blocking in Databases using DMV 
USE Master
GO
SELECT * 
FROM sys.dm_exec_requests
WHERE blocking_session_id <> 0;
GO

---- TYPE 3 :: To find Blocking in Databases using DMV / using Waiting task DMV
USE Master
GO
SELECT session_id, wait_duration_ms, wait_type, blocking_session_id 
FROM sys.dm_os_waiting_tasks 
WHERE blocking_session_id <> 0
GO

---- TYPE 4 :: To find Blocking in Databases using Activity monitor
Right Click -> Activity Monitor -> Processes -> Blocked BY ::: Here it will show the blocking SPID 


---- TYPE 5 :: To find Blocking in Databases using Activity monitor
Right click on Tasks -> reports -> Standard Reports -> Activity - All Blocking Transactions