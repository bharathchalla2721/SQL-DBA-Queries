/*
SQL Server – How to troubleshoot query timeouts
Common reasons for query time-outs are :

1)     The application starts using a query not optimal for the index

2)     Hardware changes\ Configuration changes

3)     Increased load

If you suspect the query time-out is due to memory issue , continue reading.

Debugging a query-timeout is tricky. If it’s a Production system and users are experiencing timeouts – pressure mounts on the DBA. 
The application owner starts looking towards the DBA , for reasons and a solution. (and to blame)

Isolate the problem by using a systematic approach . There are multiple approaches to any problem –

A system for debugging a query-timeout.  
Each problem has it’s own characteristics – using this system , should give you enough ideas. 
*/ 


/* 

Step 1 – system memory status
Use sys.dm_os_memory_clerks, sys.dm_os_sys_info, and memory performance counters.

*/ 
-- sys.dm_os_memory_clerks
select  memory_clerk_address,type,single_pages_kb,awe_allocated_kb
from  sys.dm_os_memory_clerks
--sys.dm_os_sys_info
select physical_memory_in_bytes,virtual_memory_in_bytes,bpool_committed ,bpool_committed ,bpool_commit_target from sys.dm_os_sys_info
--memory performance counters
--"\Memory\Available MBytes" 
--"\Memory\Page Faults/sec" 
--"\Memory\Pages/sec" 
--"\Memory\Paging File(_Total)\%Usage" 

 /* 
 Step 2 – query execution memory reservations

 */ 

select * from sys.dm_os_memory_clerks where type = 'MEMORYCLERK_SQLQERESERVATIONS'

 
/* Step 3 – identify queries waiting memory grants */ 

SELECT * from . sys.dm_exec_query_memory_grants

 
/* Step 4 – identify more memory-intensive queries */ 

select session_id, command,  status, sql_handle from sys.dm_exec_requests 

 
/* Step 5 – Analyse and fix Query from cache. Work with developers to overcome any bottlenecks */ 

SQL Server query plans in cache

 