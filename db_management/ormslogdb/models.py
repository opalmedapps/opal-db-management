from sqlalchemy import TIMESTAMP, Column, DateTime, Enum, Index, String, Text, text
from sqlalchemy.dialects.mysql import BIGINT, INTEGER
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column


class Base(DeclarativeBase):
    pass


metadata = Base.metadata


class CronLog(Base):
    __tablename__ = 'CronLog'

    ID = Column(BIGINT(20), primary_key=True)
    ReStartTime = Column(DateTime)


class KioskLog(Base):
    __tablename__ = 'KioskLog'

    KioskLogId = Column(INTEGER(11), primary_key=True)
    Timestamp = Column(DateTime, nullable=False, server_default=text('current_timestamp()'))
    KioskInput = Column(String(50))
    KioskLocation = Column(String(50), nullable=False, server_default=text("''"))
    PatientDestination = Column(String(100))
    CenterImage = Column(String(100))
    ArrowDirection = Column(String(50))
    DisplayMessage = Column(Text)


class SmsLog(Base):
    __tablename__ = 'SmsLog'
    __table_args__ = (
        Index('Service', 'Service', 'MessageId', unique=True),
    )

    SmsLogSer = Column(INTEGER(11), primary_key=True)
    SmsTimestamp = Column(DateTime, nullable=False, index=True)
    ProcessedTimestamp = Column(DateTime, nullable=False, index=True, server_default=text('current_timestamp()'))
    Result = Column(Text, nullable=False, server_default=text("''"))
    Action: Mapped[str] = mapped_column(Enum('SENT', 'RECEIVED'), nullable=False)
    Service = Column(String(50), nullable=False, server_default=text("''"))
    MessageId = Column(String(50), nullable=False, server_default=text("''"))
    ServicePhoneNumber = Column(String(50), nullable=False, server_default=text("''"))
    ClientPhoneNumber = Column(String(50), nullable=False, server_default=text("''"))
    Message = Column(Text, nullable=False, server_default=text("''"))


class VirtualWaitingRoomLog(Base):
    __tablename__ = 'VirtualWaitingRoomLog'

    VirtualWaitingRoomLogSer = Column(INTEGER(11), primary_key=True)
    DateTime = Column(DateTime, nullable=False, index=True)
    FileName = Column(String(255), nullable=False, server_default=text("''"))
    Identifier = Column(String(255), nullable=False, server_default=text("''"))
    Type = Column(String(255), nullable=False, server_default=text("''"))
    Message = Column(Text, nullable=False, server_default=text("''"))
    LastUpdated = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp() ON UPDATE current_timestamp()'))


class LoginLog(Base):
    __tablename__ = 'LoginLog'

    ID = Column(INTEGER(11), primary_key=True)
    UserName = Column(String(50), nullable=False, index=True)
    DisplayName = Column(String(50), server_default=text("''"))
    LoginDate = Column(TIMESTAMP, nullable=False, server_default=text('current_timestamp()'))
    Status = Column(INTEGER(11), nullable=False)
    Error = Column(String(200), server_default=text("''"))
    LoginIPAddress = Column(String(20), nullable=False, server_default=text("''"))
