
-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 10/14/2016
-- Description:	Gets the hours for all departments sunday through saturday
-- ==================================================================================================

CREATE PROCEDURE [dbo].[GetDepartmentHours] (
	@DepartmentID INT
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
	
	SELECT	DepartmentID,
			SunStart,
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
	FROM Departments
	WHERE DepartmentID = @DepartmentID

END


