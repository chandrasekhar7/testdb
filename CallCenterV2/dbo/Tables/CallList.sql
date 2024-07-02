CREATE TABLE [dbo].[CallList] (
    [ListID]          INT            IDENTITY (1, 1) NOT NULL,
    [DepartmentID]    INT            NOT NULL,
    [Name]            VARCHAR (100)  NOT NULL,
    [CreatedOn]       DATETIME       DEFAULT (getdate()) NOT NULL,
    [ADCMessage]      VARCHAR (1000) NULL,
    [AutoConnect]     BIT            NOT NULL,
    [CallsPerAgent]   TINYINT        NOT NULL,
    [QueuePrecedence] TINYINT        DEFAULT ((1)) NOT NULL,
    [AMD]             BIT            DEFAULT ((1)) NOT NULL,
    [PhoneID]         INT            NOT NULL,
    [Enabled]         BIT            CONSTRAINT [CallList_Enabled_Default] DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ListID] ASC),
    FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Departments] ([DepartmentID]),
    FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Departments] ([DepartmentID]),
    UNIQUE NONCLUSTERED ([Name] ASC)
);

