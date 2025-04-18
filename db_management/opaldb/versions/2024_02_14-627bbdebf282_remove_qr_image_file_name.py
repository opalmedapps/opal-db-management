# SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""
Remove QR Image File Name.

Revision ID: 627bbdebf282
Revises: 281079041645
Create Date: 2024-02-14 19:17:15.817308

"""

import sqlalchemy as sa
from alembic import op

from db_management.opaldb.custom_operations import ReplaceableObject

# revision identifiers, used by Alembic.
revision = '627bbdebf282'
down_revision = '281079041645'
branch_labels = None
depends_on = None


UPDATED_HOSPITALMAP_DELETE_TRIGGER = ReplaceableObject(
    name='`hospitalmap_delete_trigger`',
    sql_text="""AFTER DELETE ON `HospitalMap` FOR EACH ROW BEGIN\n
INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`, `MapURL_EN`,
`MapURL_FR`, `QRMapAlias`, `MapName_EN`, `MapDescription_EN`, `MapName_FR`,
`MapDescription_FR`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`)
VALUES (OLD.HospitalMapSerNum, OLD.MapUrl, OLD.MapURL_EN, OLD.MapURL_FR, OLD.QRMapAlias,
OLD.MapName_EN, OLD.MapDescription_EN, OLD.MapName_FR, OLD.MapDescription_FR, NOW(),
OLD.LastUpdatedBy, OLD.SessionId, 'DELETE');\nEND;\n""",
)

UPDATED_HOSPITALMAP_INSERT_TRIGGER = ReplaceableObject(
    name='`hospitalmap_insert_trigger`',
    sql_text="""AFTER INSERT ON `HospitalMap` FOR EACH ROW BEGIN\n
INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`, `MapURL_EN`,
`MapURL_FR`, `QRMapAlias`, `MapName_EN`, `MapDescription_EN`, `MapName_FR`,
`MapDescription_FR`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`)
VALUES (NEW.HospitalMapSerNum, NEW.MapUrl, NEW.MapURL_EN, NEW.MapURL_FR, NEW.QRMapAlias,
NEW.MapName_EN, NEW.MapDescription_EN, NEW.MapName_FR, NEW.MapDescription_FR, NOW(),
NEW.LastUpdatedBy, NEW.SessionId, 'INSERT');\nEND;\n""",
)

UPDATED_HOSPITALMAP_UPDATE_TRIGGER = ReplaceableObject(
    name='`hospitalmap_update_trigger`',
    sql_text="""AFTER UPDATE ON `HospitalMap` FOR EACH ROW BEGIN\n
INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`, `MapURL_EN`,
`MapURL_FR`, `QRMapAlias`, `MapName_EN`, `MapDescription_EN`, `MapName_FR`,
`MapDescription_FR`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`)
VALUES (NEW.HospitalMapSerNum, NEW.MapUrl, NEW.MapURL_EN, NEW.MapURL_FR,  NEW.QRMapAlias,
NEW.MapName_EN, NEW.MapDescription_EN, NEW.MapName_FR, NEW.MapDescription_FR, NOW(),
NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE');\nEND;\n""",
)

OLD_HOSPITALMAP_DELETE_TRIGGER = ReplaceableObject(
    name='`hospitalmap_delete_trigger`',
    sql_text="""AFTER DELETE ON `HospitalMap` FOR EACH ROW BEGIN\n
INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`,
`MapURL_EN`, `MapURL_FR`, `QRMapAlias`, `QRImageFileName`, `MapName_EN`,
`MapDescription_EN`, `MapName_FR`, `MapDescription_FR`, `DateAdded`,
`LastUpdatedBy`, `SessionId`, `ModificationAction`)
VALUES (OLD.HospitalMapSerNum, OLD.MapUrl, OLD.MapURL_EN, OLD.MapURL_FR,
OLD.QRMapAlias, OLD.QRImageFileName, OLD.MapName_EN, OLD.MapDescription_EN,
OLD.MapName_FR, OLD.MapDescription_FR, NOW(), OLD.LastUpdatedBy,
OLD.SessionId, 'DELETE');\nEND;\n""",
)

OLD_HOSPITALMAP_INSERT_TRIGGER = ReplaceableObject(
    name='`hospitalmap_insert_trigger`',
    sql_text="""AFTER INSERT ON `HospitalMap` FOR EACH ROW BEGIN\n
INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`,
`MapURL_EN`, `MapURL_FR`, `QRMapAlias`, `QRImageFileName`, `MapName_EN`,
`MapDescription_EN`, `MapName_FR`, `MapDescription_FR`, `DateAdded`,
`LastUpdatedBy`, `SessionId`, `ModificationAction`)
VALUES (NEW.HospitalMapSerNum, NEW.MapUrl, NEW.MapURL_EN, NEW.MapURL_FR,
NEW.QRMapAlias, NEW.QRImageFileName, NEW.MapName_EN, NEW.MapDescription_EN,
NEW.MapName_FR, NEW.MapDescription_FR, NOW(), NEW.LastUpdatedBy,
NEW.SessionId, 'INSERT');\nEND;\n""",
)

OLD_HOSPITALMAP_UPDATE_TRIGGER = ReplaceableObject(
    name='`hospitalmap_update_trigger`',
    sql_text="""AFTER UPDATE ON `HospitalMap` FOR EACH ROW BEGIN\n
INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`,
`MapURL_EN`, `MapURL_FR`, `QRMapAlias`, `QRImageFileName`, `MapName_EN`,
`MapDescription_EN`, `MapName_FR`, `MapDescription_FR`, `DateAdded`,
`LastUpdatedBy`, `SessionId`, `ModificationAction`)
VALUES (NEW.HospitalMapSerNum, NEW.MapUrl, NEW.MapURL_EN, NEW.MapURL_FR,
NEW.QRMapAlias, NEW.QRImageFileName, NEW.MapName_EN, NEW.MapDescription_EN,
NEW.MapName_FR, NEW.MapDescription_FR, NOW(), NEW.LastUpdatedBy,
NEW.SessionId, 'UPDATE');\nEND;\n""",
)


def upgrade() -> None:
    """Update QRImageFileName column from hospitalmap and Triggers to remove QRImageFileName instance."""
    op.drop_column('HospitalMap', 'QRImageFileName')
    op.drop_column('HospitalMapMH', 'QRImageFileName')
    op.drop_trigger(OLD_HOSPITALMAP_DELETE_TRIGGER)  # type: ignore[attr-defined]
    op.drop_trigger(OLD_HOSPITALMAP_INSERT_TRIGGER)  # type: ignore[attr-defined]
    op.drop_trigger(OLD_HOSPITALMAP_UPDATE_TRIGGER)  # type: ignore[attr-defined]
    op.create_trigger(UPDATED_HOSPITALMAP_DELETE_TRIGGER)  # type: ignore[attr-defined]
    op.create_trigger(UPDATED_HOSPITALMAP_INSERT_TRIGGER)  # type: ignore[attr-defined]
    op.create_trigger(UPDATED_HOSPITALMAP_UPDATE_TRIGGER)  # type: ignore[attr-defined]


def downgrade() -> None:
    """Revert QRImageFileName column from hospitalmap and Triggers to remove QRImageFileName instance."""
    op.add_column('HospitalMapMH', sa.Column('QRImageFileName', sa.VARCHAR(length=255), nullable=False))
    op.add_column('HospitalMap', sa.Column('QRImageFileName', sa.VARCHAR(length=255), nullable=False))
    op.drop_trigger(UPDATED_HOSPITALMAP_DELETE_TRIGGER)  # type: ignore[attr-defined]
    op.drop_trigger(UPDATED_HOSPITALMAP_INSERT_TRIGGER)  # type: ignore[attr-defined]
    op.drop_trigger(UPDATED_HOSPITALMAP_UPDATE_TRIGGER)  # type: ignore[attr-defined]
    op.create_trigger(OLD_HOSPITALMAP_DELETE_TRIGGER)  # type: ignore[attr-defined]
    op.create_trigger(OLD_HOSPITALMAP_INSERT_TRIGGER)  # type: ignore[attr-defined]
    op.create_trigger(OLD_HOSPITALMAP_UPDATE_TRIGGER)  # type: ignore[attr-defined]
