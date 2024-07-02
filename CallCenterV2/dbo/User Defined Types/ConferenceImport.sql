CREATE TYPE [dbo].[ConferenceImport] AS TABLE (
    [Sid]       CHAR (34) NULL,
    [Name]      CHAR (34) NOT NULL,
    [StartTime] DATETIME  NOT NULL,
    [EndTime]   DATETIME  NOT NULL);

