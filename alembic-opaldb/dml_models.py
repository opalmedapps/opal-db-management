# coding: utf-8
"""This file contains the data insertion for all regular tables in OpalDB."""
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os

# Read environment variables for connection
load_dotenv()
HOST = os.getenv('DOCKER_HOST')
USER = os.getenv('MARIADB_USER')
PASS = os.getenv('MARIADB_PASSWORD')
DB = os.getenv('LEGACY_OPAL_DB_NAME')
# Create connection and session
engine = create_engine(f'mariadb+mariadbconnector://{HOST}:{PASS}@{USER}/{DB}')

# Import the model for which you want to insert data
from ddl_models import Admin

DML_Base = declarative_base()
metadata = DML_Base.metadata

# Define new data here like this:
admins = [
    Admin(
        AdminSerNum=1, 
        ResourceSerNum=1, 
        FirstName='Example', 
        LastName='Admin Account', 
        Email='example@email.com', 
        Phone='1234567890'
    ),
]

session_maker = sessionmaker(bind=engine)

def create_admins():
    """Insert example data.
    
    Note: Session maker is a context manager, we want to create a new session for each interaction.

    If we were to keep a persistent session across different transactions we could encounter
    the situation of having two threads writing to the database at the same time which can lead to syncing issues/corrupted session.
    """
    with session_maker() as session:
        for admin in admins:
            session.add(admin)
        session.commit()

if __name__ == '__main__':
    # After specifying your insertion with the session maker, call the function here, then invoke this python file from the command line.
    create_admins()


