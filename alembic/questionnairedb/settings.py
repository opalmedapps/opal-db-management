"""Global configurations settings such as database connection strings."""
import os

from dotenv import load_dotenv
from pymysql.constants import CLIENT

load_dotenv()

# Database connection strings
DB_HOST = os.getenv('DATABASE_HOST')
DB_PORT = int(os.getenv(key='DATABASE_PORT', default=3306))  # noqa: WPS432
DB_USER = os.getenv('DATABASE_USER')
DB_PASSWORD = os.getenv('DATABASE_PASSWORD')
DB_NAME_QUESTIONNAIRE = os.getenv('LEGACY_QUESTIONNAIRE_DB_NAME')

# SSL Settings for Deployed Environments
USE_SSL = os.getenv('USE_SSL')

# Env validation
settings_dict = {
    'DB_HOST': DB_HOST,
    'DB_PORT': DB_PORT,
    'DB_USER': DB_USER,
    'DB_PASSWORD': DB_PASSWORD,
    'DB_NAME_QUESTIONNAIRE': DB_NAME_QUESTIONNAIRE,
}

for label, setting in settings_dict.items():
    if not setting or setting == '':
        raise AttributeError(f'Warning: Environment variable not set {label}')

# PyMySQL connection parameters for SSL and non-SSL (used to insert test data and functions/views/events)
PYMYSQL_CONNECT_PARAMS = {  # noqa: WPS407
    'user': DB_USER,
    'password': str(DB_PASSWORD),
    'host': DB_HOST,
    'port': DB_PORT,
    'database': DB_NAME_QUESTIONNAIRE,
    'client_flag': CLIENT.MULTI_STATEMENTS,
    'autocommit': True,
    'ssl_disabled': True,
}

# SSL Validation
if USE_SSL == '1':
    SSL_CA = os.getenv('SSL_CA')
    PYMYSQL_CONNECT_PARAMS.update({
        'ssl_disabled': False,
        'ssl_ca': SSL_CA,
    })
    print('LOG: Launching connection with secure transport.')
else:
    print('LOG: Launching connection without secure transport configured.')
