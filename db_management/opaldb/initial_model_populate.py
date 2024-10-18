"""Generate model structure file from viewing current database."""

import sys
from pathlib import Path

from sqlacodegen.codegen import CodeGenerator
from sqlalchemy import MetaData, create_engine

from db_management.connection import connection_url
from db_management.settings import DB_NAME_OPAL


def generate_models(outfile: str) -> None:
    """
    Generate the initial database model structure based on existing db state.

    To do this we use sqlacodegen: https://pypi.org/project/sqlacodegen/

    Args:
        outfile: Name of file to store database model
    """
    engine = create_engine(connection_url(DB_NAME_OPAL))
    metadata = MetaData()
    metadata.reflect(engine)
    output_file = Path(outfile).open(encoding='utf-8') if outfile else sys.stdout  # noqa: SIM115
    generator = CodeGenerator(metadata)
    generator.render(output_file)


if __name__ == '__main__':
    # Generate models for OpalDB
    generate_models('test_models.py')
