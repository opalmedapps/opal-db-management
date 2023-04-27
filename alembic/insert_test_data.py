"""Insert test data for all specified databases."""
import os
import sys
from pathlib import Path

import pymysql
from opaldb.settings import DB_NAME_OPAL, PYMYSQL_CONNECT_PARAMS
from pymysql.cursors import Cursor

# Find root and revision data paths
ROOT_DIR = Path(__file__).parents[1]
DATA_DIR = ROOT_DIR / 'app/test-data/sql'


def get_connection_cursor() -> Cursor:
    """Get a mariadb connection context manager for SQL execution.

    Returns:
        Cursor for the connection.
    """
    try:
        conn = pymysql.connect(**PYMYSQL_CONNECT_PARAMS)  # type: ignore[arg-type]
    except pymysql.Error as err:
        sys.exit('Error getting cursor for {OPALDB} {err}'.format(OPALDB=DB_NAME_OPAL, err=err))
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
        with Path(data_file_path, encoding='UTF-8').open(encoding='UTF-8') as file_handle:
            data_sql_content += file_handle.read()
            print(f'LOG: Read test data sql for {data_file}')
            file_handle.close()
        # Execute
        with get_connection_cursor() as cursor:
            cursor.execute(query="""
                SET foreign_key_checks=0;
                """)
            cursor.execute(data_sql_content)
            print(f'LOG: Succesfully inserted test data sql for {data_file}')
            cursor.execute(query="""
                SET foreign_key_checks = 1;
                """)
            cursor.close()


if __name__ == '__main__':
    insert_data(['OpalDB.sql'])
