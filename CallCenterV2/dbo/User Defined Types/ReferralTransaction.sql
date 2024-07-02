CREATE TYPE [dbo].[ReferralTransaction] AS TABLE (
    [ACHID]      INT            NOT NULL,
    [PowerID]    INT            NOT NULL,
    [BatchNum]   VARCHAR (50)   NULL,
    [ReturnCode] VARCHAR (4)    NULL,
    [Amount]     DECIMAL (6, 2) NULL,
    [ReturnDate] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([ACHID] ASC));

