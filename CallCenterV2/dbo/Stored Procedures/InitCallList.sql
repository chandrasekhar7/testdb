
-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 3/16/2016
-- Description:	Gets the basic stats of the given call list
-- ==================================================================================================

CREATE PROCEDURE [dbo].[InitCallList] (
	 @DepartmentID INT
	,@ListID INT 
)
AS
	BEGIN
	SET NOCOUNT ON
/****************************************************************************************************
--------------Change History----------------------section START--------------------------------------
*****************************************************************************************************
	DEVELOPER NAME		DATE				DESC
	scott				05/13/2016			Changed inner join to left join so empty call list will still init

	Erick Coble			10/31/2016			Added AMC(Automatic Machine Detection)
*****************************************************************************************************
--------------Change History----------------------section END----------------------------------------
*****************************************************************************************************/

	SELECT 
		 Name
		,CreatedOn
		,ADCMessage
		,AutoConnect
		,CallsPerAgent
		,QueuePrecedence AS 'Precedence'
		,ISNULL(C.Total,0) AS 'Total'
		,ISNULL(C.[Current],0) AS 'Current'
		,CL.AMD
		,Number
	
	FROM CallList CL
	INNER JOIN Phones P ON P.PhoneID = CL.PhoneID
	LEFT JOIN (SELECT ListID, COUNT(1) AS 'Total',
		SUM(IIF(StatusDate IS NULL, 0, 1)) AS 'Current'
	FROM CallListItems 
	WHERE (CallStatusID != 10 OR CallStatusID IS NULL) AND 
	(StatusDate >= DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) OR StatusDate IS NULL)
	GROUP BY ListID) C ON CL.ListID = C.ListID
		
	WHERE CL.DepartmentID = @DepartmentID
		AND CL.ListID = @ListID

	SELECT 
			SkillID
	FROM CallList CL
	LEFT JOIN CallListSkills CLS ON CLS.ListID = CL.ListID
	WHERE CL.DepartmentID = @DepartmentID
		AND CL.ListID = @ListID

END

