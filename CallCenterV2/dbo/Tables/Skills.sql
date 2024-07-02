CREATE TABLE [dbo].[Skills] (
    [SkillID]    INT          IDENTITY (1, 1) NOT NULL,
    [Name]       VARCHAR (50) NOT NULL,
    [IsRequired] BIT          NOT NULL,
    [IsLanguage] BIT          NOT NULL,
    PRIMARY KEY CLUSTERED ([SkillID] ASC),
    UNIQUE NONCLUSTERED ([Name] ASC)
);

