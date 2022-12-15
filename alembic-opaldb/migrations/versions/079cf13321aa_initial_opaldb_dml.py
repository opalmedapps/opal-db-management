"""Initial OpalDB DML

Revision ID: 079cf13321aa
Revises: e97dfdd124a7
Create Date: 2022-12-15 11:02:23.190611

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '079cf13321aa'
down_revision = 'e97dfdd124a7'
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.execute(
    """
    SET foreign_key_checks = 0;
    SET SQL_MODE='';
    SET GLOBAL sql_mode = '';
    """)



    op.execute(
    """
    SET foreign_key_checks = 1;
    SET SQL_MODE='ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
    SET GLOBAL sql_mode = 'ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
    """)



def downgrade() -> None:
    op.execute(
    """
    SET foreign_key_checks = 0;
    SET SQL_MODE='';
    SET GLOBAL sql_mode = '';
    """)



    op.execute(
    """
    SET foreign_key_checks = 1;
    SET SQL_MODE='ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
    SET GLOBAL sql_mode = 'ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
    """)
