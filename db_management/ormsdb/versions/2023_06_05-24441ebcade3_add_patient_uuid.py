"""Add UUID to Patient table

Revision ID: 24441ebcade3
Revises: da79ad032892
Create Date: 2023-06-05 15:15:55.694347

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = '24441ebcade3'
down_revision = 'da79ad032892'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Add UUID to Patient table to faciliate Backend API calls."""
    # Altering schema with system versioning requires changing the error mode
    # https://mariadb.com/docs/server/ref/mdb/system-variables/system_versioning_alter_history/
    op.execute('SET @@system_versioning_alter_history = 1;')
    op.add_column(
        'Patient',
        sa.Column(
            'OpalUUID',
            sa.String(length=37, collation='latin1_swedish_ci'),
            server_default=sa.text("''"),
            nullable=False,
            comment='UUID provided only for Opal patients, and received from Opal',
        ),
    )
    op.execute('SET @@system_versioning_alter_history = 0;')


def downgrade() -> None:
    """Drop UUID"""
    op.execute('SET @@system_versioning_alter_history = 1;')
    op.drop_column('Patient', 'OpalUUID')
    op.execute('SET @@system_versioning_alter_history = 0;')
