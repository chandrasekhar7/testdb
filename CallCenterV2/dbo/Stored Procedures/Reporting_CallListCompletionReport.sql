-- =====================================================================================================================
-- Author:		Brice Lohman
-- Create date: 3/27/2023
-- Description:	Gets the status on the completion percentage by Call List
-- =====================================================================================================================
CREATE PROCEDURE [dbo].[Reporting_CallListCompletionReport] (
	 @DeptID INT,
	 @Date DATE
)

/***********************************************************************************************************************
--------------Change History----------------------section START---------------------------------------------------------
************************************************************************************************************************
DEVELOPER 		DATE	        CARD                                    DESCRIPTION

************************************************************************************************************************
--------------Change History----------------------section END-----------------------------------------------------------
************************************************************************************************************************/
AS
BEGIN
SET NOCOUNT ON
;WITH list AS (
	SELECT 
		cl.Name AS [Call List]
		,SUM(IIF(cli.StatusDate is null, 0, 1)) AS [Completed]
		,COUNT(*) AS [Total]
		,((SUM(IIF(cli.StatusDate is null, 0, 1))/COUNT(*))*100) AS [Completion %]
		FROM [CallCenterV2].[dbo].[CallListItems] cli
		LEFT JOIN [CallCenterV2].[dbo].[CallList] cl ON cl.ListID = cli.ListID
	WHERE 
		cl.DepartmentID = @DeptID
		AND cli.createdon BETWEEN @Date and DATEADD(day, 1, @Date)
	GROUP BY cli.listid, cl.Name
)

SELECT * FROM list
ORDER BY [Call List]

END