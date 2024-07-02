CREATE TABLE [dbo].[CallSkills] (
    [CallID]  INT NOT NULL,
    [SkillID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([CallID] ASC, [SkillID] ASC),
    FOREIGN KEY ([CallID]) REFERENCES [dbo].[Calls] ([CallID]),
    FOREIGN KEY ([SkillID]) REFERENCES [dbo].[Skills] ([SkillID])
);

