"""
Add new column completedDate to answerQuestionnaire.

Revision ID: 06a9f2cd81f9
Revises: 1c313a46ee6b
Create Date: 2024-12-02 22:30:35.708514

"""
from pathlib import Path

import sqlalchemy as sa
from alembic import op

from db_management.opaldb.custom_operations import ReplaceableObject
from db_management.utility import read_sql_as_str

# revision identifiers, used by Alembic.
revision = '06a9f2cd81f9'
down_revision = '1c313a46ee6b'
branch_labels = None
depends_on = None

# Find root and revision data paths for reading sql files
ROOT_DIR = Path(__file__).parents[1]
REVISIONS_DIR = ROOT_DIR / 'revision_data'

# Paths to stored procedure sql files
PATH_QUESTIONNAIRE_LIST_OLD = REVISIONS_DIR.joinpath('QuestionnaireDB_2023_05_23-d007634d1fdd_getQuestionnaireList.sql')
PATH_UPDATE_STATUS_OLD = REVISIONS_DIR.joinpath('QuestionnaireDB_2023_05_23-d007634d1fdd_updateAnswerQuestionnaireStatus.sql')
PATH_QUESTIONNAIRE_LIST_NEW = REVISIONS_DIR.joinpath('QuestionnaireDB_2024_12_02-06a9f2cd81f9_getQuestionnaireList.sql')
PATH_UPDATE_STATUS_NEW = REVISIONS_DIR.joinpath('QuestionnaireDB_2024_12_02-06a9f2cd81f9_updateAnswerQuestionnaireStatus.sql')

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
    """Add new column completedDate to answerQuestionnaire, and update affected stored procedures."""
    # Add column and initialize its contents
    op.add_column('answerQuestionnaire', sa.Column('completedDate', sa.DateTime(), nullable=True))
    op.execute(COMPLETED_DATE_MIGRATION_QUERY)
    op.execute(RESTORE_LAST_UPDATED)

    # Update procedure getQuestionnaireList
    get_questionnaire_list_old = ReplaceableObject('getQuestionnaireList', read_sql_as_str(PATH_QUESTIONNAIRE_LIST_OLD))
    get_questionnaire_list_new = ReplaceableObject('getQuestionnaireList', read_sql_as_str(PATH_QUESTIONNAIRE_LIST_NEW))
    op.drop_procedure(get_questionnaire_list_old)  # type: ignore[attr-defined]
    op.create_procedure(get_questionnaire_list_new)  # type: ignore[attr-defined]

    # Update procedure updateAnswerQuestionnaireStatus
    update_status_old = ReplaceableObject('updateAnswerQuestionnaireStatus', read_sql_as_str(PATH_UPDATE_STATUS_OLD))
    update_status_new = ReplaceableObject('updateAnswerQuestionnaireStatus', read_sql_as_str(PATH_UPDATE_STATUS_NEW))
    op.drop_procedure(update_status_old)  # type: ignore[attr-defined]
    op.create_procedure(update_status_new)  # type: ignore[attr-defined]


def downgrade() -> None:
    """Drop column completedDate from answerQuestionnaire, and revert stored procedure updates."""
    # Drop the new column
    op.drop_column('answerQuestionnaire', 'completedDate')

    # Revert procedure update for getQuestionnaireList
    get_questionnaire_list_old = ReplaceableObject('getQuestionnaireList', read_sql_as_str(PATH_QUESTIONNAIRE_LIST_OLD))
    get_questionnaire_list_new = ReplaceableObject('getQuestionnaireList', read_sql_as_str(PATH_QUESTIONNAIRE_LIST_NEW))
    op.drop_procedure(get_questionnaire_list_new)  # type: ignore[attr-defined]
    op.create_procedure(get_questionnaire_list_old)  # type: ignore[attr-defined]

    # Revert procedure update for updateAnswerQuestionnaireStatus
    update_status_old = ReplaceableObject('updateAnswerQuestionnaireStatus', read_sql_as_str(PATH_UPDATE_STATUS_OLD))
    update_status_new = ReplaceableObject('updateAnswerQuestionnaireStatus', read_sql_as_str(PATH_UPDATE_STATUS_NEW))
    op.drop_procedure(update_status_new)  # type: ignore[attr-defined]
    op.create_procedure(update_status_old)  # type: ignore[attr-defined]
