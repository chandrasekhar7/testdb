
-- ==================================================================================================
-- Author:		Lyle Mcclanahan
-- Create date: 2/24/2020
-- Description:	Inserts A New Call List Prefixed with TX ASGMT
-- ==================================================================================================

CREATE PROCEDURE [dbo].[AddCallListSkillFromAgentID](@AgentID INT, @CallListNamePrefix VARCHAR(25))  /*CA ASGMT || TX ASGMT*/
AS
BEGIN
    SET NOCOUNT ON



/****************************************************************************************************
--------------Change History----------------------section START--------------------------------------
*****************************************************************************************************
DEVELOPER NAME		DATE				DESC
Lyle Mcclanahan		02-24-2020			INSERT CallList based on the AgentID 
INSERT Skill using firstname based on AgentID
INSERT CallListSkill based on CallLlist.ListID and Skills.SkillID

*****************************************************************************************************
--------------Change History----------------------section END----------------------------------------
*****************************************************************************************************/

	BEGIN TRANSACTION;
	SAVE TRANSACTION mySavePoint;
	BEGIN TRY

		DECLARE @SkillID INT = 0;
		DECLARE @ListID INT = 0;

		INSERT INTO [CallCenterV2].[dbo].[CallList] (DepartmentID,
								Name,
								ADCMessage,
								AutoConnect,
								CallsPerAgent,
								QueuePrecedence,
								AMD,
								PhoneID)
		SELECT A.DepartmentID
				, @CallListNamePrefix + ' ' + A.FirstName AS Name
				, 'This is ' + A.FirstName + ' with Net Pay Advance. I''m calling with regard to personal business matter. It''s important you return my call. My number is 8 8 8. 9 4 2. 3 3 6 0. Again that number is 8 8 8. 9 4 2. 3 3 6 0. Thank you.'
				, 1
				, 1
				, 1
				, 1
				, 21
		FROM [CallCenterV2].[dbo].[Agents] A
		WHERE A.ActiveAccount = 1
			AND A.AgentID = @AgentID;


		-- get listid
		SET @ListID = SCOPE_IDENTITY();


		-- Add skill      
		IF (SELECT COUNT(*)
			FROM [CallCenterV2].[dbo].[Skills] S
			WHERE S.Name = (SELECT A.FirstName
							FROM Agents A
							WHERE A.AgentID = @AgentID)) < 1
			BEGIN
				-- if this is the first time this calllist has been inserted
				-- we need to create a skill to accompany the calllist
				-- then we will push listid and skillid into CallListSkills
				INSERT INTO [CallCenterV2].[dbo].[Skills] (Name, IsRequired, IsLanguage)
				VALUES ((SELECT A.FirstName FROM [CallCenterV2].[dbo].[Agents] A WHERE A.AgentID = @AgentID), 0, 0);
				SET @SkillID = SCOPE_IDENTITY();
			END
		ELSE
			BEGIN
				--if a skill already exists then we do not need more than one
				--just fetch the already inserted skillid for insertion into CallListSkills
				SELECT @SkillID = s.SkillID
				FROM [CallCenterV2].[dbo].[Skills] s
				WHERE s.Name = (
					SELECT A.FirstName
					FROM [CallCenterV2].[dbo].[Agents] A
					WHERE A.AgentID = @AgentID)
			END


		--if we have both a ListId and a SkillID then we can safely insert into CallListSkills
		IF @ListID > 0 AND @SkillID > 0
			INSERT INTO [CallCenterV2].[dbo].[CallListSkills] (ListID, SkillID) VALUES (@ListID, @SkillID)

    COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION mySavePoint; -- rollback to MySavePoint
			END
	END CATCH

/*
DECLARE @AgentFirstName AS VARCHAR(25)='';
SELECT @AgentFirstName = A.FirstName FROM Agents A WHERE A.AgentID = @AgentID;
--ELSE
--	BEGIN					
--		INSERT INTO CallListSkills(ListID, SkillID) VALUES (
--			(SELECT cl.ListID from CallList cl WHERE cl.Name LIKE '%' + @AgentFirstName),
--			(SELECT s.Name from Skills s WHERE s.Name LIKE '%' + @AgentFirstName)
--		)						
--	END		
*/



END
    SET ANSI_NULLS ON
