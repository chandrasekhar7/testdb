CREATE TABLE [dbo].[CallListRecordings] (
    [ListID]    INT          NOT NULL,
    [FileName]  VARCHAR (50) NOT NULL,
    [CreatedOn] DATETIME     NULL,
    [isDeleted] BIT          DEFAULT (NULL) NULL,
    CONSTRAINT [CallListRecordings_CallList_ListID_fk] FOREIGN KEY ([ListID]) REFERENCES [dbo].[CallList] ([ListID])
);

