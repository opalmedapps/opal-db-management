# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""TBD."""

from dataclasses import dataclass

import pymysql
from pymysql.constants import CLIENT
from pymysql.cursors import Cursor

from db_management import settings


@dataclass(frozen=True)
class SQLConnectionParameters:
    """
    The connection parameters for PyMySQL.

    See: https://pymysql.readthedocs.io/en/latest/modules/connections.html#pymysql.connections.Connection
    """

    user: str | None
    password: str | None
    host: str | None
    port: int
    database: str | None
    client_flag: int
    autocommit: bool
    ssl_disabled: bool = True
    ssl_ca: str | None = None
    ssl_verify_cert: bool = True
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
        ssl_disabled=not settings.USE_SSL,
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
        message = 'Error connecting to database'
        raise ConnectionError(message) from exc

    return connection.cursor()


def connection_url(db_name: str) -> str:
    """
    Build the connection URL to the database for SQLAlchemy.

    Args:
        db_name: the name of the database to select

    Returns:
        the connection URL to the database
    """
    connection_params = {
        'user': settings.DB_USER,
        'password': str(settings.DB_PASSWORD),
        'host': settings.DB_HOST,
        'port': settings.DB_PORT,
        'database': db_name,
    }
    url = 'mysql+mysqldb://{user}:{password}@{host}:{port}/{database}'

    # Add SSL settings if enabled
    if settings.USE_SSL:
        connection_params.update({
            'ssl_ca': settings.SSL_CA,
        })
        # enable certificate and hostname verification
        # VERIFY_IDENTIFY is MySQL's equivalent to MariaDB's verify-server-cert
        # see: https://github.com/PyMySQL/mysqlclient/pull/475
        # see also: https://mariadb.com/kb/en/secure-connections-overview/#certificate-verification
        url += '?ssl_ca={ssl_ca}&ssl_mode=VERIFY_IDENTITY'

    return url.format(**connection_params)
