"""Global configurations settings such as database connection strings."""
import os
from typing import Literal, Optional, overload

from pymysql.constants import CLIENT
from sqlalchemy import create_engine


@overload
def _env(
    key: str,
    default: Optional[str] = None,
    required: Literal[True] = True,
) -> str:
    ...  # noqa: WPS428


@overload
def _env(
    key: str,
    default: Optional[str] = None,
    required: Literal[False] = False,
) -> Optional[str]:
    ...  # noqa: WPS428


def _env(
    key: str,
    default: Optional[str] = None,
    required: bool = True,
) -> Optional[str] | str:
    env_value = os.getenv(key, default=default)

    if required and not env_value:
        raise AttributeError(f'Environment variable "{key}" not set')

    return env_value


# Database connection strings
DB_HOST = _env('DATABASE_HOST', required=True)
DB_PORT = int(_env(key='DATABASE_PORT', default='3306'))
DB_USER = _env('DATABASE_USER')
DB_PASSWORD = _env('DATABASE_PASSWORD')
DB_NAME_OPAL = _env('LEGACY_OPAL_DB_NAME')
DB_NAME_QUESTIONNAIRE = _env('LEGACY_QUESTIONNAIRE_DB_NAME')

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

# SSL Settings
USE_SSL = _env('USE_SSL', default='0', required=False) == '1'
SSL_CA = _env('SSL_CA', required=False)


# PyMySQL connection parameters for SSL and non-SSL (used to insert test data and functions/views/events)
# test data: alembic/insert_test_data.py
# views/funcs: alembic/opaldb/migrations/versions/7a189846a0f5_insert_views_functions_events_procs.py
PYMYSQL_CONNECT_PARAMS = {  # noqa: WPS407
    'user': DB_USER,
    'password': str(DB_PASSWORD),
    'host': DB_HOST,
    'port': DB_PORT,
    'database': DB_NAME_OPAL,
    'client_flag': CLIENT.MULTI_STATEMENTS,
    'autocommit': True,
    'ssl_disabled': True,
}

# SSL Validation
if USE_SSL:
    SSL_CA = os.getenv('SSL_CA')
    PYMYSQL_CONNECT_PARAMS.update({
        'ssl_disabled': False,
        'ssl_ca': SSL_CA,
        'ssl_verify_identity': True,
    })
    print('LOG: Launching connection with secure transport.')
else:
    print('LOG: Launching connection without secure transport configured.')
