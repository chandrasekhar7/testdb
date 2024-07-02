CREATE TABLE [dbo].[DepartmentMessages] (
    [DepartmentID] INT          NOT NULL,
    [LanguageID]   TINYINT      NOT NULL,
    [Title]        VARCHAR (50) NOT NULL,
    [FileName]     VARCHAR (50) NOT NULL,
    PRIMARY KEY NONCLUSTERED ([DepartmentID] ASC, [LanguageID] ASC),
    FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Departments] ([DepartmentID])
);

