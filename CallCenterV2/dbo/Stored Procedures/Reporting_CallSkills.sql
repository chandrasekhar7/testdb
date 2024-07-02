-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 9/23/2016
-- Description:	Reports on the Calls for the given time period 
-- ==================================================================================================

CREATE PROCEDURE [dbo].[Reporting_CallSkills] (
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
@DateEnd DATETIME = @DE,
-- Jason's arbitrary value that determines if call is abandoned
@AbandonTime INT = 5;

WITH SkillAgg AS (
SELECT
		C.CallID, 
		
		Skills = STUFF((SELECT ', ' + Name
		FROM Calls C2
			LEFT JOIN CallSkills CS2 ON CS2.CallID = C2.CallID
			LEFT JOIN Skills S2 ON CS2.SkillID = S2.SkillID
		WHERE C.CallID = C2.CallID
		ORDER BY Name
		FOR XML PATH('')), 1,2,'')

FROM Calls C
	LEFT JOIN CallSkills CS ON CS.CallID = C.CallID
	LEFT JOIN Skills S ON CS.SkillID = S.SkillID
	WHERE CallStartTime > @DateStart
		AND CallStartTime < @DateEnd

	GROUP BY C.CallID

)
	SELECT 
		D.Name, 
		IIF(Skills IS NULL, '', Skills) AS 'Skills',

		COUNT(1) AS 'Calls',

		dbo.SecondsToTime(AVG(DATEDIFF(second, 0, QueueTime))) AS 'AverageQueueTime',
		SUM(IIF(AC.CustomerCallID IS NULL AND DATEDIFF(second,0, QueueTime) > @AbandonTime, 1, 0)) AS 'Abandoned',

		IIF(SUM(IIF(AC.CustomerCallID IS NULL AND DATEDIFF(second,0, QueueTime) > @AbandonTime, 1, 0)) = 0, 0,
					SUM(IIF(AC.CustomerCallID IS NULL AND DATEDIFF(second,0, QueueTime) > @AbandonTime, 1, 0)) * 1.00 / COUNT(1) * 1.00
		) AS '% Abandoned',

		dbo.SecondsToTime(MAX(IIF(AC.CustomerCallID IS NULL AND DATEDIFF(second,0, QueueTime) > @AbandonTime, DATEDIFF(second,0, QueueTime), 0))
		) AS 'Max Abandoned',

		IIF(dbo.SecondsToTime(MIN(IIF(AC.CustomerCallID IS NULL AND DATEDIFF(second,0, QueueTime) > @AbandonTime, 
			DATEDIFF(second, 0, QueueTime), 60*60*24))
			) = '24:00:00', '00:00:00', 
			dbo.SecondsToTime(MIN(IIF(AC.CustomerCallID IS NULL AND DATEDIFF(second, 0, QueueTime) > @AbandonTime,
				 DATEDIFF(second,0, QueueTime), 60*60*24))
		 )) AS 'Min Abandoned',

		dbo.SecondsToTime(SUM(IIF(AC.CustomerCallID IS NULL AND DATEDIFF(second, 0, QueueTime) > @AbandonTime,
				 DATEDIFF(second,0, QueueTime), 0)) * 1.00 /
					
				IIF(SUM(IIF(AC.CustomerCallID IS NULL AND DATEDIFF(second, 0, QueueTime) > @AbandonTime, 1, 0)) = 0, 
					1, SUM(IIF(AC.CustomerCallID IS NULL AND DATEDIFF(second, 0, QueueTime) > @AbandonTime, 1, 0)))
		) AS 'AVGAbandonTime',

		dbo.SecondsToTime(MAX(DATEDIFF(second, 0, QueueTime))) AS 'MaxQueueTime',

		dbo.SecondsToTime(AVG(IIF(CallStartTime IS NULL OR CallEndTime IS NULL OR CallStartTime > CallEndTime, 
						0 ,DATEDIFF(second, CallStartTime, CallEndTime)))
		) AS 'AverageCallTime'

	FROM SkillAgg SA
	LEFT JOIN Calls C ON C.CallID = SA.CallID
	LEFT JOIN (SELECT 
				CustomerCallID,
				MIN(CallStart) AS 'CallStart',
				MAX(CallEnd) AS 'CallEnd'
			FROM AgentCalls AC
			GROUP BY CustomerCallID) AS AC ON AC.CustomerCallID = C.CallID
	LEFT JOIN Departments D ON D.DepartmentID = C.DepartmentID
	GROUP BY D.Name, Skills 
	ORDER BY D.Name, Skills

END