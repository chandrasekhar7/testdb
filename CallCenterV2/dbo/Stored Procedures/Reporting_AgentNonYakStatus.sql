-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 9/23/2016
-- Description:	Reports on Yak's invasive Agent Activities
-- ==================================================================================================

CREATE PROCEDURE [dbo].[Reporting_AgentNonYakStatus] (
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

	Erick Coble			10/11/2016			Changed report to FALSLY show Lunch as 
											(Lunch + LEAD(Logged Out))

*****************************************************************************************************
--------------Change History----------------------section END----------------------------------------
*****************************************************************************************************/


	DECLARE @DateStart DATETIME = @DS,
	@DateEnd DATETIME = @DE

	DECLARE @StatusAgg TABLE (
		DepartmentID INT,
		AgentID INT,
		Agent VARCHAR(60),
		Status VARCHAR(30),
		AVGTime INT,
		TotalTime INT
)

	;WITH TimeClock AS (
		SELECT 
			A.DepartmentID,
			A.AgentID,
			CONCAT(A.FirstName,' ',A.LastName) AS 'Agent',
			AST.Name AS 'Status',
			DATEDIFF(second, AA.StartTime, AA.EndTime)  + 
				IIF(AST.Name = 'Lunch' AND LEAD(AST.Name) OVER (ORDER BY A.AgentID, AA.StartTime) = 'Logged Out', 
					LEAD(DATEDIFF(second, AA.StartTime, AA.EndTime)) OVER (ORDER BY A.AgentID, AA.StartTime), 0) AS 'TimeSpan'

		FROM Agents A
		LEFT JOIN AgentActivity AA ON AA.AgentID = A.AgentID
		LEFT JOIN Statuses AST ON AST.StatusID = AA.StatusID
		WHERE AA.StartTime > @DateStart
			AND AA.EndTime IS NOT NULL
			AND AA.StartTime < @DateEnd
			AND AST.Name IN('Break','Lunch','Restroom','Coaching','Meeting','Training','Task Completion','Not Ready', 'Logged Out')
			-- Ignore Agents that arent really agents, (Erick, Scott, Juan, Jamie, Jason, Brian)
			AND A.AgentUI NOT IN ('40DAB1FD-5907-4738-901B-4E899D031A7A', '0AD9212B-BE53-4DEE-9E0F-5C9060DF1A92',
				'9344C7C6-8677-4B96-9369-1B46FB4C73D4', 'D6D3A848-76B2-4936-938F-4E6836DC7466', 
				'F8F16E24-97F2-4333-9B9F-BD5C3A792AE2','3103E67C-7328-441A-976B-C278F497AC0A')
	)
	INSERT INTO @StatusAgg 
	SELECT	 DepartmentID
			,AgentID
			,Agent
			,Status
			,AVG(TimeSpan) AS 'AVGTime'
			,SUM(TimeSpan) AS 'TotalTime'
	FROM TimeClock
	WHERE Status != 'Logged Out'
	GROUP BY DepartmentID, AgentID,Agent, Status

	;WITH CallAgg AS (
		SELECT 
			DepartmentID,
			AgentID,
			Agent, 
			SUM(ISNULL([Break], 0)) AS 'Break', 
			SUM(ISNULL([Lunch], 0)) AS 'Lunch', 
			SUM(ISNULL([Restroom], 0)) AS 'Restroom',
			SUM(ISNULL([Coaching], 0)) AS 'Coaching', 
			SUM(ISNULL([Meeting], 0)) AS 'Meeting', 
			SUM(ISNULL([Training], 0)) AS 'Training',
			SUM(ISNULL([Task Completion], 0)) AS 'Task Completion', 
			SUM(ISNULL([Not Ready], 0)) AS 'Not Ready'
		 FROM (
			SELECT 
				DepartmentID, AgentID, Agent, Status, AVGTime, TotalTime
			FROM @StatusAgg) AS SourceTable
			PIVOT (
				AVG(AVGTime)
				FOR Status IN ([Break],[Lunch],[Restroom],[Coaching],[Meeting],[Training],[Task Completion],[Not Ready])
			) AS PivotTable
			GROUP BY DepartmentID, AgentID, Agent
	),
	OtherAgg AS (
		SELECT 
			DepartmentID,
			AgentID,
			Agent, 
			SUM(ISNULL([Break], 0)) AS 'Break', 
			SUM(ISNULL([Lunch], 0)) AS 'Lunch', 
			SUM(ISNULL([Restroom], 0)) AS 'Restroom',
			SUM(ISNULL([Coaching], 0)) AS 'Coaching', 
			SUM(ISNULL([Meeting], 0)) AS 'Meeting', 
			SUM(ISNULL([Training], 0)) AS 'Training',
			SUM(ISNULL([Task Completion], 0)) AS 'Task Completion', 
			SUM(ISNULL([Not Ready], 0)) AS 'Not Ready'
		 FROM (
			SELECT 
				DepartmentID, AgentID, Agent, Status, AVGTime, TotalTime
			FROM @StatusAgg) AS SourceTable
			PIVOT (
				SUM(TotalTime)
				FOR Status IN ([Break],[Lunch],[Restroom],[Coaching],[Meeting],[Training],[Task Completion],[Not Ready])
			) AS PivotTable
			GROUP BY DepartmentID, AgentID, Agent
	)

	SELECT 
		IIF(GROUPING(D.Name) = 0, D.Name, 'All') AS 'Department',
		IIF(GROUPING(A.Agent) = 0, A.Agent, 'All') AS 'Agent',
		dbo.SecondsToTime(AVG(A.[Break])) AS 'AVG Break',
		dbo.SecondsToTime(AVG(A.[Lunch])) AS 'AVG Lunch',
		dbo.SecondsToTime(AVG(A.[Restroom])) AS 'AVG Restroom',
		dbo.SecondsToTime(AVG(A.[Coaching])) AS 'AVG Coaching',
		dbo.SecondsToTime(AVG(A.[Meeting])) AS 'AVG Meeting',
		dbo.SecondsToTime(AVG(A.[Training])) AS 'AVG Training',
		dbo.SecondsToTime(AVG(A.[Task Completion])) AS 'AVG Task Completion',
		dbo.SecondsToTime(AVG(A.[Not Ready])) AS 'AVG Not Ready',

		dbo.SecondsToTime(SUM(O.[Break])) AS 'Total Break',
		dbo.SecondsToTime(SUM(O.[Lunch])) AS 'Total Lunch',
		dbo.SecondsToTime(SUM(O.[Restroom])) AS 'Total Restroom',
		dbo.SecondsToTime(SUM(O.[Coaching])) AS 'Total Coaching',
		dbo.SecondsToTime(SUM(O.[Meeting])) AS 'Total Meeting',
		dbo.SecondsToTime(SUM(O.[Training])) AS 'Total Training',
		dbo.SecondsToTime(SUM(O.[Task Completion])) AS 'Total Task Completion',
		dbo.SecondsToTime(SUM(O.[Not Ready])) AS 'Total Not Ready'
	FROM CallAgg A
	LEFT JOIN Departments D ON D.DepartmentID = A.DepartmentID
	LEFT JOIN OtherAgg O ON O.AgentID = A.AgentID
	GROUP BY ROLLUP(D.Name, A.Agent)
END