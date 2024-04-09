"""Generate model structure file from viewing current database."""
import io
import sys
from typing import Any

from sqlacodegen.codegen import CodeGenerator
from sqlalchemy import MetaData, create_engine

from db_management.connection import connection_url
from db_management.settings import DB_NAME_OPAL


def generate_models(outfile: Any = None) -> None:
    """Generate the initial database model structure based on existing db state.

    To do this we use sqlacodegen: https://pypi.org/project/sqlacodegen/

    Args:
        outfile: Name of file to store database model
    """
    engine = create_engine(connection_url(DB_NAME_OPAL))
    metadata = MetaData()
    metadata.reflect(engine)
    outfile = io.open(outfile, 'w', encoding='utf-8') if outfile else sys.stdout
    generator = CodeGenerator(metadata)
    generator.render(outfile)


if __name__ == '__main__':
    # Generate models for OpalDB
    generate_models('test_models.py')
