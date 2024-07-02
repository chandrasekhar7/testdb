CREATE TABLE [dbo].[AgentRecordings] (
    [AgentID]   VARCHAR (50) NOT NULL,
    [FileName]  VARCHAR (50) NOT NULL,
    [CreatedOn] DATETIME     NULL,
    [isDeleted] BIT          DEFAULT (NULL) NULL
);

