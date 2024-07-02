CREATE TABLE [dbo].[FailedCalls] (
    [ID]          INT       IDENTITY (1, 1) NOT NULL,
    [CallSid]     INT       NOT NULL,
    [SipCode]     INT       NULL,
    [CustomerID]  INT       NULL,
    [PhoneNumber] CHAR (10) NOT NULL,
    [AttemptDate] DATETIME  NOT NULL,
    [AgentID]     INT       NULL
);

