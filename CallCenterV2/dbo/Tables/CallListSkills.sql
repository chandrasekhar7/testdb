CREATE TABLE [dbo].[CallListSkills] (
    [ListID]  INT NOT NULL,
    [SkillID] INT NOT NULL,
    CONSTRAINT [PK_ListID_SkillID] PRIMARY KEY CLUSTERED ([ListID] ASC, [SkillID] ASC),
    FOREIGN KEY ([ListID]) REFERENCES [dbo].[CallList] ([ListID]),
    FOREIGN KEY ([ListID]) REFERENCES [dbo].[CallList] ([ListID]),
    FOREIGN KEY ([ListID]) REFERENCES [dbo].[CallList] ([ListID]),
    FOREIGN KEY ([SkillID]) REFERENCES [dbo].[Skills] ([SkillID]),
    FOREIGN KEY ([SkillID]) REFERENCES [dbo].[Skills] ([SkillID]),
    FOREIGN KEY ([SkillID]) REFERENCES [dbo].[Skills] ([SkillID])
);

