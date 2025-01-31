# SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""
Fix appointment trigger fields.

Revision ID: fc19fc57f40d
Revises: 70fe771798bc
Create Date: 2024-10-11 14:25:45.717968

"""

from alembic import op

from db_management.opaldb.custom_operations import ReplaceableObject

# revision identifiers, used by Alembic.
revision = 'fc19fc57f40d'
down_revision = '70fe771798bc'
branch_labels = None
depends_on = None


UPDATED_APPOINTMENT_DELETE_TRIGGER = ReplaceableObject(
    name='`appointment_delete_trigger`',
    sql_text="""AFTER DELETE ON `Appointment` FOR EACH ROW BEGIN\n INSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `SourceSystemID`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`, `RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`,  `ModificationAction`) VALUES (OLD.AppointmentSerNum,NULL,OLD.SessionId,OLD.AliasExpressionSerNum, OLD.CronLogSerNum, OLD.PatientSerNum,OLD.SourceDatabaseSerNum,OLD.SourceSystemID,OLD.PrioritySerNum, OLD.DiagnosisSerNum, OLD.Status, OLD.State, OLD.ScheduledStartTime,OLD.ScheduledEndTime, OLD.ActualStartDate, OLD.ActualEndDate, OLD.Location, OLD.RoomLocation_EN, OLD.RoomLocation_FR, OLD.Checkin, OLD.DateAdded,OLD.ReadStatus,NOW(), 'DELETE');\nEND;\n""",
)
UPDATED_APPOINTMENT_INSERT_TRIGGER = ReplaceableObject(
    name='`appointment_insert_trigger`',
    sql_text="""AFTER INSERT ON `Appointment` FOR EACH ROW BEGIN\nINSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `SourceSystemID`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`,`RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`, `ModificationAction`) VALUES (NEW.AppointmentSerNum,NULL,NULL,NEW.AliasExpressionSerNum, NEW.CronLogSerNum, NEW.PatientSerNum,NEW.SourceDatabaseSerNum, NEW.SourceSystemID, NEW.PrioritySerNum, NEW.DiagnosisSerNum, NEW.Status, NEW.State, NEW.ScheduledStartTime,NEW.ScheduledEndTime, NEW.ActualStartDate, NEW.ActualEndDate, NEW.Location, NEW.RoomLocation_EN, NEW.RoomLocation_FR, NEW.Checkin, NEW.DateAdded,NEW.ReadStatus,NOW(), 'INSERT');\nEND;\n""",
)
UPDATED_APPOINTMENT_UPDATE_TRIGGER = ReplaceableObject(
    name='`appointment_update_trigger`',
    sql_text="""AFTER UPDATE ON `Appointment` FOR EACH ROW BEGIN\n INSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `SourceSystemID`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`, `RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`,  `ModificationAction`) VALUES (NEW.AppointmentSerNum,NULL,NEW.SessionId,NEW.AliasExpressionSerNum, NEW.CronLogSerNum, NEW.PatientSerNum,NEW.SourceDatabaseSerNum,NEW.SourceSystemID,NEW.PrioritySerNum, NEW.DiagnosisSerNum, NEW.Status, NEW.State, NEW.ScheduledStartTime,NEW.ScheduledEndTime, NEW.ActualStartDate, NEW.ActualEndDate, NEW.Location, NEW.RoomLocation_EN, NEW.RoomLocation_FR, NEW.Checkin, NEW.DateAdded,NEW.ReadStatus,NOW(), 'UPDATE');\nEND;\n""",
)
OLD_APPOINTMENT_DELETE_TRIGGER = ReplaceableObject(
    name='`appointment_delete_trigger`',
    sql_text="""AFTER DELETE ON `Appointment` FOR EACH ROW BEGIN\n INSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `AppointmentAriaSer`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`, `RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`,  `ModificationAction`) VALUES (OLD.AppointmentSerNum,NULL,OLD.SessionId,OLD.AliasExpressionSerNum, OLD.CronLogSerNum, OLD.PatientSerNum,OLD.SourceDatabaseSerNum,OLD.AppointmentAriaSer,OLD.PrioritySerNum, OLD.DiagnosisSerNum, OLD.Status, OLD.State, OLD.ScheduledStartTime,OLD.ScheduledEndTime, OLD.ActualStartDate, OLD.ActualEndDate, OLD.Location, OLD.RoomLocation_EN, OLD.RoomLocation_FR, OLD.Checkin, OLD.DateAdded,OLD.ReadStatus,NOW(), 'DELETE');\nEND;\n""",
)
OLD_APPOINTMENT_INSERT_TRIGGER = ReplaceableObject(
    name='`appointment_insert_trigger`',
    sql_text="""AFTER INSERT ON `Appointment` FOR EACH ROW BEGIN\nINSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `AppointmentAriaSer`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`,`RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`, `ModificationAction`) VALUES (NEW.AppointmentSerNum,NULL,NULL,NEW.AliasExpressionSerNum, NEW.CronLogSerNum, NEW.PatientSerNum,NEW.SourceDatabaseSerNum, NEW.AppointmentAriaSer, NEW.PrioritySerNum, NEW.DiagnosisSerNum, NEW.Status, NEW.State, NEW.ScheduledStartTime,NEW.ScheduledEndTime, NEW.ActualStartDate, NEW.ActualEndDate, NEW.Location, NEW.RoomLocation_EN, NEW.RoomLocation_FR, NEW.Checkin, NEW.DateAdded,NEW.ReadStatus,NOW(), 'INSERT');\nEND;\n""",
)
OLD_APPOINTMENT_UPDATE_TRIGGER = ReplaceableObject(
    name='`appointment_update_trigger`',
    sql_text="""AFTER UPDATE ON `Appointment` FOR EACH ROW BEGIN\n INSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `AppointmentAriaSer`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`, `RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`,  `ModificationAction`) VALUES (NEW.AppointmentSerNum,NULL,NEW.SessionId,NEW.AliasExpressionSerNum, NEW.CronLogSerNum, NEW.PatientSerNum,NEW.SourceDatabaseSerNum,NEW.AppointmentAriaSer,NEW.PrioritySerNum, NEW.DiagnosisSerNum, NEW.Status, NEW.State, NEW.ScheduledStartTime,NEW.ScheduledEndTime, NEW.ActualStartDate, NEW.ActualEndDate, NEW.Location, NEW.RoomLocation_EN, NEW.RoomLocation_FR, NEW.Checkin, NEW.DateAdded,NEW.ReadStatus,NOW(), 'UPDATE');\nEND;\n""",
)


def upgrade() -> None:
    """Update all Appointment triggers to use new source system id field."""
    op.drop_trigger(OLD_APPOINTMENT_DELETE_TRIGGER)  # type: ignore[attr-defined]
    op.drop_trigger(OLD_APPOINTMENT_INSERT_TRIGGER)  # type: ignore[attr-defined]
    op.drop_trigger(OLD_APPOINTMENT_UPDATE_TRIGGER)  # type: ignore[attr-defined]
    op.create_trigger(UPDATED_APPOINTMENT_DELETE_TRIGGER)  # type: ignore[attr-defined]
    op.create_trigger(UPDATED_APPOINTMENT_INSERT_TRIGGER)  # type: ignore[attr-defined]
    op.create_trigger(UPDATED_APPOINTMENT_UPDATE_TRIGGER)  # type: ignore[attr-defined]


def downgrade() -> None:
    """Revert all Appointment triggers."""
    op.drop_trigger(UPDATED_APPOINTMENT_DELETE_TRIGGER)  # type: ignore[attr-defined]
    op.drop_trigger(UPDATED_APPOINTMENT_INSERT_TRIGGER)  # type: ignore[attr-defined]
    op.drop_trigger(UPDATED_APPOINTMENT_UPDATE_TRIGGER)  # type: ignore[attr-defined]
    op.create_trigger(OLD_APPOINTMENT_DELETE_TRIGGER)  # type: ignore[attr-defined]
    op.create_trigger(OLD_APPOINTMENT_INSERT_TRIGGER)  # type: ignore[attr-defined]
    op.create_trigger(OLD_APPOINTMENT_UPDATE_TRIGGER)  # type: ignore[attr-defined]
