CREATE TABLE [dbo].[Transcripts] (
    [AgentCallID]             INT           NOT NULL,
    [Word]                    VARCHAR (100) NOT NULL,
    [MillisecondsOffsetStart] INT           NOT NULL,
    [MillisecondsOffsetEnd]   INT           NOT NULL,
    [Channel]                 SMALLINT      NOT NULL,
    FOREIGN KEY ([AgentCallID]) REFERENCES [dbo].[AgentCalls] ([CallID]),
    CONSTRAINT [Transcripts_uniquerow] UNIQUE NONCLUSTERED ([AgentCallID] ASC, [Word] ASC, [MillisecondsOffsetStart] ASC, [MillisecondsOffsetEnd] ASC, [Channel] ASC)
);

