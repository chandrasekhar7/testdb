CREATE TABLE [dbo].[Voicemails_CustomerClassOverride] (
    [CallID] INT           NOT NULL,
    [Class]  NVARCHAR (20) NULL,
    PRIMARY KEY CLUSTERED ([CallID] ASC),
    FOREIGN KEY ([CallID]) REFERENCES [dbo].[Voicemails] ([CallID])
);

