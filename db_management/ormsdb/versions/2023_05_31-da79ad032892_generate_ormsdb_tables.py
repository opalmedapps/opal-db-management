"""
Generate ormsdb tables.

Revision ID: da79ad032892
Revises:
Create Date: 2023-05-31 18:10:47.904853

"""

from pathlib import Path

import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'da79ad032892'
down_revision = None
branch_labels = None
depends_on = None

# Find root and revision data paths for reading sql files
ROOT_DIR = Path(__file__).parents[1]
REVISIONS_DIR = ROOT_DIR / 'revision_data'


def upgrade() -> None:
    """Create tables and indexes."""
    op.execute('SET foreign_key_checks=0;')
    op.create_table(
        'Cron',
        sa.Column('System', sa.String(length=20), nullable=False),
        sa.Column(
            'LastReceivedSmsFetch',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.PrimaryKeyConstraint('System'),
    )
    op.create_table(
        'DiagnosisChapter',
        sa.Column('DiagnosisChapterId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('Chapter', sa.String(length=20), nullable=False),
        sa.Column('Description', sa.Text(), nullable=False),
        sa.PrimaryKeyConstraint('DiagnosisChapterId'),
        sa.UniqueConstraint('Chapter'),
    )
    op.create_table(
        'Hospital',
        sa.Column('HospitalId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('HospitalCode', sa.String(length=50), nullable=False),
        sa.Column('HospitalName', sa.String(length=100), nullable=False),
        sa.Column('Format', sa.String(length=50), nullable=True),
        sa.PrimaryKeyConstraint('HospitalId'),
        sa.UniqueConstraint('HospitalCode'),
    )
    op.create_table(
        'Insurance',
        sa.Column('InsuranceId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('InsuranceCode', sa.String(length=50), nullable=False),
        sa.Column('InsuranceName', sa.String(length=100), nullable=False),
        sa.Column('Format', sa.String(length=50), nullable=True),
        sa.PrimaryKeyConstraint('InsuranceId'),
        sa.UniqueConstraint('InsuranceCode'),
    )
    op.create_table(
        'Patient',
        sa.Column('PatientSerNum', mysql.INTEGER(display_width=10), nullable=False),
        sa.Column('LastName', sa.String(length=50), nullable=False),
        sa.Column('FirstName', sa.String(length=50), nullable=False),
        sa.Column('DateOfBirth', sa.DateTime(), nullable=False),
        sa.Column('Sex', sa.String(length=25), nullable=False),
        sa.Column('SMSAlertNum', sa.String(length=11), nullable=True),
        sa.Column('SMSSignupDate', sa.DateTime(), nullable=True),
        sa.Column('OpalPatient', mysql.TINYINT(display_width=1), server_default=sa.text('0'), nullable=False),
        sa.Column('LanguagePreference', sa.Enum('English', 'French'), nullable=True),
        sa.Column(
            'LastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('SMSLastUpdated', sa.DateTime(), nullable=True),
        sa.PrimaryKeyConstraint('PatientSerNum'),
    )
    op.create_table(
        'PatientLocation',
        sa.Column('PatientLocationSerNum', mysql.INTEGER(display_width=10), nullable=False),
        sa.Column('PatientLocationRevCount', mysql.INTEGER(display_width=3), nullable=False),
        sa.Column('AppointmentSerNum', mysql.INTEGER(display_width=10), nullable=False),
        sa.Column('CheckinVenueName', sa.String(length=50), nullable=False),
        sa.Column('ArrivalDateTime', sa.DateTime(), nullable=False),
        sa.Column('LastUpdated', sa.TIMESTAMP(), server_default=sa.text('current_timestamp()'), nullable=False),
        sa.Column(
            'IntendedAppointmentFlag', mysql.TINYINT(display_width=1), server_default=sa.text('0'), nullable=False
        ),
        sa.PrimaryKeyConstraint('PatientLocationSerNum'),
    )
    op.create_index(
        op.f('ix_PatientLocation_AppointmentSerNum'), 'PatientLocation', ['AppointmentSerNum'], unique=False
    )
    op.create_table(
        'PatientLocationMH',
        sa.Column(
            'PatientLocationSerNum',
            mysql.INTEGER(display_width=10),
            nullable=False,
            comment='This key comes from the PatientLocation table but it should be unique',
        ),
        sa.Column('PatientLocationRevCount', mysql.INTEGER(display_width=3), nullable=False),
        sa.Column('AppointmentSerNum', mysql.INTEGER(display_width=10), nullable=False),
        sa.Column('CheckinVenueName', sa.String(length=50), nullable=False),
        sa.Column('ArrivalDateTime', sa.DateTime(), nullable=False),
        sa.Column(
            'DichargeThisLocationDateTime',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp()'),
            nullable=False,
            comment='This is effectively the LastUpdated Column',
        ),
        sa.Column(
            'IntendedAppointmentFlag', mysql.TINYINT(display_width=1), server_default=sa.text('0'), nullable=False
        ),
        sa.PrimaryKeyConstraint('PatientLocationSerNum'),
    )
    op.create_index(
        op.f('ix_PatientLocationMH_AppointmentSerNum'), 'PatientLocationMH', ['AppointmentSerNum'], unique=False
    )
    op.create_table(
        'ProfileColumnDefinition',
        sa.Column('ProfileColumnDefinitionSer', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('ColumnName', sa.String(length=255), nullable=False),
        sa.Column('DisplayName', sa.String(length=255), nullable=False),
        sa.Column('Glyphicon', sa.String(length=255), nullable=False),
        sa.Column('Description', sa.Text(), nullable=False),
        sa.Column(
            'LastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.PrimaryKeyConstraint('ProfileColumnDefinitionSer'),
        sa.UniqueConstraint('ColumnName'),
    )
    op.create_table(
        'ProfileColumns',
        sa.Column('ProfileColumnSer', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('ProfileSer', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('ProfileColumnDefinitionSer', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('Position', mysql.INTEGER(display_width=11), server_default=sa.text('-1'), nullable=False),
        sa.Column('Active', mysql.TINYINT(display_width=1), server_default=sa.text('0'), nullable=False),
        sa.Column(
            'LastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.PrimaryKeyConstraint('ProfileColumnSer'),
    )
    op.create_index(op.f('ix_ProfileColumns_ProfileSer'), 'ProfileColumns', ['ProfileSer'], unique=False)
    op.create_table(
        'ProfileOptions',
        sa.Column('ProfileOptionSer', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('ProfileSer', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('Options', sa.String(length=255), nullable=False),
        sa.Column('Type', sa.Enum('ExamRoom', 'IntermediateVenue', 'Resource'), nullable=False),
        sa.Column(
            'LastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.PrimaryKeyConstraint('ProfileOptionSer'),
    )
    op.create_index(op.f('ix_ProfileOptions_ProfileSer'), 'ProfileOptions', ['ProfileSer'], unique=False)
    op.create_table(
        'TEMP_PatientQuestionnaireReview',
        sa.Column('PatientQuestionnaireReviewSerNum', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('PatientSer', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('ReviewTimestamp', sa.TIMESTAMP(), server_default=sa.text('current_timestamp()'), nullable=False),
        sa.Column('User', sa.String(length=50), nullable=False),
        sa.PrimaryKeyConstraint('PatientQuestionnaireReviewSerNum'),
    )
    op.create_index(
        op.f('ix_TEMP_PatientQuestionnaireReview_PatientSer'),
        'TEMP_PatientQuestionnaireReview',
        ['PatientSer'],
        unique=False,
    )
    op.create_table(
        'DiagnosisCode',
        sa.Column('DiagnosisCodeId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('DiagnosisChapterId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('Code', sa.String(length=20), nullable=False),
        sa.Column('Category', sa.Text(), nullable=False),
        sa.Column('Description', sa.Text(), nullable=False),
        sa.ForeignKeyConstraint(
            ['DiagnosisChapterId'],
            ['DiagnosisChapter.DiagnosisChapterId'],
        ),
        sa.PrimaryKeyConstraint('DiagnosisCodeId'),
        sa.UniqueConstraint('Code'),
    )
    op.create_index(op.f('ix_DiagnosisCode_DiagnosisChapterId'), 'DiagnosisCode', ['DiagnosisChapterId'], unique=False)
    op.create_table(
        'PatientHospitalIdentifier',
        sa.Column('PatientHospitalIdentifierId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('PatientId', mysql.INTEGER(display_width=10), nullable=False),
        sa.Column('HospitalId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('MedicalRecordNumber', sa.String(length=50), nullable=False),
        sa.Column('Active', mysql.TINYINT(display_width=4), nullable=False),
        sa.Column('DateAdded', sa.DateTime(), server_default=sa.text('current_timestamp()'), nullable=False),
        sa.Column(
            'LastModified',
            sa.DateTime(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.ForeignKeyConstraint(
            ['HospitalId'],
            ['Hospital.HospitalId'],
        ),
        sa.ForeignKeyConstraint(
            ['PatientId'],
            ['Patient.PatientSerNum'],
        ),
        sa.PrimaryKeyConstraint('PatientHospitalIdentifierId'),
    )
    op.create_index(
        'HospitalId_MedicalRecordNumber',
        'PatientHospitalIdentifier',
        ['HospitalId', 'MedicalRecordNumber'],
        unique=True,
    )
    op.create_index(
        op.f('ix_PatientHospitalIdentifier_PatientId'), 'PatientHospitalIdentifier', ['PatientId'], unique=False
    )
    op.create_table(
        'PatientInsuranceIdentifier',
        sa.Column('PatientInsuranceIdentifierId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('PatientId', mysql.INTEGER(display_width=10), nullable=False),
        sa.Column('InsuranceId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('InsuranceNumber', sa.String(length=50), nullable=False),
        sa.Column('ExpirationDate', sa.DateTime(), nullable=False),
        sa.Column('Active', mysql.TINYINT(display_width=4), nullable=False),
        sa.Column('DateAdded', sa.DateTime(), server_default=sa.text('current_timestamp()'), nullable=False),
        sa.Column(
            'LastModified',
            sa.DateTime(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.ForeignKeyConstraint(
            ['InsuranceId'],
            ['Insurance.InsuranceId'],
        ),
        sa.ForeignKeyConstraint(
            ['PatientId'],
            ['Patient.PatientSerNum'],
        ),
        sa.PrimaryKeyConstraint('PatientInsuranceIdentifierId'),
    )
    op.create_index(
        'InsuranceId_InsuranceNumber', 'PatientInsuranceIdentifier', ['InsuranceId', 'InsuranceNumber'], unique=True
    )
    op.create_index(
        op.f('ix_PatientInsuranceIdentifier_PatientId'), 'PatientInsuranceIdentifier', ['PatientId'], unique=False
    )
    op.create_table(
        'PatientMeasurement',
        sa.Column('PatientMeasurementSer', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('PatientSer', mysql.INTEGER(display_width=10), nullable=False),
        sa.Column('AppointmentId', sa.String(length=100), nullable=False),
        sa.Column('PatientId', sa.String(length=50), nullable=False),
        sa.Column('Date', sa.Date(), nullable=False),
        sa.Column('Time', sa.Time(), nullable=False),
        sa.Column('Height', sa.Float(asdecimal=True), nullable=False),
        sa.Column('Weight', sa.Float(asdecimal=True), nullable=False),
        sa.Column('BSA', sa.Float(asdecimal=True), nullable=False),
        sa.Column(
            'LastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.ForeignKeyConstraint(
            ['PatientSer'],
            ['Patient.PatientSerNum'],
        ),
        sa.PrimaryKeyConstraint('PatientMeasurementSer'),
    )
    op.create_index(op.f('ix_PatientMeasurement_PatientSer'), 'PatientMeasurement', ['PatientSer'], unique=False)
    op.create_table(
        'SpecialityGroup',
        sa.Column('SpecialityGroupId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('HospitalId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('SpecialityGroupCode', sa.String(length=50), nullable=False),
        sa.Column('SpecialityGroupName', sa.String(length=50), nullable=False),
        sa.Column(
            'LastUpdated',
            sa.DateTime(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.ForeignKeyConstraint(
            ['HospitalId'],
            ['Hospital.HospitalId'],
        ),
        sa.PrimaryKeyConstraint('SpecialityGroupId'),
        sa.UniqueConstraint('SpecialityGroupCode'),
    )
    op.create_index(op.f('ix_SpecialityGroup_HospitalId'), 'SpecialityGroup', ['HospitalId'], unique=False)
    op.create_table(
        'AppointmentCode',
        sa.Column('AppointmentCodeId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('AppointmentCode', sa.String(length=100), nullable=False),
        sa.Column('SpecialityGroupId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('DisplayName', sa.String(length=100), nullable=True),
        sa.Column('SourceSystem', sa.String(length=50), nullable=False),
        sa.Column('Active', mysql.TINYINT(display_width=4), server_default=sa.text('1'), nullable=False),
        sa.Column(
            'LastModified',
            sa.DateTime(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.ForeignKeyConstraint(
            ['SpecialityGroupId'],
            ['SpecialityGroup.SpecialityGroupId'],
        ),
        sa.PrimaryKeyConstraint('AppointmentCodeId'),
    )
    op.create_index(
        'AppointmentCode_SpecialityGroupId', 'AppointmentCode', ['AppointmentCode', 'SpecialityGroupId'], unique=True
    )
    op.create_index(
        op.f('ix_AppointmentCode_SpecialityGroupId'), 'AppointmentCode', ['SpecialityGroupId'], unique=False
    )
    op.create_table(
        'ClinicHub',
        sa.Column('ClinicHubId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('SpecialityGroupId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('ClinicHubName', sa.String(length=50), nullable=False),
        sa.Column(
            'LastUpdated',
            sa.DateTime(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.ForeignKeyConstraint(
            ['SpecialityGroupId'],
            ['SpecialityGroup.SpecialityGroupId'],
        ),
        sa.PrimaryKeyConstraint('ClinicHubId'),
    )
    op.create_index(op.f('ix_ClinicHub_SpecialityGroupId'), 'ClinicHub', ['SpecialityGroupId'], unique=False)
    op.create_table(
        'ClinicResources',
        sa.Column('ClinicResourcesSerNum', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('ResourceCode', sa.String(length=200), nullable=False),
        sa.Column(
            'ResourceName',
            sa.String(length=200),
            nullable=False,
            comment='Both Aria and Medivisit resources listed here',
        ),
        sa.Column('SpecialityGroupId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('SourceSystem', sa.String(length=50), nullable=False),
        sa.Column(
            'LastModified',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column(
            'Active',
            mysql.TINYINT(display_width=4),
            server_default=sa.text('1'),
            nullable=False,
            comment='1 = Active / 0 = Not Active',
        ),
        sa.ForeignKeyConstraint(
            ['SpecialityGroupId'],
            ['SpecialityGroup.SpecialityGroupId'],
        ),
        sa.PrimaryKeyConstraint('ClinicResourcesSerNum'),
    )
    op.create_index(
        'ClinicResources_SpecialityGroupId', 'ClinicResources', ['ResourceCode', 'SpecialityGroupId'], unique=True
    )
    op.create_index(op.f('ix_ClinicResources_Active'), 'ClinicResources', ['Active'], unique=False)
    op.create_index(op.f('ix_ClinicResources_ResourceName'), 'ClinicResources', ['ResourceName'], unique=False)
    op.create_index(
        op.f('ix_ClinicResources_SpecialityGroupId'), 'ClinicResources', ['SpecialityGroupId'], unique=False
    )
    op.create_table(
        'DiagnosisSubcode',
        sa.Column('DiagnosisSubcodeId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('DiagnosisCodeId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('Subcode', sa.String(length=20), nullable=False),
        sa.Column('Description', sa.Text(), nullable=False),
        sa.ForeignKeyConstraint(
            ['DiagnosisCodeId'],
            ['DiagnosisCode.DiagnosisCodeId'],
        ),
        sa.PrimaryKeyConstraint('DiagnosisSubcodeId'),
        sa.UniqueConstraint('Subcode'),
    )
    op.create_index(op.f('ix_DiagnosisSubcode_DiagnosisCodeId'), 'DiagnosisSubcode', ['DiagnosisCodeId'], unique=False)
    op.create_table(
        'Profile',
        sa.Column('ProfileSer', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('ProfileId', sa.String(length=255), nullable=False),
        sa.Column(
            'Category',
            sa.Enum('PAB', 'Physician', 'Nurse', 'Checkout Clerk', 'Pharmacy', 'Treatment Machine'),
            nullable=False,
        ),
        sa.Column('SpecialityGroupId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('LastUpdated', sa.TIMESTAMP(), server_default=sa.text('current_timestamp()'), nullable=False),
        sa.ForeignKeyConstraint(
            ['SpecialityGroupId'],
            ['SpecialityGroup.SpecialityGroupId'],
        ),
        sa.PrimaryKeyConstraint('ProfileSer'),
        sa.UniqueConstraint('ProfileId'),
    )
    op.create_index(op.f('ix_Profile_SpecialityGroupId'), 'Profile', ['SpecialityGroupId'], unique=False)
    op.create_table(
        'SmsMessage',
        sa.Column('SmsMessageId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('SpecialityGroupId', mysql.INTEGER(display_width=11), nullable=True),
        sa.Column('Type', sa.String(length=50), nullable=False),
        sa.Column('Event', sa.String(length=50), nullable=False),
        sa.Column('Language', sa.Enum('English', 'French'), nullable=False),
        sa.Column('Message', sa.Text(), nullable=False),
        sa.Column(
            'LastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.ForeignKeyConstraint(
            ['SpecialityGroupId'],
            ['SpecialityGroup.SpecialityGroupId'],
        ),
        sa.PrimaryKeyConstraint('SmsMessageId'),
    )
    op.create_index(
        'SpecialityGroupId_Type_Event_Language',
        'SmsMessage',
        ['SpecialityGroupId', 'Type', 'Event', 'Language'],
        unique=True,
    )
    op.create_index(op.f('ix_SmsMessage_Type'), 'SmsMessage', ['Type'], unique=False)
    op.create_table(
        'ExamRoom',
        sa.Column('AriaVenueId', sa.String(length=250), nullable=False),
        sa.Column('ClinicHubId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('ScreenDisplayName', sa.String(length=100), nullable=False),
        sa.Column('VenueEN', sa.String(length=100), server_default=sa.text("''"), nullable=False),
        sa.Column('VenueFR', sa.String(length=100), server_default=sa.text("''"), nullable=False),
        sa.Column('ExamRoomSerNum', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('IntermediateVenueSerNum', mysql.INTEGER(display_width=11), nullable=True),
        sa.Column('PositionOrder', mysql.SMALLINT(display_width=6), nullable=True),
        sa.ForeignKeyConstraint(
            ['ClinicHubId'],
            ['ClinicHub.ClinicHubId'],
        ),
        sa.PrimaryKeyConstraint('ExamRoomSerNum'),
        sa.UniqueConstraint('AriaVenueId'),
    )
    op.create_index(op.f('ix_ExamRoom_ClinicHubId'), 'ExamRoom', ['ClinicHubId'], unique=False)
    op.create_table(
        'IntermediateVenue',
        sa.Column('IntermediateVenueSerNum', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('AriaVenueId', sa.String(length=250), nullable=False),
        sa.Column('ClinicHubId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('ScreenDisplayName', sa.String(length=100), nullable=False),
        sa.Column('VenueEN', sa.String(length=100), nullable=False),
        sa.Column('VenueFR', sa.String(length=100), nullable=False),
        sa.ForeignKeyConstraint(
            ['ClinicHubId'],
            ['ClinicHub.ClinicHubId'],
        ),
        sa.PrimaryKeyConstraint('IntermediateVenueSerNum'),
    )
    op.create_index(op.f('ix_IntermediateVenue_ClinicHubId'), 'IntermediateVenue', ['ClinicHubId'], unique=False)
    op.create_table(
        'MediVisitAppointmentList',
        sa.Column('PatientSerNum', mysql.INTEGER(display_width=10), nullable=False),
        sa.Column('ClinicResourcesSerNum', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('ScheduledDateTime', sa.DateTime(), nullable=False),
        sa.Column('ScheduledDate', sa.Date(), nullable=False),
        sa.Column('ScheduledTime', sa.Time(), nullable=False),
        sa.Column(
            'AppointmentReminderSent', mysql.TINYINT(display_width=1), server_default=sa.text('0'), nullable=False
        ),
        sa.Column('AppointmentCodeId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('AppointId', sa.String(length=100), nullable=False, comment='From Interface Engine'),
        sa.Column('AppointSys', sa.String(length=50), nullable=False),
        sa.Column('Status', sa.Enum('Open', 'Cancelled', 'Completed', 'Deleted'), nullable=False),
        sa.Column('MedivisitStatus', sa.Text(), nullable=True),
        sa.Column('CreationDate', sa.DateTime(), nullable=False),
        sa.Column('AppointmentSerNum', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column(
            'LastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('LastUpdatedUserIP', sa.String(length=200), nullable=True),
        sa.ForeignKeyConstraint(
            ['AppointmentCodeId'],
            ['AppointmentCode.AppointmentCodeId'],
        ),
        sa.ForeignKeyConstraint(
            ['ClinicResourcesSerNum'],
            ['ClinicResources.ClinicResourcesSerNum'],
        ),
        sa.ForeignKeyConstraint(
            ['PatientSerNum'],
            ['Patient.PatientSerNum'],
        ),
        sa.PrimaryKeyConstraint('AppointmentSerNum'),
        comment='Appointment list to be read in daily from Medivist schedule, as provided by Ngoc',
    )
    op.create_index('MedivisitAppointId', 'MediVisitAppointmentList', ['AppointId', 'AppointSys'], unique=True)
    op.create_index(
        op.f('ix_MediVisitAppointmentList_AppointSys'), 'MediVisitAppointmentList', ['AppointSys'], unique=False
    )
    op.create_index(
        op.f('ix_MediVisitAppointmentList_AppointmentCodeId'),
        'MediVisitAppointmentList',
        ['AppointmentCodeId'],
        unique=False,
    )
    op.create_index(
        op.f('ix_MediVisitAppointmentList_ClinicResourcesSerNum'),
        'MediVisitAppointmentList',
        ['ClinicResourcesSerNum'],
        unique=False,
    )
    op.create_index(
        op.f('ix_MediVisitAppointmentList_PatientSerNum'), 'MediVisitAppointmentList', ['PatientSerNum'], unique=False
    )
    op.create_index(
        op.f('ix_MediVisitAppointmentList_ScheduledDate'), 'MediVisitAppointmentList', ['ScheduledDate'], unique=False
    )
    op.create_index(
        op.f('ix_MediVisitAppointmentList_ScheduledDateTime'),
        'MediVisitAppointmentList',
        ['ScheduledDateTime'],
        unique=False,
    )
    op.create_index(op.f('ix_MediVisitAppointmentList_Status'), 'MediVisitAppointmentList', ['Status'], unique=False)
    op.create_table(
        'PatientDiagnosis',
        sa.Column('PatientDiagnosisId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('PatientSerNum', mysql.INTEGER(display_width=10), nullable=False),
        sa.Column('RecordedMrn', sa.String(length=50), nullable=False),
        sa.Column('DiagnosisSubcodeId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('Status', sa.Enum('Active', 'Deleted'), server_default=sa.text("'Active'"), nullable=False),
        sa.Column('DiagnosisDate', sa.DateTime(), server_default=sa.text('current_timestamp()'), nullable=False),
        sa.Column('CreatedDate', sa.DateTime(), server_default=sa.text('current_timestamp()'), nullable=False),
        sa.Column(
            'LastUpdated',
            sa.DateTime(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('UpdatedBy', sa.String(length=50), nullable=False),
        sa.ForeignKeyConstraint(
            ['DiagnosisSubcodeId'],
            ['DiagnosisSubcode.DiagnosisSubcodeId'],
        ),
        sa.ForeignKeyConstraint(
            ['PatientSerNum'],
            ['Patient.PatientSerNum'],
        ),
        sa.PrimaryKeyConstraint('PatientDiagnosisId'),
    )
    op.create_index(
        op.f('ix_PatientDiagnosis_DiagnosisSubcodeId'), 'PatientDiagnosis', ['DiagnosisSubcodeId'], unique=False
    )
    op.create_index(op.f('ix_PatientDiagnosis_PatientSerNum'), 'PatientDiagnosis', ['PatientSerNum'], unique=False)
    op.create_table(
        'SmsAppointment',
        sa.Column('SmsAppointmentId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('ClinicResourcesSerNum', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('AppointmentCodeId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('SpecialityGroupId', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('SourceSystem', sa.String(length=50), nullable=False),
        sa.Column('Type', sa.String(length=50), nullable=True),
        sa.Column('Active', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column(
            'LastUpdated',
            sa.DateTime(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.ForeignKeyConstraint(
            ['AppointmentCodeId'],
            ['AppointmentCode.AppointmentCodeId'],
        ),
        sa.ForeignKeyConstraint(
            ['ClinicResourcesSerNum'],
            ['ClinicResources.ClinicResourcesSerNum'],
        ),
        sa.ForeignKeyConstraint(
            ['SpecialityGroupId'],
            ['SpecialityGroup.SpecialityGroupId'],
        ),
        sa.ForeignKeyConstraint(
            ['Type'],
            ['SmsMessage.Type'],
        ),
        sa.PrimaryKeyConstraint('SmsAppointmentId'),
    )
    op.create_index(
        'ClinicResourcesSerNum', 'SmsAppointment', ['ClinicResourcesSerNum', 'AppointmentCodeId'], unique=True
    )
    op.create_index(op.f('ix_SmsAppointment_AppointmentCodeId'), 'SmsAppointment', ['AppointmentCodeId'], unique=False)
    op.create_index(op.f('ix_SmsAppointment_SpecialityGroupId'), 'SmsAppointment', ['SpecialityGroupId'], unique=False)
    op.create_index(op.f('ix_SmsAppointment_Type'), 'SmsAppointment', ['Type'], unique=False)
    # Enable System Versioning
    funcs_sql_content = ''
    funcs_file_path = REVISIONS_DIR.joinpath('OrmsDB_enable_system_versioning.sql')
    # Read in SQL content from handle
    with Path(funcs_file_path).open(encoding='ISO-8859-1') as file_handle:
        funcs_sql_content += file_handle.read()
        file_handle.close()
    op.execute(funcs_sql_content)
    op.execute('SET foreign_key_checks=1;')


def downgrade() -> None:
    """Delete tables and indexes."""
    # ### commands auto generated by Alembic - please adjust! ###
    op.execute('SET foreign_key_checks=0;')

    op.drop_index(op.f('ix_SmsAppointment_Type'), table_name='SmsAppointment')
    op.drop_index(op.f('ix_SmsAppointment_SpecialityGroupId'), table_name='SmsAppointment')
    op.drop_index(op.f('ix_SmsAppointment_AppointmentCodeId'), table_name='SmsAppointment')
    op.drop_index('ClinicResourcesSerNum', table_name='SmsAppointment')
    op.drop_table('SmsAppointment')
    op.drop_index(op.f('ix_PatientDiagnosis_PatientSerNum'), table_name='PatientDiagnosis')
    op.drop_index(op.f('ix_PatientDiagnosis_DiagnosisSubcodeId'), table_name='PatientDiagnosis')
    op.drop_table('PatientDiagnosis')
    op.drop_index(op.f('ix_MediVisitAppointmentList_Status'), table_name='MediVisitAppointmentList')
    op.drop_index(op.f('ix_MediVisitAppointmentList_ScheduledDateTime'), table_name='MediVisitAppointmentList')
    op.drop_index(op.f('ix_MediVisitAppointmentList_ScheduledDate'), table_name='MediVisitAppointmentList')
    op.drop_index(op.f('ix_MediVisitAppointmentList_PatientSerNum'), table_name='MediVisitAppointmentList')
    op.drop_index(op.f('ix_MediVisitAppointmentList_ClinicResourcesSerNum'), table_name='MediVisitAppointmentList')
    op.drop_index(op.f('ix_MediVisitAppointmentList_AppointmentCodeId'), table_name='MediVisitAppointmentList')
    op.drop_index(op.f('ix_MediVisitAppointmentList_AppointSys'), table_name='MediVisitAppointmentList')
    op.drop_index('MedivisitAppointId', table_name='MediVisitAppointmentList')
    op.drop_table('MediVisitAppointmentList')
    op.drop_index(op.f('ix_IntermediateVenue_ClinicHubId'), table_name='IntermediateVenue')
    op.drop_table('IntermediateVenue')
    op.drop_index(op.f('ix_ExamRoom_ClinicHubId'), table_name='ExamRoom')
    op.drop_table('ExamRoom')
    op.drop_index(op.f('ix_SmsMessage_Type'), table_name='SmsMessage')
    op.drop_index('SpecialityGroupId_Type_Event_Language', table_name='SmsMessage')
    op.drop_table('SmsMessage')
    op.drop_index(op.f('ix_Profile_SpecialityGroupId'), table_name='Profile')
    op.drop_table('Profile')
    op.drop_index(op.f('ix_DiagnosisSubcode_DiagnosisCodeId'), table_name='DiagnosisSubcode')
    op.drop_table('DiagnosisSubcode')
    op.drop_index(op.f('ix_ClinicResources_SpecialityGroupId'), table_name='ClinicResources')
    op.drop_index(op.f('ix_ClinicResources_ResourceName'), table_name='ClinicResources')
    op.drop_index(op.f('ix_ClinicResources_Active'), table_name='ClinicResources')
    op.drop_index('ClinicResources_SpecialityGroupId', table_name='ClinicResources')
    op.drop_table('ClinicResources')
    op.drop_index(op.f('ix_ClinicHub_SpecialityGroupId'), table_name='ClinicHub')
    op.drop_table('ClinicHub')
    op.drop_index(op.f('ix_AppointmentCode_SpecialityGroupId'), table_name='AppointmentCode')
    op.drop_index('AppointmentCode_SpecialityGroupId', table_name='AppointmentCode')
    op.drop_table('AppointmentCode')
    op.drop_index(op.f('ix_SpecialityGroup_HospitalId'), table_name='SpecialityGroup')
    op.drop_table('SpecialityGroup')
    op.drop_index(op.f('ix_PatientMeasurement_PatientSer'), table_name='PatientMeasurement')
    op.drop_table('PatientMeasurement')
    op.drop_index(op.f('ix_PatientInsuranceIdentifier_PatientId'), table_name='PatientInsuranceIdentifier')
    op.drop_index('InsuranceId_InsuranceNumber', table_name='PatientInsuranceIdentifier')
    op.drop_table('PatientInsuranceIdentifier')
    op.drop_index(op.f('ix_PatientHospitalIdentifier_PatientId'), table_name='PatientHospitalIdentifier')
    op.drop_index('HospitalId_MedicalRecordNumber', table_name='PatientHospitalIdentifier')
    op.drop_table('PatientHospitalIdentifier')
    op.drop_index(op.f('ix_DiagnosisCode_DiagnosisChapterId'), table_name='DiagnosisCode')
    op.drop_table('DiagnosisCode')
    op.drop_index(op.f('ix_TEMP_PatientQuestionnaireReview_PatientSer'), table_name='TEMP_PatientQuestionnaireReview')
    op.drop_table('TEMP_PatientQuestionnaireReview')
    op.drop_index(op.f('ix_ProfileOptions_ProfileSer'), table_name='ProfileOptions')
    op.drop_table('ProfileOptions')
    op.drop_index(op.f('ix_ProfileColumns_ProfileSer'), table_name='ProfileColumns')
    op.drop_table('ProfileColumns')
    op.drop_table('ProfileColumnDefinition')
    op.drop_index(op.f('ix_PatientLocationMH_AppointmentSerNum'), table_name='PatientLocationMH')
    op.drop_table('PatientLocationMH')
    op.drop_index(op.f('ix_PatientLocation_AppointmentSerNum'), table_name='PatientLocation')
    op.drop_table('PatientLocation')
    op.drop_table('Patient')
    op.drop_table('Insurance')
    op.drop_table('Hospital')
    op.drop_table('DiagnosisChapter')
    op.drop_table('Cron')
    op.execute('SET foreign_key_checks=1;')
