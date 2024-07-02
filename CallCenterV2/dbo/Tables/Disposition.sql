CREATE TABLE [dbo].[Disposition] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Description] NVARCHAR (500) NOT NULL,
    CONSTRAINT [PK_Disposition] PRIMARY KEY CLUSTERED ([Id] ASC)
);

