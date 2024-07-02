CREATE TABLE [dbo].[Calls] (
    [CallID]        INT       IDENTITY (200000, 1) NOT NULL,
    [CallSid]       CHAR (34) NOT NULL,
    [DepartmentID]  INT       NOT NULL,
    [CustomerID]    INT       NULL,
    [FromNumber]    CHAR (10) NOT NULL,
    [ToNumber]      CHAR (10) NOT NULL,
    [CallDirection] CHAR (1)  NOT NULL,
    [CallState]     CHAR (2)  NULL,
    [CallZip]       CHAR (5)  NULL,
    [IVRTime]       TIME (0)  NULL,
    [QueueTime]     TIME (0)  NULL,
    [CallStartTime] DATETIME  NULL,
    [CallEndTime]   DATETIME  NULL,
    [RPC]           BIT       DEFAULT ((0)) NOT NULL,
    [HoldDuration]  TIME (0)  NULL,
    [IsAgentHangUp] BIT       NOT NULL,
    [ListItemID]    INT       NULL,
    [IsDroppedCall] BIT       NOT NULL,
    [ParentCallID]  INT       NULL,
    [DispositionId] INT       NULL,
    [LineType]      INT       NULL,
    PRIMARY KEY CLUSTERED ([CallID] ASC),
    FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Departments] ([DepartmentID]),
    FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Departments] ([DepartmentID]),
    FOREIGN KEY ([DispositionId]) REFERENCES [dbo].[Disposition] ([Id]),
    CONSTRAINT [FK__Calls__LineType__2C1E8537] FOREIGN KEY ([LineType]) REFERENCES [dbo].[LineTypes] ([TypeID]),
    UNIQUE NONCLUSTERED ([CallSid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [CallsByDate]
    ON [dbo].[Calls]([CallStartTime] ASC)
    INCLUDE([CallID], [DepartmentID], [CustomerID], [FromNumber], [ToNumber], [CallDirection], [CallEndTime], [ListItemID]);


GO
CREATE NONCLUSTERED INDEX [ndx_CustomerCallHistory]
    ON [dbo].[Calls]([CustomerID] ASC, [CallDirection] ASC, [CallStartTime] ASC);


GO
CREATE NONCLUSTERED INDEX [Calls_CustomerID_CallEndTime]
    ON [dbo].[Calls]([CustomerID] ASC, [CallEndTime] ASC) WITH (DATA_COMPRESSION = ROW);


GO
CREATE NONCLUSTERED INDEX [CustomerID_CallEndTime_Includes]
    ON [dbo].[Calls]([CustomerID] ASC, [CallEndTime] ASC)
    INCLUDE([FromNumber], [ToNumber], [CallDirection], [CallStartTime]) WITH (FILLFACTOR = 100);

