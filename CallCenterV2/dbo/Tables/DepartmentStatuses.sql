CREATE TABLE [dbo].[DepartmentStatuses] (
    [DepartmentID] INT NOT NULL,
    [StatusID]     INT NOT NULL,
    PRIMARY KEY CLUSTERED ([DepartmentID] ASC, [StatusID] ASC),
    FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Departments] ([DepartmentID]),
    FOREIGN KEY ([StatusID]) REFERENCES [dbo].[Statuses] ([StatusID])
);

