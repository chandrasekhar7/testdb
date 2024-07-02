-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 3/23/2016
-- Description:	Gets all of the call lists in DB for a specific department
-- ==================================================================================================

CREATE PROCEDURE [dbo].[GetCallLists] (
	@DepartmentID INT
	,@ListID INT = NULL
)
AS
	BEGIN
	SET NOCOUNT ON
/****************************************************************************************************
--------------Change History----------------------section START--------------------------------------
*****************************************************************************************************
	DEVELOPER NAME		DATE				DESC
	Erick Coble			10/31/2016			Added AMC(Automatic Machine Detection) optional bit
	Scott Hoopes		09/03/2019			added [Enabled] = 1 to where for Account Assignment project

*****************************************************************************************************
--------------Change History----------------------section END----------------------------------------
*****************************************************************************************************/

	SELECT 
		 CL.ListID
		,Name
		,CreatedOn
		,ADCMessage
		,AutoConnect
		,QueuePrecedence AS 'Precedence'
		,ISNULL(C.Total,0) AS 'Total'
		,ISNULL(C.[Current],0) AS 'Current'
		,CL.AMD
		,Number
	FROM CallList CL
	INNER JOIN Phones P ON CL.PhoneID = P.PhoneID
	LEFT JOIN (SELECT ListID, COUNT(1) AS 'Total',
		SUM(IIF(StatusDate IS NULL, 0, 1)) AS 'Current'
	FROM CallListItems 
	WHERE (CallStatusID != 10 OR CallStatusID IS NULL) AND 
	(StatusDate >= DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) OR StatusDate IS NULL)
	GROUP BY ListID) C ON CL.ListID = C.ListID	
	WHERE CL.DepartmentID = @DepartmentID
	and CL.[Enabled] = 1
	AND (@ListID IS NULL OR @ListID = C.ListID)
END