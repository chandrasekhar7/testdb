CREATE PROCEDURE [dbo].[GetSkills] 
AS
	BEGIN
	SET NOCOUNT ON
/****************************************************************************************************
--------------Change History----------------------section START--------------------------------------
*****************************************************************************************************
	DEVELOPER NAME		DATE				DESC

	scott hoopes		08/02/2019			see comment about teams and skills

*****************************************************************************************************
--------------Change History----------------------section END----------------------------------------
*****************************************************************************************************/

	SELECT
		 SkillID
		,Name
		,IsRequired
		,IsLanguage
	FROM Skills		
	--SAH 08/02/2019 added for issue "Teams and skills" where we are using Yak skills to assign RI accounts
	--due to 32 skill limit for Yak matching calls, we will exclude the account assignment skills from this query
    --Yak Card: Removed this based on a bug filed in trello.
    --Yak call list not following skill assigned to it
    --where Skills.[Name] not like 'CollAcct %'

END