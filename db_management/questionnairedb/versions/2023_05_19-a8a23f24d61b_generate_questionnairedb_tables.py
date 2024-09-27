"""
Generate QuestionnaireDB tables.

Revision ID: a8a23f24d61b
Revises:
Create Date: 2023-05-19 13:30:08.943534

"""

from pathlib import Path

import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'a8a23f24d61b'
down_revision = None
branch_labels = None
depends_on = None

# Find root and revision data paths for reading sql files
ROOT_DIR = Path(__file__).parents[1]
REVISIONS_DIR = ROOT_DIR / 'revision_data'


def upgrade() -> None:
    """Generate tables."""
    op.execute("""SET foreign_key_checks=0;""")
    op.create_table(
        'definitionTable',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('name', sa.String(length=255), nullable=False),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_table(
        'dictionary',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('tableId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('languageId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('contentId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('content', mysql.MEDIUMTEXT(), nullable=False),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=True),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.ForeignKeyConstraint(
            ['languageId'],
            ['language.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['tableId'],
            ['definitionTable.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_dictionary_contentId'), 'dictionary', ['contentId'], unique=False)
    op.create_index(op.f('ix_dictionary_deleted'), 'dictionary', ['deleted'], unique=False)
    op.create_index(op.f('ix_dictionary_languageId'), 'dictionary', ['languageId'], unique=False)
    op.create_index(op.f('ix_dictionary_tableId'), 'dictionary', ['tableId'], unique=False)
    op.create_table(
        'language',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('isoLang', sa.String(length=2), nullable=False),
        sa.Column('name', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=False),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.ForeignKeyConstraint(
            ['name'],
            ['dictionary.contentId'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_language_deleted'), 'language', ['deleted'], unique=False)
    op.create_index(op.f('ix_language_name'), 'language', ['name'], unique=False)
    op.create_table(
        'patient',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('hospitalId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('externalId', sa.String(length=64), nullable=False),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=False),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_patient_deleted'), 'patient', ['deleted'], unique=False)
    op.create_index(op.f('ix_patient_externalId'), 'patient', ['externalId'], unique=False)
    op.create_index(op.f('ix_patient_hospitalId'), 'patient', ['hospitalId'], unique=False)
    op.create_table(
        'library',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('OAUserId', mysql.BIGINT(display_width=20), server_default=sa.text('-1'), nullable=False),
        sa.Column('name', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('order', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.Column('private', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=False),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.ForeignKeyConstraint(
            ['name'],
            ['dictionary.contentId'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_library_OAUserId'), 'library', ['OAUserId'], unique=False)
    op.create_index(op.f('ix_library_deleted'), 'library', ['deleted'], unique=False)
    op.create_index(op.f('ix_library_name'), 'library', ['name'], unique=False)
    op.create_table(
        'purpose',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('title', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('description', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['description'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['title'],
            ['dictionary.contentId'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_purpose_description'), 'purpose', ['description'], unique=False)
    op.create_index(op.f('ix_purpose_title'), 'purpose', ['title'], unique=False)
    op.create_table(
        'respondent',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('title', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('description', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['description'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['title'],
            ['dictionary.contentId'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_respondent_description'), 'respondent', ['description'], unique=False)
    op.create_index(op.f('ix_respondent_title'), 'respondent', ['title'], unique=False)
    op.create_table(
        'tag',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('tag', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=False),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.ForeignKeyConstraint(
            ['tag'],
            ['dictionary.contentId'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_tag_deleted'), 'tag', ['deleted'], unique=False)
    op.create_index(op.f('ix_tag_tag'), 'tag', ['tag'], unique=False)
    op.create_table(
        'type',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('description', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('tableId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('subTableId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('templateTableId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('templateSubTableId', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['description'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['subTableId'],
            ['definitionTable.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['tableId'],
            ['definitionTable.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['templateSubTableId'],
            ['definitionTable.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['templateTableId'],
            ['definitionTable.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_type_description'), 'type', ['description'], unique=False)
    op.create_index(op.f('ix_type_subTableId'), 'type', ['subTableId'], unique=False)
    op.create_index(op.f('ix_type_tableId'), 'type', ['tableId'], unique=False)
    op.create_index(op.f('ix_type_templateSubTableId'), 'type', ['templateSubTableId'], unique=False)
    op.create_index(op.f('ix_type_templateTableId'), 'type', ['templateTableId'], unique=False)
    op.create_table(
        'legacyType',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('legacyName', sa.String(length=255), nullable=False),
        sa.Column('legacyTableName', sa.String(length=255), nullable=False),
        sa.Column('typeId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('default', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.ForeignKeyConstraint(
            ['typeId'],
            ['type.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
        comment='This table is a direct replication from the legacy table QuestionType in questionnaireDB. It is required for the time of the migration. When the migration will be over and the triggers will stop, this table needs to be deleted.',
    )
    op.create_index(op.f('ix_legacyType_typeId'), 'legacyType', ['typeId'], unique=False)
    op.create_table(
        'questionnaire',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('OAUserId', mysql.BIGINT(display_width=20), server_default=sa.text('-1'), nullable=False),
        sa.Column('purposeId', mysql.BIGINT(display_width=20), server_default=sa.text('1'), nullable=False),
        sa.Column('respondentId', mysql.BIGINT(display_width=20), server_default=sa.text('1'), nullable=False),
        sa.Column('title', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('nickname', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('category', mysql.INTEGER(display_width=11), server_default=sa.text('-1'), nullable=False),
        sa.Column('description', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('instruction', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('final', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('version', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.Column('parentId', mysql.BIGINT(display_width=20), server_default=sa.text('-1'), nullable=False),
        sa.Column('private', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('optionalFeedback', mysql.TINYINT(display_width=4), server_default=sa.text('1'), nullable=False),
        sa.Column(
            'visualization',
            mysql.TINYINT(display_width=4),
            server_default=sa.text('0'),
            nullable=False,
            comment='0 = regular view of the answers, 1 = graph',
        ),
        sa.Column('logo', sa.String(length=512), nullable=False),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=False),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.Column(
            'legacyName',
            sa.String(length=255),
            nullable=False,
            comment='This field is mandatory to make the app works during the migration process. This field must be removed once the migration of the legacy questionnaire will be done, the triggers stopped and the app changed to use the correct standards.',
        ),
        sa.ForeignKeyConstraint(
            ['description'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['instruction'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['nickname'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['purposeId'],
            ['purpose.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['respondentId'],
            ['respondent.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['title'],
            ['dictionary.contentId'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_questionnaire_OAUserId'), 'questionnaire', ['OAUserId'], unique=False)
    op.create_index(op.f('ix_questionnaire_deleted'), 'questionnaire', ['deleted'], unique=False)
    op.create_index(op.f('ix_questionnaire_description'), 'questionnaire', ['description'], unique=False)
    op.create_index(op.f('ix_questionnaire_instruction'), 'questionnaire', ['instruction'], unique=False)
    op.create_index(op.f('ix_questionnaire_nickname'), 'questionnaire', ['nickname'], unique=False)
    op.create_index(op.f('ix_questionnaire_parentId'), 'questionnaire', ['parentId'], unique=False)
    op.create_index(op.f('ix_questionnaire_purposeId'), 'questionnaire', ['purposeId'], unique=False)
    op.create_index(op.f('ix_questionnaire_respondentId'), 'questionnaire', ['respondentId'], unique=False)
    op.create_index(op.f('ix_questionnaire_title'), 'questionnaire', ['title'], unique=False)
    op.create_table(
        'tagLibrary',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('tagId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('libraryId', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['libraryId'],
            ['library.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['tagId'],
            ['tag.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_tagLibrary_libraryId'), 'tagLibrary', ['libraryId'], unique=False)
    op.create_index(op.f('ix_tagLibrary_tagId'), 'tagLibrary', ['tagId'], unique=False)
    op.create_table(
        'templateQuestion',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('OAUserId', mysql.BIGINT(display_width=20), server_default=sa.text('-1'), nullable=False),
        sa.Column('name', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('typeId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('version', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('parentId', mysql.BIGINT(display_width=20), server_default=sa.text('-1'), nullable=False),
        sa.Column('polarity', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('private', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=False),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.ForeignKeyConstraint(
            ['name'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['typeId'],
            ['type.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_templateQuestion_OAUserId'), 'templateQuestion', ['OAUserId'], unique=False)
    op.create_index(op.f('ix_templateQuestion_deleted'), 'templateQuestion', ['deleted'], unique=False)
    op.create_index(op.f('ix_templateQuestion_name'), 'templateQuestion', ['name'], unique=False)
    op.create_index(op.f('ix_templateQuestion_parentId'), 'templateQuestion', ['parentId'], unique=False)
    op.create_index(op.f('ix_templateQuestion_typeId'), 'templateQuestion', ['typeId'], unique=False)
    op.create_table(
        'answerQuestionnaire',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionnaireId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('patientId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column(
            'status',
            mysql.INTEGER(display_width=11),
            server_default=sa.text('0'),
            nullable=False,
            comment='0 = New, 1 = In Progress, 2 = Completed',
        ),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=False),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.ForeignKeyConstraint(
            ['patientId'],
            ['patient.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['questionnaireId'],
            ['questionnaire.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_answerQuestionnaire_deleted'), 'answerQuestionnaire', ['deleted'], unique=False)
    op.create_index(op.f('ix_answerQuestionnaire_patientId'), 'answerQuestionnaire', ['patientId'], unique=False)
    op.create_index(
        op.f('ix_answerQuestionnaire_questionnaireId'), 'answerQuestionnaire', ['questionnaireId'], unique=False
    )
    op.create_table(
        'question',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('OAUserId', mysql.BIGINT(display_width=20), server_default=sa.text('-1'), nullable=False),
        sa.Column('display', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('definition', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('question', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('typeId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('version', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.Column('parentId', mysql.BIGINT(display_width=20), server_default=sa.text('-1'), nullable=False),
        sa.Column(
            'polarity',
            mysql.TINYINT(display_width=4),
            server_default=sa.text('0'),
            nullable=False,
            comment='0 = lowGood (the lower the score, the better the answer), 1 = highGood (the higher the score, the better the answer)',
        ),
        sa.Column('private', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('final', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('optionalFeedback', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=False),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.Column(
            'legacyTypeId',
            mysql.BIGINT(display_width=20),
            nullable=False,
            comment='This ID linked to the legacyTypes table must be removed once the migration of the legacy questionnaire will be done and the triggers stopped.',
        ),
        sa.ForeignKeyConstraint(
            ['definition'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['display'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['legacyTypeId'],
            ['legacyType.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['question'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['typeId'],
            ['type.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_question_OAUserId'), 'question', ['OAUserId'], unique=False)
    op.create_index(op.f('ix_question_definition'), 'question', ['definition'], unique=False)
    op.create_index(op.f('ix_question_deleted'), 'question', ['deleted'], unique=False)
    op.create_index(op.f('ix_question_display'), 'question', ['display'], unique=False)
    op.create_index(op.f('ix_question_legacyTypeId'), 'question', ['legacyTypeId'], unique=False)
    op.create_index(op.f('ix_question_parentId'), 'question', ['parentId'], unique=False)
    op.create_index(op.f('ix_question_question'), 'question', ['question'], unique=False)
    op.create_index(op.f('ix_question_typeId'), 'question', ['typeId'], unique=False)
    op.create_table(
        'questionnaireFeedback',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionnaireId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('languageId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('patientId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('feedback', sa.Text(), nullable=False),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=False),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.ForeignKeyConstraint(
            ['languageId'],
            ['language.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['patientId'],
            ['patient.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['questionnaireId'],
            ['questionnaire.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_questionnaireFeedback_deleted'), 'questionnaireFeedback', ['deleted'], unique=False)
    op.create_index(op.f('ix_questionnaireFeedback_languageId'), 'questionnaireFeedback', ['languageId'], unique=False)
    op.create_index(op.f('ix_questionnaireFeedback_patientId'), 'questionnaireFeedback', ['patientId'], unique=False)
    op.create_index(
        op.f('ix_questionnaireFeedback_questionnaireId'), 'questionnaireFeedback', ['questionnaireId'], unique=False
    )
    op.create_table(
        'questionnaireRating',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionnaireId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('languageId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('patientId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('rating', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.Column('comment', sa.Text(), nullable=False),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=False),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.ForeignKeyConstraint(
            ['languageId'],
            ['language.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['patientId'],
            ['patient.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['questionnaireId'],
            ['questionnaire.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_questionnaireRating_deleted'), 'questionnaireRating', ['deleted'], unique=False)
    op.create_index(op.f('ix_questionnaireRating_languageId'), 'questionnaireRating', ['languageId'], unique=False)
    op.create_index(op.f('ix_questionnaireRating_patientId'), 'questionnaireRating', ['patientId'], unique=False)
    op.create_index(
        op.f('ix_questionnaireRating_questionnaireId'), 'questionnaireRating', ['questionnaireId'], unique=False
    )
    op.create_table(
        'section',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionnaireId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('title', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('instruction', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('order', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=False),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.ForeignKeyConstraint(
            ['instruction'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['questionnaireId'],
            ['questionnaire.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['title'],
            ['dictionary.contentId'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_section_deleted'), 'section', ['deleted'], unique=False)
    op.create_index(op.f('ix_section_instruction'), 'section', ['instruction'], unique=False)
    op.create_index(op.f('ix_section_questionnaireId'), 'section', ['questionnaireId'], unique=False)
    op.create_index(op.f('ix_section_title'), 'section', ['title'], unique=False)
    op.create_table(
        'templateQuestionCheckbox',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('templateQuestionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('minAnswer', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.Column('maxAnswer', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.ForeignKeyConstraint(
            ['templateQuestionId'],
            ['templateQuestion.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(
        op.f('ix_templateQuestionCheckbox_templateQuestionId'),
        'templateQuestionCheckbox',
        ['templateQuestionId'],
        unique=False,
    )
    op.create_table(
        'templateQuestionDate',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('templateQuestionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['templateQuestionId'],
            ['templateQuestion.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(
        op.f('ix_templateQuestionDate_templateQuestionId'), 'templateQuestionDate', ['templateQuestionId'], unique=False
    )
    op.create_table(
        'templateQuestionLabel',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('templateQuestionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('displayIntensity', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.Column('pathImage', sa.String(length=512), nullable=False),
        sa.ForeignKeyConstraint(
            ['templateQuestionId'],
            ['templateQuestion.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(
        op.f('ix_templateQuestionLabel_templateQuestionId'),
        'templateQuestionLabel',
        ['templateQuestionId'],
        unique=False,
    )
    op.create_table(
        'templateQuestionRadioButton',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('templateQuestionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['templateQuestionId'],
            ['templateQuestion.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(
        op.f('ix_templateQuestionRadioButton_templateQuestionId'),
        'templateQuestionRadioButton',
        ['templateQuestionId'],
        unique=False,
    )
    op.create_table(
        'templateQuestionSlider',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('templateQuestionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('minValue', sa.Float(), nullable=False),
        sa.Column('maxValue', sa.Float(), nullable=False),
        sa.Column('minCaption', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('maxCaption', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('increment', sa.Float(), nullable=False),
        sa.ForeignKeyConstraint(
            ['maxCaption'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['minCaption'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['templateQuestionId'],
            ['templateQuestion.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(
        op.f('ix_templateQuestionSlider_maxCaption'), 'templateQuestionSlider', ['maxCaption'], unique=False
    )
    op.create_index(
        op.f('ix_templateQuestionSlider_minCaption'), 'templateQuestionSlider', ['minCaption'], unique=False
    )
    op.create_index(
        op.f('ix_templateQuestionSlider_templateQuestionId'),
        'templateQuestionSlider',
        ['templateQuestionId'],
        unique=False,
    )
    op.create_table(
        'templateQuestionTextBox',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('templateQuestionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['templateQuestionId'],
            ['templateQuestion.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(
        op.f('ix_templateQuestionTextBox_templateQuestionId'),
        'templateQuestionTextBox',
        ['templateQuestionId'],
        unique=False,
    )
    op.create_table(
        'templateQuestionTime',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('templateQuestionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['templateQuestionId'],
            ['templateQuestion.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(
        op.f('ix_templateQuestionTime_templateQuestionId'), 'templateQuestionTime', ['templateQuestionId'], unique=False
    )
    op.create_table(
        'answerSection',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('answerQuestionnaireId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('sectionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['answerQuestionnaireId'],
            ['answerQuestionnaire.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['sectionId'],
            ['section.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(
        op.f('ix_answerSection_answerQuestionnaireId'), 'answerSection', ['answerQuestionnaireId'], unique=False
    )
    op.create_index(op.f('ix_answerSection_sectionId'), 'answerSection', ['sectionId'], unique=False)
    op.create_table(
        'checkbox',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('minAnswer', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.Column('maxAnswer', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.ForeignKeyConstraint(
            ['questionId'],
            ['question.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_checkbox_questionId'), 'checkbox', ['questionId'], unique=False)
    op.create_table(
        'date',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['questionId'],
            ['question.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_date_questionId'), 'date', ['questionId'], unique=False)
    op.create_table(
        'label',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column(
            'displayIntensity',
            mysql.TINYINT(display_width=4),
            server_default=sa.text('0'),
            nullable=False,
            comment='0 = patient cannot select intensity, 1 = patient can select intensity',
        ),
        sa.Column('pathImage', sa.String(length=512), nullable=False),
        sa.ForeignKeyConstraint(
            ['questionId'],
            ['question.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_label_questionId'), 'label', ['questionId'], unique=False)
    op.create_table(
        'libraryQuestion',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('libraryId', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['libraryId'],
            ['library.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['questionId'],
            ['question.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_libraryQuestion_libraryId'), 'libraryQuestion', ['libraryId'], unique=False)
    op.create_index(op.f('ix_libraryQuestion_questionId'), 'libraryQuestion', ['questionId'], unique=False)
    op.create_table(
        'questionFeedback',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('languageId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('patientId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('feedback', sa.Text(), nullable=False),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=False),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.ForeignKeyConstraint(
            ['languageId'],
            ['language.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['patientId'],
            ['patient.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['questionId'],
            ['question.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_questionFeedback_deleted'), 'questionFeedback', ['deleted'], unique=False)
    op.create_index(op.f('ix_questionFeedback_languageId'), 'questionFeedback', ['languageId'], unique=False)
    op.create_index(op.f('ix_questionFeedback_patientId'), 'questionFeedback', ['patientId'], unique=False)
    op.create_index(op.f('ix_questionFeedback_questionId'), 'questionFeedback', ['questionId'], unique=False)
    op.create_table(
        'questionRating',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('languageId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('patientId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('rating', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.Column('comment', sa.Text(), nullable=False),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=False),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.ForeignKeyConstraint(
            ['languageId'],
            ['language.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['patientId'],
            ['patient.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['questionId'],
            ['question.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_questionRating_languageId'), 'questionRating', ['languageId'], unique=False)
    op.create_index(op.f('ix_questionRating_patientId'), 'questionRating', ['patientId'], unique=False)
    op.create_index(op.f('ix_questionRating_questionId'), 'questionRating', ['questionId'], unique=False)
    op.create_table(
        'questionSection',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('sectionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('order', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.Column(
            'orientation',
            mysql.INTEGER(display_width=11),
            server_default=sa.text('0'),
            nullable=False,
            comment='0 = Portrait, 1 = Landscape, 2 = Both',
        ),
        sa.Column(
            'optional',
            mysql.TINYINT(display_width=4),
            server_default=sa.text('0'),
            nullable=False,
            comment='0 = false, 1 = true',
        ),
        sa.ForeignKeyConstraint(
            ['questionId'],
            ['question.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['sectionId'],
            ['section.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_questionSection_questionId'), 'questionSection', ['questionId'], unique=False)
    op.create_index(op.f('ix_questionSection_sectionId'), 'questionSection', ['sectionId'], unique=False)
    op.create_table(
        'radioButton',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['questionId'],
            ['question.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_radioButton_questionId'), 'radioButton', ['questionId'], unique=False)
    op.create_table(
        'slider',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('minValue', sa.Float(), nullable=False),
        sa.Column('maxValue', sa.Float(), nullable=False),
        sa.Column('minCaption', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('maxCaption', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('increment', sa.Float(), nullable=False),
        sa.ForeignKeyConstraint(
            ['maxCaption'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['minCaption'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['questionId'],
            ['question.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_slider_maxCaption'), 'slider', ['maxCaption'], unique=False)
    op.create_index(op.f('ix_slider_minCaption'), 'slider', ['minCaption'], unique=False)
    op.create_index(op.f('ix_slider_questionId'), 'slider', ['questionId'], unique=False)
    op.create_table(
        'tagQuestion',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('tagId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['questionId'],
            ['question.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['tagId'],
            ['tag.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_tagQuestion_questionId'), 'tagQuestion', ['questionId'], unique=False)
    op.create_index(op.f('ix_tagQuestion_tagId'), 'tagQuestion', ['tagId'], unique=False)
    op.create_table(
        'templateQuestionCheckboxOption',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('parentTableId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('description', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('order', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.Column(
            'specialAction',
            mysql.INTEGER(display_width=11),
            nullable=False,
            comment='0 = nothing special, 1 = check everything, 2 = uncheck everything',
        ),
        sa.ForeignKeyConstraint(
            ['description'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['parentTableId'],
            ['templateQuestionCheckbox.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(
        op.f('ix_templateQuestionCheckboxOption_description'),
        'templateQuestionCheckboxOption',
        ['description'],
        unique=False,
    )
    op.create_index(
        op.f('ix_templateQuestionCheckboxOption_parentTableId'),
        'templateQuestionCheckboxOption',
        ['parentTableId'],
        unique=False,
    )
    op.create_table(
        'templateQuestionLabelOption',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('parentTableId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('description', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('posInitX', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.Column('posInitY', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.Column('posFinalX', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.Column('posFinalY', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.Column('intensity', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.Column('order', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.ForeignKeyConstraint(
            ['description'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['parentTableId'],
            ['templateQuestionLabel.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(
        op.f('ix_templateQuestionLabelOption_description'), 'templateQuestionLabelOption', ['description'], unique=False
    )
    op.create_index(
        op.f('ix_templateQuestionLabelOption_parentTableId'),
        'templateQuestionLabelOption',
        ['parentTableId'],
        unique=False,
    )
    op.create_table(
        'templateQuestionRadioButtonOption',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('parentTableId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('description', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('order', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.ForeignKeyConstraint(
            ['description'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['parentTableId'],
            ['templateQuestionRadioButton.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(
        op.f('ix_templateQuestionRadioButtonOption_description'),
        'templateQuestionRadioButtonOption',
        ['description'],
        unique=False,
    )
    op.create_index(
        op.f('ix_templateQuestionRadioButtonOption_parentTableId'),
        'templateQuestionRadioButtonOption',
        ['parentTableId'],
        unique=False,
    )
    op.create_table(
        'templateQuestionTextBoxTrigger',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('parentTableId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('description', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('order', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.ForeignKeyConstraint(
            ['description'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['parentTableId'],
            ['templateQuestionTextBox.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(
        op.f('ix_templateQuestionTextBoxTrigger_description'),
        'templateQuestionTextBoxTrigger',
        ['description'],
        unique=False,
    )
    op.create_index(
        op.f('ix_templateQuestionTextBoxTrigger_parentTableId'),
        'templateQuestionTextBoxTrigger',
        ['parentTableId'],
        unique=False,
    )
    op.create_table(
        'textBox',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['questionId'],
            ['question.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_textBox_questionId'), 'textBox', ['questionId'], unique=False)
    op.create_table(
        'time',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['questionId'],
            ['question.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_time_questionId'), 'time', ['questionId'], unique=False)
    op.create_table(
        'answer',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionnaireId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('sectionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('questionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('typeId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('answerSectionId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('languageId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('patientId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('answered', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('skipped', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deleted', mysql.TINYINT(display_width=4), server_default=sa.text('0'), nullable=False),
        sa.Column('deletedBy', sa.String(length=255), nullable=False),
        sa.Column('creationDate', sa.DateTime(), nullable=False),
        sa.Column('createdBy', sa.String(length=255), nullable=False),
        sa.Column(
            'lastUpdated',
            sa.TIMESTAMP(),
            server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
            nullable=False,
        ),
        sa.Column('updatedBy', sa.String(length=255), nullable=False),
        sa.ForeignKeyConstraint(
            ['answerSectionId'],
            ['answerSection.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['languageId'],
            ['language.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['patientId'],
            ['patient.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['questionId'],
            ['question.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['questionnaireId'],
            ['questionnaire.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['sectionId'],
            ['section.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['typeId'],
            ['type.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_answer_answerSectionId'), 'answer', ['answerSectionId'], unique=False)
    op.create_index(op.f('ix_answer_deleted'), 'answer', ['deleted'], unique=False)
    op.create_index(op.f('ix_answer_languageId'), 'answer', ['languageId'], unique=False)
    op.create_index(op.f('ix_answer_patientId'), 'answer', ['patientId'], unique=False)
    op.create_index(op.f('ix_answer_questionId'), 'answer', ['questionId'], unique=False)
    op.create_index(op.f('ix_answer_questionnaireId'), 'answer', ['questionnaireId'], unique=False)
    op.create_index(op.f('ix_answer_sectionId'), 'answer', ['sectionId'], unique=False)
    op.create_index(op.f('ix_answer_typeId'), 'answer', ['typeId'], unique=False)
    op.create_table(
        'checkboxOption',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('parentTableId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('order', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.Column('description', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column(
            'specialAction',
            mysql.INTEGER(display_width=11),
            server_default=sa.text('0'),
            nullable=False,
            comment='0 = nothing special, 1 = check everything, 2 = uncheck everything',
        ),
        sa.ForeignKeyConstraint(
            ['description'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['parentTableId'],
            ['checkbox.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_checkboxOption_description'), 'checkboxOption', ['description'], unique=False)
    op.create_index(op.f('ix_checkboxOption_parentTableId'), 'checkboxOption', ['parentTableId'], unique=False)
    op.create_table(
        'labelOption',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('parentTableId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('description', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('posInitX', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.Column('posInitY', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.Column('posFinalX', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.Column('posFinalY', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.Column('intensity', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False),
        sa.Column('order', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.ForeignKeyConstraint(
            ['description'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['parentTableId'],
            ['label.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_labelOption_description'), 'labelOption', ['description'], unique=False)
    op.create_index(op.f('ix_labelOption_parentTableId'), 'labelOption', ['parentTableId'], unique=False)
    op.create_table(
        'radioButtonOption',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('parentTableId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('description', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('order', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.ForeignKeyConstraint(
            ['description'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['parentTableId'],
            ['radioButton.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_radioButtonOption_description'), 'radioButtonOption', ['description'], unique=False)
    op.create_index(op.f('ix_radioButtonOption_parentTableId'), 'radioButtonOption', ['parentTableId'], unique=False)
    op.create_table(
        'textBoxTrigger',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('parentTableId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('description', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('order', mysql.INTEGER(display_width=11), server_default=sa.text('1'), nullable=False),
        sa.ForeignKeyConstraint(
            ['description'],
            ['dictionary.contentId'],
        ),
        sa.ForeignKeyConstraint(
            ['parentTableId'],
            ['textBox.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_textBoxTrigger_description'), 'textBoxTrigger', ['description'], unique=False)
    op.create_index(op.f('ix_textBoxTrigger_parentTableId'), 'textBoxTrigger', ['parentTableId'], unique=False)
    op.create_table(
        'answerCheckbox',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('answerId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('value', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['answerId'],
            ['answer.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['value'],
            ['checkboxOption.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_answerCheckbox_answerId'), 'answerCheckbox', ['answerId'], unique=False)
    op.create_index(op.f('ix_answerCheckbox_value'), 'answerCheckbox', ['value'], unique=False)
    op.create_table(
        'answerDate',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('answerId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('value', sa.DateTime(), nullable=False),
        sa.ForeignKeyConstraint(
            ['answerId'],
            ['answer.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_answerDate_answerId'), 'answerDate', ['answerId'], unique=False)
    op.create_table(
        'answerLabel',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('answerId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('selected', mysql.TINYINT(display_width=4), server_default=sa.text('1'), nullable=False),
        sa.Column('posX', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('posY', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('intensity', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('value', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['answerId'],
            ['answer.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['value'],
            ['labelOption.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_answerLabel_answerId'), 'answerLabel', ['answerId'], unique=False)
    op.create_index(op.f('ix_answerLabel_value'), 'answerLabel', ['value'], unique=False)
    op.create_table(
        'answerRadioButton',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('answerId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('value', mysql.BIGINT(display_width=20), nullable=False),
        sa.ForeignKeyConstraint(
            ['answerId'],
            ['answer.ID'],
        ),
        sa.ForeignKeyConstraint(
            ['value'],
            ['radioButtonOption.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_answerRadioButton_answerId'), 'answerRadioButton', ['answerId'], unique=False)
    op.create_index(op.f('ix_answerRadioButton_value'), 'answerRadioButton', ['value'], unique=False)
    op.create_table(
        'answerSlider',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('answerId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('value', sa.Float(), nullable=False),
        sa.ForeignKeyConstraint(
            ['answerId'],
            ['answer.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_answerSlider_answerId'), 'answerSlider', ['answerId'], unique=False)
    op.create_table(
        'answerTextBox',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('answerId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('value', sa.Text(), nullable=False),
        sa.ForeignKeyConstraint(
            ['answerId'],
            ['answer.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_answerTextBox_answerId'), 'answerTextBox', ['answerId'], unique=False)
    op.create_table(
        'answerTime',
        sa.Column('ID', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('answerId', mysql.BIGINT(display_width=20), nullable=False),
        sa.Column('value', sa.DateTime(), nullable=False),
        sa.ForeignKeyConstraint(
            ['answerId'],
            ['answer.ID'],
        ),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_answerTime_answerId'), 'answerTime', ['answerId'], unique=False)

    # Insert views, functions, events, procedures
    funcs_sql_content = ''
    funcs_file_path = REVISIONS_DIR.joinpath('QuestionnaireDB_views_functions_events_procs.sql')
    # Read in SQL content from handle
    with Path(funcs_file_path, encoding='ISO-8859-1').open(encoding='ISO-8859-1') as file_handle:
        funcs_sql_content += file_handle.read()
        file_handle.close()
    op.execute(funcs_sql_content)
    op.execute("""SET foreign_key_checks=1;""")
    # ### end Alembic commands ###


def downgrade() -> None:
    """Return to the empty database state."""
    op.execute("""SET foreign_key_checks=0;""")
    op.drop_index(op.f('ix_answerTime_answerId'), table_name='answerTime')
    op.drop_table('answerTime')
    op.drop_index(op.f('ix_answerTextBox_answerId'), table_name='answerTextBox')
    op.drop_table('answerTextBox')
    op.drop_index(op.f('ix_answerSlider_answerId'), table_name='answerSlider')
    op.drop_table('answerSlider')
    op.drop_index(op.f('ix_answerRadioButton_value'), table_name='answerRadioButton')
    op.drop_index(op.f('ix_answerRadioButton_answerId'), table_name='answerRadioButton')
    op.drop_table('answerRadioButton')
    op.drop_index(op.f('ix_answerLabel_value'), table_name='answerLabel')
    op.drop_index(op.f('ix_answerLabel_answerId'), table_name='answerLabel')
    op.drop_table('answerLabel')
    op.drop_index(op.f('ix_answerDate_answerId'), table_name='answerDate')
    op.drop_table('answerDate')
    op.drop_index(op.f('ix_answerCheckbox_value'), table_name='answerCheckbox')
    op.drop_index(op.f('ix_answerCheckbox_answerId'), table_name='answerCheckbox')
    op.drop_table('answerCheckbox')
    op.drop_index(op.f('ix_textBoxTrigger_parentTableId'), table_name='textBoxTrigger')
    op.drop_index(op.f('ix_textBoxTrigger_description'), table_name='textBoxTrigger')
    op.drop_table('textBoxTrigger')
    op.drop_index(op.f('ix_radioButtonOption_parentTableId'), table_name='radioButtonOption')
    op.drop_index(op.f('ix_radioButtonOption_description'), table_name='radioButtonOption')
    op.drop_table('radioButtonOption')
    op.drop_index(op.f('ix_labelOption_parentTableId'), table_name='labelOption')
    op.drop_index(op.f('ix_labelOption_description'), table_name='labelOption')
    op.drop_table('labelOption')
    op.drop_index(op.f('ix_checkboxOption_parentTableId'), table_name='checkboxOption')
    op.drop_index(op.f('ix_checkboxOption_description'), table_name='checkboxOption')
    op.drop_table('checkboxOption')
    op.drop_index(op.f('ix_answer_typeId'), table_name='answer')
    op.drop_index(op.f('ix_answer_sectionId'), table_name='answer')
    op.drop_index(op.f('ix_answer_questionnaireId'), table_name='answer')
    op.drop_index(op.f('ix_answer_questionId'), table_name='answer')
    op.drop_index(op.f('ix_answer_patientId'), table_name='answer')
    op.drop_index(op.f('ix_answer_languageId'), table_name='answer')
    op.drop_index(op.f('ix_answer_deleted'), table_name='answer')
    op.drop_index(op.f('ix_answer_answerSectionId'), table_name='answer')
    op.drop_table('answer')
    op.drop_index(op.f('ix_time_questionId'), table_name='time')
    op.drop_table('time')
    op.drop_index(op.f('ix_textBox_questionId'), table_name='textBox')
    op.drop_table('textBox')
    op.drop_index(op.f('ix_templateQuestionTextBoxTrigger_parentTableId'), table_name='templateQuestionTextBoxTrigger')
    op.drop_index(op.f('ix_templateQuestionTextBoxTrigger_description'), table_name='templateQuestionTextBoxTrigger')
    op.drop_table('templateQuestionTextBoxTrigger')
    op.drop_index(
        op.f('ix_templateQuestionRadioButtonOption_parentTableId'), table_name='templateQuestionRadioButtonOption'
    )
    op.drop_index(
        op.f('ix_templateQuestionRadioButtonOption_description'), table_name='templateQuestionRadioButtonOption'
    )
    op.drop_table('templateQuestionRadioButtonOption')
    op.drop_index(op.f('ix_templateQuestionLabelOption_parentTableId'), table_name='templateQuestionLabelOption')
    op.drop_index(op.f('ix_templateQuestionLabelOption_description'), table_name='templateQuestionLabelOption')
    op.drop_table('templateQuestionLabelOption')
    op.drop_index(op.f('ix_templateQuestionCheckboxOption_parentTableId'), table_name='templateQuestionCheckboxOption')
    op.drop_index(op.f('ix_templateQuestionCheckboxOption_description'), table_name='templateQuestionCheckboxOption')
    op.drop_table('templateQuestionCheckboxOption')
    op.drop_index(op.f('ix_tagQuestion_tagId'), table_name='tagQuestion')
    op.drop_index(op.f('ix_tagQuestion_questionId'), table_name='tagQuestion')
    op.drop_table('tagQuestion')
    op.drop_index(op.f('ix_slider_questionId'), table_name='slider')
    op.drop_index(op.f('ix_slider_minCaption'), table_name='slider')
    op.drop_index(op.f('ix_slider_maxCaption'), table_name='slider')
    op.drop_table('slider')
    op.drop_index(op.f('ix_radioButton_questionId'), table_name='radioButton')
    op.drop_table('radioButton')
    op.drop_index(op.f('ix_questionSection_sectionId'), table_name='questionSection')
    op.drop_index(op.f('ix_questionSection_questionId'), table_name='questionSection')
    op.drop_table('questionSection')
    op.drop_index(op.f('ix_questionRating_questionId'), table_name='questionRating')
    op.drop_index(op.f('ix_questionRating_patientId'), table_name='questionRating')
    op.drop_index(op.f('ix_questionRating_languageId'), table_name='questionRating')
    op.drop_table('questionRating')
    op.drop_index(op.f('ix_questionFeedback_questionId'), table_name='questionFeedback')
    op.drop_index(op.f('ix_questionFeedback_patientId'), table_name='questionFeedback')
    op.drop_index(op.f('ix_questionFeedback_languageId'), table_name='questionFeedback')
    op.drop_index(op.f('ix_questionFeedback_deleted'), table_name='questionFeedback')
    op.drop_table('questionFeedback')
    op.drop_index(op.f('ix_libraryQuestion_questionId'), table_name='libraryQuestion')
    op.drop_index(op.f('ix_libraryQuestion_libraryId'), table_name='libraryQuestion')
    op.drop_table('libraryQuestion')
    op.drop_index(op.f('ix_label_questionId'), table_name='label')
    op.drop_table('label')
    op.drop_index(op.f('ix_date_questionId'), table_name='date')
    op.drop_table('date')
    op.drop_index(op.f('ix_checkbox_questionId'), table_name='checkbox')
    op.drop_table('checkbox')
    op.drop_index(op.f('ix_answerSection_sectionId'), table_name='answerSection')
    op.drop_index(op.f('ix_answerSection_answerQuestionnaireId'), table_name='answerSection')
    op.drop_table('answerSection')
    op.drop_index(op.f('ix_templateQuestionTime_templateQuestionId'), table_name='templateQuestionTime')
    op.drop_table('templateQuestionTime')
    op.drop_index(op.f('ix_templateQuestionTextBox_templateQuestionId'), table_name='templateQuestionTextBox')
    op.drop_table('templateQuestionTextBox')
    op.drop_index(op.f('ix_templateQuestionSlider_templateQuestionId'), table_name='templateQuestionSlider')
    op.drop_index(op.f('ix_templateQuestionSlider_minCaption'), table_name='templateQuestionSlider')
    op.drop_index(op.f('ix_templateQuestionSlider_maxCaption'), table_name='templateQuestionSlider')
    op.drop_table('templateQuestionSlider')
    op.drop_index(op.f('ix_templateQuestionRadioButton_templateQuestionId'), table_name='templateQuestionRadioButton')
    op.drop_table('templateQuestionRadioButton')
    op.drop_index(op.f('ix_templateQuestionLabel_templateQuestionId'), table_name='templateQuestionLabel')
    op.drop_table('templateQuestionLabel')
    op.drop_index(op.f('ix_templateQuestionDate_templateQuestionId'), table_name='templateQuestionDate')
    op.drop_table('templateQuestionDate')
    op.drop_index(op.f('ix_templateQuestionCheckbox_templateQuestionId'), table_name='templateQuestionCheckbox')
    op.drop_table('templateQuestionCheckbox')
    op.drop_index(op.f('ix_section_title'), table_name='section')
    op.drop_index(op.f('ix_section_questionnaireId'), table_name='section')
    op.drop_index(op.f('ix_section_instruction'), table_name='section')
    op.drop_index(op.f('ix_section_deleted'), table_name='section')
    op.drop_table('section')
    op.drop_index(op.f('ix_questionnaireRating_questionnaireId'), table_name='questionnaireRating')
    op.drop_index(op.f('ix_questionnaireRating_patientId'), table_name='questionnaireRating')
    op.drop_index(op.f('ix_questionnaireRating_languageId'), table_name='questionnaireRating')
    op.drop_index(op.f('ix_questionnaireRating_deleted'), table_name='questionnaireRating')
    op.drop_table('questionnaireRating')
    op.drop_index(op.f('ix_questionnaireFeedback_questionnaireId'), table_name='questionnaireFeedback')
    op.drop_index(op.f('ix_questionnaireFeedback_patientId'), table_name='questionnaireFeedback')
    op.drop_index(op.f('ix_questionnaireFeedback_languageId'), table_name='questionnaireFeedback')
    op.drop_index(op.f('ix_questionnaireFeedback_deleted'), table_name='questionnaireFeedback')
    op.drop_table('questionnaireFeedback')
    op.drop_index(op.f('ix_question_typeId'), table_name='question')
    op.drop_index(op.f('ix_question_question'), table_name='question')
    op.drop_index(op.f('ix_question_parentId'), table_name='question')
    op.drop_index(op.f('ix_question_legacyTypeId'), table_name='question')
    op.drop_index(op.f('ix_question_display'), table_name='question')
    op.drop_index(op.f('ix_question_deleted'), table_name='question')
    op.drop_index(op.f('ix_question_definition'), table_name='question')
    op.drop_index(op.f('ix_question_OAUserId'), table_name='question')
    op.drop_table('question')
    op.drop_index(op.f('ix_answerQuestionnaire_questionnaireId'), table_name='answerQuestionnaire')
    op.drop_index(op.f('ix_answerQuestionnaire_patientId'), table_name='answerQuestionnaire')
    op.drop_index(op.f('ix_answerQuestionnaire_deleted'), table_name='answerQuestionnaire')
    op.drop_table('answerQuestionnaire')
    op.drop_index(op.f('ix_templateQuestion_typeId'), table_name='templateQuestion')
    op.drop_index(op.f('ix_templateQuestion_parentId'), table_name='templateQuestion')
    op.drop_index(op.f('ix_templateQuestion_name'), table_name='templateQuestion')
    op.drop_index(op.f('ix_templateQuestion_deleted'), table_name='templateQuestion')
    op.drop_index(op.f('ix_templateQuestion_OAUserId'), table_name='templateQuestion')
    op.drop_table('templateQuestion')
    op.drop_index(op.f('ix_tagLibrary_tagId'), table_name='tagLibrary')
    op.drop_index(op.f('ix_tagLibrary_libraryId'), table_name='tagLibrary')
    op.drop_table('tagLibrary')
    op.drop_index(op.f('ix_questionnaire_title'), table_name='questionnaire')
    op.drop_index(op.f('ix_questionnaire_respondentId'), table_name='questionnaire')
    op.drop_index(op.f('ix_questionnaire_purposeId'), table_name='questionnaire')
    op.drop_index(op.f('ix_questionnaire_parentId'), table_name='questionnaire')
    op.drop_index(op.f('ix_questionnaire_nickname'), table_name='questionnaire')
    op.drop_index(op.f('ix_questionnaire_instruction'), table_name='questionnaire')
    op.drop_index(op.f('ix_questionnaire_description'), table_name='questionnaire')
    op.drop_index(op.f('ix_questionnaire_deleted'), table_name='questionnaire')
    op.drop_index(op.f('ix_questionnaire_OAUserId'), table_name='questionnaire')
    op.drop_table('questionnaire')
    op.drop_index(op.f('ix_legacyType_typeId'), table_name='legacyType')
    op.drop_table('legacyType')
    op.drop_index(op.f('ix_type_templateTableId'), table_name='type')
    op.drop_index(op.f('ix_type_templateSubTableId'), table_name='type')
    op.drop_index(op.f('ix_type_tableId'), table_name='type')
    op.drop_index(op.f('ix_type_subTableId'), table_name='type')
    op.drop_index(op.f('ix_type_description'), table_name='type')
    op.drop_table('type')
    op.drop_index(op.f('ix_tag_tag'), table_name='tag')
    op.drop_index(op.f('ix_tag_deleted'), table_name='tag')
    op.drop_table('tag')
    op.drop_index(op.f('ix_respondent_title'), table_name='respondent')
    op.drop_index(op.f('ix_respondent_description'), table_name='respondent')
    op.drop_table('respondent')
    op.drop_index(op.f('ix_purpose_title'), table_name='purpose')
    op.drop_index(op.f('ix_purpose_description'), table_name='purpose')
    op.drop_table('purpose')
    op.drop_index(op.f('ix_library_name'), table_name='library')
    op.drop_index(op.f('ix_library_deleted'), table_name='library')
    op.drop_index(op.f('ix_library_OAUserId'), table_name='library')
    op.drop_table('library')
    op.drop_index(op.f('ix_patient_hospitalId'), table_name='patient')
    op.drop_index(op.f('ix_patient_externalId'), table_name='patient')
    op.drop_index(op.f('ix_patient_deleted'), table_name='patient')
    op.drop_table('patient')
    op.drop_index(op.f('ix_language_name'), table_name='language')
    op.drop_index(op.f('ix_language_deleted'), table_name='language')
    op.drop_table('language')
    op.drop_index(op.f('ix_dictionary_tableId'), table_name='dictionary')
    op.drop_index(op.f('ix_dictionary_languageId'), table_name='dictionary')
    op.drop_index(op.f('ix_dictionary_deleted'), table_name='dictionary')
    op.drop_index(op.f('ix_dictionary_contentId'), table_name='dictionary')
    op.drop_table('dictionary')
    op.drop_table('definitionTable')

    op.execute("""
        DROP FUNCTION IF EXISTS `getAnswerTableOptionID`;
        DROP FUNCTION IF EXISTS `getDisplayName`;
        DROP PROCEDURE IF EXISTS `getAnswerByAnswerQuestionnaireIdAndQuestionSectionId`;
        DROP PROCEDURE IF EXISTS `getCompletedQuestionnaireInfo`;
        DROP PROCEDURE IF EXISTS `getLastAnsweredQuestionnaire`;
        DROP PROCEDURE IF EXISTS `getLastCompletedQuestionnaireByPatientId`;
        DROP PROCEDURE IF EXISTS `getQuestionnaireInfo`;
        DROP PROCEDURE IF EXISTS `getQuestionnaireList`;
        DROP PROCEDURE IF EXISTS `getQuestionnaireListORMS`;
        DROP PROCEDURE IF EXISTS `getQuestionNameAndAnswer`;
        DROP PROCEDURE IF EXISTS `getQuestionNameAndAnswerByID`;
        DROP PROCEDURE IF EXISTS `getQuestionOptions`;
        DROP PROCEDURE IF EXISTS `queryAnswers`;
        DROP PROCEDURE IF EXISTS `queryPatientQuestionnaireInfo`;
        DROP PROCEDURE IF EXISTS `queryQuestionChoices`;
        DROP PROCEDURE IF EXISTS `queryQuestionChoicesORMS`;
        DROP PROCEDURE IF EXISTS `queryQuestions`;
        DROP PROCEDURE IF EXISTS `saveAnswer`;
        DROP PROCEDURE IF EXISTS `updateAnswerQuestionnaireStatus`;
        DROP EVENT IF EXISTS `SyncPublishQuestionnaire`;
        """)
    op.execute("""SET foreign_key_checks=1;""")
