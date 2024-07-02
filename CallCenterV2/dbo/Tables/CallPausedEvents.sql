CREATE TABLE [dbo].[CallPausedEvents] (
    [CallPausedId] INT       IDENTITY (1, 1) NOT NULL,
    [CallSid]      CHAR (34) NOT NULL,
    [LoanId]       INT       NULL,
    [AgentId]      INT       NOT NULL,
    [StartTime]    DATETIME  NOT NULL,
    [EndTime]      DATETIME  NULL,
    CONSTRAINT [PK_CallPausedEvents] PRIMARY KEY CLUSTERED ([CallPausedId] ASC),
    CONSTRAINT [FK_CallPausedEvents_Agents] FOREIGN KEY ([AgentId]) REFERENCES [dbo].[Agents] ([AgentID])
);

