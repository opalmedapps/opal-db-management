# coding: utf-8
"""This example file shows how to insert data with SQLAlchemy models instead of relying on raw SQL This is the preferred method for new data being inserted in the future.

Note the metadata object for this file must be registered in this alembic folder's env.py file for the changes to be seen by the autogenerate migration feature.
"""
import os

from dotenv import load_dotenv
# Import the model for which you want to insert data
from models import Patient
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Read environment variables for connection
load_dotenv()
HOST = os.getenv('DATABASE_HOST')
USER = os.getenv('DATABASE_USER')
PASS = os.getenv('DATABASE_PASSWORD')
DB = os.getenv('LEGACY_OPAL_DB_NAME')
# Create connection and session
engine = create_engine(
    f'mariadb+mariadbconnector://{HOST}:{PASS}@{USER}/{DB}',
)


DML_Base = declarative_base()
metadata = DML_Base.metadata

# Define new data here like this:
patients = [
    Patient(
        PatientSerNum='1',
        PatientAriaSer='1',
        PatientId='123456789',
        PatientId2='0',
        FirstName='Example',
        LastName='Patient',
        Sex='Male',
        DateOfBirth='1996-07-06',
        Age=26,  # noqa: WPS432
        Email='example@email.com',
        TelNum='1234567890',
        EnableSMS=1,
        Language='EN',
        SSN='OTES12345678',
        AccessLevel=1,
        BlockedStatus=0,
        StatusReasonTxt='',
        SessionID='238746sdvpkjvdns19284712',
    ),
]

session_maker = sessionmaker(bind=engine)


def create_patients() -> None:
    """Insert example data.

    Note: Session maker is a context manager, we want to create a new session for each interaction.

    If we were to keep a persistent session across different transactions we could encounter
    the situation of having two threads writing to the database at the same time which can lead to syncing issues/corrupted session.
    """
    with session_maker() as session:
        for patient in patients:
            session.add(patient)
        session.commit()


if __name__ == '__main__':
    # After specifying your insertion with the session maker, call the function here, then invoke this python file from the command line.
    create_patients()
