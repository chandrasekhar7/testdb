
-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 10/14/2016
-- Description:	Gets the department message exceptions for example: if it is a holiday and we would
--				like to play a different message then the one that plays on other days
-- ==================================================================================================

CREATE PROCEDURE [dbo].[GetDepartmentMessageExceptions] (
	@DepartmentID INT,
	@Date DATE	
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
			ExceptionDate,
			FileName,
			StartTime,
			EndTime
	FROM DepartmentMessageExceptions DM
	LEFT JOIN Languages L ON L.LanguageID = DM.LanguageID
	WHERE ExceptionDate = @Date
		AND DepartmentID = @DepartmentID
END
