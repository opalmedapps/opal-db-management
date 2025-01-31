"""Global configurations settings such as database connection strings."""
import os

from dotenv import load_dotenv
from sqlalchemy import create_engine

load_dotenv()

# Database connection strings
DB_HOST = os.getenv('DATABASE_HOST')
DB_PORT = int(os.getenv(key='DATABASE_PORT', default=3306))  # noqa: WPS432
DB_USER = os.getenv('DATABASE_USER')
DB_PASSWORD = os.getenv('DATABASE_PASSWORD')
DB_NAME_OPAL = os.getenv('LEGACY_OPAL_DB_NAME')
DB_NAME_QUESTIONNAIRE = os.getenv('LEGACY_QUESTIONNAIRE_DB_NAME')
# SQLAlchemy-->OpalDB Engine
OPALDB_ENGINE = create_engine(
    'mysql+mysqldb://{user}:{password}@{host}:{port}/{database}'.format(
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        port=DB_PORT,
        database=DB_NAME_OPAL,
    ),
)
# SSL Settings for Deployed Environments
SSL_CA = os.getenv('SSL_CA')
SSL_CERT = os.getenv('SSL_CERT')
SSL_KEY = os.getenv('SSL_KEY')
USE_SSL = False

# Env validation
settings_dict = {
    'DB_HOST': DB_HOST,
    'DB_PORT': DB_PORT,
    'DB_USER': DB_USER,
    'DB_PASSWORD': DB_PASSWORD,
    'DB_NAME_OPAL': DB_NAME_OPAL,
    'DB_NAME_QUESTIONNAIRE': DB_NAME_QUESTIONNAIRE,
}

for label, setting in settings_dict.items():
    if not setting or setting == '':
        raise AttributeError(f'Warning: Environment variable not set {label}')

# SSL Validation
if all((SSL_CA, SSL_CERT, SSL_KEY)):
    USE_SSL = True
    print('LOG: Launching connection with secure transport.')
else:
    print('LOG: Launching connection without secure transport configured.')
