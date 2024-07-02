CREATE TABLE [dbo].[zAgentCalls] (
    [Sid]       CHAR (34)        NOT NULL,
    [StartTime] DATETIME         NULL,
    [EndTime]   DATETIME         NULL,
    [AgentID]   UNIQUEIDENTIFIER NULL,
    PRIMARY KEY CLUSTERED ([Sid] ASC)
);

