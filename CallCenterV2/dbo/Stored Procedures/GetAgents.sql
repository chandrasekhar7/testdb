CREATE PROCEDURE [dbo].[GetAgents]
	@AgentUI UNIQUEIDENTIFIER = NULL
AS
	BEGIN
	SET NOCOUNT ON
/****************************************************************************************************
--------------Change History----------------------section START--------------------------------------
*****************************************************************************************************
	DEVELOPER NAME		DATE				DESC

	scott hoopes		08/02/2019			see comment about teams and skills
    naveen              11/16/20            agent recordings
	srinivasan palaniappan 08/23/2023       Added sort to pick the long standing agent.
*****************************************************************************************************
--------------Change History----------------------section END----------------------------------------
*****************************************************************************************************/

	SELECT	 AgentID
			,AgentUI
			,Agent
			,FirstName
			,LastName
			,A.DepartmentID
			,DepartmentUI
			,CreatedOn
			,x.ReadyTime
	FROM Agents A
	LEFT JOIN Departments D ON D.DepartmentID = A.DepartmentID
	OUTER APPLY(
	SELECT TOP 1 RA.[ReadyTime] as ReadyTime 
	  FROM [CallCenterV2].[dbo].[ReadyAgents] RA
	 WHERE RA.AgentID  = A.AgentID
	 ORDER BY 1 desc
	)x
	WHERE A.ActiveAccount = 1
	AND (A.AgentUI = @AgentUI OR @AgentUI IS NULL)
	ORDER BY x.ReadyTime asc, AgentID;

	SELECT	 ASK.AgentID
			,Name As 'Skill'
			,Priority
	FROM AgentSkills ASK
	INNER JOIN Skills S ON S.SkillID = ASK.SkillID
		--SAH 08/02/2019 added for issue "Teams and skills" where we are using Yak skills to assign RI accounts
		--due to 32 skill limit for Yak matching calls, we will exclude the account assignment skills from this query
		--and S.[Name] not like 'CollAcct %'
	LEFT JOIN Agents A ON A.AgentID = ASK.AgentID
	WHERE A.ActiveAccount = 1
	AND (A.AgentUI = @AgentUI OR @AgentUI IS NULL)
	ORDER BY ASK.AgentID;

    SELECT
           AR.AgentID,
           AR.FileName,
           AR.CreatedOn
	FROM AgentRecordings AR
	INNER JOIN Agents A ON AR.AgentID = A.AgentUI
	WHERE A.ActiveAccount = 1
	AND (A.AgentUI = @AgentUI OR @AgentUI IS NULL) AND (AR.isDeleted IS NULL OR AR.isDeleted = 0)
	ORDER BY AR.AgentID;

END