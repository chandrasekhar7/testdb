-- =============================================
-- Author:		Jon Reed
-- Create date: 7/24/2018
-- Description:	To archive the automated voicemails created by Netpay Eyes in the testing of Yak availability.
-- =============================================
CREATE PROCEDURE ArchiveNPECalls
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE v
	SET IsArchived = 1
	FROM Voicemails v
	JOIN Calls c ON v.CallID = c.CallID
	WHERE c.FromNumber = '3163134978'

END
