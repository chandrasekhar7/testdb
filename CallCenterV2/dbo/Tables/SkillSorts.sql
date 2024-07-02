CREATE TABLE [dbo].[SkillSorts] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Description] VARCHAR (255) NOT NULL,
    [isActive]    BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

