CREATE TABLE [dbo].[zCalls] (
    [Sid]        CHAR (34)        NOT NULL,
    [CallID]     UNIQUEIDENTIFIER NULL,
    [StartTime]  DATETIME         NULL,
    [EndTime]    DATETIME         NULL,
    [FromNumber] CHAR (10)        NULL,
    [ToNumber]   CHAR (10)        NULL,
    [Direction]  CHAR (1)         NULL,
    PRIMARY KEY CLUSTERED ([Sid] ASC),
    UNIQUE NONCLUSTERED ([CallID] ASC),
    UNIQUE NONCLUSTERED ([Sid] ASC)
);

