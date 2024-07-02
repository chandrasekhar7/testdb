
-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 3/8/2016
-- Description:	Timestamps the start and end time of a given status for a specific agent
-- ==================================================================================================

CREATE PROCEDURE [dbo].[NewAgentActivity] (
	 @AgentID INT
	,@StatusID INT 
	,@StartTime DATETIME
	,@EndTime DATETIME
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

	INSERT INTO AgentActivity VALUES(
		 @AgentID 
		,@StatusID  
		,@StartTime 
		,@EndTime 
	)

END




SET ANSI_NULLS ON
