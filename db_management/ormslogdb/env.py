# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""Alembic configurations and environment settings; load ORM metadata from model(s)."""

from collections.abc import Iterable
from logging.config import fileConfig

from alembic import context
from alembic.environment import MigrationContext
from alembic.operations import MigrationScript
from sqlalchemy import engine_from_config, pool

from db_management import connection, settings
from db_management.ormslogdb.models import Base

# this is the Alembic Config object, which provides
# access to the values within the .ini file in use.
config = context.config

config.set_main_option(
    'sqlalchemy.url',
    connection.connection_url(settings.DB_NAME_ORMS_LOG),
)

# Interpret the config file for Python logging.
# This line sets up loggers basically.
if config.config_file_name is not None:
    fileConfig(config.config_file_name)


target_metadata = [Base.metadata]


def run_migrations_offline() -> None:
    """
    Run migrations in 'offline' mode.

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

    # TODO: Investigate transactional migrations:
    # https://github.com/sqlalchemy/alembic/issues/755#issuecomment-735221194


def process_revision_directives(
    context: MigrationContext,  # noqa: ARG001
    revision: str | Iterable[str | None] | Iterable[str],  # noqa: ARG001
    directives: list[MigrationScript],
) -> None:
    """
    Don't create a new migration if no changes are detected.

    Args:
        context: the migration context
        revision: the revision
        directives: migration file commands
    """
    if config.cmd_opts and config.cmd_opts.autogenerate:
        script = directives[0]
        if script.upgrade_ops and script.upgrade_ops.is_empty():
            directives[:] = []


def run_migrations_online() -> None:
    """
    Run migrations in 'online' mode.

    In this scenario we need to create an Engine
    and associate a connection with the context.

    https://alembic.sqlalchemy.org/en/latest/cookbook.html#don-t-generate-empty-migrations-with-autogenerate
    We will add the configuration for Alembic to not generate empty
    migrations with autogenerate if no schema changes are detected.

    """
    connectable = engine_from_config(
        config.get_section(config.config_ini_section, {}),
        prefix='sqlalchemy.',
        poolclass=pool.NullPool,
    )

    with connectable.connect() as db_connection:
        context.configure(
            connection=db_connection,
            target_metadata=target_metadata,
            process_revision_directives=process_revision_directives,
            # https://stackoverflow.com/questions/12409724/no-changes-detected-in-alembic-autogeneration-of-migrations-with-flask-sqlalchem
            compare_type=True,  # Detect changes in col type with autogenerate
            compare_server_default=True,  # Detect changes in col defaults with autogenerate
        )

        with context.begin_transaction():
            context.run_migrations()
        # TODO: Investigate transactional migrations:
        # https://github.com/sqlalchemy/alembic/issues/755#issuecomment-735221194


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()
