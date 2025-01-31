"""Run SQL scripts from a directory on a specific database."""
import argparse
import sys
from pathlib import Path

from db_management.connection import connection_cursor, sql_connection_parameters


def run_sql_scripts(db_name: str, directory: Path, disable_foreign_key_checks: bool = False) -> None:
    """
    Run all SQL scripts of the given directory on the database.

    Args:
        db_name: the name of the database to connect to
        directory: the directory containing SQL scripts
        disable_foreign_key_checks: whether foreign key checks should be disabled during execution, defaults to False
    """
    for path in directory.glob('*.sql'):
        print(f'LOG: Running SQL of file: {path}')

        with Path(path).open() as fd:
            sql_queries = fd.read()

        with connection_cursor(sql_connection_parameters(db_name)) as cursor:
            if disable_foreign_key_checks:
                cursor.execute(query='SET foreign_key_checks=0')

            cursor.execute(sql_queries)

        print(f'LOG: Successfully ran SQL for {path}')


def main(argv: list[str]) -> int:
    """
    Parse command-line arguments and run the SQL files.

    Args:
        argv: the command-line arguments passed to the script

    Returns:
        the exit code, 0 if no errors occurred
    """
    parser = argparse.ArgumentParser()
    parser.add_argument(
        'db_name',
        metavar='db-name',
        help='the name of the database to connect to and run SQL commands for',
        choices=['OpalDB'],
        type=str,
    )
    parser.add_argument('sql_dir', metavar='sql-dir', help='the directory that contains SQL files', type=Path)
    parser.add_argument('--disable-foreign-key-checks', action='store_true', required=False)

    args = parser.parse_args(argv)

    run_sql_scripts(args.db_name, args.sql_dir, args.disable_foreign_key_checks)

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
