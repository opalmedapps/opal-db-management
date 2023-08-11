from sqlalchemy import (
    TIMESTAMP,
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
from sqlalchemy.dialects.mysql import INTEGER, SMALLINT, TINYINT
from sqlalchemy.ext.declarative import DeclarativeMeta, declarative_base
from sqlalchemy.orm import relationship

# see: https://github.com/python/mypy/issues/2477#issuecomment-703142484
Base: DeclarativeMeta = declarative_base()

metadata = Base.metadata

t_BuildType = Table(
    'BuildType', metadata,
    Column('Name', String(30), nullable=False)
)

class Cron(Base):
    __tablename__ = 'Cron'

    System = Column(String(20), primary_key=True)
    LastReceivedSmsFetch = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))


class DiagnosisChapter(Base):
    __tablename__ = 'DiagnosisChapter'

    DiagnosisChapterId = Column(INTEGER(11), primary_key=True)
    Chapter = Column(String(20), nullable=False, unique=True)
    Description = Column(Text, nullable=False)


class Hospital(Base):
    __tablename__ = 'Hospital'

    HospitalId = Column(INTEGER(11), primary_key=True)
    HospitalCode = Column(String(50), nullable=False, unique=True)
    HospitalName = Column(String(100), nullable=False)
    Format = Column(String(50))


class Insurance(Base):
    __tablename__ = 'Insurance'

    InsuranceId = Column(INTEGER(11), primary_key=True)
    InsuranceCode = Column(String(50), nullable=False, unique=True)
    InsuranceName = Column(String(100), nullable=False)
    Format = Column(String(50))


class Patient(Base):
    __tablename__ = 'Patient'

    PatientSerNum = Column(INTEGER(10), primary_key=True)
    LastName = Column(String(50), nullable=False)
    FirstName = Column(String(50), nullable=False)
    DateOfBirth = Column(DateTime, nullable=False)
    Sex = Column(String(25), nullable=False)
    SMSAlertNum = Column(String(11))
    SMSSignupDate = Column(DateTime)
    OpalPatient = Column(TINYINT(1), nullable=False, server_default=text('0'))
    OpalUUID = Column(String(length=37, collation='latin1_swedish_ci'), nullable=False, server_default=text("''"), comment='UUID provided only for Opal patients, and received from Opal')
    LanguagePreference = Column(Enum('English', 'French'))
    LastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    SMSLastUpdated = Column(DateTime)


class PatientLocation(Base):
    __tablename__ = 'PatientLocation'

    PatientLocationSerNum = Column(INTEGER(10), primary_key=True)
    PatientLocationRevCount = Column(INTEGER(3), nullable=False)
    AppointmentSerNum = Column(INTEGER(10), nullable=False, index=True)
    CheckinVenueName = Column(String(50), nullable=False)
    ArrivalDateTime = Column(DateTime, nullable=False)
    LastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp()'))
    IntendedAppointmentFlag = Column(TINYINT(1), nullable=False, server_default=text('0'))


class PatientLocationMH(Base):
    __tablename__ = 'PatientLocationMH'

    PatientLocationSerNum = Column(INTEGER(10), primary_key=True, comment='This key comes from the PatientLocation table but it should be unique')
    PatientLocationRevCount = Column(INTEGER(3), nullable=False)
    AppointmentSerNum = Column(INTEGER(10), nullable=False, index=True)
    CheckinVenueName = Column(String(50), nullable=False)
    ArrivalDateTime = Column(DateTime, nullable=False)
    DichargeThisLocationDateTime = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp()'), comment='This is effectively the LastUpdated Column')
    IntendedAppointmentFlag = Column(TINYINT(1), nullable=False, server_default=text('0'))


class ProfileColumnDefinition(Base):
    __tablename__ = 'ProfileColumnDefinition'

    ProfileColumnDefinitionSer = Column(INTEGER(11), primary_key=True)
    ColumnName = Column(String(255), nullable=False, unique=True)
    DisplayName = Column(String(255), nullable=False)
    Glyphicon = Column(String(255), nullable=False)
    Description = Column(Text, nullable=False)
    LastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))


class ProfileColumn(Base):
    __tablename__ = 'ProfileColumns'

    ProfileColumnSer = Column(INTEGER(11), primary_key=True)
    ProfileSer = Column(INTEGER(11), nullable=False, index=True)
    ProfileColumnDefinitionSer = Column(INTEGER(11), nullable=False)
    Position = Column(INTEGER(11), nullable=False, server_default=text('-1'))
    Active = Column(TINYINT(1), nullable=False, server_default=text('0'))
    LastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))


class ProfileOption(Base):
    __tablename__ = 'ProfileOptions'

    ProfileOptionSer = Column(INTEGER(11), primary_key=True)
    ProfileSer = Column(INTEGER(11), nullable=False, index=True)
    Options = Column(String(255), nullable=False)
    Type = Column(Enum('ExamRoom', 'IntermediateVenue', 'Resource'), nullable=False)
    LastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))


class TEMPPatientQuestionnaireReview(Base):
    __tablename__ = 'TEMP_PatientQuestionnaireReview'

    PatientQuestionnaireReviewSerNum = Column(INTEGER(11), primary_key=True)
    PatientSer = Column(INTEGER(11), nullable=False, index=True)
    ReviewTimestamp = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp()'))
    User = Column(String(50), nullable=False)


class DiagnosisCode(Base):
    __tablename__ = 'DiagnosisCode'

    DiagnosisCodeId = Column(INTEGER(11), primary_key=True)
    DiagnosisChapterId = Column(ForeignKey('DiagnosisChapter.DiagnosisChapterId'), nullable=False, index=True)
    Code = Column(String(20), nullable=False, unique=True)
    Category = Column(Text, nullable=False)
    Description = Column(Text, nullable=False)

    DiagnosisChapter = relationship('DiagnosisChapter')


class PatientHospitalIdentifier(Base):
    __tablename__ = 'PatientHospitalIdentifier'
    __table_args__ = (
        Index('HospitalId_MedicalRecordNumber', 'HospitalId', 'MedicalRecordNumber', unique=True),
    )

    PatientHospitalIdentifierId = Column(INTEGER(11), primary_key=True)
    PatientId = Column(ForeignKey('Patient.PatientSerNum'), nullable=False, index=True)
    HospitalId = Column(ForeignKey('Hospital.HospitalId'), nullable=False)
    MedicalRecordNumber = Column(String(50), nullable=False)
    Active = Column(TINYINT(4), nullable=False)
    DateAdded = Column(DateTime, nullable=False, server_default=text('current_timestamp()'))
    LastModified = Column(DateTime, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))

    Hospital = relationship('Hospital')
    Patient = relationship('Patient')


class PatientInsuranceIdentifier(Base):
    __tablename__ = 'PatientInsuranceIdentifier'
    __table_args__ = (
        Index('InsuranceId_InsuranceNumber', 'InsuranceId', 'InsuranceNumber', unique=True),
    )

    PatientInsuranceIdentifierId = Column(INTEGER(11), primary_key=True)
    PatientId = Column(ForeignKey('Patient.PatientSerNum'), nullable=False, index=True)
    InsuranceId = Column(ForeignKey('Insurance.InsuranceId'), nullable=False)
    InsuranceNumber = Column(String(50), nullable=False)
    ExpirationDate = Column(DateTime, nullable=False)
    Active = Column(TINYINT(4), nullable=False)
    DateAdded = Column(DateTime, nullable=False, server_default=text('current_timestamp()'))
    LastModified = Column(DateTime, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))

    Insurance = relationship('Insurance')
    Patient = relationship('Patient')


class PatientMeasurement(Base):
    __tablename__ = 'PatientMeasurement'

    PatientMeasurementSer = Column(INTEGER(11), primary_key=True)
    PatientSer = Column(ForeignKey('Patient.PatientSerNum'), nullable=False, index=True)
    AppointmentId = Column(String(100), nullable=False)
    PatientId = Column(String(50), nullable=False)
    Date = Column(Date, nullable=False)
    Time = Column(Time, nullable=False)
    Height = Column(Float(asdecimal=True), nullable=False)
    Weight = Column(Float(asdecimal=True), nullable=False)
    BSA = Column(Float(asdecimal=True), nullable=False)
    LastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))

    Patient = relationship('Patient')


class SpecialityGroup(Base):
    __tablename__ = 'SpecialityGroup'

    SpecialityGroupId = Column(INTEGER(11), primary_key=True)
    HospitalId = Column(ForeignKey('Hospital.HospitalId'), nullable=False, index=True)
    SpecialityGroupCode = Column(String(50), nullable=False, unique=True)
    SpecialityGroupName = Column(String(50), nullable=False)
    LastUpdated = Column(DateTime, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))

    Hospital = relationship('Hospital')


class AppointmentCode(Base):
    __tablename__ = 'AppointmentCode'
    __table_args__ = (
        Index('AppointmentCode_SpecialityGroupId', 'AppointmentCode', 'SpecialityGroupId', unique=True),
    )

    AppointmentCodeId = Column(INTEGER(11), primary_key=True)
    AppointmentCode = Column(String(100), nullable=False)
    SpecialityGroupId = Column(ForeignKey('SpecialityGroup.SpecialityGroupId'), nullable=False, index=True)
    DisplayName = Column(String(100))
    SourceSystem = Column(String(50), nullable=False)
    Active = Column(TINYINT(4), nullable=False, server_default=text('1'))
    LastModified = Column(DateTime, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))

    SpecialityGroup = relationship('SpecialityGroup')


class ClinicHub(Base):
    __tablename__ = 'ClinicHub'

    ClinicHubId = Column(INTEGER(11), primary_key=True)
    SpecialityGroupId = Column(ForeignKey('SpecialityGroup.SpecialityGroupId'), nullable=False, index=True)
    ClinicHubName = Column(String(50), nullable=False)
    LastUpdated = Column(DateTime, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))

    SpecialityGroup = relationship('SpecialityGroup')


class ClinicResource(Base):
    __tablename__ = 'ClinicResources'
    __table_args__ = (
        Index('ClinicResources_SpecialityGroupId', 'ResourceCode', 'SpecialityGroupId', unique=True),
    )

    ClinicResourcesSerNum = Column(INTEGER(11), primary_key=True)
    ResourceCode = Column(String(200), nullable=False)
    ResourceName = Column(String(200), nullable=False, index=True, comment='Both Aria and Medivisit resources listed here')
    SpecialityGroupId = Column(ForeignKey('SpecialityGroup.SpecialityGroupId'), nullable=False, index=True)
    SourceSystem = Column(String(50), nullable=False)
    LastModified = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    Active = Column(TINYINT(4), nullable=False, index=True, server_default=text('1'), comment='1 = Active / 0 = Not Active')

    SpecialityGroup = relationship('SpecialityGroup')


class DiagnosisSubcode(Base):
    __tablename__ = 'DiagnosisSubcode'

    DiagnosisSubcodeId = Column(INTEGER(11), primary_key=True)
    DiagnosisCodeId = Column(ForeignKey('DiagnosisCode.DiagnosisCodeId'), nullable=False, index=True)
    Subcode = Column(String(20), nullable=False, unique=True)
    Description = Column(Text, nullable=False)

    DiagnosisCode = relationship('DiagnosisCode')


class Profile(Base):
    __tablename__ = 'Profile'

    ProfileSer = Column(INTEGER(11), primary_key=True)
    ProfileId = Column(String(255), nullable=False, unique=True)
    Category = Column(Enum('PAB', 'Physician', 'Nurse', 'Checkout Clerk', 'Pharmacy', 'Treatment Machine'), nullable=False)
    SpecialityGroupId = Column(ForeignKey('SpecialityGroup.SpecialityGroupId'), nullable=False, index=True)
    LastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp()'))

    SpecialityGroup = relationship('SpecialityGroup')


class SmsMessage(Base):
    __tablename__ = 'SmsMessage'
    __table_args__ = (
        Index('SpecialityGroupId_Type_Event_Language', 'SpecialityGroupId', 'Type', 'Event', 'Language', unique=True),
    )

    SmsMessageId = Column(INTEGER(11), primary_key=True)
    SpecialityGroupId = Column(ForeignKey('SpecialityGroup.SpecialityGroupId'))
    Type = Column(String(50), nullable=False, index=True)
    Event = Column(String(50), nullable=False)
    Language = Column(Enum('English', 'French'), nullable=False)
    Message = Column(Text, nullable=False)
    LastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))

    SpecialityGroup = relationship('SpecialityGroup')


class ExamRoom(Base):
    __tablename__ = 'ExamRoom'

    AriaVenueId = Column(String(250), nullable=False, unique=True)
    ClinicHubId = Column(ForeignKey('ClinicHub.ClinicHubId'), nullable=False, index=True)
    ScreenDisplayName = Column(String(100), nullable=False)
    VenueEN = Column(String(100), nullable=False, server_default=text("''"))
    VenueFR = Column(String(100), nullable=False, server_default=text("''"))
    ExamRoomSerNum = Column(INTEGER(11), primary_key=True)
    IntermediateVenueSerNum = Column(INTEGER(11))
    PositionOrder = Column(SMALLINT(6))

    ClinicHub = relationship('ClinicHub')


class IntermediateVenue(Base):
    __tablename__ = 'IntermediateVenue'

    IntermediateVenueSerNum = Column(INTEGER(11), primary_key=True)
    AriaVenueId = Column(String(250), nullable=False)
    ClinicHubId = Column(ForeignKey('ClinicHub.ClinicHubId'), nullable=False, index=True)
    ScreenDisplayName = Column(String(100), nullable=False)
    VenueEN = Column(String(100), nullable=False)
    VenueFR = Column(String(100), nullable=False)

    ClinicHub = relationship('ClinicHub')


class MediVisitAppointmentList(Base):
    __tablename__ = 'MediVisitAppointmentList'
    __table_args__ = (
        Index('MedivisitAppointId', 'AppointId', 'AppointSys', unique=True),
        {'comment': 'Appointment list to be read in daily from Medivist schedule, as provided by Ngoc'}
    )

    PatientSerNum = Column(ForeignKey('Patient.PatientSerNum'), nullable=False, index=True)
    ClinicResourcesSerNum = Column(ForeignKey('ClinicResources.ClinicResourcesSerNum'), nullable=False, index=True)
    ScheduledDateTime = Column(DateTime, nullable=False, index=True)
    ScheduledDate = Column(Date, nullable=False, index=True)
    ScheduledTime = Column(Time, nullable=False)
    AppointmentReminderSent = Column(TINYINT(1), nullable=False, server_default=text('0'))
    AppointmentCodeId = Column(ForeignKey('AppointmentCode.AppointmentCodeId'), nullable=False, index=True)
    AppointId = Column(String(100), nullable=False, comment='From Interface Engine')
    AppointSys = Column(String(50), nullable=False, index=True)
    Status = Column(Enum('Open', 'Cancelled', 'Completed', 'Deleted'), nullable=False, index=True)
    MedivisitStatus = Column(Text)
    CreationDate = Column(DateTime, nullable=False)
    AppointmentSerNum = Column(INTEGER(11), primary_key=True)
    LastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    LastUpdatedUserIP = Column(String(200))

    AppointmentCode = relationship('AppointmentCode')
    ClinicResource = relationship('ClinicResource')
    Patient = relationship('Patient')


class PatientDiagnosi(Base):
    __tablename__ = 'PatientDiagnosis'

    PatientDiagnosisId = Column(INTEGER(11), primary_key=True)
    PatientSerNum = Column(ForeignKey('Patient.PatientSerNum'), nullable=False, index=True)
    RecordedMrn = Column(String(50), nullable=False)
    DiagnosisSubcodeId = Column(ForeignKey('DiagnosisSubcode.DiagnosisSubcodeId'), nullable=False, index=True)
    Status = Column(Enum('Active', 'Deleted'), nullable=False, server_default=text("'Active'"))
    DiagnosisDate = Column(DateTime, nullable=False, server_default=text('current_timestamp()'))
    CreatedDate = Column(DateTime, nullable=False, server_default=text('current_timestamp()'))
    LastUpdated = Column(DateTime, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))
    UpdatedBy = Column(String(50), nullable=False)

    DiagnosisSubcode = relationship('DiagnosisSubcode')
    Patient = relationship('Patient')


class SmsAppointment(Base):
    __tablename__ = 'SmsAppointment'
    __table_args__ = (
        Index('ClinicResourcesSerNum', 'ClinicResourcesSerNum', 'AppointmentCodeId', unique=True),
    )

    SmsAppointmentId = Column(INTEGER(11), primary_key=True)
    ClinicResourcesSerNum = Column(ForeignKey('ClinicResources.ClinicResourcesSerNum'), nullable=False)
    AppointmentCodeId = Column(ForeignKey('AppointmentCode.AppointmentCodeId'), nullable=False, index=True)
    SpecialityGroupId = Column(ForeignKey('SpecialityGroup.SpecialityGroupId'), nullable=False, index=True)
    SourceSystem = Column(String(50), nullable=False)
    Type = Column(ForeignKey('SmsMessage.Type'), index=True)
    Active = Column(TINYINT(4), nullable=False, server_default=text('0'))
    LastUpdated = Column(DateTime, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))

    AppointmentCode = relationship('AppointmentCode')
    ClinicResource = relationship('ClinicResource')
    SpecialityGroup = relationship('SpecialityGroup')
    SmsMessage = relationship('SmsMessage')
