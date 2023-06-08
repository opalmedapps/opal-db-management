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
DB_NAME_ORMS = _env('ORMS_DB_NAME')
DB_NAME_ORMS_LOG = _env('ORMS_LOG_DB_NAME')

# SSL Settings
USE_SSL = _env('USE_SSL', default='0', required=False) == '1'
SSL_CA = _env('SSL_CA', required=False)
