CREATE PROCEDURE [dbo].[AutoNumberRotation] AS

/****************************************************************************************************
--------------Change History----------------------section START--------------------------------------
*****************************************************************************************************
	DEVELOPER NAME		DATE				DESC
	Stephen Jehner      02/14/2023          Added MO, UT, and TN numbers
    Alejandro           05/16/2024          Adding LA numbers
*****************************************************************************************************
--------------Change History----------------------section END----------------------------------------
*****************************************************************************************************/

    DECLARE @DefaultID INT = 0

    -- CA Phone Numbers ID -> 42 to 53 (Jan to Dec)

        SELECT
               @DefaultID = PhoneID
        FROM dbo.Phones
        WHERE DepartmentID = 2 AND Location = 'CA' AND LocationDefault = 1

        UPDATE P
            SET LocationDefault = 0
        FROM dbo.Phones P
        WHERE PhoneID = @DefaultID

        UPDATE dbo.Phones
            SET LocationDefault = 1
        WHERE PhoneID = IIF(@DefaultID = 53, 42,@DefaultID + 1)

    -- TX Phone Numbers ID -> 54 to 65 (Jan to Dec)

        SELECT
               @DefaultID = PhoneID
        FROM dbo.Phones
        WHERE DepartmentID = 2 AND Location = 'TX' AND LocationDefault = 1

        UPDATE P
            SET LocationDefault = 0
        FROM dbo.Phones P
        WHERE PhoneID = @DefaultID

        UPDATE dbo.Phones
            SET LocationDefault = 1
        WHERE PhoneID = IIF(@DefaultID = 65, 54,@DefaultID + 1)

    -- KS Phone Numbers ID -> 66 to 77 (Jan to Dec)

        SELECT
               @DefaultID = PhoneID
        FROM dbo.Phones
        WHERE DepartmentID = 2 AND Location = 'KS' AND LocationDefault = 1

        UPDATE P
            SET LocationDefault = 0
        FROM dbo.Phones P
        WHERE PhoneID = @DefaultID

        UPDATE dbo.Phones
            SET LocationDefault = 1
        WHERE PhoneID = IIF(@DefaultID = 77, 66,@DefaultID + 1)

    -- MO Phone Numbers ID -> 78 to 89 (Jan to Dec)

        SELECT
               @DefaultID = PhoneID
        FROM dbo.Phones
        WHERE DepartmentID = 2 AND Location = 'MO' AND LocationDefault = 1

        UPDATE P
            SET LocationDefault = 0
        FROM dbo.Phones P
        WHERE PhoneID = @DefaultID

        UPDATE dbo.Phones
            SET LocationDefault = 1
        WHERE PhoneID = IIF(@DefaultID = 89, 78,@DefaultID + 1)

    -- UT Phone Numbers ID -> 90 to 101 (Jan to Dec)

        SELECT
               @DefaultID = PhoneID
        FROM dbo.Phones
        WHERE DepartmentID = 2 AND Location = 'UT' AND LocationDefault = 1

        UPDATE P
            SET LocationDefault = 0
        FROM dbo.Phones P
        WHERE PhoneID = @DefaultID

        UPDATE dbo.Phones
            SET LocationDefault = 1
        WHERE PhoneID = IIF(@DefaultID = 101, 90,@DefaultID + 1)

    -- TN Phone Numbers ID -> 102 to 113 (Jan to Dec)

        SELECT
               @DefaultID = PhoneID
        FROM dbo.Phones
        WHERE DepartmentID = 2 AND Location = 'TN' AND LocationDefault = 1

        UPDATE P
            SET LocationDefault = 0
        FROM dbo.Phones P
        WHERE PhoneID = @DefaultID

        UPDATE dbo.Phones
            SET LocationDefault = 1
        WHERE PhoneID = IIF(@DefaultID = 113, 102,@DefaultID + 1)

    -- LA Phone Numbers ID -> 114 to 125 (Jan to Dec)

        SELECT
               @DefaultID = PhoneID
        FROM dbo.Phones
        WHERE DepartmentID = 2 AND Location = 'LA' AND LocationDefault = 1

        UPDATE P
            SET LocationDefault = 0
        FROM dbo.Phones P
        WHERE PhoneID = @DefaultID

        UPDATE dbo.Phones
            SET LocationDefault = 1
        WHERE PhoneID = IIF(@DefaultID = 125, 114,@DefaultID + 1)