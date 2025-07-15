# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""Run SQL scripts from a directory on a specific database."""

import argparse
import sys
from pathlib import Path

from db_management.connection import connection_cursor, sql_connection_parameters


def run_sql_scripts(
    db_name: str,
    directory: Path,
    disable_foreign_key_checks: bool = False,
) -> None:
    """
    Run all SQL scripts of the given directory on the database.

    Due to the circular foreign key requirements between QuestionnaireDB.language and
    QuestionnaireDB.dictionary, the default for QuestionnaireDB is to disable foreign key checks.

    Args:
        db_name: the name of the database to connect to
        directory: the directory containing SQL scripts
        disable_foreign_key_checks: whether foreign key checks should be disabled during execution, defaults to False

    Raises:
        SystemExit: If production truncation safety check fails
    """
    for path in sorted(directory.glob('*.sql')):
        # Halt execution if db is Production and action is truncate
        try:
            _truncate_safety_check(path, db_name)
        except OSError as err:
            message = f'Error encountered during execution: {err}'
            raise SystemExit(message) from err
        print(f'LOG: Running SQL of file: {path}')
        with Path(path).open(encoding='utf-8') as fd:
            sql_queries = fd.read()

        with connection_cursor(sql_connection_parameters(db_name)) as cursor:
            if disable_foreign_key_checks:
                print('LOG: Foreign key checks temporarily disabled')
                cursor.execute(query='SET foreign_key_checks=0')

            cursor.execute(sql_queries)
            cursor.execute(query='SET foreign_key_checks=1')

        print(f'LOG: Successfully ran SQL for {path}')


def _existing_directory(directory: str) -> Path:
    """
    Convert a directory argument as a string to a Path.

    If the path does not exist an error is raised.

    Args:
        directory: the directory on the file system

    Returns:
        the path instance for the directory

    Raises:
        ArgumentTypeError: if the directory does not exist
    """
    directory_path = Path(directory)

    if not directory_path.exists():
        message = 'the directory does not exist'
        raise argparse.ArgumentTypeError(message)

    return directory_path


def _truncate_safety_check(path: Path, db_name: str) -> None:
    """
    Throw an error and halt execution if a user tries to truncate a non-Development database.

    Args:
        path: The path to the sql script being executed
        db_name: the name of the database to check

    Raises:
        OSError: If the current database build type is anything except `Development`
    """
    if 'truncate' in str(path):
        with connection_cursor(sql_connection_parameters(db_name)) as cursor:
            cursor.execute('SELECT Name FROM BuildType;')
            build_type = cursor.fetchone()
            if build_type and build_type[0] != 'Development':
                raise OSError(
                    'Cannot execute truncate file on non-development databases.' + ' Check BuildType table value.',
                )


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
        choices=['OpalDB', 'QuestionnaireDB', 'OrmsDatabase', 'OrmsLog'],
        type=str,
    )
    parser.add_argument(
        'sql_dir',
        metavar='sql-dir',
        help='the directory that contains SQL files',
        type=_existing_directory,
    )
    parser.add_argument('--disable-foreign-key-checks', action='store_true', required=False)

    args = parser.parse_args(argv)

    run_sql_scripts(args.db_name, args.sql_dir, args.disable_foreign_key_checks)

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
