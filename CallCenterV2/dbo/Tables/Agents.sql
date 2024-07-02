CREATE TABLE [dbo].[Agents] (
    [AgentID]       INT              IDENTITY (1, 1) NOT NULL,
    [AgentUI]       UNIQUEIDENTIFIER NOT NULL,
    [Agent]         VARCHAR (30)     NOT NULL,
    [FirstName]     VARCHAR (20)     NOT NULL,
    [LastName]      VARCHAR (20)     NOT NULL,
    [DepartmentID]  INT              NULL,
    [Ext]           CHAR (3)         NULL,
    [CreatedOn]     DATETIME         DEFAULT (getdate()) NOT NULL,
    [ActiveAccount] BIT              DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([AgentID] ASC)
);

