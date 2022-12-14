"""OpalDB Bulk Data Insert

Revision ID: 301ac9ef1f94
Revises: 3f066422497c
Create Date: 2022-12-14 13:50:23.221757

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '301ac9ef1f94'
down_revision = '3f066422497c'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Bulk insert with raq SQL."""
    # Read in scripts from SQL file
    op.execute(
    """
    SET foreign_key_checks = 0;
    SET SQL_MODE='';
    SET GLOBAL sql_mode = '';




    SET foreign_key_checks = 1;
    SET SQL_MODE='ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
    SET GLOBAL sql_mode = 'ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
    """
    )

def downgrade() -> None:
    """Bulk delete with raw SQL."""
    op.execute(
    """
    SET foreign_key_checks = 0;
    SET SQL_MODE='';
    SET GLOBAL sql_mode = '';




    SET foreign_key_checks = 1;
    SET SQL_MODE='ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
    SET GLOBAL sql_mode = 'ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
    """
    )