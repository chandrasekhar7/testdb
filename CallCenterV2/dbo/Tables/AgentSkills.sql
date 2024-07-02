CREATE TABLE [dbo].[AgentSkills] (
    [AgentID]         INT     NOT NULL,
    [SkillID]         INT     NOT NULL,
    [Priority]        TINYINT DEFAULT ((5)) NOT NULL,
    [AssignmentCount] INT     NULL,
    PRIMARY KEY CLUSTERED ([AgentID] ASC, [SkillID] ASC),
    FOREIGN KEY ([AgentID]) REFERENCES [dbo].[Agents] ([AgentID]),
    FOREIGN KEY ([SkillID]) REFERENCES [dbo].[Skills] ([SkillID])
);

