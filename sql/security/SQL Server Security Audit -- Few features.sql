/* 
How to create a SQL Server Security Audit
Question:  I’d like to create  a regular SQL Server security audit. 
This information will be scanned by an internal audit tool . 
Could you recommend a list of SQL Server procedures to cover users and objects?

I’ve already ready through the post : Powershell sql server security audit ,  but I’d like to focus on objects and user privileges 

Answer:   These queries and procedures cover the basics of user and object level privileges.

Gather these recordsets and  run the rules over the data regularly. 
Highlight any  disparities with the SQL Server Security Policy

*/ 

--Contains one row for each logon account.
--The system views are : sys.sql_logins , sys.server_principals , but use this one. 
select * from    sys.syslogins


--Reports the login security configuration of Microsoft® SQL Server™
--Is a deprecated feature 
exec xp_loginconfig

--Returns version information about Microsoft SQL Server
exec xp_msver

--Returns one row for each table privilege that is granted to or granted by the current user in the current database. 
Exec sp_table_privileges  '%'

--Returns information about the roles in the current database.
--sp_helprole for every database
exec sp_helprole

--Reports information about database-level principals in the current database
--sp_helpuser for every database 
exec sp_helpuser

--Returns the physical names and attributes of files associated with the current database. 
--Use this stored procedure to determine the names of files to attach to or detach from the server. 
--sp_helpfile for every database
exec sp_helpfile

--Returns a report that has information about user permissions for an object, or statement permissions, in the current database. 
--sp_helprotect for every database
exec sp_helprotect

