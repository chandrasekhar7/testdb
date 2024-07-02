
-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 10/14/2016
-- Description:	Gets all custom messages for a department which will be executed if the department
--				is not open and does not have an exception for the date at that given time
-- ==================================================================================================

CREATE PROCEDURE [dbo].[GetDepartmentMessages] (
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
			L.Title AS 'Language',
			FileName
	FROM DepartmentMessages DM
	LEFT JOIN Languages L ON L.LanguageID = DM.LanguageID
	WHERE DepartmentID = @DepartmentID
	--ORDER BY DepartmentID
END


SET ANSI_NULLS ON
