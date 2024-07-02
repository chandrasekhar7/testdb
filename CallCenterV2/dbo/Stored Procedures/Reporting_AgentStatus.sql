-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 9/23/2016
-- Description:	Reports on the Agent Call Related Stats
-- ==================================================================================================

CREATE PROCEDURE [dbo].[Reporting_AgentStatus] (
	 @DS DATETIME,
	 @DE DATETIME
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


	DECLARE @DateStart DATETIME = @DS,
	@DateEnd DATETIME = @DE

	;WITH StatusAgg AS (
		SELECT
			AC.AgentID,
			C.CallDirection,
			DATEDIFF(second, AC.CallStart, AC.CallEnd) AS 'CallTime',
			ISNULL(DATEDIFF(second, AA.StartTime, AA.EndTime), 0) AS 'AfterCallTime',
			DATEDIFF(second, 0, C.HoldDuration) AS 'HoldDuration'
		FROM (SELECT 
				AgentID,
				CustomerCallID,
				MIN(CallStart) AS 'CallStart',
				MAX(CallEnd) AS 'CallEnd'
			FROM AgentCalls AC
			WHERE AgentID NOT IN (6,13,10,15,16,27)
			GROUP BY AgentID, CustomerCallID) AC
		INNER JOIN Calls C ON C.CallID = AC.CustomerCallID
		LEFT JOIN AgentActivity AA ON AC.AgentID = AA.AgentID AND AA.StartTime > DATEADD(second, -5, AC.CallEnd)
			AND AA.StartTime < DATEADD(second, 5, AC.CallEnd) AND AA.StatusID = 7
		LEFT JOIN Statuses AST ON AST.StatusID = AA.StatusID AND AST.Name = 'After Call Work'

		WHERE CallStartTime > @DateStart AND CallEndTime < @DateEnd
	),
	CallAgg AS (
		SELECT
			AgentID,
			CallDirection,
			SUM(1) AS 'Calls',
			AVG(CallTime) AS 'AVGCallTime',
			AVG(AfterCallTime) AS 'AVGAfterCallTime',
			AVG(HoldDuration) AS 'AVGHoldTime'

		FROM StatusAgg
		GROUP BY AgentID, CallDirection

	)

	SELECT 
		D.Name AS 'Department',
		CONCAT(A.FirstName,' ',A.LastName) AS 'Agent',
		Calls,
		IIF(CallDirection = 'I', 'Inbound', 'Outbound') AS 'Direction',
		CONVERT(TIME(0), DATEADD(MS, AVGCallTime * 1000, 0)) AS 'AVGCallTime',
		CONVERT(TIME(0), DATEADD(MS, AVGAfterCallTime * 1000, 0)) AS 'AVGAfterCallTime',
		CONVERT(TIME(0), DATEADD(MS, AVGHoldTime * 1000, 0)) AS 'AVGHoldTime'
	FROM CallAgg CA
	LEFT JOIN Agents A ON CA.AgentID = A.AgentID
	LEFT JOIN Departments D ON A.DepartmentID = D.DepartmentID
	ORDER BY Department, Agent, CallDirection
END