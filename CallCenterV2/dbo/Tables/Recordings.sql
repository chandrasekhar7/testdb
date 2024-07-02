CREATE TABLE [dbo].[Recordings] (
    [AgentCallID]  INT              NOT NULL,
    [RecordingUI]  UNIQUEIDENTIFIER NOT NULL,
    [Duration]     INT              NOT NULL,
    [Format]       VARCHAR (4)      NOT NULL,
    [DirID]        TINYINT          NOT NULL,
    [DepartmentID] INT              NULL,
    PRIMARY KEY CLUSTERED ([AgentCallID] ASC),
    FOREIGN KEY ([AgentCallID]) REFERENCES [dbo].[AgentCalls] ([CallID])
);

