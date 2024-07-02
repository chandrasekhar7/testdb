-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 10/7/2016
-- Description:	Inserts new agent call into the AgentCalls Table
-- ==================================================================================================

CREATE PROCEDURE [dbo].[CompletedAgentCall] (
	@CallSid CHAR(34),
	@CustomerCallID INT,
	@AgentID INT,
	@CallStart DATETIME,
	@CallEnd DATETIME,
	@CallType TINYINT = 1
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

	INSERT INTO AgentCalls (
		 CallSid
		,CustomerCallID
		,AgentID
		,CallStart
		,CallEnd
		,CallType
	) VALUES (
		 @CallSid
		,@CustomerCallID
		,@AgentID
		,@CallStart
		,@CallEnd
		,@CallType
	)

	SELECT SCOPE_IDENTITY() AS 'ID'
END
