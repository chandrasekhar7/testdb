CREATE TABLE [dbo].[CallStatus] (
    [CallStatusID] TINYINT      IDENTITY (1, 1) NOT NULL,
    [Name]         VARCHAR (20) NOT NULL,
    PRIMARY KEY CLUSTERED ([CallStatusID] ASC),
    UNIQUE NONCLUSTERED ([Name] ASC)
);

