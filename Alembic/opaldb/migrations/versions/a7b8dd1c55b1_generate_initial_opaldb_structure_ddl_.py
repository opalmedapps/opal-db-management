"""Generate initial OpalDB structure DDL & DML.

This migration assumes the database has been created and user as write priveleges.

Revision ID: a7b8dd1c55b1
Revises:
Create Date: 2022-12-16 10:36:32.095480

"""
import os
import sys
from pathlib import Path

import pymysql
from dotenv import load_dotenv
from pymysql.constants import CLIENT
from pymysql.cursors import Cursor

# revision identifiers, used by Alembic.
revision = 'a7b8dd1c55b1'
down_revision = None
branch_labels = None
depends_on = None

# DEVELOPER NOTE
# For this initial migration only, we will manually connect to the database and generate the schema.
# As of 2022-12-16, we have copied the DDL & DML from dbv_opaldb, for future revisions please use alembic & SQLAlchemy ORM paradigm.
# See example files & README for guides on how to use these tools.

# Find root and revision data paths
ROOT_DIR = Path(__file__).parents[1]
REVISIONS_DIR = ROOT_DIR / 'revision_data'
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
    try:
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


def upgrade() -> None:
    """Insert all data & SQL scripts for dev OpalDB."""
    with get_connection_cursor(autocommit=True) as cursor:
        cursor.execute(query="""
            SET foreign_key_checks=0;
            SET sql_mode='';
            SET global sql_mode='';
            """)

    # Loop over the 10 revision folders, and their sub files, reading only '*.sql'
    for idx in range(1, 12):
        rev_folder = os.path.join(REVISIONS_DIR, str(idx))
        sql_content = ''
        for rev_file in os.listdir(rev_folder):
            if rev_file.endswith('.sql'):
                rev_file_path = os.path.join(rev_folder, rev_file)

                with Path(rev_file_path, encoding='ISO-8859-1').open(encoding='ISO-8859-1') as handle:
                    sql_content += handle.read()
                    handle.close()
        with get_connection_cursor(autocommit=True) as cursor:
            cursor.execute(sql_content)
            cursor.close()

    with get_connection_cursor(autocommit=True) as cursor:
        cursor.execute(query="""
                SET foreign_key_checks = 1;
                SET SQL_MODE='ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
                SET GLOBAL SQL_MODE = 'ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
            """)
        cursor.close()


def downgrade() -> None:
    """Undo initial schema and data migration by deleting db and re-creating."""
    with get_connection_cursor(autocommit=True) as cursor:
        cursor.execute(query="""
            SET foreign_key_checks=0;
            SET sql_mode='';
            SET global sql_mode='';
        """)

    with get_connection_cursor(autocommit=True) as cursor:
        cursor.execute(query=f"""
        DROP DATABASE {OPALDB};

        CREATE DATABASE IF NOT EXISTS {OPALDB} /*!40100 DEFAULT CHARACTER SET latin1 */;
        USE {OPALDB};
        GRANT ALL PRIVILEGES ON {OPALDB}.* TO {USER}@`%`;

        """)

    with get_connection_cursor(autocommit=True) as cursor:
        cursor.execute(query="""
        SET foreign_key_checks = 1;
        SET SQL_MODE='ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
        SET GLOBAL SQL_MODE = 'ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
        """)
