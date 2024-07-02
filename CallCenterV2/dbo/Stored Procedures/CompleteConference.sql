
-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 3/14/2016
-- Description:	Inserts a new Conference
-- ==================================================================================================

CREATE PROCEDURE [dbo].[CompleteConference] (
	 @ConferenceSid CHAR(34),
	 @StartTime DATETIME,
	 @EndTime DATETIME,
	 @Name CHAR(34)

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

	INSERT INTO Conferences (
		ConferenceSid,
		StartTime,
		EndTime,
		Name
	
	) VALUES(
		 @ConferenceSid,
		 @StartTime,
		 @EndTime,
		 @Name
	)

	SELECT SCOPE_IDENTITY() AS 'ID'

END

