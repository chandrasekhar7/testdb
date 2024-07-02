-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 11/9/2016
-- Description:	Completes a call
-- ==================================================================================================

CREATE PROCEDURE [dbo].[CompleteCall] (
	 @CallID INT
	,@DepartmentID INT
	,@CustomerID INT = NULL
	,@IVRTime TIME(0) = '0:00'
	,@QueueTime TIME(0) = '0:00'
	,@CallEndTime DATETIME
	,@HoldTime TIME = '0:00'
	,@IsAgentHangUp BIT
	,@ListItemID INT = NULL
	,@IsDroppedCall BIT = 0
	,@ParentCallID INT = NULL
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

	UPDATE Calls
		SET DepartmentID = @DepartmentID
			,CustomerID = @CustomerID
			,IVRTime = @IVRTime
			,QueueTime = @QueueTime
			,CallEndTime = @CallEndTime
			,HoldDuration = @HoldTime
			,IsAgentHangup = @IsAgentHangUp
			,ListItemID = @ListItemID
			,IsDroppedCall = @IsDroppedCall
			,ParentCallID = @ParentCallID
	WHERE CallID = @CallID


END
