CREATE TYPE [dbo].[AgentCallImport] AS TABLE (
    [Sid]       CHAR (34)        NULL,
    [StartTime] DATETIME         NULL,
    [EndTime]   DATETIME         NULL,
    [AgentID]   UNIQUEIDENTIFIER NULL);

