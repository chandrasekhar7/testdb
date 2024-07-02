CREATE TABLE [dbo].[ReadyAgents] (
    [AgentID]   INT      NOT NULL,
    [ReadyTime] DATETIME NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [NDX_AgentID_Includes]
    ON [dbo].[ReadyAgents]([AgentID] ASC)
    INCLUDE([ReadyTime]) WITH (FILLFACTOR = 100);

