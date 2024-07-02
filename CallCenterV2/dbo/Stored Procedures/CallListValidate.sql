-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 3/30/2016
-- Description:	Validates whether the customer can be called or not
-- ==================================================================================================

CREATE PROCEDURE [dbo].[CallListValidate] (
	 @CustomerID INT
	,@PhoneNumber CHAR(10)
	,@ItemID INT
)
AS
	BEGIN
	SET NOCOUNT ON
/****************************************************************************************************
--------------Change History----------------------section START--------------------------------------
*****************************************************************************************************
	DEVELOPER NAME		DATE				DESC
	Erick Coble			20160815			Do not call the same number twice a day
	scott hoopes		20200911			added local variables for each parameter
*****************************************************************************************************
--------------Change History----------------------section END----------------------------------------
*****************************************************************************************************/

DECLARE @AlreadyCalled BIT = 0,							-- Has the number been dialed yet today?
			@IsCall BIT = 0,							-- does customer have a completed call today?
			@localCustomerID int = @CustomerID,			--local variable, bypass parameter sniffing
			@localPhoneNumber CHAR(10) = @PhoneNumber,	--local variable, bypass parameter sniffing
			@localItemID int = @ItemID					--local variable, bypass parameter sniffing

	SELECT TOP 1
		 @AlreadyCalled = 1	-- dialed today?
	FROM CallListItems
	WHERE ((PhoneNumber = @PhoneNumber AND (CallStatusID IS NOT NULL AND CallStatusID != 11 AND CallStatusID != 10)) --CallStatusID = 5 OR CallStatusID = 12))
		OR (@CustomerID = CustomerID
		AND CallStatusID = 5))
		AND StatusDate >= DATEADD(dd,DATEDIFF(dd,0,GETDATE()),0)

	SELECT TOP 1
		@IsCall = 1		-- completed call from customer today?
	FROM Calls
	WHERE CallStartTime > DATEADD(dd,DATEDIFF(dd,0,GETDATE()),0) 
		AND @CustomerID = CustomerID	
		AND RPC = 1

	IF(@AlreadyCalled = 1 OR @IsCall = 1) BEGIN
		UPDATE CallListItems
			SET CallStatusID = CS.CallStatusID -- Set Status to Ignored
			,StatusDate = GETDATE()
		FROM CallStatus CS
		WHERE @ItemID = ItemID
			AND CS.Name = 'ignored'
	END

	SELECT @AlreadyCalled AS 'AlreadyCalled', @IsCall AS 'IsCall'
	

END


SET ANSI_NULLS ON
