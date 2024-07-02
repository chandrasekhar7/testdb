CREATE TABLE [dbo].[DepartmentMessageExceptions] (
    [ExceptionID]   INT           IDENTITY (1, 1) NOT NULL,
    [DepartmentID]  INT           NOT NULL,
    [LanguageID]    TINYINT       NOT NULL,
    [Title]         VARCHAR (50)  NOT NULL,
    [FileName]      VARCHAR (100) NULL,
    [ExceptionDate] DATE          NOT NULL,
    [StartTime]     TIME (0)      NOT NULL,
    [EndTime]       TIME (0)      NOT NULL,
    PRIMARY KEY CLUSTERED ([ExceptionID] ASC),
    FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Departments] ([DepartmentID])
);

