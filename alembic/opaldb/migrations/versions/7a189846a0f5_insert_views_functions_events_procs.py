"""insert-views-functions-events-procs

Revision ID: 7a189846a0f5
Revises: 85a1cf55990c
Create Date: 2023-02-01 10:41:21.466828

"""
import os
import sys
from pathlib import Path

import pymysql
from pymysql.constants import CLIENT
from pymysql.cursors import Cursor
from settings import DB_HOST, DB_NAME_OPAL, DB_PASSWORD, DB_PORT, DB_USER

# revision identifiers, used by Alembic.
revision = '7a189846a0f5'
down_revision = '85a1cf55990c'
branch_labels = None
depends_on = None

# Find root and revision data paths
ROOT_DIR = Path(__file__).parents[1]
REVISIONS_DIR = ROOT_DIR / 'revision_data'


def get_connection_cursor(autocommit: bool) -> Cursor:
    """Get a mariadb connection context manager for SQL execution.

    Args:
        autocommit: whether to always save data after executing.

    Returns:
        Cursor for the connection.
    """
    try:
        conn = pymysql.connect(
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST,
            port=DB_PORT,
            database=DB_NAME_OPAL,
            client_flag=CLIENT.MULTI_STATEMENTS,
            autocommit=autocommit,
        )
    except pymysql.Error as err:
        sys.exit('Error getting cursor for {OPALDB} {err}'.format(OPALDB=DB_NAME_OPAL, err=err.args[0]))
    return conn.cursor()


def upgrade() -> None:
    """Insert functions, events, etc for OpalDB."""
    with get_connection_cursor(autocommit=True) as cursor:
        cursor.execute(query="""
            SET foreign_key_checks=0;
            """)

    funcs_sql_content = ''
    funcs_file_path = os.path.join(REVISIONS_DIR, 'OpalDB_views_functions_events_procs.sql')
    # Read in SQL content from handle
    with Path(funcs_file_path, encoding='ISO-8859-1').open(encoding='ISO-8859-1') as file_handle:
        funcs_sql_content += file_handle.read()
        file_handle.close()
    # Execute
    with get_connection_cursor(autocommit=True) as cursor:
        cursor.execute(funcs_sql_content)
        cursor.execute(query="""
            SET foreign_key_checks = 1;
            """)
        cursor.close()


def downgrade() -> None:
    """Drop all from OpalDB."""
    with get_connection_cursor(autocommit=True) as cursor:
        cursor.execute(query="""
            SET foreign_key_checks=0;
            """)

        cursor.execute(query=f"""
        DROP DATABASE {DB_NAME_OPAL};

        CREATE DATABASE IF NOT EXISTS {DB_NAME_OPAL} /*!40100 DEFAULT CHARACTER SET latin1 */;
        USE {DB_NAME_OPAL};
        GRANT ALL PRIVILEGES ON {DB_NAME_OPAL}.* TO {DB_USER}@`%`;

        """)

        cursor.execute(query="""
                SET foreign_key_checks = 1;
            """)
        cursor.close()
