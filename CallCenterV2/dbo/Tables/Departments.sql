CREATE TABLE [dbo].[Departments] (
    [DepartmentID] INT              IDENTITY (1, 1) NOT NULL,
    [DepartmentUI] UNIQUEIDENTIFIER NOT NULL,
    [Name]         VARCHAR (50)     NOT NULL,
    [SunStart]     TIME (0)         NOT NULL,
    [SunEnd]       TIME (0)         NOT NULL,
    [MonStart]     TIME (0)         NOT NULL,
    [MonEnd]       TIME (0)         NOT NULL,
    [TuesStart]    TIME (0)         NOT NULL,
    [TuesEnd]      TIME (0)         NOT NULL,
    [WedStart]     TIME (0)         NOT NULL,
    [WedEnd]       TIME (0)         NOT NULL,
    [ThursStart]   TIME (0)         NOT NULL,
    [ThursEnd]     TIME (0)         NOT NULL,
    [FriStart]     TIME (0)         NOT NULL,
    [FriEnd]       TIME (0)         NOT NULL,
    [SatStart]     TIME (0)         NOT NULL,
    [SatEnd]       TIME (0)         NOT NULL,
    PRIMARY KEY CLUSTERED ([DepartmentID] ASC),
    UNIQUE NONCLUSTERED ([Name] ASC)
);

