CREATE TYPE [dbo].[CallImport] AS TABLE (
    [Sid]        CHAR (34)        NULL,
    [CallID]     UNIQUEIDENTIFIER NULL,
    [StartTime]  DATETIME         NULL,
    [EndTime]    DATETIME         NULL,
    [FromNumber] CHAR (10)        NULL,
    [ToNumber]   CHAR (10)        NULL,
    [Direction]  CHAR (1)         NULL);

