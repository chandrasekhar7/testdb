CREATE PROCEDURE [dbo].[NewVoiceMail] (
	 @CallID INT
	,@RecordingID UNIQUEIDENTIFIER
	,@Duration INT
	,@Format VARCHAR(4) = 'mp3'
	,@DirectoryID INT
	,@DepartmentID INT
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

	INSERT INTO Voicemails (CallID, RecordingUI, Duration, Format, DirID, IsArchived, DepartmentID)

	VALUES(
		 @CallID 
		,@RecordingID
		,@Duration
		,@Format
		,@DirectoryID
		,0
		,@DepartmentID
	)

END