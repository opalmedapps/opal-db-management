"""Run SQL scripts from a directory on a specific database."""
import argparse
import sys
from pathlib import Path

from common import connection, settings


def run_sql_scripts(paths: list[Path]) -> None:
    """
    Run the SQL of the given list of SQL file paths.

    Args:
        paths: list of SQL file paths
    """
    cursor = connection.connection_cursor()

    for path in paths:
        print(f'LOG: Running SQL of file: {path}')

        with Path(path).open() as fd:
            sql_queries = fd.read()

        with cursor:
            cursor.execute(query="""
                SET foreign_key_checks=0;
                """)
            cursor.execute(sql_queries)
            cursor.execute(query="""
                SET foreign_key_checks = 1;
                """)

        print(f'LOG: Succesfully ran SQL for {path}')


def main(argv: list[str]) -> int:
    """
    Parse command-line arguments and run the SQL files.

    Args:
        argv: the command-line arguments passed to the script

    Returns:
        the exit code, 0 if no errors occurred
    """
    print(connection.sql_connection_parameters(settings.DB_NAME_OPAL))
    parser = argparse.ArgumentParser()
    parser.add_argument('sql_dir', metavar='sql-dir', help='the directory that contains SQL files', type=Path)

    args = parser.parse_args(argv)

    print(args.sql_dir)

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
