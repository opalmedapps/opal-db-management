# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""
Create all triggers for OpalDB.

Revision ID: 2cbae06775ef
Revises: d52eab1ee338
Create Date: 2023-11-30 16:00:26.413244

"""

from alembic import op

from db_management.opaldb.revision_data.opaldb_replaceable_objects import TRIGGER_LIST

# revision identifiers, used by Alembic.
revision = '2cbae06775ef'
down_revision = 'd52eab1ee338'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Create all triggers for OpalDB using custom operations."""
    for trigger in TRIGGER_LIST:
        op.create_trigger(trigger)  # type: ignore[attr-defined]


def downgrade() -> None:
    """Delete all triggers for OpalDB using custom operations."""
    for trigger in TRIGGER_LIST:
        op.drop_trigger(trigger)  # type: ignore[attr-defined]
