# SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""
Leave comments indicating intent to rename instances of educational material to reference material.

Revision ID: 799788987ccd
Revises: 07fe49bfe5dd
Create Date: 2024-05-02 17:49:16.045240

"""

import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '799788987ccd'
down_revision = '07fe49bfe5dd'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Create comments."""
    op.alter_column(
        'Alias',
        'EducationalMaterialControlSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
        existing_nullable=True,
    )
    op.alter_column(
        'AliasMH',
        'EducationalMaterialControlSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
        existing_nullable=True,
    )
    op.alter_column(
        'DiagnosisTranslation',
        'EducationalMaterialControlSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
        existing_nullable=True,
    )
    op.alter_column(
        'DiagnosisTranslationMH',
        'EducationalMaterialControlSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
        existing_nullable=True,
    )
    op.create_table_comment(
        'EducationalMaterial',
        'All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        existing_comment=None,
        schema=None,
    )
    op.alter_column(
        'EducationalMaterialCategory',
        'ID',
        existing_type=mysql.BIGINT(display_width=20),
        comment='Primary key. Auto-increment. Purpose of the Educational Material.',
        existing_comment='Primary key. Auto-increment.',
        existing_nullable=False,
        autoincrement=True,
    )
    op.create_table_comment(
        'EducationalMaterialCategory',
        'All Educational names to be changed to ReferenceMaterial when migrated to Django.  Category refers to the purpose of the Educational Material.',
        existing_comment=None,
        schema=None,
    )
    op.alter_column(
        'EducationalMaterialControl',
        'EducationalMaterialCategoryId',
        existing_type=mysql.BIGINT(display_width=20),
        comment='Foreign key with ID in EducationalMaterialCategory table. Category refers to the purpose of the Educational Material.',
        existing_comment='Foreign key with ID in EducationalMaterialCategory table.',
        existing_nullable=False,
        existing_server_default=sa.text('1'),
    )
    op.create_table_comment(
        'EducationalMaterialControl',
        'All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        existing_comment=None,
        schema=None,
    )
    op.create_table_comment(
        'EducationalMaterialMH',
        'All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        existing_comment=None,
        schema=None,
    )
    op.create_table_comment(
        'EducationalMaterialPackageContent',
        'Directory of each material that is contained in an educational material package. No foreign keys to facilitate order changes. All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        existing_comment='Directory of each material that is contained in an educational material package. No foreign keys to facilitate order changes.',
        schema=None,
    )
    op.create_table_comment(
        'EducationalMaterialRating',
        'All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        existing_comment=None,
        schema=None,
    )
    op.create_table_comment(
        'EducationalMaterialTOC',
        'All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        existing_comment=None,
        schema=None,
    )
    op.alter_column(
        'TestControl',
        'EducationalMaterialControlSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
        existing_nullable=True,
    )
    op.alter_column(
        'TestResultControl',
        'EducationalMaterialControlSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
        existing_nullable=True,
    )
    op.create_table_comment(
        'cronControlEducationalMaterial',
        'All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        existing_comment=None,
        schema=None,
    )
    op.create_table_comment(
        'cronControlPatient_EducationalMaterial',
        'All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        existing_comment=None,
        schema=None,
    )


def downgrade() -> None:
    """Drop comments."""
    op.drop_table_comment(
        'cronControlPatient_EducationalMaterial',
        existing_comment='All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        schema=None,
    )
    op.drop_table_comment(
        'cronControlEducationalMaterial',
        existing_comment='All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        schema=None,
    )
    op.alter_column(
        'TestResultControl',
        'EducationalMaterialControlSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        comment=None,
        existing_comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
        existing_nullable=True,
    )
    op.alter_column(
        'TestControl',
        'EducationalMaterialControlSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        comment=None,
        existing_comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
        existing_nullable=True,
    )
    op.drop_table_comment(
        'EducationalMaterialTOC',
        existing_comment='All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        schema=None,
    )
    op.drop_table_comment(
        'EducationalMaterialRating',
        existing_comment='All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        schema=None,
    )
    op.create_table_comment(
        'EducationalMaterialPackageContent',
        'Directory of each material that is contained in an educational material package. No foreign keys to facilitate order changes.',
        existing_comment='Directory of each material that is contained in an educational material package. No foreign keys to facilitate order changes. All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        schema=None,
    )
    op.drop_table_comment(
        'EducationalMaterialMH',
        existing_comment='All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        schema=None,
    )
    op.drop_table_comment(
        'EducationalMaterialControl',
        existing_comment='All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        schema=None,
    )
    op.alter_column(
        'EducationalMaterialControl',
        'EducationalMaterialCategoryId',
        existing_type=mysql.BIGINT(display_width=20),
        comment='Foreign key with ID in EducationalMaterialCategory table.',
        existing_comment='Foreign key with ID in EducationalMaterialCategory table. Category refers to the purpose of the Educational Material.',
        existing_nullable=False,
        existing_server_default=sa.text('1'),
    )
    op.drop_table_comment(
        'EducationalMaterialCategory',
        existing_comment='All Educational names to be changed to ReferenceMaterial when migrated to Django.  Category refers to the purpose of the Educational Material.',
        schema=None,
    )
    op.alter_column(
        'EducationalMaterialCategory',
        'ID',
        existing_type=mysql.BIGINT(display_width=20),
        comment='Primary key. Auto-increment.',
        existing_comment='Primary key. Auto-increment. Purpose of the Educational Material.',
        existing_nullable=False,
        autoincrement=True,
    )
    op.drop_table_comment(
        'EducationalMaterial',
        existing_comment='All Educational names to be changed to ReferenceMaterial when migrated to Django.',
        schema=None,
    )
    op.alter_column(
        'DiagnosisTranslationMH',
        'EducationalMaterialControlSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        comment=None,
        existing_comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
        existing_nullable=True,
    )
    op.alter_column(
        'DiagnosisTranslation',
        'EducationalMaterialControlSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        comment=None,
        existing_comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
        existing_nullable=True,
    )
    op.alter_column(
        'AliasMH',
        'EducationalMaterialControlSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        comment=None,
        existing_comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
        existing_nullable=True,
    )
    op.alter_column(
        'Alias',
        'EducationalMaterialControlSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        comment=None,
        existing_comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
        existing_nullable=True,
    )
