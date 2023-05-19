"""TBD."""
from dataclasses import dataclass
from typing import Optional

import pymysql
from pymysql.constants import CLIENT
from pymysql.cursors import Cursor

from db_management.common import settings


@dataclass(frozen=True)
class SQLConnectionParameters(object):
    """
    The connection parameters for PyMySQL.

    See: https://pymysql.readthedocs.io/en/latest/modules/connections.html#pymysql.connections.Connection
    """

    user: Optional[str]
    password: Optional[str]
    host: Optional[str]
    port: int
    database: Optional[str]
    client_flag: int
    autocommit: bool
    ssl_disabled: bool = True
    ssl_ca: Optional[str] = None
    ssl_verify_identity: bool = True


def sql_connection_parameters(db_name: str) -> SQLConnectionParameters:
    """
    Return the SQL connection parameters for the given database.

    Args:
        db_name: the name of the database to select

    Returns:
        the SQL connection parameters to connect via PyMySQL
    """
    return SQLConnectionParameters(
        user=settings.DB_USER,
        password=settings.DB_PASSWORD,
        host=settings.DB_HOST,
        port=settings.DB_PORT,
        database=db_name,
        client_flag=CLIENT.MULTI_STATEMENTS,
        autocommit=True,
        ssl_disabled=settings.USE_SSL,
        ssl_ca=settings.SSL_CA,
    )


def connection_cursor(connection_parameters: SQLConnectionParameters) -> Cursor:
    """
    Get a MariaDB connection cursor for SQL execution.

    Args:
        connection_parameters: the connection parameters for the connection

    Returns:
        Cursor for the connection.

    Raises:
        ConnectionError: if the connection to the database failed
    """
    try:
        connection: pymysql.Connection[Cursor] = pymysql.connect(**connection_parameters.__dict__)
    except pymysql.Error as exc:
        raise ConnectionError('Error connecting to database') from exc

    return connection.cursor()
