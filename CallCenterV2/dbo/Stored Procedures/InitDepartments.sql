CREATE PROCEDURE [dbo].[InitDepartments]
	@DepartmentID INT = NULL
AS
	BEGIN
	SET NOCOUNT ON
/****************************************************************************************************
--------------Change History----------------------section START--------------------------------------
*****************************************************************************************************
	DEVELOPER NAME		DATE				DESC

	Erick Coble			12/1/2016			Added Number to Call List

	scott hoopes		08/02/2019			see comment about teams and skills
	Scott Hoopes		09/03/2019			added [Enabled] = 1 to where for Account Assignment project
    naveen              2/11/2021           pass location and location default to yak

*****************************************************************************************************
--------------Change History----------------------section END----------------------------------------
*****************************************************************************************************/

	-- Departments
	SELECT	 D.DepartmentID
			,D.DepartmentUI
			,Name
	FROM Departments D
	WHERE D.DepartmentID = @DepartmentID OR @DepartmentID IS NULL

	-- Phones
	SELECT	DepartmentID,
			Number,
			Precedence,
			IsPrimary,
			IsHidden,
	        Location,
	        LocationDefault
	FROM Phones
	--WHERE DepartmentID = @DepartmentID OR @DepartmentID IS NULL
	ORDER BY DepartmentID, IsPrimary DESC

	-- Agents
	SELECT DepartmentID,
			AgentID,
			AgentUI,
			Agent,
			FirstName,
			LastName,
			CreatedOn
	FROM Agents
	WHERE ActiveAccount = 1
		AND DepartmentID = @DepartmentID OR @DepartmentID IS NULL

	-- Agent Statuspar
	SELECT	DepartmentID,
			S.StatusID,
			Name,
			CanAnswer
	FROM DepartmentStatuses DS
	LEFT JOIN Statuses S ON S.StatusID = DS.StatusID

	-- Agent Skills
	SELECT AgentID,
			AgentSkills.SkillID,
			Priority
	FROM AgentSkills
	--SAH 08/02/2019 added for issue "Teams and skills" where we are using Yak skills to assign RI accounts
	--due to 32 skill limit for Yak matching calls, we will exclude the account assignment skills from this query
	INNER JOIN Skills S ON S.SkillID = AgentSkills.SkillID
		--and S.[Name] not like 'CollAcct %'

	SELECT
		 CL.ListID
		 ,CL.DepartmentID
		,Name
		,CL.CreatedOn
		,ADCMessage
		,AutoConnect
		,CallsPerAgent
		,QueuePrecedence AS 'Precedence'
		,ISNULL(C.Total,0) AS 'Total'
		,ISNULL(C.[Current],0) AS 'Current'
		,CL.AMD
		,Number
	    ,coalesce(CLR.FileName,'') as 'RecordingName'

	FROM CallList CL
	INNER JOIN Phones P ON P.PhoneID = CL.PhoneID
	LEFT JOIN (SELECT ListID, COUNT(1) AS 'Total',
		SUM(IIF(StatusDate IS NULL, 0, 1)) AS 'Current'
	FROM CallListItems
	WHERE (CallStatusID != 10 OR CallStatusID IS NULL) AND
	(StatusDate >= DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) OR StatusDate IS NULL)
	GROUP BY ListID) C ON CL.ListID = C.ListID
	LEFT JOIN CallListRecordings CLR on CL.ListID = CLR.ListID AND CLR.isDeleted is null or CLR.isDeleted = 0
	Where CL.[Enabled] = 1


	SELECT
		ListID
		,SkillID
	FROM CallListSkills

    SELECT
           AR.AgentID,
           AR.FileName,
           AR.CreatedOn
	FROM AgentRecordings AR
	INNER JOIN Agents A ON AR.AgentID = A.AgentUI
	WHERE ActiveAccount = 1 AND (AR.isDeleted IS NULL OR AR.isDeleted = 0)
		AND (DepartmentID = @DepartmentID OR @DepartmentID IS NULL)
	ORDER BY AR.CreatedOn DESC;

END