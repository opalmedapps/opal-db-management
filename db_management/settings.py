"""Global configurations settings such as database connection strings."""

import os
from typing import Literal, Optional, overload

import dotenv

# load .env to be able to modify during development
dotenv.load_dotenv()


@overload
def _env(
    key: str,
    default: Optional[str] = None,
    required: Literal[True] = True,
) -> str: ...


@overload
def _env(
    key: str,
    default: Optional[str] = None,
    required: Literal[False] = False,
) -> Optional[str]: ...


def _env(
    key: str,
    default: Optional[str] = None,
    required: bool = True,
) -> Optional[str] | str:
    env_value = os.getenv(key, default=default)

    if required and not env_value:
        message = f'Environment variable "{key}" not set'
        raise AttributeError(message)

    return env_value


# Database connection strings
DB_HOST = _env('DATABASE_HOST', required=True)
DB_PORT = int(_env(key='DATABASE_PORT', default='3306'))
DB_USER = _env('DATABASE_USER')
DB_PASSWORD = _env('DATABASE_PASSWORD')
DB_NAME_OPAL = 'OpalDB'
DB_NAME_QUESTIONNAIRE = 'QuestionnaireDB'
DB_NAME_ORMS = 'OrmsDatabase'
DB_NAME_ORMS_LOG = 'OrmsLog'

# SSL Settings
USE_SSL = _env('USE_SSL', default='0', required=False) == '1'
SSL_CA = _env('SSL_CA', required=False)
