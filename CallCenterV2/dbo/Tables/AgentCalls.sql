CREATE TABLE [dbo].[AgentCalls] (
    [CallID]         INT       IDENTITY (200000, 1) NOT NULL,
    [CallSid]        CHAR (34) NOT NULL,
    [CustomerCallID] INT       NOT NULL,
    [AgentID]        INT       NOT NULL,
    [CallStart]      DATETIME  NOT NULL,
    [CallEnd]        DATETIME  NOT NULL,
    [CallType]       TINYINT   NOT NULL,
    PRIMARY KEY CLUSTERED ([CallID] ASC),
    FOREIGN KEY ([CustomerCallID]) REFERENCES [dbo].[Calls] ([CallID]),
    UNIQUE NONCLUSTERED ([CallSid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [MatchCustomerLeg]
    ON [dbo].[AgentCalls]([CustomerCallID] ASC)
    INCLUDE([CallID], [AgentID]);

