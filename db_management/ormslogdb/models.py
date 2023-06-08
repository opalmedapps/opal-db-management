from sqlalchemy import TIMESTAMP, Column, DateTime, Enum, Index, String, Text, text
from sqlalchemy.dialects.mysql import BIGINT, INTEGER
from sqlalchemy.ext.declarative import DeclarativeMeta, declarative_base

# see: https://github.com/python/mypy/issues/2477#issuecomment-703142484
Base: DeclarativeMeta = declarative_base()

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
    Action = Column(Enum('SENT', 'RECEIVED'), nullable=False)
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
