"""Initial OpalDB DML. We will use the original revision files in the same order to ensure no data insertion issues when altering tables.

Revision ID: 079cf13321aa
Revises: e97dfdd124a7
Create Date: 2022-12-15 11:02:23.190611

"""
# from alembic import op
# import sqlalchemy as sa
# from sqlalchemy.dialects import mysql
from pathlib import Path
import os
import mariadb
import mariadb.constants.CLIENT as CLIENT
from dotenv import load_dotenv
import sys

ROOT_DIR = os.path.dirname(os.path.abspath(__file__))

# revision identifiers, used by Alembic.
revision = '079cf13321aa'
down_revision = 'e97dfdd124a7'
branch_labels = None
depends_on = None

# This revision is done using mariadb connector, ONE TIME ONLY
# We want to use the SQLAlchemy ORM for future revision migrations (DML & DDL), in this case we have to use
# an alternate DB connector because alembic doesnt allow bulk raw SQL execution natively.
# Please see "example_dml_model" for an example how to use the SQA ORM for db revisions.
def get_connection_cursor(autocommit: bool):
    load_dotenv()
    HOST = os.getenv('DOCKER_HOST')
    PORT = int(os.getenv('MARIADB_PORT'))
    USER = os.getenv('MARIADB_USER')
    PASS = os.getenv('MARIADB_PASSWORD')
    DB = os.getenv('LEGACY_OPAL_DB_NAME')
    try:
        conn = mariadb.connect(
            user=USER, 
            password=PASS, 
            host=HOST, 
            port=PORT, 
            database=DB, 
            client_flag=CLIENT.MULTI_STATEMENTS,
            autocommit=autocommit
        )
        return conn.cursor()
    except mariadb.Error as e:
        print(f'Error getting cursor or connection to mariaDB (Database {DB}) {e}')
        sys.exit(1)

def upgrade() -> None:
    """Insert all data & SQL scripts for dev OpalDB."""

    with get_connection_cursor(autocommit=True) as cursor:
        cursor.execute(
        """
        SET foreign_key_checks=0;
        SET sql_mode='';
        SET global sql_mode='';
        """
        )

    # Views
    data_path = os.path.join(ROOT_DIR, '../revision_data/views.sql')
    with Path(data_path,encoding='utf8').open(encoding='utf8') as handle:
        sql_content = handle.read()
        with get_connection_cursor(autocommit=True) as cursor:
            cursor.execute(sql_content)
        handle.close()

    # Functions
    data_path = os.path.join(ROOT_DIR, '../revision_data/functions.sql')
    with Path(data_path,encoding='utf8').open(encoding='utf8') as handle:
        sql_content = handle.read()
        with get_connection_cursor(autocommit=True) as cursor:
            cursor.execute(sql_content)
        handle.close()

    # Procedures
    data_path = os.path.join(ROOT_DIR, '../revision_data/procedures.sql')
    with Path(data_path,encoding='utf8').open(encoding='utf8') as handle:
        sql_content = handle.read()
        with get_connection_cursor(autocommit=True) as cursor:
            cursor.execute(sql_content)
        handle.close()

    # Triggers
    data_path = os.path.join(ROOT_DIR, '../revision_data/triggers.sql')
    with Path(data_path,encoding='utf8').open(encoding='utf8') as handle:
        sql_content = handle.read()
        with get_connection_cursor(autocommit=True) as cursor:
            cursor.execute(sql_content)
        handle.close()

    # Event-Scheduling
    data_path = os.path.join(ROOT_DIR, '../revision_data/event-scheduling.sql')
    with Path(data_path,encoding='utf8').open(encoding='utf8') as handle:
        sql_content = handle.read()
        with get_connection_cursor(autocommit=True) as cursor:
            cursor.execute(sql_content)
        handle.close()
     
    # Bulk data insertions
    # data_path = os.path.join(ROOT_DIR, '../revision_data/data-insert.sql')
    # with Path(data_path,encoding='utf8').open(encoding='utf8') as handle:
    #     sql_content = handle.read()
    #     with get_connection_cursor(autocommit=True) as cursor:
    #         cursor.execute(sql_content)
    #     handle.close()

    with get_connection_cursor(autocommit=True) as cursor:
       cursor.execute(
        """
        SET foreign_key_checks = 1;
        SET SQL_MODE='ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
        SET GLOBAL SQL_MODE = 'ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
        """
        )


def downgrade() -> None:
    """Reverse operation clears all the inserted data and SQL constructs."""
    with get_connection_cursor(autocommit=True) as cursor:
        cursor.execute(
        """
        SET foreign_key_checks=0;
        SET sql_mode='';
        SET global sql_mode='';
        """
        )

    with get_connection_cursor(autocommit=True) as cursor:
        cursor.execute(
        """
        DROP alembic_OpalDB;
        DROP alembic_QuestionnaireDB;

        
        """
        )

    with get_connection_cursor(autocommit=True) as cursor:
        cursor.execute(
        """
        SET foreign_key_checks = 1;
        SET SQL_MODE='ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
        SET GLOBAL SQL_MODE = 'ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
        """
        )