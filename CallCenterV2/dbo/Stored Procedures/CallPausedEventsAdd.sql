CREATE PROCEDURE [dbo].[CallPausedEventsAdd] (
	 @CallSid CHAR(34)
	,@LoanId INT
    ,@AgentId INT
    ,@StartTime DATETIME
)
AS
	BEGIN
	SET NOCOUNT ON
/****************************************************************************************************
--------------Change History----------------------section START--------------------------------------
*****************************************************************************************************
	DEVELOPER NAME		DATE				DESC

*****************************************************************************************************
--------------Change History----------------------section END----------------------------------------
*****************************************************************************************************/

	INSERT INTO CallPausedEvents(CallSid, LoanId, AgentId, StartTime)
		VALUES(@CallSid, @LoanId, @AgentId, @StartTime)

    --SELECT SCOPE_IDENTITY()

END