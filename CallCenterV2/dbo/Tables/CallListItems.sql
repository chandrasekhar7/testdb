CREATE TABLE [dbo].[CallListItems] (
    [ItemID]       INT       IDENTITY (1, 1) NOT NULL,
    [ListID]       INT       NOT NULL,
    [CreatedOn]    DATETIME  DEFAULT (getdate()) NOT NULL,
    [CustomerID]   INT       NOT NULL,
    [PhoneNumber]  CHAR (10) NOT NULL,
    [PhoneType]    CHAR (1)  NULL,
    [CallStatusID] TINYINT   NULL,
    [StatusDate]   DATETIME  NULL,
    [StartTime]    TIME (0)  NOT NULL,
    [EndTime]      TIME (0)  NOT NULL,
    [LoanNbr]      INT       NULL,
    [SipResponse]  INT       NULL,
    [isDeleted]    BIT       DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ItemID] ASC),
    FOREIGN KEY ([CallStatusID]) REFERENCES [dbo].[CallStatus] ([CallStatusID]),
    FOREIGN KEY ([CallStatusID]) REFERENCES [dbo].[CallStatus] ([CallStatusID]),
    FOREIGN KEY ([ListID]) REFERENCES [dbo].[CallList] ([ListID]),
    FOREIGN KEY ([ListID]) REFERENCES [dbo].[CallList] ([ListID])
);


GO
CREATE NONCLUSTERED INDEX [index_for_Paydini2016_CustomerSummaryLoadCustomerServiceNotes]
    ON [dbo].[CallListItems]([CustomerID] ASC, [CallStatusID] ASC)
    INCLUDE([ListID], [StatusDate]);


GO
CREATE NONCLUSTERED INDEX [ndx_ListIdStatus]
    ON [dbo].[CallListItems]([ListID] ASC, [StatusDate] ASC)
    INCLUDE([CallStatusID]);

