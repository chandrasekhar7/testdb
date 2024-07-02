ALTER ROLE [db_owner] ADD MEMBER [NETPAYADVANCE\Database_Live];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [NETPAYADVANCE\SVC_NPASANDSQL$];


GO
ALTER ROLE [db_datareader] ADD MEMBER [NETPAYADVANCE\Database_Live_Readonly];


GO
ALTER ROLE [db_datareader] ADD MEMBER [ConsoleApps];


GO
ALTER ROLE [db_datareader] ADD MEMBER [SVC_Analytics];


GO
ALTER ROLE [db_datareader] ADD MEMBER [NETPAYADVANCE\SVC_NPASANDSQL$];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [ConsoleApps];

