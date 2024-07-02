CREATE PROCEDURE [dbo].[FindRecordingMatch] (
	@CallSid CHAR(34)
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

	SELECT TOP 1 D.DepartmentUI, C.CallStartTime, AC.CallID, D.DepartmentID
	FROM AgentCalls AC
	LEFT JOIN Calls C ON C.CallID = AC.CustomerCallID
	LEFT JOIN Departments D ON D.DepartmentID = C.DepartmentID
	LEFT JOIN Recordings R ON R.AgentCallID = AC.CallID
	WHERE AC.CallSid = @CallSid AND R.AgentCallID IS NULL
		AND C.CallID IS NOT NULL

END