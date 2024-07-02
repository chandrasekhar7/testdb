CREATE PROCEDURE [dbo].[GetDepartment]
	@DepartmentID INT
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

	SELECT	 D.DepartmentID
			,Name
			,SunStart
			SunEnd,
			MonStart,
			MonEnd,
			TuesStart,
			TuesEnd,
			WedStart,
			WedEnd,
			ThursStart,
			ThursEnd,
			FriStart,
			FriEnd,
			SatStart,
			SatEnd
	FROM Departments D
	WHERE D.DepartmentID = @DepartmentID

	-- Department Statuses
	SELECT D.DepartmentID
			,StatusID
			,A.Name
			,CanAnswer
	FROM AgentStatus A
	LEFT JOIN Departments D ON D.DepartmentID = A.DepartmentID OR A.DepartmentID IS NULL
	WHERE D.DepartmentID = @DepartmentID
	ORDER BY D.DepartmentID, StatusID

	-- Department Phones
	SELECT	 Number
			,Precedence
			,IsPrimary
	        ,Location
	        ,LocationDefault
	FROM Phones
	WHERE DepartmentID = @DepartmentID

END


SET ANSI_NULLS ON