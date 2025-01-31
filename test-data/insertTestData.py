"""This file will insert development data into the databases, to be used after running alembic upgrades."""
import os
import sys
from pathlib import Path

import pymysql
from pymysql.constants import CLIENT
from pymysql.cursors import Cursor

from config.settings import DB_NAME_OPAL, HOST, PASSWORD, PORT, USER, OPAL_TEST_DATA_NAME

# Find root and revision data paths
ROOT_DIR = Path(__file__).parents[1]
DATA_DIR = ROOT_DIR / 'test-data/sql'


def get_connection_cursor(autocommit: bool) -> Cursor:
    """Get a mariadb connection context manager for SQL execution.

    Args:
        autocommit: whether to always save data after executing.

    Returns:
        Cursor for the connection.
    """
    try:
        conn = pymysql.connect(
            user=USER,
            password=str(PASSWORD),
            host=HOST,
            port=PORT,
            database=DB_NAME_OPAL,
            client_flag=CLIENT.MULTI_STATEMENTS,
            autocommit=autocommit,
        )
    except pymysql.Error as err:
        sys.exit('Error getting cursor or connection to mariaDB (Database {OPALDB}) {err}'.format(OPALDB=DB_NAME_OPAL, err=err.args[0]))  # noqa: E501
    return conn.cursor()


def insert_data(data_files: list) -> None:
    """Insert development data for specified dbs.

    Args:
        data_files: list of database sql files for insert.
    """
    # For each dev data file specified in args, insert to db
    for data_file in data_files:
        data_sql_content = ''
        data_file_path = os.path.join(DATA_DIR, data_file)
        # Read in SQL content from handle
        with Path(data_file_path, encoding='UTF-8').open(encoding='UTF-8') as file_handle:  # noqa: WPS110
            data_sql_content += file_handle.read()
            print(f'LOG: Read test data sql for {data_file}')
            file_handle.close()
        # Execute
        with get_connection_cursor(autocommit=True) as cursor:
            cursor.execute(query="""
                SET foreign_key_checks=0;
                SET sql_mode='';
                SET global sql_mode='';
                """)
            cursor.execute(data_sql_content)
            print(f'LOG: Succesfully inserted test data sql for {data_file}')
            cursor.execute(query="""
                    SET foreign_key_checks = 1;
                    SET SQL_MODE='ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
                    SET GLOBAL SQL_MODE = 'ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
                """)
            cursor.close()


if __name__ == '__main__':
    insert_data([OPAL_TEST_DATA_NAME])
