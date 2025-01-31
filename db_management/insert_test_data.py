"""Insert test data for all specified databases."""
import os
from pathlib import Path

from db_management.connection import connection_cursor, sql_connection_parameters
from db_management.settings import DB_NAME_OPAL

# Find root and revision data paths
ROOT_DIR = Path(__file__).parents[1]
DATA_DIR = ROOT_DIR / 'app/test-data/sql'


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
        with connection_cursor(sql_connection_parameters(DB_NAME_OPAL)) as cursor:
            cursor.execute(query='SET foreign_key_checks=0;')
            cursor.execute(data_sql_content)
            print(f'LOG: Succesfully inserted test data sql for {data_file}')
            cursor.execute(query='SET foreign_key_checks=1;')
            cursor.close()


if __name__ == '__main__':
    insert_data(['OpalDB.sql'])
