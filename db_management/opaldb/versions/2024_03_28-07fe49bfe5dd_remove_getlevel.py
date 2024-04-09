"""Remove the `getLevel` stored procedure.

getLevel was being used to determine a default hospital map for appointments if there was none in the alias.
However, this is specific to the Cedar's Cancer Centre and doesn't work for other sites and institutions.

Revision ID: 07fe49bfe5dd
Revises: bc09885fdeec
Create Date: 2024-03-28 01:27:23.883537

"""
from alembic import op

from db_management.opaldb.custom_operations import ReplaceableObject

# revision identifiers, used by Alembic.
revision = '07fe49bfe5dd'
down_revision = 'bc09885fdeec'
branch_labels = None
depends_on = None

get_level_procedure = ReplaceableObject(
    'getLevel',  # noqa: WPS462
    """
    (`in_DateTime` datetime, `in_Description` varchar(255), `in_HospitalMap` int) RETURNS int(11)
    DETERMINISTIC
        COMMENT 'Get the RC or S1 level for the patient appointments'
    BEGIN
    /*
    By: Yick Mo
    Date: 2018-06-04

    Purpose: This will override the original location of the appointment by figuring out the time of the appointment
        and where the level where the patient should go depends on what floor the doctor is located during the day.
        The morning shift is AM until 13:00 which is considered PM.

        NOTE: This is temporary for now due to the fact of the hard coding of the database and hospital maps.
        Need to design this to be more dynamic.
    Parameters:
        in_DateTime = date and time of the appointment

        in_Description = description of the appointment
            NOTE:
                OpalDB is AliasExpression table (Description is the fieldname)
                Wait Room Management is Clinic Resources table (ResourceName is the fieldname)

        in_HospitalMap = original location where the patient is suppose to go for their appointment

    Update: 2021-09-21 YM
        Removed the connection to ORMS database because we are now using APIs
    */

        -- Declare variables
        Declare wsDateTime DateTime;
        Declare wsDescription, wsCurrentHospitalMap, wsRCLevel, wsDSLevel VarChar(255);
        Declare wsDayOfWeek, wsBloodTest, wsDS_Area VarChar(3);
        Declare wsAMFM, wsReturnLevel VarChar(3);
        Declare wsReturnHospitalMap Int;
        -- Store the parameters
        set wsDateTime = in_DateTime;
        set wsDescription = in_Description;
        set wsCurrentHospitalMap = concat('|', IfNull(in_HospitalMap, ''), '|');

        -- Setup the default map location for RC and DS
        set wsRCLevel = '|20|21|22|23|24|25|'; -- RC Level
        set wsDSLevel = '|10|19|26|'; -- DS Level

        -- Get the three characters of the day
        set wsDayOfWeek = left(DAYNAME(ADDDATE(wsDateTime, INTERVAL 0 DAY)), 3);

        -- Get the AM or PM
        set wsAMFM = if(hour(ADDTIME(wsDateTime, '0 0:00:00')) >= 13, 'PM', 'AM');

        -- Set the variables to default
        set wsBloodTest = 'No';
        set wsDS_Area = 'No';

        -- Step 1) Is the appointment a blood test
        set wsBloodTest = if(ltrim(rtrim(wsDescription)) = 'NS - prise de sang/blood tests pre/post tx', 'Yes', 'No');

        -- Step 2) If not a blood test, then is the appointment description for DS location only
        if (wsBloodTest = 'No') then
            if (wsDescription like '.EBC%'
                or wsDescription like '.EBP%'
                or wsDescription like '.EBM%'
                or wsDescription like 'CT%'
                or wsDescription like '.BXC%'
                or wsDescription like 'FOLLOW%'
                or wsDescription like 'F-U%'
                or wsDescription like 'CONSULT%'
                or wsDescription like 'Injection%'
                or wsDescription like 'Transfusion%'
                or wsDescription like 'Nursing Consult%'
                or wsDescription like 'INTRA%'
                or wsDescription like 'Hydration%') then
                    if (
                        (wsDescription <> 'CONSULT RETURN TELEMED') AND
                        (wsDescription <> 'CONSULT NEW TELEMED') AND
                        (wsDescription <> 'FOLLOW UP TELEMED LESS/30 DAYS') AND
                        (wsDescription <> 'FOLLOW UP TELEMED MORE/30 DAYS') AND
                        (wsDescription <> 'FU TELEMED LESS/30DAYS') AND
                        (wsDescription <> 'FU TELEMED MORE/30DAYS') AND
                        (wsDescription <> 'INTRA TREAT TELEMED')
                        )then
                        set wsDS_Area = 'Yes';
                    else
                        set wsDS_Area = 'No';
                    end if;
            else
                set wsDS_Area = 'No';
            end if;
        end if;

        -- Step 3) If it is not a blood test and DS location only, then get the current location of the doctor
        if ((wsBloodTest = 'No') and (wsDS_Area = 'No')) then

            -- Return only the RC or DS location of the doctor
            -- Doctors may be assigned to two different rooms
            /*
            set wsReturnLevel =
                (SELECT Level
                    FROM WaitRoomManagementFED.DoctorSchedule USE INDEX (ID_ResourceNameDayAMPM)
                    WHERE ResourceName = wsDescription
                        AND DAY = wsDayOfWeek
                        AND AMPM = wsAMFM
                    limit 1);
            */
            -- If no location found, return N/A
            set wsReturnLevel = (IfNull(wsReturnLevel, 'N/A'));
        end if;


        -- Step 4) Return the location
        set wsReturnHospitalMap = -1;

        if ((wsBloodTest = 'Yes') and (wsDS_Area = 'No')) then
            set wsReturnHospitalMap = 23; -- Return RC level for blood test
        else
            if ((wsBloodTest = 'No') and (wsDS_Area = 'Yes')) then
                -- Return DS Level for only DS location based on the appointment description
                set wsReturnHospitalMap = 19;
            else
                -- If doctor's and appointment location match or if the doctor's location is N/A,
                -- then return original location.
                if ( 	((wsReturnLevel = 'S1') and (instr(wsDSLevel, wsCurrentHospitalMap) > 0))  or
                        ((wsReturnLevel = 'RC')  and (instr(wsRCLevel, wsCurrentHospitalMap) > 0)) or
                        ((wsReturnLevel = 'N/A') and (wsCurrentHospitalMap <> '||')) ) then
                    set wsReturnHospitalMap = in_HospitalMap;
                else
                    -- If doctor's and appointment location does not match
                    if (wsReturnLevel = 'S1') then
                        set wsReturnHospitalMap = 19; -- Return DS level
                    else
                        if (wsReturnLevel = 'RC') then
                            set wsReturnHospitalMap = 20; --  Return RC level
                        end if;
                    end if;
                end if;

            end if;
        end if;

        if (wsReturnHospitalMap = -1) then
            set wsReturnHospitalMap = 20; -- Force default for all appointment when unable to locate one
        end if;

        Return wsReturnHospitalMap;

    END;
    """,
)


def upgrade() -> None:
    """Upgrade to this migration."""
    op.drop_procedure(get_level_procedure)  # type: ignore[attr-defined]


def downgrade() -> None:
    """Downgrade this migration."""
    op.create_procedure(get_level_procedure)  # type: ignore[attr-defined]
