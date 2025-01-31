"""add_missing_defaults

Revision ID: bcf300b3df7b
Revises: 9f32d05833a5
Create Date: 2023-05-15 20:35:17.462142

"""
import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'bcf300b3df7b'
down_revision = '9f32d05833a5'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Alter existing columns in Questionnaire, QuestionnaireControl, and TxTeamMessages to have proper defaults."""
    op.alter_column(
        'PatientTestResult',
        'ReadStatus',
        existing_type=mysql.INTEGER(display_width=11),
        server_default=sa.text('0'),
        existing_comment='Deprecated',
        existing_nullable=False,
    )
    op.alter_column(
        'Questionnaire',
        'DateAdded',
        existing_type=mysql.DATETIME(),
        server_default=sa.text('current_timestamp()'),
        existing_nullable=False,
    )
    op.alter_column(
        'Questionnaire',
        'CompletedFlag',
        existing_type=mysql.TINYINT(display_width=4),
        server_default=sa.text('0'),
        existing_nullable=False,
    )
    op.alter_column(
        'Questionnaire',
        'SessionId',
        existing_type=mysql.TEXT(),
        server_default=sa.text("'[]'"),
        existing_nullable=False,
    )
    op.alter_column(
        'QuestionnaireControl',
        'PublishFlag',
        existing_type=mysql.TINYINT(display_width=4),
        server_default=sa.text('0'),
        existing_nullable=False,
    )
    op.alter_column(
        'QuestionnaireControl',
        'LastPublished',
        existing_type=mysql.DATETIME(),
        nullable=True,
    )
    op.alter_column(
        'TxTeamMessage',
        'ReadStatus',
        existing_type=mysql.INTEGER(display_width=11),
        server_default=sa.text('0'),
        existing_comment='Deprecated',
        existing_nullable=False,
    )


def downgrade() -> None:
    """Revert the above changes."""
    op.alter_column(
        'TxTeamMessage',
        'ReadStatus',
        existing_type=mysql.INTEGER(display_width=11),
        server_default=None,
        existing_comment='Deprecated',
        existing_nullable=False,
    )
    op.alter_column(
        'QuestionnaireControl',
        'LastPublished',
        existing_type=mysql.DATETIME(),
        nullable=False,
    )
    op.alter_column(
        'QuestionnaireControl',
        'PublishFlag',
        existing_type=mysql.TINYINT(display_width=4),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'Questionnaire',
        'SessionId',
        existing_type=mysql.TEXT(),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'Questionnaire',
        'CompletedFlag',
        existing_type=mysql.TINYINT(display_width=4),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'Questionnaire',
        'DateAdded',
        existing_type=mysql.DATETIME(),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'PatientTestResult',
        'ReadStatus',
        existing_type=mysql.INTEGER(display_width=11),
        server_default=None,
        existing_comment='Deprecated',
        existing_nullable=False,
    )
