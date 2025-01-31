"""general_update_procedures_and_tables

Revision ID: d007634d1fdd
Revises: a8a23f24d61b
Create Date: 2023-05-23 18:36:01.996021

"""
import os
from pathlib import Path

import sqlalchemy as sa
from sqlalchemy.dialects import mysql

from alembic import op

# revision identifiers, used by Alembic.
revision = 'd007634d1fdd'
down_revision = 'a8a23f24d61b'
branch_labels = None
depends_on = None

# Find root and revision data paths for reading sql files
ROOT_DIR = Path(__file__).parents[1]
REVISIONS_DIR = ROOT_DIR / 'revision_data'


def upgrade() -> None:
    """Table and procedure updates covering QuestionnaireDB DBV revisions 3-9"""
    op.execute('SET foreign_key_checks=0;')
    op.alter_column(
        'answer',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    op.add_column(
        'answerQuestionnaire',
        sa.Column(
            'respondentUsername',
            sa.String(length=255),
            server_default=sa.text("''"),
            nullable=False,
            comment='Firebase username of the user who answered (or is answering) the questionnaire',
        ),
    )
    op.add_column(
        'answerQuestionnaire',
        sa.Column(
            'respondentDisplayName',
            sa.String(length=255),
            server_default=sa.text("''"),
            nullable=False,
            comment='First name and last name of the respondent for display purposes.',
        ),
    )
    op.alter_column(
        'language',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    op.alter_column(
        'library',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    op.alter_column(
        'question',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    op.alter_column(
        'questionFeedback',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    op.alter_column(
        'questionRating',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    op.alter_column(
        'questionnaire',
        'logo',
        existing_type=mysql.VARCHAR(length=512),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    op.alter_column(
        'questionnaire',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    op.alter_column(
        'questionnaire',
        'legacyName',
        existing_type=mysql.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_nullable=False,
        comment="""This field is mandatory to make the app works during the migration process.
        This field must be removed once the migration of the legacy questionnaire will be done,
        the triggers stopped and the app changed to use the correct standards.""",
    )
    op.alter_column(
        'questionnaireFeedback',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    op.alter_column(
        'questionnaireRating',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    op.alter_column(
        'section',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    op.alter_column(
        'tag',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    op.alter_column(
        'templateQuestion',
        'version',
        existing_type=mysql.INTEGER(display_width=11),
        server_default=sa.text('0'),
        existing_nullable=False,
    )
    op.alter_column(
        'templateQuestion',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    # Latest procedure updates
    funcs_sql_content = ''
    funcs_file_path = os.path.join(REVISIONS_DIR, 'QuestionnaireDB_update_procedures.sql')
    # Read in SQL content from handle
    with Path(funcs_file_path, encoding='ISO-8859-1').open(encoding='ISO-8859-1') as file_handle:
        funcs_sql_content += file_handle.read()
        file_handle.close()
    op.execute(funcs_sql_content)
    op.execute('SET foreign_key_checks=1;')


def downgrade() -> None:
    """Revert to a8a initial state."""
    op.execute('SET foreign_key_checks=0;')
    op.alter_column(
        'templateQuestion',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'templateQuestion',
        'version',
        existing_type=mysql.INTEGER(display_width=11),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'tag',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'section',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'questionnaireRating',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'questionnaireFeedback',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'questionnaire',
        'legacyName',
        existing_type=mysql.VARCHAR(length=255),
        server_default=None,
        existing_nullable=False,
        comment="""This field is mandatory to make the app works during the migration process.
        This field must be removed once the migration of the legacy questionnaire will be done,
        the triggers stopped and the app changed to use the correct standards.""",
    )
    op.alter_column(
        'questionnaire',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'questionnaire',
        'logo',
        existing_type=mysql.VARCHAR(length=512),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'questionRating',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'questionFeedback',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'question',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'library',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'language',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=None,
        existing_nullable=False,
    )
    op.drop_column('answerQuestionnaire', 'respondentDisplayName')
    op.drop_column('answerQuestionnaire', 'respondentUsername')
    op.alter_column(
        'answer',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=255),
        server_default=None,
        existing_nullable=False,
    )
    # Revert to old procedures, functions, etc
    op.execute('DROP PROCEDURE IF EXISTS `getCompletedQuestionnairesList`;')
    funcs_sql_content = ''
    funcs_file_path = os.path.join(REVISIONS_DIR, 'QuestionnaireDB_views_functions_events_procs.sql')
    # Read in SQL content from handle
    with Path(funcs_file_path, encoding='ISO-8859-1').open(encoding='ISO-8859-1') as file_handle:
        funcs_sql_content += file_handle.read()
        file_handle.close()
    op.execute(funcs_sql_content)
    op.execute('SET foreign_key_checks=1;')
