# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""
Example file to demonstrate SQLAlchemy-based db management.

This example file shows how to insert data with SQLAlchemy models
instead of relying on raw SQL This is the preferred method for
new data being inserted in the future.

Note the metadata object for this file must be registered in this
alembic folder's env.py file for the changes to be seen
by the autogenerate migration feature.
"""

from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker

# Import the model for which you want to insert data
from db_management.connection import connection_url
from db_management.opaldb.models import Patient
from db_management.settings import DB_NAME_OPAL

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
        Age=26,
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

session_maker = sessionmaker(bind=create_engine(connection_url(DB_NAME_OPAL)))


def create_patients() -> None:
    """
    Insert example data.

    Note: Session maker is a context manager, we want to create a new session for each interaction.

    If we were to keep a persistent session across different transactions we could encounter
    the situation of having two threads writing to the database at the same time
    which can lead to syncing issues/corrupted session.
    """
    with session_maker() as session:
        for patient in patients:
            session.add(patient)
        session.commit()


if __name__ == '__main__':
    # After specifying your insertion with the session maker, call the function here, then call this python script.
    create_patients()
