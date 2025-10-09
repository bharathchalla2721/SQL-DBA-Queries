-- Is there data in the second file of tempdb?
--drop table #sfs
--drop table #fixed_drives
--drop table #output_table
--drop table #databases
--drop table #dbf
--drop table #fg
--—————————————
-- Save result set from showfilestats
--—————————————
CREATE TABLE #sfs (    fileid            tinyint
                    , filegroupid    tinyint
                    , totalextents    int
                    , usedextents    int
                    , dbfilename    sysname
                    , physfile        varchar(255) );
    
--——————————————--
-- Save result set from sys.database_files
--——————————————--
CREATE TABLE #dbf (    [file_id]                int
                    , file_guid                uniqueidentifier
                    , [type]                tinyint
                    , type_desc                nvarchar(60)
                    , data_space_id            int
                    , [name]                sysname
                    , physical_name            nvarchar(260)
                    , [state]                tinyint
                    , state_desc            nvarchar(60)
                    , size                    int
                    , max_size                int
                    , growth                int
                    , is_media_ro            bit
                    , is_ro                    bit
                    , is_sparse                bit
                    , is_percent_growth        bit
                    , is_name_reserved        bit
                    , create_lsn            numeric(25, 0)
                    , drop_lsn                numeric(25, 0)
                    , read_only_lsn            numeric(25, 0)
                    , read_write_lsn        numeric(25, 0)
                    , diff_base_lsn            numeric(25, 0)
                    , diff_base_guid        uniqueidentifier
                    , diff_base_time        datetime
                    , redo_start_lsn        numeric(25, 0)
                    , redo_start_fork_guid    uniqueidentifier
                    , redo_target_lsn        numeric(25, 0)
                    , redo_target_fork_guid    uniqueidentifier
                    , back_lsn                numeric(25, 0) );
                    
--——————————————--
-- Save result set from sys.filegroups select * from sys.filegroups
--——————————————--
CREATE TABLE #fg (    [name]                sysname
                    , data_space_id        int
                    , [type]            char(2)
                    , type_desc            nvarchar(60)
                    , is_default        bit
                    , [filegroup_id]    uniqueidentifier
                    , log_filegroup_id    int
                    , is_read_only        bit );
                    
-- Populate #disk_free_space with data 
    
CREATE TABLE #fixed_drives (DriveLetter    char(1) NOT NULL
                            , FreeMB    int NOT NULL );

INSERT INTO #fixed_drives
    EXEC master..xp_fixeddrives;
    
CREATE TABLE #output_table (DatabaseName    sysname
                            , FG_Name        sysname
                            , GB_Allocated    numeric(8, 2)
                            , GB_Used        numeric(8, 2)
                            , GB_Available    numeric(8, 2)
                            , DBFilename    sysname
                            , PhysicalFile    sysname
                            , Free_GB_on_Drive    numeric(8, 2) );
                            
SELECT    name AS DBName
INTO    #databases
FROM    sys.databases
WHERE    database_id <= 4
AND        state_desc = 'ONLINE';

DECLARE    @dbname    sysname;

SELECT    @dbname = (    SELECT    TOP (1) DBName FROM    #databases);
DELETE FROM #databases WHERE DBName = @dbname;

WHILE @dbname IS NOT NULL
BEGIN

    -- Get the file group data
    INSERT INTO #sfs            
        EXEC('USE '+ @dbname + '; DBCC showfilestats;');
        
    INSERT INTO #dbf
        EXEC('USE '+ @dbname + '; SELECT * FROM sys.database_files;');
        
    INSERT INTO #fg
        EXEC('USE '+ @dbname + '; SELECT * FROM sys.filegroups;');
        
    -- Wrap it up!
    INSERT INTO #output_table    (DatabaseName
                                , FG_Name
                                , GB_Allocated
                                , GB_Used
                                , GB_Available
                                , DBFilename
                                , PhysicalFile
                                , Free_GB_on_Drive )
        SELECT    @dbname AS DATABASE_NAME
                , fg.name AS [File Group Name]
                , CAST(((sfs.totalextents * 64.0) / 1024000.0) AS numeric(8, 2)) AS GB_Allocated
                , CAST(((sfs.usedextents * 64.0) / 1024000.0) AS NUMERIC(8, 2)) AS GB_Used
                , CAST((((sfs.totalextents - sfs.usedextents) * 64.0) / 1024000.0) AS NUMERIC(8, 2)) AS GB_Available
                , sfs.dbfilename
                , sfs.physfile
                , CAST((fd.FreeMB / 1000.0) AS NUMERIC(8, 2)) AS Free_GB_on_Drive
        FROM        #sfs sfs
                INNER JOIN #dbf dbf
                    ON    dbf.[file_id] = sfs.fileid
                INNER JOIN #fg fg
                    ON fg.data_space_id = sfs.filegroupid
                INNER JOIN #fixed_drives fd
                    ON    fd.DriveLetter = SUBSTRING(sfs.physfile, 1, 1);
    
    SELECT    @dbname = (    SELECT    TOP (1) DBName FROM    #databases);
    IF @dbname IS NOT NULL
        DELETE FROM #databases WHERE DBName = @dbname;
        
    TRUNCATE TABLE #sfs;
    TRUNCATE TABLE #dbf;
    TRUNCATE TABLE #fg;
END

SELECT    CONVERT(int, CONVERT(char, current_timestamp, 112)) AS CaptureDate
        , DatabaseName
        , FG_Name
        , GB_Allocated
        , GB_Used
        , GB_Available
        , DBFilename
        , PhysicalFile
        , Free_GB_on_Drive
FROM    #output_table
ORDER BY DatabaseName
        , FG_Name