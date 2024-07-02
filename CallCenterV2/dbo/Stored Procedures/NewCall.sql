CREATE PROCEDURE [dbo].[NewCall] (
	 @CallSid CHAR(34)
	,@DepartmentID INT
	,@CustomerID INT = NULL
	,@FromNumber CHAR(10)
	,@ToNumber CHAR(10)
	,@CallDirection CHAR(1)
	,@CallState CHAR(2) = NULL
	,@CallZip CHAR(5) = NULL
	,@IVRTime TIME(0) = '0:00'
	,@QueueTime TIME(0) = '0:00'
	,@CallStartTime DATETIME
	,@CallEndTime DATETIME = NULL
	,@HoldTime TIME = '0:00'
	,@IsAgentHangUp BIT
	,@ListItemID INT = NULL
	,@IsDroppedCall BIT = 0
	,@lineType int = 1
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


INSERT INTO Calls(
			 CallSid 
			,DepartmentID
			,CustomerID 
			,FromNumber 
			,ToNumber 
			,CallDirection 
			,CallState 
			,CallZip 
			,IVRTime
			,QueueTime 
			,CallStartTime	
			,CallEndTime
			,HoldDuration
			,IsAgentHangUp
			,ListItemID
			,IsDroppedCall
			,LineType
		)VALUES (
			 @CallSid
			,@DepartmentID
			,@CustomerID 
			,@FromNumber 
			,@ToNumber 
			,@CallDirection 
			,@CallState 
			,@CallZip 
			,@IVRTime
			,@QueueTime 
			,@CallStartTime
			,@CallEndTime
			,@HoldTime
			,@IsAgentHangUp
			,@ListItemID
			,@IsDroppedCall
			,@lineType
		)

		SELECT SCOPE_IDENTITY() AS 'ID'
END


SET ANSI_NULLS ON