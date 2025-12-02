/*
Who made DDL table changes on the database.
Question:

Some DDL changes have occurred on the SQL Server database. Can I find out who made the changes?
Answer:

Yes. The SQL Server default trace has the Object Altered event. 

Read this FAQ for details on SQL default trace
*/ 

-- This script will list all Object Altered event. 
-- Add WHERE predicates on date and databasename to refine  the search and isolate the DDL change

select e.name as eventclass,t.loginname, t.spid, t.starttime, 
t.textdata, t.objectid, t.objectname, t.databasename, 
t.hostname, t.ntusername, 
t.ntdomainname, t.clientprocessid, t.applicationname, t.error 
FROM sys.fn_trace_gettable(CONVERT(VARCHAR(150), ( SELECT TOP 1
f.[value]
FROM sys.fn_trace_getinfo(NULL) f
WHERE f.property = 2
)), DEFAULT) T
inner join sys.trace_events e on t.eventclass = e.trace_event_id
where eventclass=164

