import io
import sys
from sqlalchemy import create_engine, MetaData
from sqlacodegen.codegen import CodeGenerator

def generate_models(host, user, password, database, outfile = None):
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
    generate_models('host.docker.internal:3307', 'root', 'root', 'OpalDB', 'models.py')  # TODO: Read in database connection parameters from .env file