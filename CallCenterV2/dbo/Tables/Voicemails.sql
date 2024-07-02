CREATE TABLE [dbo].[Voicemails] (
    [CallID]       INT              NOT NULL,
    [RecordingUI]  UNIQUEIDENTIFIER NOT NULL,
    [Duration]     INT              NOT NULL,
    [Format]       VARCHAR (4)      NOT NULL,
    [DirID]        TINYINT          NOT NULL,
    [IsArchived]   BIT              DEFAULT ((0)) NOT NULL,
    [DepartmentID] INT              NULL,
    PRIMARY KEY CLUSTERED ([CallID] ASC),
    FOREIGN KEY ([CallID]) REFERENCES [dbo].[Calls] ([CallID])
);

