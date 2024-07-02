-- =====================================================================================================================
-- Author:		Brice Lohman
-- Create date: 6/22/2023
-- Description:	Gets the status on the completion percentage by Call List
-- =====================================================================================================================
CREATE PROCEDURE [dbo].[Reporting_DailyCallListReport] 

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
	DECLARE @html VARCHAR(MAX) = '',
			@dtStartLocal DATETIME = CONVERT(VARCHAR, CONVERT(date, GETDATE())) + ' 00:00',
			@dtEndLocal DATETIME = CONVERT(VARCHAR, CONVERT(date, GETDATE())) + ' 23:59:59';

    WITH CallList AS (
	SELECT
		cl.Name AS [Name]
		,SUM(IIF(cli.StatusDate is null, 0, 1)) AS [CompletedCalls]
		,COUNT(*) AS [TotalCalls]
		--,ROUND(((SUM(IIF(cli.StatusDate is null, 0, 1.00))/CONVERT(float, COUNT(*)))*100), 2) AS [Completion %]
		,FORMAT((SUM(IIF(cli.StatusDate is null, 0, 1))/COUNT(*)), 'P') AS [Completion %]
		FROM [CallCenterV2].[dbo].[CallListItems] cli
		LEFT JOIN [CallCenterV2].[dbo].[CallList] cl ON cl.ListID = cli.ListID
	  WHERE cli.createdon BETWEEN @dtStartLocal and @dtEndLocal
        AND CallStatusID <> 1 -- 1 is just queued
        AND CallStatusID IS NOT NULL
	  GROUP BY cli.listid, cl.Name)


    SELECT @html = '<h2>Call List Completion Report - ' + CONVERT(VARCHAR, GETDATE(), 101) + '<br><table border="1" cellpadding="4" cellspacing="0">' +
        '<tr><th>Name</th><th>Completed Calls</th><th>Total Calls</th><th>Completion %</th></tr>' + STUFF((
            SELECT 
				Name AS td,
				CompletedCalls AS [td align=right], 
				TotalCalls AS [td align=right], 
				[Completion %] AS [td align=right]
            FROM CallList
            FOR XML RAW('tr'), ELEMENTS
            ), 1,0,'') + '</table><br>'

    SET @html = Replace(@html, '_x003D_', '=');
    SET @html = Replace(@html, '_x0020_', space(1));
    SET @html = REPLACE(@html, '</td align=right>', '</td>')

	EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'ILM',
    @recipients='collectionsleadership@netpayadvance.com;',
    @subject = 'Call List Completion Report',
    @body = @html,
    @body_format = 'HTML';

END