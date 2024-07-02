
CREATE PROCEDURE [dbo].[YakLogError] (
	 @Message varChar(max)
	,@StackTrace varChar(max)
	,@Properties varChar(max)
)
AS
	BEGIN
	SET NOCOUNT ON
/****************************************************************************************************
--------------Change History----------------------section START--------------------------------------
*****************************************************************************************************
	DEVELOPER NAME		DATE				DESC
	Stephe Jehner		08-18-2023			Created Proc to log YAK errors

*****************************************************************************************************
--------------Change History----------------------section END----------------------------------------
*****************************************************************************************************/

	INSERT INTO CHOOSEPDF.dbo.ErrorLogs (Message, MessageTemplate, Level, TimeStamp, Exception, Properties)
	VALUES
		(@Message, 
		@Message,
		'Error',
		GETDATE(),
		@StackTrace,
		@Properties
		)
END


SET ANSI_NULLS ON
