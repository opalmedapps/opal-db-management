"""
Add new column completedDate to answerQuestionnaire.

Revision ID: 06a9f2cd81f9
Revises: 1c313a46ee6b
Create Date: 2024-12-02 22:30:35.708514

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = '06a9f2cd81f9'
down_revision = '1c313a46ee6b'
branch_labels = None
depends_on = None


# Populate the completedDate with our best guess based on the lastUpdated value (which was previously used as the "Date Answered" in the app)
COMPLETED_DATE_MIGRATION_QUERY = """
    UPDATE answerQuestionnaire aq
    SET aq.completedDate = aq.lastUpdated
    WHERE aq.`status` = 2
    ;
"""

# Restore the previous lastUpdated values so they aren't modified by this migration
RESTORE_LAST_UPDATED = """
    UPDATE answerQuestionnaire aq
    SET aq.lastUpdated = aq.completedDate
    WHERE aq.`status` = 2
    ;
"""


def upgrade() -> None:
    """Add new column completedDate to answerQuestionnaire."""
    op.add_column('answerQuestionnaire', sa.Column('completedDate', sa.DateTime(), nullable=True))
    op.execute(COMPLETED_DATE_MIGRATION_QUERY)
    op.execute(RESTORE_LAST_UPDATED)


def downgrade() -> None:
    """Drop column completedDate from answerQuestionnaire."""
    op.drop_column('answerQuestionnaire', 'completedDate')
