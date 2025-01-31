"""Insert test data for all specified databases."""
import os
import sys
from pathlib import Path

import pymysql
from opaldb import settings
from pymysql.constants import CLIENT
from pymysql.cursors import Cursor

# Find root and revision data paths
ROOT_DIR = Path(__file__).parents[1]
DATA_DIR = ROOT_DIR / 'app/test-data/sql'


def get_connection_cursor(autocommit: bool) -> Cursor:
    """Get a mariadb connection context manager for SQL execution.

    Args:
        autocommit: whether to always save data after executing.

    Returns:
        Cursor for the connection.
    """
    connection_params = {
        'user': settings.DB_USER,
        'password': str(settings.DB_PASSWORD),
        'host': settings.DB_HOST,
        'port': settings.DB_PORT,
        'database': settings.DB_NAME_OPAL,
        'client_flag': CLIENT.MULTI_STATEMENTS,
        'autocommit': autocommit,
        'ssl_disabled': True,
    }
    if settings.USE_SSL:
        connection_params.update({
            'ssl_disabled': False,
            'ssl_ca': settings.SSL_CA,
            'ssl_cert': settings.SSL_CERT,
            'ssl_key': settings.SSL_KEY,
        })
    try:
        conn = pymysql.connect(**connection_params)  # type: ignore[arg-type]

    except pymysql.Error as err:
        sys.exit('Error getting cursor for {OPALDB} {err}'.
                 format(
                     OPALDB=settings.DB_NAME_OPAL,
                     err=err.args[0],
                 ),
                 )
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
        with get_connection_cursor(autocommit=True) as cursor:
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
