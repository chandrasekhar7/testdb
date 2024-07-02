CREATE TABLE [dbo].[SipCodes] (
    [Code]        INT            NOT NULL,
    [Name]        VARCHAR (45)   NOT NULL,
    [Description] VARCHAR (8000) NOT NULL,
    PRIMARY KEY CLUSTERED ([Code] ASC)
);

