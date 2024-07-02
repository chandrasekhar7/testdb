-- ==================================================================================================
-- Author:		Erick Coble
-- Create date: 4/7/2016
-- Description:	Sets Time and exceeds 24 hours
-- ==================================================================================================
CREATE FUNCTION [dbo].[SecondsToTime]
(
	@seconds INT
)
RETURNS VARCHAR(12)
AS
BEGIN
	DECLARE @hh VARCHAR(4) = CAST(@seconds / 3600 AS VARCHAR),
	@mm VARCHAR(2) = CAST((@seconds / 60) % 60 AS VARCHAR),
	@ss VARCHAR(2) = CAST(@seconds % 60 AS VARCHAR)
	-- Return the result of the function
	RETURN IIF(LEN(@hh) = 1, '0', '') + @hh + ':' +
		RIGHT('0' + @mm,2) + ':' +
		RIGHT('0' + @ss,2)

END