CREATE TABLE [dbo].[Statuses] (
    [StatusID]         INT          IDENTITY (1, 1) NOT NULL,
    [Name]             VARCHAR (30) NOT NULL,
    [CanAnswer]        BIT          NOT NULL,
    [DefaultStatus]    BIT          NOT NULL,
    [DefaultAfterCall] BIT          NOT NULL,
    [AgentCanSet]      BIT          NOT NULL,
    [BrowserHotKey]    INT          NULL,
    PRIMARY KEY CLUSTERED ([StatusID] ASC)
);

