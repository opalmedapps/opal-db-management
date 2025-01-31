"""Global configurations settings such as database connection strings."""
import os

from dotenv import load_dotenv
from sqlalchemy import create_engine

load_dotenv()

# Database connection strings
HOST = os.getenv('DATABASE_HOST')
PORT = int(os.getenv(key='DATABASE_PORT', default=3006))  # noqa: WPS432
USER = os.getenv('DATABASE_USER')
PASSWORD = os.getenv('DATABASE_PASSWORD')
DB_NAME_OPAL = os.getenv('LEGACY_OPAL_DB_NAME')
DB_NAME_QUESTIONNAIRE = os.getenv('LEGACY_QUESTIONNAIRE_DB_NAME')

# SQLAlchemy-->OpalDB Engine
OPALDB_ENGINE = create_engine(
    'mariadb+mariadbconnector://{user}:{password}@{host}:{port}/{database}'.format(  # noqa: E501
        user=USER,
        password=PASSWORD,
        host=HOST,
        port=PORT,
        database=DB_NAME_OPAL,
    ),
)

# Test Data file names
OPAL_TEST_DATA_NAME = os.getenv('LEGACY_OPAL_DB_TEST_SCRIPT_NAME')