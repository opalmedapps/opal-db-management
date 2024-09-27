"""
Adds missing autoincrements to OpalDB.

Note that autoincrements are not supported by alembic revision autogenerate
due to the non-agnostic nature of MariaDB autoincrements... or something

https://github.com/sqlalchemy/alembic/issues/1224

Revision ID: 12ea7cde17ce
Revises: 759547f5ca7d
Create Date: 2023-07-18 16:04:02.348834

"""
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '12ea7cde17ce'
down_revision = 'eb93d22b78f1'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Add autoincrements to various MH tables."""
    op.create_index(op.f('ix_AliasExpressionMH_RevSerNum'), 'AliasExpressionMH', ['RevSerNum'], unique=False)
    op.alter_column(
        'AliasExpressionMH',
        'RevSerNum',
        existing_type=mysql.BIGINT(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(
        op.f('ix_AliasExpressionMH_legacy_RevSerNum'),
        'AliasExpressionMH_legacy',
        ['RevSerNum'],
        unique=False,
    )
    op.alter_column(
        'AliasExpressionMH_legacy',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_AliasMH_AliasRevSerNum'), 'AliasMH', ['AliasRevSerNum'], unique=False)
    op.alter_column(
        'AliasMH',
        'AliasRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )
    op.create_index(
        op.f('ix_AnnouncementMH_AnnouncementRevSerNum'),
        'AnnouncementMH',
        ['AnnouncementRevSerNum'],
        unique=False,
    )
    op.alter_column(
        'AnnouncementMH',
        'AnnouncementRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(
        op.f('ix_AppointmentMH_AppointmentRevSerNum'),
        'AppointmentMH',
        ['AppointmentRevSerNum'],
        unique=False,
    )
    op.alter_column(
        'AppointmentMH',
        'AppointmentRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_DiagnosisCodeMH_RevSerNum'), 'DiagnosisCodeMH', ['RevSerNum'], unique=False)
    op.alter_column(
        'DiagnosisCodeMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_DiagnosisCodeMH_legacy_RevSerNum'), 'DiagnosisCodeMH_legacy', ['RevSerNum'], unique=False)
    op.alter_column(
        'DiagnosisCodeMH_legacy',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_DiagnosisMH_RevisionSerNum'), 'DiagnosisMH', ['RevisionSerNum'], unique=False)
    op.alter_column(
        'DiagnosisMH',
        'RevisionSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_DiagnosisTranslationMH_RevSerNum'), 'DiagnosisTranslationMH', ['RevSerNum'], unique=False)
    op.alter_column(
        'DiagnosisTranslationMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_DoctorMH_DoctorRevSerNum'), 'DoctorMH', ['DoctorRevSerNum'], unique=False)
    op.alter_column(
        'DoctorMH',
        'DoctorRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_DocumentMH_DocumentRevSerNum'), 'DocumentMH', ['DocumentRevSerNum'], unique=False)
    op.alter_column(
        'DocumentMH',
        'DocumentRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(
        op.f('ix_EducationalMaterialMH_EducationalMaterialRevSerNum'),
        'EducationalMaterialMH',
        ['EducationalMaterialRevSerNum'],
        unique=False,
    )
    op.alter_column(
        'EducationalMaterialMH',
        'EducationalMaterialRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_EmailControlMH_RevSerNum'), 'EmailControlMH', ['RevSerNum'], unique=False)
    op.alter_column(
        'EmailControlMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_HospitalMapMH_RevSerNum'), 'HospitalMapMH', ['RevSerNum'], unique=False)
    op.alter_column(
        'HospitalMapMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_NotificationControlMH_RevSerNum'), 'NotificationControlMH', ['RevSerNum'], unique=False)
    op.alter_column(
        'NotificationControlMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(
        op.f('ix_NotificationMH_NotificationRevSerNum'),
        'NotificationMH',
        ['NotificationRevSerNum'],
        unique=False,
    )
    op.alter_column(
        'NotificationMH',
        'NotificationRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_PatientMH_PatientRevSerNum'), 'PatientMH', ['PatientRevSerNum'], unique=False)
    op.alter_column(
        'PatientMH',
        'PatientRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(
        op.f('ix_PatientsForPatientsMH_PatientsForPatientsRevSerNum'),
        'PatientsForPatientsMH',
        ['PatientsForPatientsRevSerNum'],
        unique=False,
    )
    op.alter_column(
        'PatientsForPatientsMH',
        'PatientsForPatientsRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(
        op.f('ix_PatientsForPatientsPersonnelMH_PatientsForPatientsPersonnelRevSerNum'),
        'PatientsForPatientsPersonnelMH',
        ['PatientsForPatientsPersonnelRevSerNum'],
        unique=False,
    )
    op.alter_column(
        'PatientsForPatientsPersonnelMH',
        'PatientsForPatientsPersonnelRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_PostControlMH_RevSerNum'), 'PostControlMH', ['RevSerNum'], unique=False)
    op.alter_column(
        'PostControlMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_QuestionnaireControlMH_RevSerNum'), 'QuestionnaireControlMH', ['RevSerNum'], unique=False)
    op.alter_column(
        'QuestionnaireControlMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(
        op.f('ix_QuestionnaireMH_QuestionnaireRevSerNum'),
        'QuestionnaireMH',
        ['QuestionnaireRevSerNum'],
        unique=False,
    )
    op.alter_column(
        'QuestionnaireMH',
        'QuestionnaireRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_TaskMH_TaskRevSerNum'), 'TaskMH', ['TaskRevSerNum'], unique=False)
    op.alter_column(
        'TaskMH',
        'TaskRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_TestResultControlMH_RevSerNum'), 'TestResultControlMH', ['RevSerNum'], unique=False)
    op.alter_column(
        'TestResultControlMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_TestResultExpressionMH_RevSerNum'), 'TestResultExpressionMH', ['RevSerNum'], unique=False)
    op.alter_column(
        'TestResultExpressionMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_TestResultMH_TestResultRevSerNum'), 'TestResultMH', ['TestResultRevSerNum'], unique=False)
    op.alter_column(
        'TestResultMH',
        'TestResultRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(
        op.f('ix_TxTeamMessageMH_TxTeamMessageRevSerNum'),
        'TxTeamMessageMH',
        ['TxTeamMessageRevSerNum'],
        unique=False,
    )
    op.alter_column(
        'TxTeamMessageMH',
        'TxTeamMessageRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_UsersMH_UserRevSerNum'), 'UsersMH', ['UserRevSerNum'], unique=False)
    op.alter_column(
        'UsersMH',
        'UserRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_alertMH_revisionId'), 'alertMH', ['revisionId'], unique=False)
    op.alter_column(
        'alertMH',
        'revisionId',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.alter_column(
        'patientStudyMH',
        'revisionId',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )

    op.create_index(op.f('ix_resourcePendingMH_revisionId'), 'resourcePendingMH', ['revisionId'], unique=False)
    op.alter_column(
        'resourcePendingMH',
        'revisionId',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )


def downgrade() -> None:
    """Remove autoincrements from various MH tables."""
    op.alter_column(
        'AliasExpressionMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_AliasExpressionMH_RevSerNum'), table_name='AliasExpressionMH')

    op.alter_column(
        'AliasExpressionMH_legacy',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_AliasExpressionMH_legacy_RevSerNum'), table_name='AliasExpressionMH_legacy')

    op.alter_column(
        'AliasMH',
        'AliasRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_AliasMH_AliasRevSerNum'), table_name='AliasMH')

    op.alter_column(
        'AnnouncementMH',
        'AnnouncementRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_AnnouncementMH_AnnouncementRevSerNum'), table_name='AnnouncementMH')

    op.alter_column(
        'AppointmentMH',
        'AppointmentRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_AppointmentMH_AppointmentRevSerNum'), table_name='AppointmentMH')

    op.alter_column(
        'DiagnosisCodeMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_DiagnosisCodeMH_RevSerNum'), table_name='DiagnosisCodeMH')

    op.alter_column(
        'DiagnosisCodeMH_legacy',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_DiagnosisCodeMH_legacy_RevSerNum'), table_name='DiagnosisCodeMH_legacy')

    op.alter_column(
        'DiagnosisMH',
        'RevisionSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_DiagnosisMH_RevisionSerNum'), table_name='DiagnosisMH')

    op.alter_column(
        'DiagnosisTranslationMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_DiagnosisTranslationMH_RevSerNum'), table_name='DiagnosisTranslationMH')

    op.alter_column(
        'DoctorMH',
        'DoctorRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_DoctorMH_DoctorRevSerNum'), table_name='DoctorMH')

    op.alter_column(
        'DocumentMH',
        'DocumentRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_DocumentMH_DocumentRevSerNum'), table_name='DocumentMH')

    op.alter_column(
        'EducationalMaterialMH',
        'EducationalMaterialRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_EducationalMaterialMH_EducationalMaterialRevSerNum'), table_name='EducationalMaterialMH')

    op.alter_column(
        'NotificationControlMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_NotificationControlMH_RevSerNum'), table_name='NotificationControlMH')

    op.alter_column(
        'EmailControlMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_EmailControlMH_RevSerNum'), table_name='EmailControlMH')

    op.alter_column(
        'HospitalMapMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_HospitalMapMH_RevSerNum'), table_name='HospitalMapMH')

    op.alter_column(
        'NotificationMH',
        'NotificationRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_NotificationMH_NotificationRevSerNum'), table_name='NotificationMH')

    op.alter_column(
        'PatientMH',
        'PatientRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_PatientMH_PatientRevSerNum'), table_name='PatientMH')

    op.alter_column(
        'PatientsForPatientsMH',
        'PatientsForPatientsRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_PatientsForPatientsMH_PatientsForPatientsRevSerNum'), table_name='PatientsForPatientsMH')

    op.alter_column(
        'PatientsForPatientsPersonnelMH',
        'PatientsForPatientsPersonnelRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(
        op.f('ix_PatientsForPatientsPersonnelMH_PatientsForPatientsPersonnelRevSerNum'),
        table_name='PatientsForPatientsPersonnelMH',
    )

    op.alter_column(
        'PostControlMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_PostControlMH_RevSerNum'), table_name='PostControlMH')

    op.alter_column(
        'QuestionnaireControlMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_QuestionnaireControlMH_RevSerNum'), table_name='QuestionnaireControlMH')

    op.alter_column(
        'QuestionnaireMH',
        'QuestionnaireRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_QuestionnaireMH_QuestionnaireRevSerNum'), table_name='QuestionnaireMH')

    op.alter_column(
        'TaskMH',
        'TaskRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_TaskMH_TaskRevSerNum'), table_name='TaskMH')

    op.alter_column(
        'TestResultControlMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_TestResultControlMH_RevSerNum'), table_name='TestResultControlMH')

    op.alter_column(
        'TestResultExpressionMH',
        'RevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_TestResultExpressionMH_RevSerNum'), table_name='TestResultExpressionMH')

    op.alter_column(
        'TestResultMH',
        'TestResultRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_TestResultMH_TestResultRevSerNum'), table_name='TestResultMH')

    op.alter_column(
        'TxTeamMessageMH',
        'TxTeamMessageRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_TxTeamMessageMH_TxTeamMessageRevSerNum'), table_name='TxTeamMessageMH')

    op.alter_column(
        'UsersMH',
        'UserRevSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_UsersMH_UserRevSerNum'), table_name='UsersMH')

    op.alter_column(
        'alertMH',
        'revisionId',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_alertMH_revisionId'), table_name='alertMH')

    op.alter_column(
        'patientStudyMH',
        'revisionId',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )

    op.alter_column(
        'resourcePendingMH',
        'revisionId',
        existing_type=mysql.INTEGER(display_width=11),
        existing_nullable=False,
        autoincrement=False,
    )
    op.drop_index(op.f('ix_resourcePendingMH_revisionId'), table_name='resourcePendingMH')
