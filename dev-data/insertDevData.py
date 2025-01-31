"""This file will insert development data into the databases, to be used after running alembic upgrades."""
import os
import sys
from pathlib import Path

import pymysql
from dotenv import load_dotenv
from pymysql.constants import CLIENT
from pymysql.cursors import Cursor

# Find root and revision data paths
ROOT_DIR = Path(__file__).parents[1]
DATA_DIR = ROOT_DIR / 'dev-data\\sql'
# Load db connection environment variables
load_dotenv()
HOST = os.getenv('DOCKER_HOST')
PORT = int(os.getenv(key='MARIADB_PORT', default=3007))
USER = os.getenv('MARIADB_USER')
PASS = os.getenv('MARIADB_PASSWORD', default='root_password')
OPALDB = os.getenv('LEGACY_OPAL_DB_NAME')
QSTDB = os.getenv('LEGACY_QUESTIONNAIRE_DB_NAME')


def get_connection_cursor(autocommit: bool) -> Cursor:
    """Get a mariadb connection context manager for SQL execution.

    Args:
        autocommit: whether to always save data after executing.

    Returns:
        Cursor for the connection.
    """
    try:  # noqa: WPS229
        conn = pymysql.connect(
            user=USER,
            password=PASS,
            host=HOST,
            port=PORT,
            database=OPALDB,
            client_flag=CLIENT.MULTI_STATEMENTS,
            autocommit=autocommit,
        )
        return conn.cursor()
    except pymysql.Error as err:
        print('Error getting cursor or connection to mariaDB (Database {OPALDB}) {err}'.format(OPALDB=OPALDB, err=err.args[0]))  # noqa: WPS421
        sys.exit(1)


def insert_data(data_files) -> None:
    """Insert development data for specified dbs."""
    with get_connection_cursor(autocommit=True) as cursor:
        cursor.execute(query="""
            SET foreign_key_checks=0;
            SET sql_mode='';
            SET global sql_mode='';
            """)
    # For each dev data file specified in args, insert to db
    for data_file in data_files:
        data_sql_content = ''
        data_file_path = os.path.join(DATA_DIR, data_file)
        # Read in SQL content from handle
        with Path(data_file_path, encoding='ISO-8859-1').open(encoding='ISO-8859-1') as handle:  # noqa: WPS110
            data_sql_content += handle.read()
            handle.close()
        # Execute
        with get_connection_cursor(autocommit=True) as cursor:
            cursor.execute(data_sql_content)
            cursor.close()
        with get_connection_cursor(autocommit=True) as cursor:
            cursor.execute(query="""
                    SET foreign_key_checks = 1;
                    SET SQL_MODE='ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
                    SET GLOBAL SQL_MODE = 'ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
                """)
            cursor.close()


if __name__ == '__main__':
    insert_data(['OpalDB.sql'])