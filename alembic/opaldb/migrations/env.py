"""Alembic configurations and environment settings; load ORM metadata from model(s)."""
import os
from logging.config import fileConfig
from typing import Any

from models import Base
from sqlalchemy import engine_from_config, pool
from dotenv import load_dotenv

from alembic import context

load_dotenv()
HOST = os.getenv('DATABASE_HOST')
PORT = int(os.getenv(key='DATABASE_PORT', default=3007))
USER = os.getenv('DATABASE_USER')
PASS = os.getenv('DATABASE_PASSWORD')
DB_NAME_OPAL = os.getenv('LEGACY_OPAL_DB_NAME')

# this is the Alembic Config object, which provides
# access to the values within the .ini file in use.
config = context.config

# Reset sqlalchemy target url using .env vars
config.set_main_option('sqlalchemy.url', 'mariadb+mariadbconnector://{user}:{password}@{host}:{port}/{database}'.format(user=USER, password=PASS, host=HOST, port=PORT, database=DB_NAME_OPAL))


# Interpret the config file for Python logging.
# This line sets up loggers basically.
if config.config_file_name is not None:
    fileConfig(config.config_file_name)


target_metadata = [Base.metadata]


def run_migrations_offline() -> None:
    """Run migrations in 'offline' mode.

    This configures the context with just a URL
    and not an Engine, though an Engine is acceptable
    here as well.  By skipping the Engine creation
    we don't even need a DBAPI to be available.

    Calls to context.execute() here emit the given string to the
    script output.

    """
    url = config.get_main_option('sqlalchemy.url')
    context.configure(
        url=url,
        target_metadata=target_metadata,
        literal_binds=True,
        dialect_opts={'paramstyle': 'named'},
    )

    with context.begin_transaction():
        context.run_migrations()


def process_revision_directives(directives: Any) -> None:
    """Don't create a new migration if no changes are detected.

    Args:
        directives: migration file commands.
    """
    if config.cmd_opts.autogenerate:  # type: ignore
        script = directives[0]
        if script.upgrade_ops.is_empty():
            directives[:] = []  # noqa: WPS362


def run_migrations_online() -> None:
    """Run migrations in 'online' mode.

    In this scenario we need to create an Engine
    and associate a connection with the context.

    Following this guide: https://alembic.sqlalchemy.org/en/latest/cookbook.html#don-t-generate-empty-migrations-with-autogenerate
    We will add the configuration for Alembic to not generate empty migrations with autogenerate if no shchema changes are detected.

    """
    connectable = engine_from_config(
        config.get_section(config.config_ini_section),
        prefix='sqlalchemy.',
        poolclass=pool.NullPool,
    )

    with connectable.connect() as connection:
        context.configure(
            connection=connection,
            target_metadata=target_metadata,
            # process_revision_directives=process_revision_directives, # noqa: WPS442
        )

        with context.begin_transaction():
            context.run_migrations()


if context.is_offline_mode():
    print('offline')
    run_migrations_offline()
else:
    print('online')
    run_migrations_online()
