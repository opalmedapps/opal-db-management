# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""Base ORM models file for OpalDB."""

from sqlalchemy import (
    TIMESTAMP,
    Boolean,
    Column,
    Date,
    DateTime,
    Enum,
    Float,
    ForeignKey,
    Index,
    String,
    Table,
    Text,
    Time,
    text,
)
from sqlalchemy.dialects.mysql import BIGINT, INTEGER, LONGTEXT, MEDIUMTEXT, SMALLINT, TINYINT, VARCHAR
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship


class Base(DeclarativeBase):
    pass


metadata = Base.metadata

t_Admin = Table(
    'Admin',
    metadata,
    Column('AdminSerNum', INTEGER(11), nullable=False),
    Column('ResourceSerNum', INTEGER(11), nullable=False, index=True),
    Column('FirstName', Text, nullable=False),
    Column('LastName', Text, nullable=False),
    Column('Email', Text, nullable=False),
    Column('Phone', BIGINT(20)),
    Column(
        'LastUpdated',
        TIMESTAMP,
        nullable=False,
        server_default=text('current_timestamp() ON UPDATE current_timestamp()'),
    ),
)


class AliasExpressionMH(Base):
    __tablename__ = 'AliasExpressionMH'

    AliasSerNum = Column(INTEGER(11), nullable=False, index=True, server_default=text('0'))
    masterSourceAliasId = Column(BIGINT(20), nullable=False, index=True, server_default=text('0'))
    ExpressionName = Column(String(250), primary_key=True, nullable=False)
    Description = Column(String(250), primary_key=True, nullable=False)
    RevSerNum = Column(BIGINT(11), primary_key=True, nullable=False, index=True, autoincrement=True)
    LastTransferred = Column(DateTime, nullable=False, server_default=text("'2000-01-01 00:00:00'"))
    LastUpdatedBy = Column(INTEGER(11), index=True)
    DateAdded = Column(DateTime, nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    SessionId = Column(String(255))


class AliasExpressionMHLegacy(Base):
    __tablename__ = 'AliasExpressionMH_legacy'

    AliasSerNum = Column(INTEGER(11), nullable=False, index=True, server_default=text('0'))
    ExpressionName = Column(String(250), primary_key=True, nullable=False)
    Description = Column(String(250), primary_key=True, nullable=False)
    RevSerNum = Column(INTEGER(11), primary_key=True, autoincrement=True, index=True, nullable=False)
    LastTransferred = Column(DateTime, nullable=False, server_default=text("'2000-01-01 00:00:00'"))
    LastUpdatedBy = Column(INTEGER(11), index=True)
    DateAdded = Column(DateTime, nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    SessionId = Column(String(255))


class AliasMH(Base):
    __tablename__ = 'AliasMH'

    AliasSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    AliasRevSerNum = Column(INTEGER(11), primary_key=True, autoincrement=True, nullable=False, index=True)
    AliasType = Column(String(25), nullable=False)
    AliasUpdate = Column(INTEGER(11), nullable=False)
    AliasName_FR = Column(String(100), nullable=False)
    AliasName_EN = Column(String(100), nullable=False)
    AliasDescription_FR = Column(Text, nullable=False)
    AliasDescription_EN = Column(Text, nullable=False)
    EducationalMaterialControlSerNum = Column(
        INTEGER(11), index=True, comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.'
    )
    HospitalMapSerNum = Column(INTEGER(11))
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True, server_default=text('1'))
    ColorTag = Column(String(25), nullable=False, server_default=text("'#777777'"))
    LastTransferred = Column(DateTime, nullable=False, server_default=text("'2000-01-01 00:00:00'"))
    LastUpdatedBy = Column(INTEGER(11), index=True)
    SessionId = Column(String(255))
    ModificationAction = Column(String(25), nullable=False)
    DateAdded = Column(DateTime, nullable=False)


class AllowableExtension(Base):
    __tablename__ = 'AllowableExtension'

    Type: Mapped[Enum] = mapped_column(Enum('video', 'website', 'pdf', 'image'), primary_key=True, nullable=False)
    Name = Column(String(50), primary_key=True, nullable=False)


class AnnouncementMH(Base):
    __tablename__ = 'AnnouncementMH'

    AnnouncementSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    AnnouncementRevSerNum = Column(INTEGER(11), primary_key=True, autoincrement=True, nullable=False, index=True)
    CronLogSerNum = Column(INTEGER(11), index=True)
    PatientSerNum = Column(INTEGER(11), nullable=False, index=True)
    PostControlSerNum = Column(INTEGER(11), nullable=False, index=True)
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class AppointmentMH(Base):
    __tablename__ = 'AppointmentMH'

    AppointmentSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    AppointmentRevSerNum = Column(INTEGER(11), primary_key=True, autoincrement=True, nullable=False, index=True)
    SessionId = Column(Text)
    AliasExpressionSerNum = Column(INTEGER(11), nullable=False, index=True)
    CronLogSerNum = Column(INTEGER(11), index=True)
    PatientSerNum = Column(INTEGER(11), nullable=False, index=True)
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True)
    SourceSystemID = Column(String(100), nullable=False, index=True)
    PrioritySerNum = Column(INTEGER(11), nullable=False, index=True)
    DiagnosisSerNum = Column(INTEGER(11), nullable=False, index=True)
    Status = Column(String(100), nullable=False)
    State = Column(String(25), nullable=False)
    ScheduledStartTime = Column(DateTime, nullable=False)
    ScheduledEndTime = Column(DateTime, nullable=False)
    ActualStartDate = Column(DateTime, nullable=False)
    ActualEndDate = Column(DateTime, nullable=False)
    Location = Column(INTEGER(10), nullable=False)
    RoomLocation_EN = Column(String(100), nullable=False)
    RoomLocation_FR = Column(String(100), nullable=False)
    Checkin = Column(TINYINT(4), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


t_BuildType = Table('BuildType', metadata, Column('Name', String(30), nullable=False))


class CheckinLog(Base):
    __tablename__ = 'CheckinLog'

    CheckinLogSerNum = Column(INTEGER(11), primary_key=True)
    AppointmentSerNum = Column(INTEGER(11), nullable=False)
    DeviceId = Column(String(100), nullable=False)
    Latitude = Column(Float(asdecimal=True), nullable=False, comment='In meters, from 45.474127399999996, -73.6011402')
    Longitude = Column(Float(asdecimal=True), nullable=False)
    Accuracy = Column(Float(asdecimal=True), nullable=False, comment='Accuracy in meters')
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class Cron(Base):
    __tablename__ = 'Cron'

    CronSerNum = Column(INTEGER(11), primary_key=True)
    NextCronDate = Column(Date, nullable=False)
    RepeatUnits = Column(String(50), nullable=False)
    NextCronTime = Column(Time, nullable=False)
    RepeatInterval = Column(INTEGER(11), nullable=False)
    LastCron = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class DiagnosisCodeMH(Base):
    __tablename__ = 'DiagnosisCodeMH'

    DiagnosisTranslationSerNum = Column(INTEGER(11), nullable=False, index=True)
    SourceUID = Column(INTEGER(11), primary_key=True, nullable=False)
    RevSerNum = Column(INTEGER(11), primary_key=True, autoincrement=True, nullable=False, index=True)
    DiagnosisCode = Column(String(100), nullable=False)
    Description = Column(String(2056), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdatedBy = Column(INTEGER(11), index=True)
    SessionId = Column(String(255))


class DiagnosisCodeMHLegacy(Base):
    __tablename__ = 'DiagnosisCodeMH_legacy'

    DiagnosisTranslationSerNum = Column(INTEGER(11), nullable=False, index=True)
    SourceUID = Column(INTEGER(11), primary_key=True, nullable=False)
    RevSerNum = Column(INTEGER(11), primary_key=True, autoincrement=True, nullable=False, index=True)
    DiagnosisCode = Column(String(100), nullable=False)
    Description = Column(String(2056), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdatedBy = Column(INTEGER(11), index=True)
    SessionId = Column(String(255))


class DiagnosisMH(Base):
    __tablename__ = 'DiagnosisMH'

    DiagnosisSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    RevisionSerNum = Column(INTEGER(11), primary_key=True, autoincrement=True, nullable=False, index=True)
    action = Column(String(128), nullable=False)
    PatientSerNum = Column(INTEGER(11), nullable=False, index=True)
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True)
    DiagnosisAriaSer = Column(String(32), nullable=False, index=True)
    DiagnosisCode = Column(String(50), nullable=False)
    Description_EN = Column(String(200), nullable=False)
    Description_FR = Column(String(255), nullable=False)
    Stage = Column(String(32))
    StageCriteria = Column(String(32))
    CreationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(128), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    updatedBy = Column(String(128), nullable=False, index=True)


class DiagnosisTranslationMH(Base):
    __tablename__ = 'DiagnosisTranslationMH'

    DiagnosisTranslationSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    RevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    EducationalMaterialControlSerNum = Column(
        INTEGER(11), index=True, comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.'
    )
    Name_EN = Column(String(2056), nullable=False)
    Name_FR = Column(String(2056), nullable=False)
    Description_EN = Column(String(2056), nullable=False)
    Description_FR = Column(String(2056), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdatedBy = Column(INTEGER(11), index=True)
    SessionId = Column(String(255))


class Doctor(Base):
    __tablename__ = 'Doctor'

    DoctorSerNum = Column(INTEGER(11), primary_key=True, index=True)
    ResourceSerNum = Column(INTEGER(11), nullable=False, index=True)
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True)
    DoctorAriaSer = Column(INTEGER(20), nullable=False, index=True)
    FirstName = Column(String(100), nullable=False)
    LastName = Column(String(100), nullable=False)
    Role = Column(String(100), nullable=False)
    Workplace = Column(String(100), nullable=False)
    Email = Column(Text)
    Phone = Column(String(20))
    Address = Column(Text)
    ProfileImage = Column(String(255), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    BIO_EN = Column(Text)
    BIO_FR = Column(Text)


class DoctorMH(Base):
    __tablename__ = 'DoctorMH'

    DoctorSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    DoctorRevSerNum = Column(INTEGER(11), primary_key=True, autoincrement=True, nullable=False, index=True)
    ResourceSerNum = Column(INTEGER(11), nullable=False)
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True)
    DoctorAriaSer = Column(INTEGER(20), nullable=False)
    FirstName = Column(String(100), nullable=False)
    LastName = Column(String(100), nullable=False)
    Role = Column(String(100), nullable=False)
    Workplace = Column(String(100), nullable=False)
    Email = Column(Text)
    Phone = Column(String(20))
    Address = Column(Text)
    ProfileImage = Column(String(255), nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    BIO_EN = Column(Text)
    BIO_FR = Column(Text)


class DocumentMH(Base):
    __tablename__ = 'DocumentMH'

    DocumentSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    DocumentRevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    CronLogSerNum = Column(INTEGER(11), index=True)
    SessionId = Column(Text)
    PatientSerNum = Column(INTEGER(11), nullable=False)
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True)
    DocumentId = Column(String(100), nullable=False)
    AliasExpressionSerNum = Column(INTEGER(11), nullable=False)
    ApprovedBySerNum = Column(INTEGER(11), nullable=False)
    ApprovedTimeStamp = Column(DateTime, nullable=False)
    AuthoredBySerNum = Column(INTEGER(11), nullable=False)
    DateOfService = Column(DateTime, nullable=False)
    Revised = Column(String(5), nullable=False)
    ValidEntry = Column(String(5), nullable=False)
    ErrorReasonText = Column(Text, nullable=False)
    OriginalFileName = Column(String(500), nullable=False)
    FinalFileName = Column(String(500), nullable=False)
    CreatedBySerNum = Column(INTEGER(11), nullable=False)
    CreatedTimeStamp = Column(DateTime, nullable=False)
    TransferStatus = Column(String(10), nullable=False)
    TransferLog = Column(String(1000), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class EducationalMaterialCategory(Base):
    __tablename__ = 'EducationalMaterialCategory'
    __table_args__ = {
        'comment': 'All Educational names to be changed to ReferenceMaterial when migrated to Django.  Category refers to the purpose of the Educational Material.'
    }

    ID = Column(
        BIGINT(20), primary_key=True, comment='Primary key. Auto-increment. Purpose of the Educational Material.'
    )
    title_EN = Column(
        String(128),
        nullable=False,
        server_default=text("''"),
        comment='English title of an educational material category.',
    )
    title_FR = Column(
        String(128),
        nullable=False,
        server_default=text("''"),
        comment='French title of an educational material category.',
    )
    description_EN = Column(
        String(512),
        nullable=False,
        server_default=text("''"),
        comment='English description of an educational material category.',
    )
    description_FR = Column(
        String(512),
        nullable=False,
        server_default=text("''"),
        comment='French description of an educational material category.',
    )


class EducationalMaterialMH(Base):
    __tablename__ = 'EducationalMaterialMH'
    __table_args__ = {'comment': 'All Educational names to be changed to ReferenceMaterial when migrated to Django.'}

    EducationalMaterialSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    EducationalMaterialRevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    CronLogSerNum = Column(INTEGER(11), index=True)
    EducationalMaterialControlSerNum = Column(INTEGER(11), nullable=False)
    PatientSerNum = Column(INTEGER(11), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class EducationalMaterialPackageContent(Base):
    __tablename__ = 'EducationalMaterialPackageContent'
    __table_args__ = {
        'comment': 'Directory of each material that is contained in an educational material package. No foreign keys to facilitate order changes. All Educational names to be changed to ReferenceMaterial when migrated to Django.'
    }

    EducationalMaterialPackageContentSerNum = Column(INTEGER(11), primary_key=True)
    EducationalMaterialControlSerNum = Column(
        INTEGER(11), nullable=False, index=True, comment='Material contained in a package.'
    )
    OrderNum = Column(INTEGER(11), nullable=False, comment='Position of the material in the package, starting at 1.')
    ParentSerNum = Column(
        INTEGER(11), nullable=False, index=True, comment='EducationalMaterialControlSerNum of the parent package.'
    )
    DateAdded = Column(DateTime, nullable=False)
    AddedBy = Column(INTEGER(11))
    LastUpdated = Column(
        TIMESTAMP, nullable=False, index=True, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    LastUpdatedBy = Column(INTEGER(11))


class EducationalMaterialRating(Base):
    __tablename__ = 'EducationalMaterialRating'
    __table_args__ = {'comment': 'All Educational names to be changed to ReferenceMaterial when migrated to Django.'}

    EducationalMaterialRatingSerNum = Column(INTEGER(11), primary_key=True)
    EducationalMaterialControlSerNum = Column(INTEGER(11), nullable=False)
    PatientSerNum = Column(INTEGER(11), nullable=False)
    Username = Column(
        String(255),
        nullable=False,
        server_default=text("''"),
        comment='The username of the person who submitted an educational material rating.',
    )
    RatingValue = Column(TINYINT(6), nullable=False)
    SessionId = Column(Text, nullable=False, server_default=text("''"), comment='Deprecated')
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class EducationalMaterialTOC(Base):
    __tablename__ = 'EducationalMaterialTOC'
    __table_args__ = {'comment': 'All Educational names to be changed to ReferenceMaterial when migrated to Django.'}

    EducationalMaterialTOCSerNum = Column(INTEGER(11), primary_key=True)
    EducationalMaterialControlSerNum = Column(INTEGER(11), nullable=False, index=True)
    OrderNum = Column(INTEGER(11), nullable=False)
    ParentSerNum = Column(INTEGER(11), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class EmailControlMH(Base):
    __tablename__ = 'EmailControlMH'

    EmailControlSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    RevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    Subject_EN = Column(String(100), nullable=False)
    Subject_FR = Column(String(100), nullable=False)
    Body_EN = Column(Text, nullable=False)
    Body_FR = Column(Text, nullable=False)
    EmailTypeSerNum = Column(INTEGER(11), nullable=False, index=True)
    DateAdded = Column(DateTime, nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdatedBy = Column(INTEGER(11), index=True)
    SessionId = Column(String(255))


class EmailLogMH(Base):
    __tablename__ = 'EmailLogMH'

    EmailLogSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    EmailLogRevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True)
    CronLogSerNum = Column(INTEGER(11), index=True)
    PatientSerNum = Column(INTEGER(11), nullable=False)
    EmailControlSerNum = Column(INTEGER(11), nullable=False, index=True)
    Status = Column(String(5), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    ModificationAction = Column(String(25), nullable=False)


class EmailType(Base):
    __tablename__ = 'EmailType'

    EmailTypeSerNum = Column(INTEGER(11), primary_key=True)
    EmailTypeId = Column(String(100), nullable=False)
    EmailTypeName = Column(String(200), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class Filter(Base):
    __tablename__ = 'Filters'

    FilterSerNum = Column(INTEGER(11), primary_key=True)
    ControlTable = Column(String(100), nullable=False, index=True)
    ControlTableSerNum = Column(INTEGER(11), nullable=False, index=True)
    FilterType = Column(String(100), nullable=False, index=True)
    FilterId = Column(String(150), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdatedBy = Column(INTEGER(11))
    SessionId = Column(String(255))
    ScheduledTimeOffset = Column(INTEGER(11), server_default=text('0'), nullable=False)
    ScheduledTimeUnit: Mapped[Enum] = mapped_column(Enum('minutes', 'hours', 'days', 'weeks', 'months'), nullable=True)
    ScheduledTimeDirection: Mapped[Enum] = mapped_column(
        Enum('before', 'after'), server_default=text("'after'"), nullable=False
    )


t_FiltersMH = Table(
    'FiltersMH',
    metadata,
    Column('FilterSerNum', INTEGER(11), nullable=False, index=True),
    Column('ControlTable', String(100), nullable=False),
    Column('ControlTableSerNum', INTEGER(11), nullable=False, index=True),
    Column('FilterType', String(100), nullable=False),
    Column('FilterId', String(150), nullable=False),
    Column('ModificationAction', String(25), nullable=False),
    Column('DateAdded', DateTime, nullable=False),
    Column('LastUpdatedBy', INTEGER(11), index=True),
    Column('SessionId', String(255)),
)


t_FrequencyEvents = Table(
    'FrequencyEvents',
    metadata,
    Column('ControlTable', String(50), nullable=False),
    Column('ControlTableSerNum', INTEGER(11), nullable=False),
    Column('MetaKey', String(50), nullable=False),
    Column('MetaValue', String(150), nullable=False),
    Column('CustomFlag', INTEGER(11), nullable=False),
    Column('DateAdded', DateTime, nullable=False),
    Column(
        'LastUpdated',
        TIMESTAMP,
        nullable=False,
        server_default=text('current_timestamp() ON UPDATE current_timestamp()'),
    ),
    Index('ControlTable', 'ControlTable', 'ControlTableSerNum', 'MetaKey', unique=True),
)


class HospitalMapMH(Base):
    __tablename__ = 'HospitalMapMH'

    HospitalMapSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    RevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    MapUrl = Column(String(255))
    MapURL_EN = Column(String(512))
    MapURL_FR = Column(String(512))
    QRMapAlias = Column(String(255))
    MapName_EN = Column(String(255))
    MapDescription_EN = Column(String(255))
    MapName_FR = Column(String(255))
    MapDescription_FR = Column(String(255))
    DateAdded = Column(DateTime, nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdatedBy = Column(INTEGER(11), index=True)
    SessionId = Column(String(255))


class HospitalIdentifierType(Base):
    __tablename__ = 'Hospital_Identifier_Type'

    Hospital_Identifier_Type_Id = Column(INTEGER(11), primary_key=True)
    Code = Column(String(20), nullable=False, unique=True)
    ADT_Web_Service_Code = Column(String(20), nullable=False)
    Description_EN = Column(String(250), nullable=False)
    Description_FR = Column(String(250), nullable=False)


class NotificationControlMH(Base):
    __tablename__ = 'NotificationControlMH'

    NotificationControlSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    RevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    Name_EN = Column(String(100), nullable=False)
    Name_FR = Column(String(100), nullable=False)
    Description_EN = Column(Text, nullable=False)
    Description_FR = Column(Text, nullable=False)
    NotificationTypeSerNum = Column(String(100), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdatedBy = Column(INTEGER(11), index=True)
    ModificationAction = Column(String(25), nullable=False)
    SessionId = Column(String(255))


class NotificationMH(Base):
    __tablename__ = 'NotificationMH'

    NotificationSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    NotificationRevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    CronLogSerNum = Column(INTEGER(11), index=True)
    PatientSerNum = Column(INTEGER(11), nullable=False, index=True)
    NotificationControlSerNum = Column(INTEGER(11), nullable=False, index=True)
    RefTableRowSerNum = Column(BIGINT(11), nullable=False, index=True)
    ReadStatus = Column(INTEGER(11), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    RefTableRowTitle_EN = Column(String(500), nullable=False)
    RefTableRowTitle_FR = Column(String(500), nullable=False)


class NotificationType(Base):
    __tablename__ = 'NotificationTypes'

    NotificationTypeSerNum = Column(INTEGER(11), primary_key=True)
    NotificationTypeId = Column(String(100), nullable=False)
    NotificationTypeName = Column(String(200), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class OAActivityLog(Base):
    __tablename__ = 'OAActivityLog'

    ActivitySerNum = Column(INTEGER(11), primary_key=True)
    Activity = Column(String(255), nullable=False)
    OAUserSerNum = Column(INTEGER(11), nullable=False, index=True)
    SessionId = Column(String(255), nullable=False)
    DateAdded = Column(DateTime, nullable=False)


class OAUserRole(Base):
    __tablename__ = 'OAUserRole'

    OAUserSerNum = Column(INTEGER(11), primary_key=True, nullable=False, index=True)
    RoleSerNum = Column(INTEGER(11), primary_key=True, nullable=False, index=True)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class Patient(Base):
    __tablename__ = 'Patient'

    PatientSerNum = Column(INTEGER(11), primary_key=True, index=True)
    PatientAriaSer = Column(INTEGER(11), nullable=False, index=True, server_default=text('0'), comment='Deprecated')
    PatientId = Column(String(50), nullable=False, server_default=text("''"), comment='Deprecated')
    PatientId2 = Column(String(50), nullable=False, server_default=text("''"), comment='Deprecated')
    FirstName = Column(String(50), nullable=False)
    LastName = Column(String(50), nullable=False)
    Alias = Column(String(100), server_default=text("''"))
    ProfileImage = Column(LONGTEXT, comment='Deprecated')
    Sex = Column(String(25), nullable=False)
    DateOfBirth = Column(DateTime, nullable=False)
    Age = Column(INTEGER(11))
    TelNum = Column(BIGINT(11), server_default=text('0'))
    EnableSMS = Column(TINYINT(4), nullable=False, server_default=text('0'))
    Email = Column(String(50), nullable=False)
    Language: Mapped[Enum] = mapped_column(Enum('EN', 'FR', 'SN'), nullable=False)
    SSN = Column(String(16), nullable=False)
    AccessLevel: Mapped[Enum] = mapped_column(Enum('1', '2', '3'), nullable=False, server_default=text("'1'"))
    RegistrationDate = Column(DateTime, nullable=False, server_default=text('current_timestamp()'))
    ConsentFormExpirationDate = Column(DateTime)
    BlockedStatus = Column(TINYINT(4), nullable=False, server_default=text('0'), comment='to block user on Firebase')
    StatusReasonTxt = Column(Text, nullable=False, server_default=text("''"))
    DeathDate = Column(DateTime)
    SessionId = Column(Text, nullable=False, server_default=text("''"), comment='Deprecated')
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    TestUser = Column(TINYINT(4), nullable=False, server_default=text('0'))
    TermsAndAgreementSign = Column(TINYINT(4))
    TermsAndAgreementSignDateTime = Column(DateTime)


class PatientControl(Base):
    __tablename__ = 'PatientControl'

    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), primary_key=True, index=True
    )
    PatientUpdate = Column(INTEGER(11), nullable=False, index=True, server_default=text('1'))
    LastTransferred = Column(DateTime, nullable=False, server_default=text("'2000-01-01 00:00:00'"))
    PC_LastUpdated = Column(
        'LastUpdated',
        TIMESTAMP,
        nullable=False,
        server_default=text('current_timestamp() ON UPDATE current_timestamp()'),
    )
    TransferFlag = Column(SMALLINT(6), nullable=False, index=True, server_default=text('0'))


class PatientActivityLog(Base):
    __tablename__ = 'PatientActivityLog'

    ActivitySerNum = Column(INTEGER(11), primary_key=True)
    Request = Column(String(255), nullable=False, index=True)
    Parameters = Column(String(2048), server_default=text("''"), comment='The parameters passed to the request.')
    TargetPatientId = Column(
        INTEGER(11),
        comment='PatientSerNum of the patient targeted by the request (if the request targets patient data).',
    )
    Username = Column(String(255), nullable=False, index=True)
    DeviceId = Column(
        String(255),
        nullable=False,
        comment='This will have information about the previous and current values of fields',
    )
    SessionId = Column(Text, nullable=False, server_default=text("''"), comment='Deprecated')
    DateTime = Column(DateTime, nullable=False, index=True)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    AppVersion = Column(String(50), nullable=False, index=True)


t_PatientDoctorHistory = Table(
    'PatientDoctorHistory',
    metadata,
    Column('PatientDoctorSerNum', INTEGER(11), nullable=False, server_default=text('0')),
    Column('PatientSerNum', INTEGER(11), nullable=False),
    Column('DoctorSerNum', INTEGER(11), nullable=False),
    Column('OncologistFlag', INTEGER(11), nullable=False),
    Column('PrimaryFlag', INTEGER(11), nullable=False),
    Column('LastUpdated', TIMESTAMP, nullable=False, server_default=text("'0000-00-00 00:00:00'")),
)


class PatientMH(Base):
    __tablename__ = 'PatientMH'

    PatientSerNum = Column(INTEGER(11), primary_key=True, nullable=False, index=True)
    PatientRevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    SessionId = Column(Text)
    PatientAriaSer = Column(INTEGER(11), nullable=False)
    PatientId = Column(String(50), nullable=False)
    PatientId2 = Column(String(50), nullable=False)
    FirstName = Column(String(50), nullable=False)
    LastName = Column(String(50), nullable=False)
    Alias = Column(String(100))
    Sex = Column(String(25), nullable=False)
    DateOfBirth = Column(DateTime, nullable=False)
    Age = Column(INTEGER(11))
    TelNum = Column(BIGINT(11))
    EnableSMS = Column(TINYINT(4), nullable=False)
    Email = Column(String(50), nullable=False)
    Language: Mapped[Enum] = mapped_column(Enum('EN', 'FR', 'SN'), nullable=False)
    SSN = Column(Text, nullable=False)
    AccessLevel: Mapped[Enum] = mapped_column(Enum('1', '2', '3'), nullable=False)
    RegistrationDate = Column(DateTime, nullable=False)
    ConsentFormExpirationDate = Column(DateTime)
    BlockedStatus = Column(TINYINT(4), nullable=False, server_default=text('0'))
    StatusReasonTxt = Column(Text, nullable=False)
    DeathDate = Column(DateTime)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class PatientsForPatientsMH(Base):
    __tablename__ = 'PatientsForPatientsMH'

    PatientsForPatientsSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    PatientsForPatientsRevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    CronLogSerNum = Column(INTEGER(11), index=True)
    PatientSerNum = Column(INTEGER(11), nullable=False, index=True)
    PostControlSerNum = Column(INTEGER(11), nullable=False, index=True)
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class PatientsForPatientsPersonnel(Base):
    __tablename__ = 'PatientsForPatientsPersonnel'

    PatientsForPatientsPersonnelSerNum = Column(INTEGER(11), primary_key=True)
    FirstName = Column(String(255), nullable=False)
    LastName = Column(String(255), nullable=False)
    Email = Column(String(100))
    Bio_EN = Column(Text, nullable=False)
    Bio_FR = Column(Text, nullable=False)
    Website = Column(String(100), nullable=False)
    ProfileImage = Column(String(255), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class PatientsForPatientsPersonnelMH(Base):
    __tablename__ = 'PatientsForPatientsPersonnelMH'

    PatientsForPatientsPersonnelSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    PatientsForPatientsPersonnelRevSerNum = Column(
        INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True
    )
    FirstName = Column(String(255), nullable=False)
    LastName = Column(INTEGER(11), nullable=False)
    Email = Column(String(100))
    Bio_EN = Column(Text, nullable=False)
    Bio_FR = Column(Text, nullable=False)
    Website = Column(String(100), nullable=False)
    ProfileImage = Column(String(255), nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class PhaseInTreatment(Base):
    __tablename__ = 'PhaseInTreatment'

    PhaseInTreatmentSerNum = Column(INTEGER(11), primary_key=True)
    Name_EN = Column(String(200), nullable=False)
    Name_FR = Column(String(200), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class PlanWorkflow(Base):
    __tablename__ = 'PlanWorkflow'
    __table_args__ = (Index('PlanSerNum', 'PlanSerNum', 'OrderNum', unique=True),)

    PlanWorkflowSerNum = Column(INTEGER(11), primary_key=True)
    PlanSerNum = Column(INTEGER(11), nullable=False)
    OrderNum = Column(INTEGER(11), nullable=False)
    Type = Column(String(255), nullable=False)
    TypeSerNum = Column(INTEGER(11), nullable=False)
    PublishedName_EN = Column(String(255), nullable=False)
    PublishedName_FR = Column(String(255), nullable=False)
    PublishedDescription_EN = Column(String(255), nullable=False)
    PublishedDescription_FR = Column(String(255), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class PostControlMH(Base):
    __tablename__ = 'PostControlMH'

    PostControlSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    RevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    PostType = Column(String(100), nullable=False)
    PublishFlag = Column(INTEGER(11), nullable=False, server_default=text('0'))
    PostName_FR = Column(String(100), nullable=False)
    PostName_EN = Column(String(100), nullable=False)
    Body_FR = Column(Text, nullable=False)
    Body_EN = Column(Text, nullable=False)
    PublishDate = Column(DateTime)
    Disabled = Column(TINYINT(1), nullable=False, server_default=text('0'))
    DateAdded = Column(DateTime, nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastPublished = Column(DateTime, nullable=False, server_default=text("'2002-01-01 00:00:00'"))
    LastUpdatedBy = Column(INTEGER(11), index=True)
    SessionId = Column(String(255))


class Priority(Base):
    __tablename__ = 'Priority'

    PrioritySerNum = Column(INTEGER(11), primary_key=True)
    PatientSerNum = Column(INTEGER(11), nullable=False)
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True)
    PriorityAriaSer = Column(INTEGER(11), nullable=False)
    PriorityDateTime = Column(DateTime, nullable=False)
    PriorityCode = Column(String(25), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class PushNotification(Base):
    __tablename__ = 'PushNotification'

    PushNotificationSerNum = Column(INTEGER(11), primary_key=True)
    PatientDeviceIdentifierSerNum = Column(INTEGER(11), index=True)
    PatientSerNum = Column(INTEGER(11), nullable=False, index=True)
    NotificationControlSerNum = Column(INTEGER(11), nullable=False, index=True)
    RefTableRowSerNum = Column(BIGINT(11), nullable=False, index=True)
    DateAdded = Column(DateTime, nullable=False)
    SendStatus = Column(String(3), nullable=False)
    SendLog = Column(Text, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class QuestionnaireControlMH(Base):
    __tablename__ = 'QuestionnaireControlMH'

    QuestionnaireControlSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    RevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    QuestionnaireDBSerNum = Column(INTEGER(11), nullable=False)
    QuestionnaireName_EN = Column(String(2056), nullable=False)
    QuestionnaireName_FR = Column(String(2056), nullable=False)
    Intro_EN = Column(Text, nullable=False)
    Intro_FR = Column(Text, nullable=False)
    PublishFlag = Column(TINYINT(4), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdatedBy = Column(INTEGER(11), index=True)
    LastPublished = Column(DateTime, nullable=False)
    SessionId = Column(String(255))


class QuestionnaireDBDefinitionTable(Base):
    __tablename__ = 'definitionTable'
    __table_args__ = {'schema': 'QuestionnaireDB'}

    ID = Column(BIGINT(20), primary_key=True)
    name = Column(String(255), nullable=False)


class QuestionnaireDBDictionary(Base):
    __tablename__ = 'dictionary'
    __table_args__ = {'schema': 'QuestionnaireDB'}

    ID = Column(BIGINT(20), primary_key=True)
    tableId: Mapped[int] = mapped_column(ForeignKey('QuestionnaireDB.definitionTable.ID'), nullable=False, index=True)
    languageId: Mapped[int] = mapped_column(ForeignKey('QuestionnaireDB.language.ID'), nullable=False, index=True)
    contentId = Column(BIGINT(20), nullable=False, index=True)
    content = Column(MEDIUMTEXT, nullable=False)
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False, server_default=text("''"))
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    updatedBy = Column(String(255), nullable=False, server_default=text("''"))

    language = relationship('Language', primaryjoin='Dictionary.languageId == Language.ID')
    definitionTable = relationship('DefinitionTable')


class QuestionnaireDBLanguage(Base):
    __tablename__ = 'language'
    __table_args__ = {'schema': 'QuestionnaireDB'}

    ID = Column(BIGINT(20), primary_key=True)
    isoLang = Column(String(2), nullable=False)
    name: Mapped[int] = mapped_column(ForeignKey('QuestionnaireDB.dictionary.contentId'), nullable=False, index=True)
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False, server_default=text("''"))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False, server_default=text("''"))
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    updatedBy = Column(String(255), nullable=False, server_default=text("''"))

    dictionary = relationship('Dictionary', primaryjoin='Language.name == Dictionary.contentId')


class QuestionnaireMH(Base):
    __tablename__ = 'QuestionnaireMH'

    QuestionnaireSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    QuestionnaireRevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    CronLogSerNum = Column(INTEGER(11), index=True)
    QuestionnaireControlSerNum = Column(INTEGER(11), nullable=False, index=True)
    PatientSerNum = Column(INTEGER(11), nullable=False, index=True)
    DateAdded = Column(DateTime, nullable=False)
    PatientQuestionnaireDBSerNum = Column(INTEGER(11), index=True)
    CompletedFlag = Column(TINYINT(4), nullable=False)
    CompletionDate = Column(DateTime)
    ModificationAction = Column(String(25), nullable=False)


class Resource(Base):
    __tablename__ = 'Resource'

    ResourceSerNum = Column(INTEGER(11), primary_key=True, index=True)
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True)
    ResourceAriaSer = Column(INTEGER(11), nullable=False, index=True, server_default=text('0'))
    ResourceCode = Column(String(128), nullable=False)
    ResourceName = Column(String(255), nullable=False)
    ResourceType = Column(String(1000), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class Role(Base):
    __tablename__ = 'Role'

    RoleSerNum = Column(INTEGER(11), primary_key=True)
    RoleName = Column(String(100), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class SecurityQuestion(Base):
    __tablename__ = 'SecurityQuestion'

    SecurityQuestionSerNum = Column(INTEGER(11), primary_key=True)
    QuestionText_EN = Column(String(2056), nullable=False)
    QuestionText_FR = Column(String(2056), nullable=False)
    CreationDate = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    Active = Column(
        TINYINT(4), nullable=False, index=True, server_default=text('0'), comment='0 = Disable / 1 = Enable'
    )


class SourceDatabase(Base):
    __tablename__ = 'SourceDatabase'

    SourceDatabaseSerNum = Column(INTEGER(11), primary_key=True)
    SourceDatabaseName = Column(String(255), nullable=False)
    Enabled = Column(TINYINT(4), nullable=False, server_default=text('0'))


class Staff(Base):
    __tablename__ = 'Staff'

    StaffSerNum = Column(INTEGER(11), primary_key=True)
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True)
    StaffId = Column(String(11), nullable=False, index=True)
    FirstName = Column(String(30), nullable=False)
    LastName = Column(String(30), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class TaskMH(Base):
    __tablename__ = 'TaskMH'

    TaskSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    TaskRevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    CronLogSerNum = Column(INTEGER(11), index=True)
    PatientSerNum = Column(INTEGER(11), nullable=False, index=True)
    AliasExpressionSerNum = Column(INTEGER(11), nullable=False, index=True)
    PrioritySerNum = Column(INTEGER(11), nullable=False, index=True)
    DiagnosisSerNum = Column(INTEGER(11), nullable=False, index=True)
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True)
    TaskAriaSer = Column(INTEGER(11), nullable=False, index=True)
    Status = Column(String(100), nullable=False)
    State = Column(String(25), nullable=False)
    DueDateTime = Column(DateTime, nullable=False)
    CreationDate = Column(DateTime, nullable=False)
    CompletionDate = Column(DateTime, nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class TestResultControlMH(Base):
    __tablename__ = 'TestResultControlMH'

    TestResultControlSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    RevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    Name_EN = Column(String(200), nullable=False)
    Name_FR = Column(String(200), nullable=False)
    Description_EN = Column(Text, nullable=False)
    Description_FR = Column(Text, nullable=False)
    Group_EN = Column(String(200), nullable=False)
    Group_FR = Column(String(200), nullable=False)
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True, server_default=text('1'))
    EducationalMaterialControlSerNum = Column(INTEGER(11), index=True)
    PublishFlag = Column(INTEGER(11), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastPublished = Column(DateTime, nullable=False, server_default=text("'2002-01-01 00:00:00'"))
    LastUpdatedBy = Column(INTEGER(11), index=True)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    ModificationAction = Column(String(25), nullable=False)
    URL_EN = Column(String(2000))
    URL_FR = Column(String(2000))
    SessionId = Column(String(255))


class TestResultExpressionMH(Base):
    __tablename__ = 'TestResultExpressionMH'

    TestResultControlSerNum = Column(INTEGER(11), nullable=False, index=True)
    ExpressionName = Column(String(100), primary_key=True, nullable=False)
    RevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    DateAdded = Column(DateTime, nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastPublished = Column(DateTime, nullable=False, server_default=text("'2000-01-01 00:00:00'"))
    LastUpdatedBy = Column(INTEGER(11), index=True)
    SessionId = Column(String(255))


class TestResultMH(Base):
    __tablename__ = 'TestResultMH'

    TestResultSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    TestResultRevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    CronLogSerNum = Column(INTEGER(11), index=True)
    TestResultGroupSerNum = Column(INTEGER(11), nullable=False)
    TestResultExpressionSerNum = Column(INTEGER(11), nullable=False, index=True)
    PatientSerNum = Column(INTEGER(11), nullable=False, index=True)
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True)
    TestResultAriaSer = Column(String(100), nullable=False, index=True)
    ComponentName = Column(String(30), nullable=False)
    FacComponentName = Column(String(30), nullable=False)
    AbnormalFlag = Column(String(5), nullable=False)
    TestDate = Column(DateTime, nullable=False)
    MaxNorm = Column(Float, nullable=False)
    MinNorm = Column(Float, nullable=False)
    ApprovedFlag = Column(String(5), nullable=False)
    TestValue = Column(Float, nullable=False)
    TestValueString = Column(String(400), nullable=False)
    UnitDescription = Column(String(40), nullable=False)
    ValidEntry = Column(String(5), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False)
    ModificationAction = Column(String(25), nullable=False)


class Translation(Base):
    __tablename__ = 'Translation'

    TranslationSerNum = Column(BIGINT(20), primary_key=True)
    TranslationTableName = Column(
        String(150), nullable=False, index=True, server_default=text("''"), comment='Name of the Table'
    )
    TranslationColumnName = Column(String(150), nullable=False, server_default=text("''"), comment='Name of the column')
    TranslationCurrent = Column(String(512), nullable=False, server_default=text("''"), comment='Current text')
    TranslationReplace = Column(
        String(512), nullable=False, server_default=text("''"), comment='Replace the current text'
    )
    Active = Column(
        TINYINT(4), nullable=False, index=True, server_default=text('1'), comment='1 = Active / 0 = Not Active'
    )
    RefTableRecNo = Column(BIGINT(20), comment='Record Number of the reference table')


class TxTeamMessageMH(Base):
    __tablename__ = 'TxTeamMessageMH'

    TxTeamMessageSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    TxTeamMessageRevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    CronLogSerNum = Column(INTEGER(11), index=True)
    PatientSerNum = Column(INTEGER(11), nullable=False, index=True)
    PostControlSerNum = Column(INTEGER(11), nullable=False, index=True)
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class User(Base):
    __tablename__ = 'Users'

    UserSerNum = Column(INTEGER(11), primary_key=True)
    UserType = Column(String(255), nullable=False, index=True)
    UserTypeSerNum = Column(INTEGER(11), nullable=False, index=True)
    Username = Column(String(255), nullable=False, comment='This field is Firebase User UID')
    Password = Column(String(255), nullable=False)
    SessionId = Column(Text, server_default=text("''"), comment='Deprecated')
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class UsersMH(Base):
    __tablename__ = 'UsersMH'

    UserSerNum = Column(INTEGER(11), primary_key=True, nullable=False)
    UserRevSerNum = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    SessionId = Column(Text, nullable=False)
    UserType = Column(String(255), nullable=False)
    UserTypeSerNum = Column(INTEGER(11), nullable=False)
    Username = Column(String(255), nullable=False)
    Password = Column(String(255), nullable=False)
    ModificationAction = Column(String(25), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class Venue(Base):
    __tablename__ = 'Venue'

    VenueSerNum = Column(INTEGER(11), primary_key=True)
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True)
    SourceUID = Column(INTEGER(11), nullable=False, index=True)
    VenueId = Column(String(100), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class Accesslevel(Base):
    __tablename__ = 'accesslevel'
    __table_args__ = {
        'comment': 'Table to store level of access in opal application. There are two levels 1- Need to Know and 2-All. '
    }

    Id = Column(BIGINT(20), primary_key=True)
    AccessLevelName_EN = Column(String(200), nullable=False)
    AccessLevelName_FR = Column(String(200), nullable=False)


class Alert(Base):
    __tablename__ = 'alert'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key, auto-increment')
    contact = Column(
        MEDIUMTEXT,
        nullable=False,
        comment='list of contacts for the alert. JSON format field that contains phone number and email.',
    )
    subject = Column(MEDIUMTEXT, nullable=False, comment='Subject of the alert. Should be plain text, no html.')
    body = Column(MEDIUMTEXT, nullable=False, comment='Body of the alert message. Plain text, no html.')
    trigger = Column(MEDIUMTEXT, nullable=False, comment='List of conditions to trigger the alert. JSON format.')
    active = Column(
        TINYINT(1),
        nullable=False,
        server_default=text('0'),
        comment='Is the alert active (equals to 0) or not (equals to 1). By default, inactive.',
    )
    deleted = Column(TINYINT(1), nullable=False, server_default=text('0'), comment=' 0 = not deleted, 1 = deleted')
    deletedBy = Column(
        String(128), nullable=False, server_default=text("''"), comment='Username of the person who deleted the record'
    )
    creationDate = Column(DateTime, nullable=False, comment='Date and time of creation of the record')
    createdBy = Column(
        String(128), nullable=False, server_default=text("''"), comment='Username of the person who created the record'
    )
    lastUpdated = Column(
        TIMESTAMP,
        nullable=False,
        server_default=text('current_timestamp() ON UPDATE current_timestamp()'),
        comment='Date and time of last update of the record',
    )
    updatedBy = Column(
        String(128), nullable=False, server_default=text("''"), comment='Username of the person who updated the record'
    )


class AlertMH(Base):
    __tablename__ = 'alertMH'

    alertId = Column(BIGINT(20), primary_key=True, nullable=False, comment='Primary key from alert table')
    revisionId = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    action = Column(String(128), nullable=False, comment='Action taken')
    contact = Column(
        MEDIUMTEXT,
        nullable=False,
        comment='list of contacts for the alert. JSON format field that contains phone number and email.',
    )
    subject = Column(MEDIUMTEXT, nullable=False, comment='Subject of the alert. Should be plain text, no html.')
    body = Column(MEDIUMTEXT, nullable=False, comment='Body of the alert message. Plain text, no html.')
    trigger = Column(MEDIUMTEXT, nullable=False, comment='List of conditions to trigger the alert. JSON format.')
    active = Column(
        TINYINT(1),
        nullable=False,
        server_default=text('0'),
        comment='Is the alert active (equals to 0) or not (equals to 1). By default, inactive.',
    )
    deleted = Column(TINYINT(1), nullable=False, server_default=text('0'), comment=' 0 = not deleted, 1 = deleted')
    deletedBy = Column(
        String(128), nullable=False, server_default=text("''"), comment='Username of the person who deleted the record'
    )
    creationDate = Column(DateTime, nullable=False, comment='Date and time of creation of the record')
    createdBy = Column(
        String(128), nullable=False, server_default=text("''"), comment='Username of the person who created the record'
    )
    lastUpdated = Column(
        TIMESTAMP,
        nullable=False,
        server_default=text('current_timestamp() ON UPDATE current_timestamp()'),
        comment='Date and time of last update of the record',
    )
    updatedBy = Column(
        String(128),
        nullable=False,
        server_default=text("''"),
        index=True,
        comment='Username of the person who updated the record',
    )


class Audit(Base):
    __tablename__ = 'audit'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key. Auto-increment.')
    module = Column(String(128), nullable=False, comment='Name of the module the user accessed')
    method = Column(String(128), nullable=False, comment='Name of the method in the module the user activated')
    argument = Column(LONGTEXT, nullable=False, comment='Arguments (if any) passed to the method called.')
    access = Column(String(16), nullable=False, comment='If the access to the user was GRANTED or DENIED')
    ipAddress = Column(String(64), nullable=False, comment='IP address of the user')
    creationDate = Column(DateTime, nullable=False, comment='Date of the user request')
    createdBy = Column(String(128), nullable=False, comment='Username of the user who made the request')


class AuditSystem(Base):
    __tablename__ = 'auditSystem'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key. Auto-increment.')
    module = Column(String(128), nullable=False, comment='Name of the module the user accessed')
    method = Column(String(128), nullable=False, comment='Name of the method in the module the user activated')
    argument = Column(LONGTEXT, nullable=False, comment='Arguments (if any) passed to the method called.')
    access = Column(String(16), nullable=False, comment='If the access to the user was GRANTED or DENIED')
    ipAddress = Column(String(64), nullable=False, comment='IP address of the user')
    creationDate = Column(DateTime, nullable=False, comment='Date of the user request')
    createdBy = Column(String(128), nullable=False, comment='Username of the user who made the request')


class CategoryModule(Base):
    __tablename__ = 'categoryModule'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key. Auto-increment')
    name_EN = Column(String(128), nullable=False, comment='English name of the category')
    name_FR = Column(String(128), nullable=False, comment='French name of the category')
    order = Column(INTEGER(3), nullable=False, server_default=text('999'), comment='Order in the navigation menu')


class CronControlEducationalMaterial(Base):
    __tablename__ = 'cronControlEducationalMaterial'
    __table_args__ = {'comment': 'All Educational names to be changed to ReferenceMaterial when migrated to Django.'}

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key. Auto-increment.')
    cronControlEducationalMaterialControlSerNum = Column(
        INTEGER(11), nullable=False, index=True, comment='Foreign key with EducMatControlSerNum from EMC. Mandatory.'
    )
    publishFlag = Column(
        SMALLINT(6),
        nullable=False,
        index=True,
        server_default=text('0'),
        comment='Marker for data that has been published from opalAdmin.',
    )
    lastPublished = Column(
        DateTime, nullable=False, server_default=text("'2000-01-01 00:00:00'"), comment='Last publish date.'
    )
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    sessionId = Column(String(255), comment='SessionId of the user who last updated this field.')


class CronControlPatientEducationalMaterial(Base):
    __tablename__ = 'cronControlPatient_EducationalMaterial'
    __table_args__ = {'comment': 'All Educational names to be changed to ReferenceMaterial when migrated to Django.'}

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key. Auto-increment.')
    cronControlPatientSerNum = Column(
        INTEGER(11),
        nullable=False,
        index=True,
        comment='Foreign key with PatientSerNum from patient control. Mandatory.',
    )
    transferFlag = Column(
        SMALLINT(6),
        nullable=False,
        server_default=text('0'),
        comment='Marker for data that needs to be read on next cron.',
    )
    lastTransferred = Column(
        DateTime,
        nullable=False,
        server_default=text("'2000-01-01 00:00:00'"),
        comment='Last transfer date. Updated after any given cron job finishes.',
    )
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class CustomPushNotificationLog(Base):
    __tablename__ = 'customPushNotificationLog'

    customPushNotificationID = Column(BIGINT(20), primary_key=True)
    PatientSerNum = Column(BIGINT(20), nullable=False, index=True)
    PatientDeviceIdentifierSerNum = Column(BIGINT(20), nullable=False)
    SendStatus = Column(String(3), nullable=False)
    NotificationTitle = Column(String(100), nullable=False)
    NotificationMSG = Column(Text, nullable=False)
    DateAdded = Column(DateTime, nullable=False, index=True)


class Language(Base):
    __tablename__ = 'language'
    __table_args__ = {'comment': 'Table to store language list.'}

    Id = Column(BIGINT(20), primary_key=True)
    Prefix = Column(String(100), nullable=False)
    LanguageName_EN = Column(String(200), nullable=False)
    LanguageName_FR = Column(String(200), nullable=False)


class MasterSourceAlias(Base):
    __tablename__ = 'masterSourceAlias'
    __table_args__ = (
        Index('f_externalId_code_source_type', 'externalId', 'code', 'source', 'type', unique=True),
        {'comment': 'Imported list of all the aliases from different sources'},
    )

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key')
    externalId = Column(
        String(512), nullable=False, server_default=text("'-1'"), comment='External ID from the other database'
    )
    code = Column(String(128), nullable=False, comment='Code of the alias source')
    description = Column(String(128), nullable=False, comment='Expression of the alias source')
    type = Column(
        INTEGER(3),
        nullable=False,
        server_default=text('-1'),
        comment='-1 = no type, 1 = Task, 2 = Appointment, 3 = Document',
    )
    source = Column(
        INTEGER(3), nullable=False, server_default=text('-1'), comment='-1 = no source type, 1 = Aria, 2 = Medivisit'
    )
    deleted = Column(INTEGER(1), nullable=False, server_default=text('0'), comment='has the data being deleted or not')
    deletedBy = Column(
        String(255),
        nullable=False,
        server_default=text("''"),
        comment='username of who marked the record to be deleted',
    )
    creationDate = Column(DateTime, nullable=False, comment='Date of creation of the record')
    createdBy = Column(
        String(255), nullable=False, server_default=text("''"), comment='username of who created the record'
    )
    lastUpdated = Column(
        TIMESTAMP,
        nullable=False,
        server_default=text('current_timestamp() ON UPDATE current_timestamp()'),
        comment='Last time the record was updated',
    )
    updatedBy = Column(
        String(255), nullable=False, server_default=text("''"), comment='username of who updated the record'
    )


class MasterSourceDiagnosis(Base):
    __tablename__ = 'masterSourceDiagnosis'
    __table_args__ = (
        Index('masterSourceDiagnosisKey', 'externalId', 'code', 'source', unique=True),
        {'comment': 'Imported list of all the diagnosis from different sources'},
    )

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key')
    externalId = Column(
        String(512), nullable=False, server_default=text("'-1'"), comment='External ID from the other database'
    )
    code = Column(String(256), nullable=False, comment='Diagnosis Code')
    description = Column(String(256), nullable=False, comment='Description of the diagnostic')
    source = Column(INTEGER(3), nullable=False, server_default=text('-1'), comment='-1 = no source type, 1 = Aria')
    deleted = Column(INTEGER(1), nullable=False, server_default=text('0'), comment='has the data being deleted or not')
    deletedBy = Column(
        String(255),
        nullable=False,
        server_default=text("''"),
        comment='username of who marked the record to be deleted',
    )
    creationDate = Column(DateTime, nullable=False, comment='Date of creation of the record')
    createdBy = Column(
        String(255), nullable=False, server_default=text("''"), comment='username of who created the record'
    )
    lastUpdated = Column(
        TIMESTAMP,
        nullable=False,
        server_default=text('current_timestamp() ON UPDATE current_timestamp()'),
        comment='Last time the record was updated',
    )
    updatedBy = Column(
        String(255), nullable=False, server_default=text("''"), comment='username of who updated the record'
    )


class OaRole(Base):
    __tablename__ = 'oaRole'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key. Auto-increment')
    name_EN = Column(String(64), nullable=False, comment='English name of the role')
    name_FR = Column(String(64), nullable=False, comment='French name of the role')
    deleted = Column(INTEGER(1), nullable=False, server_default=text('0'), comment='has the data being deleted or not')
    deletedBy = Column(
        String(255),
        nullable=False,
        server_default=text("''"),
        comment='username of who marked the record to be deleted',
    )
    creationDate = Column(DateTime, nullable=False, comment='Date of creation of the record')
    createdBy = Column(
        String(255), nullable=False, server_default=text("''"), comment='username of who created the record'
    )
    lastUpdated = Column(
        TIMESTAMP,
        nullable=False,
        server_default=text('current_timestamp() ON UPDATE current_timestamp()'),
        comment='Last time the record was updated',
    )
    updatedBy = Column(
        String(255), nullable=False, server_default=text("''"), comment='username of who updated the record'
    )


class PatientStudyMH(Base):
    __tablename__ = 'patientStudyMH'

    patientStudyId = Column(BIGINT(20), primary_key=True, nullable=False)
    revisionId = Column(INTEGER(11), primary_key=True, nullable=False, index=True, autoincrement=True)
    action = Column(String(128), nullable=False)
    patientId = Column(INTEGER(11), nullable=False, index=True)
    studyId = Column(BIGINT(20), nullable=False, index=True)
    consentStatus = Column(INTEGER(11), nullable=False)
    readStatus = Column(INTEGER(11), nullable=False)
    lastUpdated = Column(
        TIMESTAMP, nullable=False, index=True, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class PublicationSetting(Base):
    __tablename__ = 'publicationSetting'
    __table_args__ = {'comment': 'This table list all the different settings a publication can have.'}

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key')
    name_EN = Column(String(512), nullable=False, comment='English name of the setting')
    name_FR = Column(String(512), nullable=False, comment='French name of the setting')
    internalName = Column(
        String(512),
        nullable=False,
        comment='Name of the field for the triggers when processing the data on the backend and frontend',
    )
    isTrigger = Column(
        TINYINT(1),
        nullable=False,
        server_default=text('0'),
        comment='Is the setting a trigger (1) or something else (0)',
    )
    isUnique = Column(
        TINYINT(1),
        nullable=False,
        server_default=text('0'),
        comment='Is the setting can have only one unique value (1) or not (0)',
    )
    selectAll = Column(
        TINYINT(1),
        nullable=False,
        server_default=text('0'),
        comment='Can the setting (mostly a trigger) has an "All" (1) value or not (0)',
    )
    opalDB = Column(
        MEDIUMTEXT,
        nullable=False,
        comment='SQL or table name from the OpalDB to get or insert the data. Note: if the ariaDB field is filled, it must be run before this one.',
    )
    opalPK = Column(String(512), nullable=False, comment='Primary key used for the OpalDB field')
    custom = Column(
        MEDIUMTEXT,
        nullable=False,
        comment='This field contains JSON format data for custom settings (like for age and sex for example)',
    )


class ResourcePending(Base):
    __tablename__ = 'resourcePending'
    __table_args__ = (Index('sourceAppointment', 'sourceName', 'appointmentId', unique=True),)

    ID = Column(BIGINT(20), primary_key=True)
    sourceName = Column(String(128), nullable=False)
    appointmentId = Column(String(100), nullable=False)
    resources = Column(MEDIUMTEXT, nullable=False)
    level = Column(TINYINT(4), nullable=False, server_default=text('1'))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    updatedBy = Column(String(255), nullable=False)


class ResourcePendingError(Base):
    __tablename__ = 'resourcePendingError'

    ID = Column(BIGINT(20), primary_key=True)
    sourceName = Column(String(128), nullable=False)
    appointmentId = Column(String(100), nullable=False)
    resources = Column(MEDIUMTEXT, nullable=False)
    level = Column(TINYINT(4), nullable=False, server_default=text('1'))
    error = Column(MEDIUMTEXT, nullable=False)
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    updatedBy = Column(String(255), nullable=False)


class ResourcePendingMH(Base):
    __tablename__ = 'resourcePendingMH'

    resourcePendingId = Column(BIGINT(20), primary_key=True, nullable=False)
    revisionId = Column(INTEGER(11), primary_key=True, nullable=False, autoincrement=True, index=True)
    action = Column(String(128), nullable=False)
    sourceName = Column(String(128), nullable=False)
    appointmentId = Column(String(100), nullable=False)
    resources = Column(MEDIUMTEXT, nullable=False)
    level = Column(TINYINT(4), nullable=False, server_default=text('1'))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False)
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    updatedBy = Column(String(255), nullable=False, index=True)


class Termsandagreement(Base):
    __tablename__ = 'termsandagreement'
    __table_args__ = {
        'comment': 'Table to store terms and agreement document link(In En & Fr) with version of the document and created and last modified dates.'
    }

    Id = Column(BIGINT(20), primary_key=True)
    DocumentLink_EN = Column(String(2000), nullable=False)
    DocumentLink_FR = Column(String(2000), nullable=False)
    PDFLink_EN = Column(MEDIUMTEXT, nullable=False)
    PDFLink_FR = Column(MEDIUMTEXT, nullable=False)
    Version = Column(String(10000), nullable=False)
    Active = Column(TINYINT(4), nullable=False)
    CreateDate = Column(TIMESTAMP)
    LastModifyDate = Column(TIMESTAMP, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))


class AppointmentPending(Base):
    __tablename__ = 'AppointmentPending'
    __table_args__ = (Index('UniqueAppointment', 'sourceName', 'SourceSystemID', unique=True),)

    ID = Column(BIGINT(20), primary_key=True)
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    sourceName = Column(String(255), nullable=False, index=True)
    appointmentTypeCode = Column(String(250), nullable=False, comment='Appointment Type Code')
    appointmentTypeDescription = Column(String(250), nullable=False, comment='Appointment Type Description')
    SourceSystemID = Column(String(100), nullable=False, index=True)
    PrioritySerNum = Column(INTEGER(11), nullable=False, index=True)
    DiagnosisSerNum = Column(INTEGER(11), nullable=False, index=True)
    Status = Column(String(100), nullable=False)
    State = Column(String(25), nullable=False)
    ScheduledStartTime = Column(DateTime, nullable=False)
    ScheduledEndTime = Column(DateTime, nullable=False)
    ActualStartDate = Column(DateTime, nullable=False)
    ActualEndDate = Column(DateTime, nullable=False)
    Location = Column(INTEGER(10), nullable=False, server_default=text('10'))
    RoomLocation_EN = Column(String(100), nullable=False)
    RoomLocation_FR = Column(String(100), nullable=False)
    Checkin = Column(TINYINT(4), nullable=False)
    ChangeRequest = Column(TINYINT(4), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    DateModified = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False)
    Level = Column(TINYINT(4), nullable=False, server_default=text('1'))
    SessionId = Column(Text, nullable=False)
    updatedBy = Column(String(255), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    Patient = relationship('Patient')


class AppointmentPendingMH(Base):
    __tablename__ = 'AppointmentPendingMH'
    __table_args__ = (Index('UniqueAppointment', 'sourceName', 'SourceSystemID'),)

    AppointmentPendingId = Column(BIGINT(20), primary_key=True, nullable=False, server_default=text('0'))
    revisionId = Column(BIGINT(20), primary_key=True, nullable=False, index=True, autoincrement=True)
    action = Column(String(128))
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    sourceName = Column(String(128), nullable=False, index=True)
    appointmentTypeCode = Column(String(250), nullable=False, comment='Appointment Type Code')
    appointmentTypeDescription = Column(String(250), nullable=False, comment='Appointment Type Description')
    SourceSystemID = Column(String(100), nullable=False, index=True)
    PrioritySerNum = Column(INTEGER(11), nullable=False, index=True)
    DiagnosisSerNum = Column(INTEGER(11), nullable=False, index=True)
    Status = Column(String(100), nullable=False)
    State = Column(String(25), nullable=False)
    ScheduledStartTime = Column(DateTime, nullable=False)
    ScheduledEndTime = Column(DateTime, nullable=False)
    ActualStartDate = Column(DateTime, nullable=False)
    ActualEndDate = Column(DateTime, nullable=False)
    Location = Column(INTEGER(10), nullable=False, server_default=text('10'))
    RoomLocation_EN = Column(String(100), nullable=False)
    RoomLocation_FR = Column(String(100), nullable=False)
    Checkin = Column(TINYINT(4), nullable=False)
    Level = Column(TINYINT(4))
    ChangeRequest = Column(TINYINT(4), nullable=False)
    PendingDate = Column(DateTime, nullable=False)
    ProcessedDate = Column(DateTime, nullable=False, server_default=text("'0000-00-00 00:00:00'"))
    ReadStatus = Column(INTEGER(11), nullable=False)
    SessionId = Column(Text, nullable=False)
    updatedBy = Column(String(255), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    Patient = relationship('Patient')


class CronLog(Base):
    __tablename__ = 'CronLog'

    CronLogSerNum = Column(INTEGER(11), primary_key=True)
    CronSerNum: Mapped[int] = mapped_column(
        ForeignKey('Cron.CronSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    CronStatus = Column(String(25), nullable=False)
    CronDateTime = Column(DateTime, nullable=False)

    Cron = relationship('Cron')


class Diagnosis(Base):
    __tablename__ = 'Diagnosis'

    DiagnosisSerNum = Column(INTEGER(11), primary_key=True, index=True)
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True)
    DiagnosisAriaSer = Column(String(32), nullable=False, index=True)
    DiagnosisCode = Column(String(50), nullable=False, index=True)
    Description_EN = Column(String(200), nullable=False)
    Description_FR = Column(String(255), nullable=False)
    Stage = Column(String(32))
    StageCriteria = Column(String(32))
    CreationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(128), nullable=False, server_default=text("'CronJob'"))
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    updatedBy = Column(String(128), nullable=False, server_default=text("'CronJob'"))

    Patient = relationship('Patient')


class EducationalMaterialControl(Base):
    __tablename__ = 'EducationalMaterialControl'
    __table_args__ = {'comment': 'All Educational names to be changed to ReferenceMaterial when migrated to Django.'}

    EducationalMaterialControlSerNum = Column(INTEGER(11), primary_key=True, index=True)
    EducationalMaterialType_EN = Column(String(100), nullable=False)
    EducationalMaterialType_FR = Column(String(100), nullable=False)
    EducationalMaterialCategoryId: Mapped[int] = mapped_column(
        ForeignKey('EducationalMaterialCategory.ID'),
        nullable=False,
        index=True,
        server_default=text('1'),
        comment='Foreign key with ID in EducationalMaterialCategory table. Category refers to the purpose of the Educational Material.',
    )
    PublishFlag = Column(INTEGER(11), nullable=False, index=True, server_default=text('0'))
    Name_EN = Column(String(200), nullable=False)
    Name_FR = Column(VARCHAR(200), nullable=False)
    URL_EN = Column(String(2000))
    URL_FR = Column(String(2000))
    URLType_EN = Column(String(100))
    URLType_FR = Column(String(100))
    ShareURL_EN = Column(String(2000))
    ShareURL_FR = Column(String(2000))
    PhaseInTreatmentSerNum = Column(INTEGER(11), index=True)
    ParentFlag = Column(INTEGER(11), nullable=False, server_default=text('1'))
    DateAdded = Column(DateTime, nullable=False)
    LastUpdatedBy = Column(INTEGER(11))
    LastPublished = Column(DateTime, nullable=False, server_default=text("'2002-01-01 00:00:00'"))
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    deleted = Column(TINYINT(1), nullable=False, server_default=text('0'))
    SessionId = Column(String(255))

    EducationalMaterialCategory = relationship('EducationalMaterialCategory')


class Feedback(Base):
    __tablename__ = 'Feedback'

    FeedbackSerNum = Column(INTEGER(11), primary_key=True)
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', ondelete='CASCADE', onupdate='CASCADE'), nullable=False, index=True
    )
    FeedbackContent = Column(String(255))
    AppRating = Column(TINYINT(4), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    SessionId = Column(Text, nullable=False, server_default=text("''"), comment='Deprecated')
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    Patient = relationship('Patient')


class OAUser(Base):
    __tablename__ = 'OAUser'

    OAUserSerNum = Column(INTEGER(11), primary_key=True)
    Username = Column(String(1000), nullable=False, unique=True)
    Password = Column(String(1000), nullable=False)
    oaRoleId: Mapped[int] = mapped_column(
        ForeignKey('oaRole.ID'), nullable=False, index=True, server_default=text('1'), comment='Role of the user'
    )
    type = Column(
        TINYINT(1),
        nullable=False,
        server_default=text('1'),
        comment="Type of user. 1 = 'human' user. 2 = 'system' user",
    )
    Language: Mapped[Enum] = mapped_column(Enum('EN', 'FR'), nullable=False, server_default=text("'EN'"))
    deleted = Column(TINYINT(1), nullable=False, server_default=text('0'))
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    oaRole = relationship('OaRole')


class PatientActionLog(Base):
    __tablename__ = 'PatientActionLog'
    __table_args__ = {'comment': 'Log of the actions a user takes in the app (clicking, scrolling to bottom, etc.)'}

    PatientActionLogSerNum = Column(BIGINT(11), primary_key=True)
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    Action = Column(String(125), nullable=False, server_default=text("''"), comment='Action the user took.')
    RefTable = Column(
        String(125),
        nullable=False,
        index=True,
        server_default=text("''"),
        comment='Table containing the item that was acted upon.',
    )
    RefTableSerNum = Column(INTEGER(11), nullable=False, comment='SerNum identifying the item in RefTable.')
    ActionTime = Column(
        TIMESTAMP,
        nullable=False,
        index=True,
        server_default=text('current_timestamp()'),
        comment='Timestamp when the user took the action.',
    )

    Patient = relationship('Patient')


class PatientDoctor(Base):
    __tablename__ = 'PatientDoctor'

    PatientDoctorSerNum = Column(INTEGER(11), primary_key=True)
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    DoctorSerNum: Mapped[int] = mapped_column(
        ForeignKey('Doctor.DoctorSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    OncologistFlag = Column(INTEGER(11), nullable=False, index=True)
    PrimaryFlag = Column(INTEGER(11), nullable=False, index=True)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    Doctor = relationship('Doctor')
    Patient = relationship('Patient')


class PatientHospitalIdentifier(Base):
    __tablename__ = 'Patient_Hospital_Identifier'
    __table_args__ = (
        Index('IX_PatientHospitalIdentifier', 'PatientSerNum', 'Hospital_Identifier_Type_Code', 'MRN', unique=True),
    )

    Patient_Hospital_Identifier_Id = Column(INTEGER(11), primary_key=True)
    PatientSerNum: Mapped[int] = mapped_column(ForeignKey('Patient.PatientSerNum'), nullable=False, index=True)
    Hospital_Identifier_Type_Code: Mapped[int] = mapped_column(
        ForeignKey('Hospital_Identifier_Type.Code'), nullable=False, index=True
    )
    MRN = Column(String(20), nullable=False, index=True)
    Is_Active = Column(TINYINT(1), nullable=False, server_default=text('1'))

    Hospital_Identifier_Type = relationship('HospitalIdentifierType')
    Patient = relationship('Patient')


class QuestionnaireDBPurpose(Base):
    __tablename__ = 'purpose'
    __table_args__ = {'schema': 'QuestionnaireDB'}

    ID = Column(BIGINT(20), primary_key=True)
    title: Mapped[int] = mapped_column(ForeignKey('QuestionnaireDB.dictionary.contentId'), nullable=False, index=True)
    description: Mapped[int] = mapped_column(
        ForeignKey('QuestionnaireDB.dictionary.contentId'), nullable=False, index=True
    )

    dictionary = relationship('Dictionary', primaryjoin='Purpose.description == Dictionary.contentId')
    dictionary1 = relationship('Dictionary', primaryjoin='Purpose.title == Dictionary.contentId')


class QuestionnaireDBRespondent(Base):
    __tablename__ = 'respondent'
    __table_args__ = {'schema': 'QuestionnaireDB'}

    ID = Column(BIGINT(20), primary_key=True)
    title: Mapped[int] = mapped_column(ForeignKey('QuestionnaireDB.dictionary.contentId'), nullable=False, index=True)
    description: Mapped[int] = mapped_column(
        ForeignKey('QuestionnaireDB.dictionary.contentId'), nullable=False, index=True
    )

    dictionary = relationship('Dictionary', primaryjoin='Respondent.description == Dictionary.contentId')
    dictionary1 = relationship('Dictionary', primaryjoin='Respondent.title == Dictionary.contentId')


class SecurityAnswer(Base):
    __tablename__ = 'SecurityAnswer'
    __table_args__ = (Index('SecurityQuestionSerNum', 'SecurityQuestionSerNum', 'PatientSerNum', unique=True),)

    SecurityAnswerSerNum = Column(INTEGER(11), primary_key=True)
    SecurityQuestionSerNum: Mapped[int] = mapped_column(
        ForeignKey('SecurityQuestion.SecurityQuestionSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', ondelete='CASCADE', onupdate='CASCADE'), nullable=False, index=True
    )
    AnswerText = Column(String(2056), nullable=False)
    CreationDate = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    Patient = relationship('Patient')
    SecurityQuestion = relationship('SecurityQuestion')


class StatusAlias(Base):
    __tablename__ = 'StatusAlias'

    StatusAliasSerNum = Column(INTEGER(11), primary_key=True)
    SourceDatabaseSerNum: Mapped[int] = mapped_column(
        ForeignKey('SourceDatabase.SourceDatabaseSerNum', ondelete='CASCADE', onupdate='CASCADE'),
        nullable=False,
        index=True,
    )
    Name = Column(String(30), nullable=False)
    Expression = Column(String(45), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    SourceDatabase = relationship('SourceDatabase')


class Module(Base):
    __tablename__ = 'module'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary Key')
    operation = Column(
        TINYINT(1),
        nullable=False,
        server_default=text('7'),
        comment='List of available operations for the module (R/W/D)',
    )
    name_EN = Column(String(512), nullable=False, comment='English name of the module')
    name_FR = Column(String(512), nullable=False, comment='French name of the module')
    description_EN = Column(String(512), nullable=False, comment='English description of the module')
    description_FR = Column(String(512), nullable=False, comment='French description of the module')
    tableName = Column(String(256), nullable=False, comment='Table name of the module in the DB')
    controlTableName = Column(
        String(256), nullable=False, comment='Table name for the control table field in the Filters table'
    )
    primaryKey = Column(String(256), nullable=False, comment='Primary key of the table name')
    iconClass = Column(String(512), nullable=False, comment='Icon classes for html display')
    url = Column(String(255), nullable=False, comment='URL of the module. Used to generate the nav menus.')
    subModule = Column(LONGTEXT, comment='Contains all the submodule info in a JSON format')
    subModuleMenu = Column(
        TINYINT(1),
        nullable=False,
        server_default=text('0'),
        comment='If the module has submodules, can these being displayed in a navigation menu',
    )
    core = Column(
        TINYINT(1),
        nullable=False,
        server_default=text('0'),
        comment='An essential module that can never being deactivated',
    )
    active = Column(
        TINYINT(1), nullable=False, server_default=text('0'), comment='Is the module active or not in opalAdmin'
    )
    categoryModuleId: Mapped[int] = mapped_column(
        ForeignKey('categoryModule.ID'), nullable=True, index=True, comment='Attach the module to a specific category'
    )
    publication = Column(
        TINYINT(1),
        nullable=False,
        server_default=text('0'),
        comment='Is the module is linked to the publication module',
    )
    customCode = Column(
        TINYINT(1), nullable=False, server_default=text('0'), comment='Is the module allows custom codes'
    )
    unique = Column(
        TINYINT(1),
        nullable=False,
        server_default=text('1'),
        comment='To determine if an entry of the specified module can be published multiple times or not',
    )
    order = Column(
        INTEGER(3), nullable=False, server_default=text('999'), comment='Order to display the list of modules'
    )
    sqlPublicationList = Column(
        LONGTEXT, nullable=False, comment='SQL query to list the publications associated to the module'
    )
    sqlDetails = Column(LONGTEXT, nullable=False, comment='SQL query to list the details of a publication')
    sqlPublicationChartLog = Column(
        LONGTEXT, nullable=False, comment='SQL query to list the chart log publications associated to the module'
    )
    sqlPublicationListLog = Column(
        LONGTEXT, nullable=False, comment='SQL query to list the detailed logs publications associated to the module'
    )
    sqlPublicationMultiple = Column(
        LONGTEXT, nullable=False, comment='When publication is not unique. use this field to list available publication'
    )
    sqlPublicationUnique = Column(
        LONGTEXT, nullable=False, comment='When publication is unique. use this field to list available publication'
    )

    categoryModule = relationship('CategoryModule')


class DiagnosisTranslation(Base):
    __tablename__ = 'DiagnosisTranslation'

    DiagnosisTranslationSerNum = Column(INTEGER(11), primary_key=True)
    AliasName = Column(String(100), nullable=False, server_default=text("''"))
    EducationalMaterialControlSerNum: Mapped[int] = mapped_column(
        ForeignKey(
            'EducationalMaterialControl.EducationalMaterialControlSerNum', ondelete='SET NULL', onupdate='CASCADE'
        ),
        nullable=True,
        index=True,
        comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
    )
    Name_EN = Column(String(2056), nullable=False)
    Name_FR = Column(String(2056), nullable=False)
    Description_EN = Column(String(2056), nullable=False)
    Description_FR = Column(String(2056), nullable=False)
    DiagnosisCode = Column(String(100), nullable=False, index=True)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdatedBy: Mapped[int] = mapped_column(
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    SessionId = Column(String(255))

    EducationalMaterialControl = relationship('EducationalMaterialControl')
    OAUser = relationship('OAUser')


class EducationalMaterial(Base):
    __tablename__ = 'EducationalMaterial'
    __table_args__ = {'comment': 'All Educational names to be changed to ReferenceMaterial when migrated to Django.'}

    EducationalMaterialSerNum = Column(INTEGER(11), primary_key=True)
    CronLogSerNum: Mapped[int] = mapped_column(
        ForeignKey('CronLog.CronLogSerNum', onupdate='CASCADE'), nullable=True, index=True
    )
    EducationalMaterialControlSerNum: Mapped[int] = mapped_column(
        ForeignKey('EducationalMaterialControl.EducationalMaterialControlSerNum', onupdate='CASCADE'),
        nullable=False,
        index=True,
    )
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False, comment='Deprecated')
    ReadBy = Column(LONGTEXT, nullable=False, server_default=text("'[]'"))
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    CronLog = relationship('CronLog')
    EducationalMaterialControl = relationship('EducationalMaterialControl')
    Patient = relationship('Patient')


class EmailControl(Base):
    __tablename__ = 'EmailControl'

    EmailControlSerNum = Column(INTEGER(11), primary_key=True)
    Subject_EN = Column(String(100), nullable=False)
    Subject_FR = Column(String(100), nullable=False)
    Body_EN = Column(Text, nullable=False)
    Body_FR = Column(Text, nullable=False)
    EmailTypeSerNum: Mapped[int] = mapped_column(
        ForeignKey('EmailType.EmailTypeSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    DateAdded = Column(DateTime, nullable=False)
    LastUpdatedBy: Mapped[int] = mapped_column(
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    SessionId = Column(String(255))

    EmailType = relationship('EmailType')
    OAUser = relationship('OAUser')


class HospitalMap(Base):
    __tablename__ = 'HospitalMap'

    HospitalMapSerNum = Column(INTEGER(11), primary_key=True, index=True)
    MapUrl = Column(String(255))
    MapURL_EN = Column(String(512))
    MapURL_FR = Column(String(512))
    QRMapAlias = Column(String(255))
    MapName_EN = Column(String(255))
    MapDescription_EN = Column(String(255))
    MapName_FR = Column(String(255))
    MapDescription_FR = Column(String(255))
    DateAdded = Column(DateTime, nullable=False)
    LastUpdatedBy: Mapped[int] = mapped_column(
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    SessionId = Column(String(255))

    OAUser = relationship('OAUser')


class NotificationControl(Base):
    __tablename__ = 'NotificationControl'

    NotificationControlSerNum = Column(INTEGER(11), primary_key=True)
    Name_EN = Column(String(100), nullable=False)
    Name_FR = Column(String(100), nullable=False)
    Description_EN = Column(Text, nullable=False)
    Description_FR = Column(Text, nullable=False)
    NotificationType = Column(String(100), nullable=False)
    NotificationTypeSerNum: Mapped[int] = mapped_column(
        ForeignKey('NotificationTypes.NotificationTypeSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    DateAdded = Column(DateTime, nullable=False)
    LastUpdatedBy: Mapped[int] = mapped_column(
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    LastPublished = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    SessionId = Column(String(255))

    OAUser = relationship('OAUser')
    NotificationType1 = relationship('NotificationType')


class PatientDeviceIdentifier(Base):
    __tablename__ = 'PatientDeviceIdentifier'
    __table_args__ = (
        Index('ix_PatientDeviceIdentifier_Unique_Username_DeviceId', 'Username', 'DeviceId', unique=True),
    )

    PatientDeviceIdentifierSerNum = Column(INTEGER(11), primary_key=True)
    PatientSerNum = Column(INTEGER(11), nullable=False, server_default=text('0'), index=True, comment='Deprecated')
    Username = Column(String(255), nullable=False, server_default=text("''"))
    DeviceId = Column(String(255), nullable=False)
    appVersion = Column(
        String(16), nullable=False, comment='Version of Opal App installed on patient device. Eg 1.10.9. Optional.'
    )
    RegistrationId = Column(String(256), nullable=False)
    DeviceType = Column(TINYINT(4), nullable=False, comment='0 = iOS, 1 = Android, 3 = browser')
    SessionId = Column(Text, nullable=False, server_default=text("''"), comment='Deprecated')
    SecurityAnswerSerNum = Column(INTEGER(11), nullable=True, index=True)
    SecurityAnswer = Column(String(256), nullable=False, server_default=text("''"))
    Attempt = Column(INTEGER(11), nullable=False, server_default=text('0'))
    Trusted = Column(TINYINT(1), nullable=False, server_default=text('0'))
    TimeoutTimestamp = Column(TIMESTAMP)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )


class PostControl(Base):
    __tablename__ = 'PostControl'

    PostControlSerNum = Column(INTEGER(11), primary_key=True, index=True)
    PostType = Column(String(100), nullable=False, index=True)
    PublishFlag = Column(INTEGER(11), nullable=False, index=True, server_default=text('0'))
    PostName_FR = Column(String(100), nullable=False)
    PostName_EN = Column(String(100), nullable=False)
    Body_FR = Column(Text, nullable=False)
    Body_EN = Column(Text, nullable=False)
    PublishDate = Column(DateTime)
    Disabled = Column(TINYINT(1), nullable=False, server_default=text('0'))
    DateAdded = Column(DateTime, nullable=False)
    LastPublished = Column(DateTime, nullable=False, server_default=text("'2002-01-01 00:00:00'"))
    LastUpdatedBy: Mapped[int] = mapped_column(
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    deleted = Column(TINYINT(1), nullable=False, server_default=text('0'))
    SessionId = Column(String(255))

    OAUser = relationship('OAUser')


class QuestionnaireControl(Base):
    __tablename__ = 'QuestionnaireControl'

    QuestionnaireControlSerNum = Column(INTEGER(11), primary_key=True, index=True)
    QuestionnaireDBSerNum = Column(INTEGER(11), nullable=False, index=True)
    QuestionnaireName_EN = Column(String(2056), nullable=False)
    QuestionnaireName_FR = Column(String(2056), nullable=False)
    Intro_EN = Column(Text, nullable=False)
    Intro_FR = Column(Text, nullable=False)
    PublishFlag = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    DateAdded = Column(DateTime, nullable=False)
    LastPublished = Column(DateTime)
    LastUpdatedBy: Mapped[int] = mapped_column(
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    SessionId = Column(String(255))

    OAUser = relationship('OAUser')


class QuestionnaireDBQuestionnaire(Base):
    __tablename__ = 'questionnaire'
    __table_args__ = {'schema': 'QuestionnaireDB'}

    ID = Column(BIGINT(20), primary_key=True)
    OAUserId = Column(BIGINT(20), nullable=False, index=True, server_default=text('-1'))
    purposeId: Mapped[int] = mapped_column(
        ForeignKey('QuestionnaireDB.purpose.ID'), nullable=False, index=True, server_default=text('1')
    )
    respondentId: Mapped[int] = mapped_column(
        ForeignKey('QuestionnaireDB.respondent.ID'), nullable=False, index=True, server_default=text('1')
    )
    title: Mapped[int] = mapped_column(ForeignKey('QuestionnaireDB.dictionary.contentId'), nullable=False, index=True)
    nickname: Mapped[int] = mapped_column(
        ForeignKey('QuestionnaireDB.dictionary.contentId'), nullable=False, index=True
    )
    category = Column(INTEGER(11), nullable=False, server_default=text('-1'))
    description: Mapped[int] = mapped_column(
        ForeignKey('QuestionnaireDB.dictionary.contentId'), nullable=False, index=True
    )
    instruction: Mapped[int] = mapped_column(
        ForeignKey('QuestionnaireDB.dictionary.contentId'), nullable=False, index=True
    )
    final = Column(TINYINT(4), nullable=False, server_default=text('0'))
    version = Column(INTEGER(11), nullable=False, server_default=text('1'))
    parentId = Column(BIGINT(20), nullable=False, index=True, server_default=text('-1'))
    private = Column(TINYINT(4), nullable=False, server_default=text('0'))
    optionalFeedback = Column(TINYINT(4), nullable=False, server_default=text('1'))
    visualization = Column(
        TINYINT(4), nullable=False, server_default=text('0'), comment='0 = regular view of the answers, 1 = graph'
    )
    logo = Column(String(512), nullable=False)
    deleted = Column(TINYINT(4), nullable=False, index=True, server_default=text('0'))
    deletedBy = Column(String(255), nullable=False, server_default=text("''"))
    creationDate = Column(DateTime, nullable=False)
    createdBy = Column(String(255), nullable=False, server_default=text("''"))
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    updatedBy = Column(String(255), nullable=False, server_default=text("''"))
    legacyName = Column(
        String(255),
        nullable=False,
        comment='This field is mandatory to make the app works during the migration process. This field must be removed once the migration of the legacy questionnaire will be done, the triggers stopped and the app changed to use the correct standards.',
    )

    dictionary = relationship('Dictionary', primaryjoin='Questionnaire.description == Dictionary.contentId')
    dictionary1 = relationship('Dictionary', primaryjoin='Questionnaire.instruction == Dictionary.contentId')
    dictionary2 = relationship('Dictionary', primaryjoin='Questionnaire.nickname == Dictionary.contentId')
    purpose = relationship('Purpose')
    respondent = relationship('Respondent')
    dictionary3 = relationship('Dictionary', primaryjoin='Questionnaire.title == Dictionary.contentId')


class TestControl(Base):
    __tablename__ = 'TestControl'

    TestControlSerNum = Column(INTEGER(11), primary_key=True)
    Name_EN = Column(String(200), nullable=False)
    Name_FR = Column(String(200), nullable=False)
    Description_EN = Column(Text, nullable=False)
    Description_FR = Column(Text, nullable=False)
    Group_EN = Column(String(200), nullable=False)
    Group_FR = Column(String(200), nullable=False)
    SourceDatabaseSerNum: Mapped[int] = mapped_column(
        ForeignKey('SourceDatabase.SourceDatabaseSerNum', onupdate='CASCADE'),
        nullable=False,
        index=True,
        server_default=text('1'),
    )
    EducationalMaterialControlSerNum: Mapped[int] = mapped_column(
        ForeignKey(
            'EducationalMaterialControl.EducationalMaterialControlSerNum', ondelete='SET NULL', onupdate='CASCADE'
        ),
        nullable=True,
        index=True,
        comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
    )
    InterpretationRecommended = Column(
        Boolean, nullable=False, server_default=text('0'), comment='Clinician interpretation recommended.'
    )
    PublishFlag = Column(INTEGER(11), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastPublished = Column(DateTime, nullable=False, server_default=text("'2002-01-01 00:00:00'"))
    LastUpdatedBy: Mapped[int] = mapped_column(
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    URL_EN = Column(String(2000), nullable=False, server_default=text("''"))
    URL_FR = Column(String(2000), nullable=False, server_default=text("''"))
    SessionId = Column(String(255))

    EducationalMaterialControl = relationship('EducationalMaterialControl')
    OAUser = relationship('OAUser')
    SourceDatabase = relationship('SourceDatabase')


class TestExpression(Base):
    __tablename__ = 'TestExpression'
    __table_args__ = (Index('TestCode', 'TestCode', 'SourceDatabaseSerNum', unique=True),)

    TestExpressionSerNum = Column(INTEGER(11), primary_key=True)
    TestControlSerNum = Column(INTEGER(11), index=True)
    TestCode = Column(String(30), nullable=False, server_default=text("''"))
    ExpressionName = Column(String(100), nullable=False)
    DateAdded = Column(DateTime, nullable=False, server_default=text('current_timestamp()'))
    LastPublished = Column(DateTime)
    LastUpdatedBy: Mapped[int] = mapped_column(
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    SourceDatabaseSerNum: Mapped[int] = mapped_column(
        ForeignKey('SourceDatabase.SourceDatabaseSerNum', onupdate='CASCADE'),
        nullable=False,
        index=True,
        server_default=text('4'),
    )
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    SessionId = Column(String(255))
    externalId = Column(String(512), nullable=False, server_default=text("'-1'"))
    deleted = Column(INTEGER(1), nullable=False, server_default=text('0'))
    deletedBy = Column(String(255))
    createdBy = Column(String(255), nullable=False, server_default=text("'cronjob'"))
    updatedBy = Column(String(255), nullable=False, server_default=text("'cronjob'"))

    OAUser = relationship('OAUser')
    SourceDatabase = relationship('SourceDatabase')


class TestGroupExpression(Base):
    __tablename__ = 'TestGroupExpression'
    __table_args__ = (Index('TestCode', 'TestCode', 'SourceDatabaseSerNum', unique=True),)

    TestGroupExpressionSerNum = Column(INTEGER(11), primary_key=True)
    TestCode = Column(String(30), nullable=False)
    ExpressionName = Column(String(100), nullable=False)
    DateAdded = Column(DateTime, nullable=False, server_default=text('current_timestamp()'))
    LastPublished = Column(DateTime)
    LastUpdatedBy: Mapped[int] = mapped_column(
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    SourceDatabaseSerNum: Mapped[int] = mapped_column(
        ForeignKey('SourceDatabase.SourceDatabaseSerNum', onupdate='CASCADE'),
        nullable=False,
        index=True,
        server_default=text('4'),
    )
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    SessionId = Column(String(255))

    OAUser = relationship('OAUser')
    SourceDatabase = relationship('SourceDatabase')


class TestResult(Base):
    __tablename__ = 'TestResult'

    TestResultSerNum = Column(INTEGER(11), primary_key=True)
    CronLogSerNum: Mapped[int] = mapped_column(
        ForeignKey('CronLog.CronLogSerNum', onupdate='CASCADE'), nullable=True, index=True
    )
    TestResultGroupSerNum = Column(INTEGER(11), nullable=False, index=True)
    TestResultControlSerNum = Column(INTEGER(11), nullable=False, index=True)
    TestResultExpressionSerNum = Column(INTEGER(11), nullable=False, index=True)
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True)
    TestResultAriaSer = Column(String(100), nullable=False, index=True)
    ComponentName = Column(String(30), nullable=False)
    FacComponentName = Column(String(30), nullable=False)
    AbnormalFlag = Column(String(5), nullable=False)
    TestDate = Column(DateTime, nullable=False)
    MaxNorm = Column(Float, nullable=False)
    MinNorm = Column(Float, nullable=False)
    ApprovedFlag = Column(String(5), nullable=False)
    TestValue = Column(Float, nullable=False)
    TestValueString = Column(String(400), nullable=False)
    UnitDescription = Column(String(40), nullable=False)
    ValidEntry = Column(String(5), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    CronLog = relationship('CronLog')
    Patient = relationship('Patient')


class TestResultControl(Base):
    __tablename__ = 'TestResultControl'

    TestResultControlSerNum = Column(INTEGER(11), primary_key=True)
    Name_EN = Column(String(200), nullable=False)
    Name_FR = Column(String(200), nullable=False)
    Description_EN = Column(Text, nullable=False)
    Description_FR = Column(Text, nullable=False)
    Group_EN = Column(String(200), nullable=False)
    Group_FR = Column(String(200), nullable=False)
    SourceDatabaseSerNum: Mapped[int] = mapped_column(
        ForeignKey('SourceDatabase.SourceDatabaseSerNum', onupdate='CASCADE'),
        nullable=False,
        index=True,
        server_default=text('1'),
    )
    EducationalMaterialControlSerNum: Mapped[int] = mapped_column(
        ForeignKey(
            'EducationalMaterialControl.EducationalMaterialControlSerNum', ondelete='SET NULL', onupdate='CASCADE'
        ),
        nullable=True,
        index=True,
        comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
    )
    PublishFlag = Column(INTEGER(11), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastPublished = Column(DateTime, nullable=False, server_default=text("'2002-01-01 00:00:00'"))
    LastUpdatedBy: Mapped[int] = mapped_column(
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    URL_EN = Column(String(2000), nullable=False)
    URL_FR = Column(String(2000), nullable=False)
    SessionId = Column(String(255))

    EducationalMaterialControl = relationship('EducationalMaterialControl')
    OAUser = relationship('OAUser')
    SourceDatabase = relationship('SourceDatabase')


class CronControlPatient(Base):
    __tablename__ = 'cronControlPatient'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key. Auto-increment.')
    cronControlPatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('PatientControl.PatientSerNum'),
        nullable=False,
        index=True,
        comment='Foreign key with PatientSerNum from patient control. Mandatory.',
    )
    cronType = Column(
        String(100),
        nullable=False,
        index=True,
        comment='Field refers to what cron controller is using this transfer flag. eg TxTeamMessage, Document, Announcement, etc. Mandatory',
    )
    transferFlag = Column(
        SMALLINT(6),
        nullable=False,
        server_default=text('0'),
        comment='Marker for data that needs to be read on next cron.',
    )
    lastTransferred = Column(
        DateTime,
        nullable=False,
        server_default=text("'2000-01-01 00:00:00'"),
        comment='Last transfer date. Updated after any given cron job finishes.',
    )
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    PatientControl = relationship('PatientControl')


class CronControlPatientAnnouncement(Base):
    __tablename__ = 'cronControlPatient_Announcement'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key. Auto-increment.')
    cronControlPatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('PatientControl.PatientSerNum'),
        nullable=False,
        index=True,
        comment='Foreign key with PatientSerNum from patient control. Mandatory.',
    )
    transferFlag = Column(
        SMALLINT(6),
        nullable=False,
        server_default=text('0'),
        comment='Marker for data that needs to be read on next cron.',
    )
    lastTransferred = Column(
        DateTime,
        nullable=False,
        server_default=text("'2000-01-01 00:00:00'"),
        comment='Last transfer date. Updated after any given cron job finishes.',
    )
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    PatientControl = relationship('PatientControl')


class CronControlPatientLegacyQuestionnaire(Base):
    __tablename__ = 'cronControlPatient_LegacyQuestionnaire'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key. Auto-increment.')
    cronControlPatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('PatientControl.PatientSerNum'),
        nullable=False,
        index=True,
        comment='Foreign key with PatientSerNum from patient control. Mandatory.',
    )
    transferFlag = Column(
        SMALLINT(6),
        nullable=False,
        server_default=text('0'),
        comment='Marker for data that needs to be read on next cron.',
    )
    lastTransferred = Column(
        DateTime,
        nullable=False,
        server_default=text("'2000-01-01 00:00:00'"),
        comment='Last transfer date. Updated after any given cron job finishes.',
    )
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    PatientControl = relationship('PatientControl')


class CronControlPatientTreatmentTeamMessage(Base):
    __tablename__ = 'cronControlPatient_TreatmentTeamMessage'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key. Auto-increment.')
    cronControlPatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('PatientControl.PatientSerNum'),
        nullable=False,
        index=True,
        comment='Foreign key with PatientSerNum from patient control. Mandatory.',
    )
    transferFlag = Column(
        SMALLINT(6),
        nullable=False,
        server_default=text('0'),
        comment='Marker for data that needs to be read on next cron.',
    )
    lastTransferred = Column(
        DateTime,
        nullable=False,
        server_default=text("'2000-01-01 00:00:00'"),
        comment='Last transfer date. Updated after any given cron job finishes.',
    )
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    PatientControl = relationship('PatientControl')


class ModulePublicationSetting(Base):
    __tablename__ = 'modulePublicationSetting'
    __table_args__ = {
        'comment': 'Intersection table between module and publicationSetting to reproduce a N-N relationships between the tables'
    }

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key')
    moduleId: Mapped[int] = mapped_column(
        ForeignKey('module.ID'), nullable=False, index=True, comment='Foreign key from the module table'
    )
    publicationSettingId: Mapped[int] = mapped_column(
        ForeignKey('publicationSetting.ID'),
        nullable=False,
        index=True,
        comment='Foreign key from the publicationSettings table',
    )

    module = relationship('Module')
    publicationSetting = relationship('PublicationSetting')


class OaRoleModule(Base):
    __tablename__ = 'oaRoleModule'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key. Auto-increment')
    moduleId: Mapped[int] = mapped_column(ForeignKey('module.ID'), nullable=False, index=True, comment='Module ID')
    oaRoleId: Mapped[int] = mapped_column(ForeignKey('oaRole.ID'), nullable=False, index=True, comment='OA Role ID')
    access = Column(
        TINYINT(1),
        nullable=False,
        server_default=text('0'),
        comment='Access level level (0-7) for this role on this module',
    )

    module = relationship('Module')
    oaRole = relationship('OaRole')


class Alias(Base):
    __tablename__ = 'Alias'

    AliasSerNum = Column(INTEGER(11), primary_key=True, index=True)
    AliasType = Column(String(25), nullable=False, index=True)
    AliasUpdate = Column(INTEGER(11), nullable=False, index=True, server_default=text('0'))
    AliasName_FR = Column(String(100), nullable=False)
    AliasName_EN = Column(String(100), nullable=False)
    AliasDescription_FR = Column(Text, nullable=False)
    AliasDescription_EN = Column(Text, nullable=False)
    EducationalMaterialControlSerNum: Mapped[int] = mapped_column(
        ForeignKey(
            'EducationalMaterialControl.EducationalMaterialControlSerNum', ondelete='SET NULL', onupdate='CASCADE'
        ),
        nullable=True,
        index=True,
        comment='To be changed to ReferenceMaterialControlSerNum when migrated to Django.',
    )
    HospitalMapSerNum: Mapped[int] = mapped_column(
        ForeignKey('HospitalMap.HospitalMapSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    SourceDatabaseSerNum = Column(INTEGER(11), nullable=False, index=True, server_default=text('1'))
    ColorTag = Column(String(25), nullable=False, server_default=text("'#777777'"))
    WaitTimeValidity = Column(
        TINYINT(4), nullable=False, server_default=text('1'), comment='This field exists in DEV. Usage is unknown'
    )
    LastTransferred = Column(DateTime, nullable=False, server_default=text("'2000-01-01 00:00:00'"))
    LastUpdatedBy: Mapped[int] = mapped_column(
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    SessionId = Column(String(255))

    EducationalMaterialControl = relationship('EducationalMaterialControl')
    HospitalMap = relationship('HospitalMap')
    OAUser = relationship('OAUser')


class AppointmentCheckin(Base):
    __tablename__ = 'AppointmentCheckin'

    AliasSerNum: Mapped[int] = mapped_column(
        ForeignKey('Alias.AliasSerNum', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, index=True
    )
    CheckinPossible = Column(TINYINT(4), nullable=False)
    CheckinInstruction_EN = Column(Text, nullable=False)
    CheckinInstruction_FR = Column(Text, nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    AC_LastUpdatedBy: Mapped[int] = mapped_column(
        'LastUpdatedBy',
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'),
        nullable=True,
        index=True,
    )
    AC_SessionId = Column('SessionId', String(255))
    AC_LastUpdated = Column(
        'LastUpdated',
        TIMESTAMP,
        nullable=False,
        server_default=text('current_timestamp() ON UPDATE current_timestamp()'),
    )

    OAUser = relationship('OAUser')


class Announcement(Base):
    __tablename__ = 'Announcement'

    AnnouncementSerNum = Column(INTEGER(11), primary_key=True, index=True)
    CronLogSerNum: Mapped[int] = mapped_column(
        ForeignKey('CronLog.CronLogSerNum', onupdate='CASCADE'), nullable=True, index=True
    )
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    PostControlSerNum: Mapped[int] = mapped_column(
        ForeignKey('PostControl.PostControlSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False, server_default=text('0'), comment='Deprecated')
    ReadBy = Column(LONGTEXT, nullable=False, server_default=text("'[]'"))
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    CronLog = relationship('CronLog')
    Patient = relationship('Patient')
    PostControl = relationship('PostControl')


class DiagnosisCode(Base):
    __tablename__ = 'DiagnosisCode'
    __table_args__ = (Index('SourceUID', 'SourceUID', 'Source', unique=True),)

    DiagnosisCodeSerNum = Column(INTEGER(11), primary_key=True)
    DiagnosisTranslationSerNum: Mapped[int] = mapped_column(
        ForeignKey('DiagnosisTranslation.DiagnosisTranslationSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    SourceUID = Column(BIGINT(20), nullable=False, server_default=text('0'))
    Source: Mapped[int] = mapped_column(
        ForeignKey('SourceDatabase.SourceDatabaseSerNum'), nullable=False, index=True, server_default=text('-1')
    )
    DiagnosisCode = Column(String(100), nullable=False, index=True)
    Description = Column(String(2056), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdatedBy: Mapped[int] = mapped_column(
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    SessionId = Column(INTEGER(11))

    DiagnosisTranslation = relationship('DiagnosisTranslation')
    OAUser = relationship('OAUser')
    SourceDatabase = relationship('SourceDatabase')


class EmailLog(Base):
    __tablename__ = 'EmailLog'

    EmailLogSerNum = Column(INTEGER(11), primary_key=True)
    CronLogSerNum: Mapped[int] = mapped_column(
        ForeignKey('CronLog.CronLogSerNum', onupdate='CASCADE'), nullable=True, index=True
    )
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    EmailControlSerNum: Mapped[int] = mapped_column(
        ForeignKey('EmailControl.EmailControlSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    Status = Column(String(5), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    CronLog = relationship('CronLog')
    EmailControl = relationship('EmailControl')
    Patient = relationship('Patient')


class Notification(Base):
    __tablename__ = 'Notification'

    NotificationSerNum = Column(INTEGER(11), primary_key=True)
    CronLogSerNum: Mapped[int] = mapped_column(
        ForeignKey('CronLog.CronLogSerNum', onupdate='CASCADE'), nullable=True, index=True
    )
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    NotificationControlSerNum: Mapped[int] = mapped_column(
        ForeignKey('NotificationControl.NotificationControlSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    RefTableRowSerNum = Column(INTEGER(11), nullable=False, index=True)
    DateAdded = Column(DateTime)
    ReadStatus = Column(INTEGER(11), nullable=False, comment='Deprecated')
    ReadBy = Column(LONGTEXT, nullable=False, server_default=text("'[]'"))
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    RefTableRowTitle_EN = Column(String(500), nullable=False)
    RefTableRowTitle_FR = Column(String(500), nullable=False)

    CronLog = relationship('CronLog')
    NotificationControl = relationship('NotificationControl')
    Patient = relationship('Patient')


class PatientTestResult(Base):
    __tablename__ = 'PatientTestResult'
    __table_args__ = (
        Index('PatientTestCodeTestDate', 'PatientSerNum', 'TestExpressionSerNum', 'CollectedDateTime', unique=True),
    )

    PatientTestResultSerNum = Column(BIGINT(11), primary_key=True)
    TestGroupExpressionSerNum: Mapped[int] = mapped_column(
        ForeignKey('TestGroupExpression.TestGroupExpressionSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    TestExpressionSerNum: Mapped[int] = mapped_column(
        ForeignKey('TestExpression.TestExpressionSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    AbnormalFlag = Column(String(10))
    SequenceNum = Column(INTEGER(11), comment='Order of Lab Tests in which they should be displayed')
    CollectedDateTime = Column(DateTime, nullable=False)
    ResultDateTime = Column(DateTime, nullable=False)
    AvailableAt = Column(DateTime, nullable=False)
    NormalRangeMin = Column(Float)
    NormalRangeMax = Column(Float)
    NormalRange = Column(String(30), nullable=False, server_default=text("''"))
    TestValueNumeric = Column(Float)
    TestValue = Column(String(255), nullable=False)
    UnitDescription = Column(String(40), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False, server_default=text('0'), comment='Deprecated')
    ReadBy = Column(LONGTEXT, nullable=False, server_default=text("'[]'"))
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    Patient = relationship('Patient')
    TestExpression = relationship('TestExpression')
    TestGroupExpression = relationship('TestGroupExpression')


class PatientsForPatient(Base):
    __tablename__ = 'PatientsForPatients'

    PatientsForPatientsSerNum = Column(INTEGER(11), primary_key=True)
    CronLogSerNum: Mapped[int] = mapped_column(
        ForeignKey('CronLog.CronLogSerNum', onupdate='CASCADE'), nullable=True, index=True
    )
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    PostControlSerNum: Mapped[int] = mapped_column(
        ForeignKey('PostControl.PostControlSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False, server_default=text('0'))
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    CronLog = relationship('CronLog')
    Patient = relationship('Patient')
    PostControl = relationship('PostControl')


class Questionnaire(Base):
    __tablename__ = 'Questionnaire'

    QuestionnaireSerNum = Column(BIGINT(20), primary_key=True)
    CronLogSerNum: Mapped[int] = mapped_column(
        ForeignKey('CronLog.CronLogSerNum', onupdate='CASCADE'), nullable=True, index=True
    )
    QuestionnaireControlSerNum: Mapped[int] = mapped_column(
        ForeignKey('QuestionnaireControl.QuestionnaireControlSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    DateAdded = Column(DateTime, nullable=False, server_default=text('current_timestamp()'))
    PatientQuestionnaireDBSerNum = Column(INTEGER(11), index=True)
    CompletedFlag = Column(TINYINT(4), nullable=False, server_default=text('0'))
    CompletionDate = Column(DateTime)
    SessionId = Column(Text, nullable=False, server_default=text("'[]'"))
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    CronLog = relationship('CronLog')
    Patient = relationship('Patient')
    QuestionnaireControl = relationship('QuestionnaireControl')


class TestResultAdditionalLink(Base):
    __tablename__ = 'TestResultAdditionalLinks'

    TestResultAdditionalLinksSerNum = Column(INTEGER(11), primary_key=True)
    TestResultControlSerNum: Mapped[int] = mapped_column(
        ForeignKey('TestResultControl.TestResultControlSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    Name_EN = Column(String(1028), nullable=False)
    Name_FR = Column(String(1028), nullable=False)
    URL_EN = Column(String(2056), nullable=False)
    URL_FR = Column(String(2056), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    TestResultControl = relationship('TestResultControl')


class TestResultExpression(Base):
    __tablename__ = 'TestResultExpression'

    TestResultExpressionSerNum = Column(INTEGER(11), primary_key=True)
    TestResultControlSerNum: Mapped[int] = mapped_column(
        ForeignKey('TestResultControl.TestResultControlSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    ExpressionName = Column(String(100), nullable=False, unique=True)
    DateAdded = Column(DateTime, nullable=False)
    LastPublished = Column(DateTime, nullable=False, server_default=text("'2000-01-01 00:00:00'"))
    LastUpdatedBy: Mapped[int] = mapped_column(
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    SessionId = Column(String(255))

    OAUser = relationship('OAUser')
    TestResultControl = relationship('TestResultControl')


class TxTeamMessage(Base):
    __tablename__ = 'TxTeamMessage'

    TxTeamMessageSerNum = Column(INTEGER(11), primary_key=True, index=True)
    CronLogSerNum: Mapped[int] = mapped_column(
        ForeignKey('CronLog.CronLogSerNum', onupdate='CASCADE'), nullable=True, index=True
    )
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    PostControlSerNum: Mapped[int] = mapped_column(
        ForeignKey('PostControl.PostControlSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False, server_default=text('0'), comment='Deprecated')
    ReadBy = Column(LONGTEXT, nullable=False, server_default=text("'[]'"))
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    CronLog = relationship('CronLog')
    Patient = relationship('Patient')
    PostControl = relationship('PostControl')


class CronControlPostAnnouncement(Base):
    __tablename__ = 'cronControlPost_Announcement'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key. Auto-increment.')
    cronControlPostSerNum: Mapped[int] = mapped_column(
        ForeignKey('PostControl.PostControlSerNum'),
        nullable=False,
        index=True,
        comment='Foreign key with PostControlSerNum from PostControl. Mandatory.',
    )
    publishFlag = Column(
        SMALLINT(6),
        nullable=False,
        index=True,
        server_default=text('0'),
        comment='Marker for data that has been published from opalAdmin.',
    )
    lastPublished = Column(
        DateTime, nullable=False, server_default=text("'2000-01-01 00:00:00'"), comment='Last publish date.'
    )
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    sessionId = Column(String(255), comment='SessionId of the user who last updated this field.')

    PostControl = relationship('PostControl')


class CronControlPostTreatmentTeamMessage(Base):
    __tablename__ = 'cronControlPost_TreatmentTeamMessage'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key. Auto-increment.')
    cronControlPostSerNum: Mapped[int] = mapped_column(
        ForeignKey('PostControl.PostControlSerNum'),
        nullable=False,
        index=True,
        comment='Foreign key with PostControlSerNum from PostControl. Mandatory.',
    )
    publishFlag = Column(
        SMALLINT(6),
        nullable=False,
        index=True,
        server_default=text('0'),
        comment='Marker for data that has been published from opalAdmin.',
    )
    lastPublished = Column(
        DateTime, nullable=False, server_default=text("'2000-01-01 00:00:00'"), comment='Last publish date.'
    )
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    sessionId = Column(String(255), comment='SessionId of the user who last updated this field.')

    PostControl = relationship('PostControl')


class Study(Base):
    """This table contains a foreign key to QuestionnaireDB.questionnaire."""

    __tablename__ = 'study'

    ID = Column(BIGINT(20), primary_key=True, unique=True, comment='Primary key. Auto-increment.')
    consentQuestionnaireId: Mapped[int] = mapped_column(
        ForeignKey('QuestionnaireDB.questionnaire.ID'),
        nullable=True,
        index=True,
        comment='QuestionnaireDB questionnaire ID of the consent form for this study. Foreign key field. Mandatory.',
    )
    code = Column(String(64), comment='Study ID entered by the user. Mandatory.')
    title_EN = Column(String(256), comment='English title of the study. Mandatory.')
    title_FR = Column(String(256), comment='French title of the study. Mandatory.')
    description_EN = Column(Text, comment='English description of the study. Mandatory.')
    description_FR = Column(Text, comment='French description of the study. Mandatory.')
    investigator = Column(String(256), comment='Principal investigator of the study. Mandatory.')
    email = Column(String(128), comment='Principal investigator email address of the study. Mandatory.')
    phone = Column(String(25), comment='Principal investigator phone number of the study. Mandatory.')
    phoneExt = Column(String(10), comment='Principal investigator phone number extension. Optional.')
    startDate = Column(Date, comment='Start date of the study. Optional.')
    endDate = Column(Date, comment='End date of the study. Optional.')
    deleted = Column(
        TINYINT(4), nullable=False, server_default=text('0'), comment='Mark the record as deleted (1) or not (0)'
    )
    creationDate = Column(DateTime, nullable=False, comment='Date and time of the creation of the record.')
    createdBy = Column(String(255), comment='Username of the creator of the record.')
    lastUpdated = Column(
        TIMESTAMP,
        server_default=text('current_timestamp() ON UPDATE current_timestamp()'),
        comment='Date and time of the last modification',
    )
    updatedBy = Column(String(255), comment='Username of the last user who modify the record')

    questionnaire = relationship('Questionnaire')


class AliasExpression(Base):
    __tablename__ = 'AliasExpression'
    __table_args__ = (Index('idx_ExpressionName_Description', 'ExpressionName', 'Description'),)

    AliasExpressionSerNum = Column(INTEGER(11), primary_key=True, index=True)
    AliasSerNum: Mapped[int] = mapped_column(
        ForeignKey('Alias.AliasSerNum', onupdate='CASCADE'), nullable=False, index=True, server_default=text('0')
    )
    masterSourceAliasId: Mapped[int] = mapped_column(ForeignKey('masterSourceAlias.ID'), nullable=True, unique=True)
    ExpressionName = Column(String(250), nullable=False)
    Description = Column(String(250), nullable=False, comment='Resource Description')
    LastTransferred = Column(DateTime, nullable=False, server_default=text("'2000-01-01 00:00:00'"))
    LastUpdatedBy: Mapped[int] = mapped_column(
        ForeignKey('OAUser.OAUserSerNum', ondelete='SET NULL', onupdate='CASCADE'), nullable=True, index=True
    )
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    SessionId = Column(String(255))

    Alias = relationship('Alias')
    OAUser = relationship('OAUser')
    masterSourceAlias = relationship('MasterSourceAlias')


class CronControlAlias(Base):
    __tablename__ = 'cronControlAlias'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary key. Auto-increment.')
    cronControlAliasSerNum: Mapped[int] = mapped_column(
        ForeignKey('Alias.AliasSerNum'),
        nullable=False,
        index=True,
        comment='Foreign key with AliasSerNum from Alias. Mandatory.',
    )
    cronType = Column(
        String(100),
        nullable=False,
        index=True,
        comment='Field refers to what cron controller is using this transfer flag. eg TxTeamMessages, Document, Announcement, etc. Mandatory',
    )
    aliasUpdate = Column(
        SMALLINT(6),
        nullable=False,
        index=True,
        server_default=text('0'),
        comment='Marker for data that needs to be read on next cron.',
    )
    lastTransferred = Column(
        DateTime,
        nullable=False,
        server_default=text("'2000-01-01 00:00:00'"),
        comment='Last transfer date. Updated after any given cron job finishes.',
    )
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )
    sessionId = Column(String(255), comment='SessionId of the user who last updated this field.')

    Alias = relationship('Alias')


class PatientStudy(Base):
    __tablename__ = 'patientStudy'

    ID = Column(BIGINT(20), primary_key=True, comment='Primary Key. Auto-increment.')
    patientId: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum'),
        nullable=False,
        index=True,
        comment='Foreign key with PatientSerNum in Patient table',
    )
    studyId: Mapped[int] = mapped_column(
        ForeignKey('study.ID'), nullable=False, index=True, comment='Foreign key with Id in study table.'
    )
    consentStatus = Column(
        INTEGER(11),
        nullable=False,
        comment='Patient consent status for this study. 1 = invited; 2 = opalConsented; 3 = otherConsented; 4 = declined. Mandatory.',
    )
    readStatus = Column(
        INTEGER(11), nullable=False, server_default=text('0'), comment='Patient read status for this consent form.'
    )
    lastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    Patient = relationship('Patient')
    study = relationship('Study')


class QuestionnaireStudy(Base):
    """This table contains a foreign key to QuestionnaireDB.questionnaire."""

    __tablename__ = 'questionnaireStudy'

    ID = Column(BIGINT(20), primary_key=True)
    studyId: Mapped[int] = mapped_column(ForeignKey('study.ID'), nullable=False, index=True)
    questionnaireId: Mapped[int] = mapped_column(
        ForeignKey('QuestionnaireDB.questionnaire.ID'), nullable=False, index=True
    )

    questionnaire = relationship('Questionnaire')
    study = relationship('Study')


class Appointment(Base):
    __tablename__ = 'Appointment'

    AppointmentSerNum = Column(INTEGER(11), primary_key=True, index=True)
    AliasExpressionSerNum: Mapped[int] = mapped_column(
        ForeignKey('AliasExpression.AliasExpressionSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    CronLogSerNum = Column(INTEGER(11), index=True)
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    SourceDatabaseSerNum: Mapped[int] = mapped_column(
        ForeignKey('SourceDatabase.SourceDatabaseSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    AppointmentAriaSer = Column(
        INTEGER(11),
        nullable=True,
        index=True,
        comment='Deprecated - systems now use SourceSystemID. DO NOT DELETE (to preserve legacy data for possible downgrade operation).',
    )
    SourceSystemID = Column(
        String(100),
        nullable=False,
        index=True,
        comment='Unique identifier for the appointment in the source system. Equivalent to ORMs MVA.AppointId field, if ORMs is installed.',
    )
    PrioritySerNum = Column(INTEGER(11), nullable=False, index=True)
    DiagnosisSerNum = Column(INTEGER(11), nullable=False, index=True)
    Status = Column(String(100), nullable=False, index=True)
    State = Column(String(25), nullable=False, index=True)
    ScheduledStartTime = Column(DateTime, nullable=False, index=True)
    ScheduledEndTime = Column(DateTime, nullable=False)
    ActualStartDate = Column(DateTime, nullable=False)
    ActualEndDate = Column(DateTime, nullable=False)
    Location = Column(INTEGER(10), nullable=False, server_default=text('10'))
    RoomLocation_EN = Column(String(100), nullable=False)
    RoomLocation_FR = Column(String(100), nullable=False)
    Checkin = Column(TINYINT(4), nullable=False)
    CheckinUsername = Column(
        String(225), nullable=False, server_default=text("''"), comment='Firebase username of the user who checked in.'
    )
    ChangeRequest = Column(TINYINT(4), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False, comment='Deprecated')
    ReadBy = Column(LONGTEXT, nullable=False, server_default=text("'[]'"))
    SessionId = Column(Text, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    AliasExpression = relationship('AliasExpression')
    Patient = relationship('Patient')
    SourceDatabase = relationship('SourceDatabase')


class Document(Base):
    __tablename__ = 'Document'

    DocumentSerNum = Column(INTEGER(11), primary_key=True)
    CronLogSerNum: Mapped[int] = mapped_column(
        ForeignKey('CronLog.CronLogSerNum', onupdate='CASCADE'), nullable=True, index=True
    )
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    SourceDatabaseSerNum: Mapped[int] = mapped_column(
        ForeignKey('SourceDatabase.SourceDatabaseSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    DocumentId = Column(String(100), nullable=False)
    AliasExpressionSerNum: Mapped[int] = mapped_column(
        ForeignKey('AliasExpression.AliasExpressionSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    ApprovedBySerNum = Column(INTEGER(11), nullable=False, index=True)
    ApprovedTimeStamp = Column(DateTime, nullable=False)
    AuthoredBySerNum = Column(INTEGER(11), nullable=False, index=True)
    DateOfService = Column(DateTime, nullable=False)
    Revised = Column(String(5), nullable=False)
    ValidEntry = Column(String(5), nullable=False)
    ErrorReasonText = Column(Text, nullable=False)
    OriginalFileName = Column(String(500), nullable=False)
    FinalFileName = Column(String(500), nullable=False)
    CreatedBySerNum = Column(INTEGER(11), nullable=False, index=True)
    CreatedTimeStamp = Column(DateTime, nullable=False)
    TransferStatus = Column(String(10), nullable=False)
    TransferLog = Column(String(1000), nullable=False)
    SessionId = Column(Text, nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    ReadStatus = Column(INTEGER(11), nullable=False, comment='Deprecated')
    ReadBy = Column(LONGTEXT, nullable=False, server_default=text("'[]'"))
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    AliasExpression = relationship('AliasExpression')
    CronLog = relationship('CronLog')
    Patient = relationship('Patient')
    SourceDatabase = relationship('SourceDatabase')


class Task(Base):
    __tablename__ = 'Task'

    TaskSerNum = Column(INTEGER(11), primary_key=True)
    CronLogSerNum: Mapped[int] = mapped_column(
        ForeignKey('CronLog.CronLogSerNum', onupdate='CASCADE'), nullable=True, index=True
    )
    PatientSerNum: Mapped[int] = mapped_column(
        ForeignKey('Patient.PatientSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    AliasExpressionSerNum: Mapped[int] = mapped_column(
        ForeignKey('AliasExpression.AliasExpressionSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    PrioritySerNum = Column(INTEGER(11), nullable=False, index=True)
    DiagnosisSerNum = Column(INTEGER(11), nullable=False, index=True)
    SourceDatabaseSerNum: Mapped[int] = mapped_column(
        ForeignKey('SourceDatabase.SourceDatabaseSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    TaskAriaSer = Column(INTEGER(11), nullable=False, index=True)
    Status = Column(String(100), nullable=False)
    State = Column(String(25), nullable=False)
    DueDateTime = Column(DateTime, nullable=False)
    CreationDate = Column(DateTime, nullable=False)
    CompletionDate = Column(DateTime, nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    AliasExpression = relationship('AliasExpression')
    CronLog = relationship('CronLog')
    Patient = relationship('Patient')
    SourceDatabase = relationship('SourceDatabase')


class PatientLocation(Base):
    __tablename__ = 'PatientLocation'

    PatientLocationSerNum = Column(INTEGER(11), primary_key=True)
    SourceDatabaseSerNum: Mapped[int] = mapped_column(
        ForeignKey('SourceDatabase.SourceDatabaseSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    SourceUID = Column(INTEGER(11), nullable=False, index=True)
    AppointmentSerNum: Mapped[int] = mapped_column(
        ForeignKey('Appointment.AppointmentSerNum', ondelete='CASCADE', onupdate='CASCADE'), nullable=False, index=True
    )
    RevCount = Column(INTEGER(11), nullable=False, index=True)
    CheckedInFlag = Column(TINYINT(4), nullable=False, index=True)
    ArrivalDateTime = Column(DateTime, nullable=False)
    VenueSerNum = Column(INTEGER(11), nullable=False, index=True)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    Appointment = relationship('Appointment')
    SourceDatabase = relationship('SourceDatabase')


class PatientLocationMH(Base):
    __tablename__ = 'PatientLocationMH'

    PatientLocationMHSerNum = Column(INTEGER(11), primary_key=True)
    SourceDatabaseSerNum: Mapped[int] = mapped_column(
        ForeignKey('SourceDatabase.SourceDatabaseSerNum', onupdate='CASCADE'), nullable=False, index=True
    )
    SourceUID = Column(INTEGER(11), nullable=False, index=True)
    AppointmentSerNum: Mapped[int] = mapped_column(
        ForeignKey('Appointment.AppointmentSerNum', ondelete='CASCADE', onupdate='CASCADE'), nullable=False, index=True
    )
    RevCount = Column(INTEGER(11), nullable=False, index=True)
    CheckedInFlag = Column(TINYINT(4), nullable=False, index=True)
    ArrivalDateTime = Column(DateTime, nullable=False)
    VenueSerNum = Column(INTEGER(11), nullable=False, index=True)
    HstryDateTime = Column(DateTime, nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    Appointment = relationship('Appointment')
    SourceDatabase = relationship('SourceDatabase')


class ResourceAppointment(Base):
    __tablename__ = 'ResourceAppointment'

    ResourceAppointmentSerNum = Column(INTEGER(11), primary_key=True)
    ResourceSerNum = Column(INTEGER(11), nullable=False, index=True)
    AppointmentSerNum: Mapped[int] = mapped_column(
        ForeignKey('Appointment.AppointmentSerNum', ondelete='CASCADE', onupdate='CASCADE'), nullable=False, index=True
    )
    ExclusiveFlag = Column(String(11), nullable=False)
    PrimaryFlag = Column(String(11), nullable=False)
    DateAdded = Column(DateTime, nullable=False)
    LastUpdated = Column(
        TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()')
    )

    Appointment = relationship('Appointment')
