
-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 1/7/2016
-- Description:	Gets all of the departments in the callCenter
-- ==================================================================================================

CREATE PROCEDURE [dbo].[ZInitDepartments] 
	@DepartmentID INT = NULL
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
			IsHidden
	FROM Phones
	WHERE DepartmentID = @DepartmentID OR @DepartmentID IS NULL

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
			SkillID
	FROM AgentSkills

	SELECT 
		 CL.ListID
		 ,CL2.DepartmentID
		,CL.Name
		,CL.CreatedOn
		,CL.ADCMessage
		,CL.AutoConnect
		,CL.CallsPerAgent
		,CL.QueuePrecedence AS 'Precedence'
		,C.Total
		,C.[Current]
		,CL.AMD
	
	FROM CallCenter.dbo.CallList CL
	INNER JOIN CallList CL2 ON CL2.ListID = CL.ListID
	LEFT JOIN (SELECT ListID, COUNT(1) AS 'Total',
		SUM(IIF(StatusDate IS NULL, 0, 1)) AS 'Current'
	FROM CallCenter.dbo.CallListItems 
	WHERE (CallStatusID != 10 OR CallStatusID IS NULL) AND 
	(StatusDate >= DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) OR StatusDate IS NULL)
	GROUP BY ListID) C ON CL.ListID = C.ListID
	
	

	SELECT 
		ListID
		,SkillID
	FROM CallListSkills
		

END