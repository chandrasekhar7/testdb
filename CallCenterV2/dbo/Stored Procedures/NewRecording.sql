CREATE PROCEDURE [dbo].[NewRecording] (
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

	INSERT INTO Recordings (AgentCallID, RecordingUI, Duration, Format, DirID, DepartmentID)

    VALUES(
		 @CallID
		,@RecordingID
		,@Duration
		,@Format
		,@DirectoryID
        ,@DepartmentID
	)

END