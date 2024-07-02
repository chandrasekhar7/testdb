CREATE PROCEDURE [dbo].[FindVoicemailMatch] (
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

	SELECT TOP 1 D.DepartmentUI, C.CallStartTime, C.CallID, D.DepartmentID
	FROM Calls C
	LEFT JOIN Departments D ON D.DepartmentID = C.DepartmentID
	LEFT JOIN AgentCalls AC on C.CallID = AC.CustomerCallID
	WHERE AC.CallSid IS NULL AND C.CallSid = @CallSid

END