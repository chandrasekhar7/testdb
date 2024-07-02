CREATE TABLE [dbo].[Phones] (
    [PhoneID]         TINYINT      IDENTITY (1, 1) NOT NULL,
    [DepartmentID]    INT          NOT NULL,
    [Number]          VARCHAR (10) NOT NULL,
    [Precedence]      INT          DEFAULT ((1)) NOT NULL,
    [IsPrimary]       BIT          NOT NULL,
    [IsHidden]        BIT          DEFAULT ((0)) NOT NULL,
    [Location]        CHAR (2)     NULL,
    [LocationDefault] BIT          NULL,
    PRIMARY KEY CLUSTERED ([PhoneID] ASC)
);

