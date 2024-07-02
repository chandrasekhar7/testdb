CREATE TABLE [dbo].[Conferences] (
    [ConferenceID]  INT       IDENTITY (1, 1) NOT NULL,
    [ConferenceSid] CHAR (34) NOT NULL,
    [StartTime]     DATETIME  NULL,
    [EndTime]       DATETIME  NULL,
    [Name]          CHAR (34) NOT NULL,
    PRIMARY KEY CLUSTERED ([ConferenceID] ASC)
);

