CREATE PROCEDURE [dbo].[ImportConferences] (
	@Conferences ConferenceImport READONLY
) AS
BEGIN

	INSERT INTO ZConferences
	SELECT 
		Sid,
		Name,
		StartTime,
		EndTime
	FROM @Conferences

END 
