"""Generate model structure file from viewing current database."""
import io
import os
import sys

from dotenv import load_dotenv
from sqlacodegen.codegen import CodeGenerator
from sqlalchemy import MetaData, create_engine


def generate_models(host, user, password, database, outfile=None):
    """Generate the initial database model structure based on existing db state.

    To do this we use sqlacodegen: https://pypi.org/project/sqlacodegen/

    Args:
        host: Docker internal host OR 127.0.0.1 for other database hosts (eg XAMPP)
        user: DB username
        password: DB password
        database: DB name
        outfile: Name of file to store database model
    """
    engine = create_engine(f'mariadb+mariadbconnector://{user}:{password}@{host}/{database}')
    metadata = MetaData(bind=engine)
    metadata.reflect()
    outfile = io.open(outfile, 'w', encoding='utf-8') if outfile else sys.stdout
    generator = CodeGenerator(metadata)
    generator.render(outfile)


if __name__ == '__main__':
    # Read environment variables
    load_dotenv()
    HOST = os.getenv('DOCKER_HOST')
    PORT = os.getenv('MARIADB_PORT')
    USER = os.getenv('MARIADB_USER')
    PASS = os.getenv('MARIADB_PASSWORD')
    DB = os.getenv('LEGACY_OPAL_DB_NAME')
    # Generate models for OpalDB
    generate_models(HOST + ':' + PORT, USER, PASS, DB, 'models.py')  # noqa: WPS336
