"""set_default_value_for_deleteby

Revision ID: 224fa0bbfd7c
Revises: 2cbae06775ef
Create Date: 2024-01-11 10:39:27.381090

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = '224fa0bbfd7c'
down_revision = '2cbae06775ef'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Set default value empty string for deletedBy, createdBy, updatedBy"""
    op.alter_column(
        'alert',
        'createdBy',
        existing_type=sa.VARCHAR(length=128),
        server_default=sa.text("''"),
        existing_comment='Username of the person who created the record',
        existing_nullable=False,
    )
    op.alter_column(
        'alert',
        'updatedBy',
        existing_type=sa.VARCHAR(length=128),
        server_default=sa.text("''"),
        existing_comment='Username of the person who updated the record',
        existing_nullable=False,
    )
    op.alter_column(
        'alertMH',
        'deletedBy',
        existing_type=sa.VARCHAR(length=128),
        server_default=sa.text("''"),
        existing_comment='Username of the person who deleted the record',
        existing_nullable=False,
    )
    op.alter_column(
        'alertMH',
        'createdBy',
        existing_type=sa.VARCHAR(length=128),
        server_default=sa.text("''"),
        existing_comment='Username of the person who created the record',
        existing_nullable=False,
    )
    op.alter_column(
        'alertMH',
        'updatedBy',
        existing_type=sa.VARCHAR(length=128),
        server_default=sa.text("''"),
        existing_comment='Username of the person who updated the record',
        existing_nullable=False,
    )
    op.alter_column(
        'masterSourceAlias',
        'createdBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_comment='username of who created the record',
        existing_nullable=False,
    )
    op.alter_column(
        'masterSourceAlias',
        'updatedBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_comment='username of who updated the record',
        existing_nullable=False,
    )
    op.alter_column(
        'masterSourceDiagnosis',
        'deletedBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_comment='username of who marked the record to be deleted',
        existing_nullable=False,
    )
    op.alter_column(
        'masterSourceDiagnosis',
        'createdBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_comment='username of who created the record',
        existing_nullable=False,
    )
    op.alter_column(
        'masterSourceDiagnosis',
        'updatedBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_comment='username of who updated the record',
        existing_nullable=False,
    )
    op.alter_column(
        'oaRole',
        'deletedBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_comment='username of who marked the record to be deleted',
        existing_nullable=False,
    )
    op.alter_column(
        'oaRole',
        'createdBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_comment='username of who created the record',
        existing_nullable=False,
    )
    op.alter_column(
        'oaRole',
        'updatedBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=sa.text("''"),
        existing_comment='username of who updated the record',
        existing_nullable=False,
    )


def downgrade() -> None:
    """Remove default value from deletedBy, createdBy, updatedBy"""
    op.alter_column(
        'oaRole',
        'updatedBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=None,
        existing_comment='username of who updated the record',
        existing_nullable=False,
    )
    op.alter_column(
        'oaRole',
        'createdBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=None,
        existing_comment='username of who created the record',
        existing_nullable=False,
    )
    op.alter_column(
        'oaRole',
        'deletedBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=None,
        existing_comment='username of who marked the record to be deleted',
        existing_nullable=False,
    )
    op.alter_column(
        'masterSourceDiagnosis',
        'updatedBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=None,
        existing_comment='username of who updated the record',
        existing_nullable=False,
    )
    op.alter_column(
        'masterSourceDiagnosis',
        'createdBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=None,
        existing_comment='username of who created the record',
        existing_nullable=False,
    )
    op.alter_column(
        'masterSourceDiagnosis',
        'deletedBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=None,
        existing_comment='username of who marked the record to be deleted',
        existing_nullable=False,
    )
    op.alter_column(
        'masterSourceAlias',
        'updatedBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=None,
        existing_comment='username of who updated the record',
        existing_nullable=False,
    )
    op.alter_column(
        'masterSourceAlias',
        'createdBy',
        existing_type=sa.VARCHAR(length=255),
        server_default=None,
        existing_comment='username of who created the record',
        existing_nullable=False,
    )
    op.alter_column(
        'alertMH',
        'updatedBy',
        existing_type=sa.VARCHAR(length=128),
        server_default=None,
        existing_comment='Username of the person who updated the record',
        existing_nullable=False,
    )
    op.alter_column(
        'alertMH',
        'createdBy',
        existing_type=sa.VARCHAR(length=128),
        server_default=None,
        existing_comment='Username of the person who created the record',
        existing_nullable=False,
    )
    op.alter_column(
        'alertMH',
        'deletedBy',
        existing_type=sa.VARCHAR(length=128),
        server_default=None,
        existing_comment='Username of the person who deleted the record',
        existing_nullable=False,
    )
    op.alter_column(
        'alert',
        'updatedBy',
        existing_type=sa.VARCHAR(length=128),
        server_default=None,
        existing_comment='Username of the person who updated the record',
        existing_nullable=False,
    )
    op.alter_column(
        'alert',
        'createdBy',
        existing_type=sa.VARCHAR(length=128),
        server_default=None,
        existing_comment='Username of the person who created the record',
        existing_nullable=False,
    )
