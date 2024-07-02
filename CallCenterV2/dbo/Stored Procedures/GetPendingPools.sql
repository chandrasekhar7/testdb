
-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 10/21/2016
-- Description:	Gets the minimum amount of time for a call list to wait until it can start up again
--				if it has any pending list items
-- ==================================================================================================

CREATE PROCEDURE [dbo].[GetPendingPools] (
	@ListID INT
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
	
	SELECT MIN(StartTime) AS 'Until'

	FROM CallListItems
	WHERE StartTime IS NOT NULL
	AND CallStatusID IS NULL
	AND StartTime > CONVERT(TIME(0),GETDATE(),108)
	AND ListID = @ListID

END


