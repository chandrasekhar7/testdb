

CREATE PROCEDURE ImportCalls (
	@Calls CallImport READONLY,
	@AC AgentCallImport READONLY
) AS
BEGIN

	INSERT INTO ZCalls 
	SELECT 
		Sid,
		CallID,
		StartTime,
		EndTime,
		FromNumber,
		ToNumber,
		Direction
	FROM @Calls

	INSERT INTO ZAgentCalls SELECT * FROM @AC
END 