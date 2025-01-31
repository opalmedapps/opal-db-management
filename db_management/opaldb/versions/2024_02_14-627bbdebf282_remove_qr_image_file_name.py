"""remove_QR_Image_File_Name

Revision ID: 627bbdebf282
Revises: 281079041645
Create Date: 2024-02-14 19:17:15.817308

"""
import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '627bbdebf282'
down_revision = '281079041645'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Remove column QRImageFileName and data from HospitalMap to fix the insert query for HospitalMap"""
    op.drop_column('HospitalMap', 'QRImageFileName')
    op.drop_column('HospitalMapMH', 'QRImageFileName')


def downgrade() -> None:
    """Remove QRImageFileName proprieties from HospitalMap"""
    op.add_column('HospitalMapMH', sa.Column('QRImageFileName', mysql.VARCHAR(length=255), nullable=False))
    op.add_column('HospitalMap', sa.Column('QRImageFileName', mysql.VARCHAR(length=255), nullable=False))
