

-- Clears the cache

dbcc sqlperf (UMSStats, clear)
dbcc sqlperf (WaitStats, clear)
dbcc sqlperf (IOStats, clear)
dbcc sqlperf (Threads, clear)
DBCC FREEPROCCACHE
DBCC SQLPERF('sys.dm_os_wait_stats', CLEAR)
