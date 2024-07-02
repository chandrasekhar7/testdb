CREATE TABLE [dbo].[ConferenceAgentParticipants] (
    [CallID]       INT NOT NULL,
    [ConferenceID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([CallID] ASC, [ConferenceID] ASC),
    FOREIGN KEY ([CallID]) REFERENCES [dbo].[AgentCalls] ([CallID]),
    FOREIGN KEY ([ConferenceID]) REFERENCES [dbo].[Conferences] ([ConferenceID])
);

