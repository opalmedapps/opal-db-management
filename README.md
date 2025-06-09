<!--
SPDX-FileCopyrightText: Copyright (C) 2021 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>

SPDX-License-Identifier: AGPL-3.0-or-later
-->

# DB Docker

Opal currently has several different databases for the various services it provides.
Some of these are from legacy systems and over time will continue to have their functionality ported to the new backend component (using the Django web framework) via the strangler fig pattern.
The databases maintained in this repository include:

1. OpalDB (Legacy)
1. QuestionnaireDB (Legacy)
1. OrmsDatabase (Legacy)
1. OrmsLog (Legacy)
1. OpalReportDB (Legacy)

The backend database is maintained and managed directly in the backend repository.

## Installation

### Prerequisites

- Install Docker on your local machine (it is recommended to install [Docker Desktop](https://www.docker.com/products/docker-desktop))
- Have git installed on your local machine

### Step 1: Clone the current repository

```shell
git clone https://gitlab.com/opalmedapps/db-docker.git
```

### Step 2: Create a local `.env` file

Create a `.env` file at the root of the project and copy the content of `.env.sample` to it.
The file will hold our database credentials and is ignored by git.

Pay close attention to the following variable:

1. `USE_SSL` - leave this at `0` unless you want to run the database with encrypted connections, which will require the generation of SSL certificates (see section below on [Running the databases with encrypted connections](#running-the-databases-with-encrypted-connections))

### Step 3: Scaffold the project using `docker compose`

The `docker compose` command uses the directive written in the `compose.yaml` file to initiate the required container for a project.
In our case, it runs a database service using the MariaDB image, `adminer` as a web GUI to interact with the database, and an `app` service to manage database migrations and test data.
Database information (username, password, etc) and port are set in the `.env` file.

To scaffold our project simply run the command:

```shell
docker compose up -d adminer
```

This starts adminer and the database.

**Hint:** remove `-d` to run in the foreground instead of detached mode.

Once the database server is initialized and all databases created, run the `app` service to migrate the databases with `alembic`:

```shell
docker compose run --rm app
```

See further below for inserting the test data.

### Step 4: Test your installation

As mentioned in step 3, the docker compose command also runs an `adminer` container.
To access the UI in a web browser visit: http://localhost:8090/

The credentials for logging in can be found in the `.env` file.

You should by now have fully up and running databases that can be easily started and stopped using the Docker Desktop GUI (or via the command-line, whichever you prefer).

### Step 5: Insert test data

In order to facilitate deployments to new institutions and development, we have split test data used by developers from "initial" data used by institutions in production environments.
These two sets of data can be inserted separately from the CLI.
Note that, generally speaking, initial data should be considered the "base" dataset upon which test data can optionally be added.

To facilitate rapid resetting of all data, the following script can be called which will truncate all databases, insert all initial data, insert all test data, and insert Opal general institution test data according to the required command line institution argument (`omi` for `Opal Medical Institution` or `ohigph` for `OHIG Pediatric Hospital`).

```shell
docker compose run --rm app db_management/reset_data.sh <institution>
```

## Contributing

First, create a virtual environment and install the dependencies:

```shell
python3 -m venv --upgrade-deps .venv
source .venv/bin/activate
pip install -r requirements/development.txt
```

This project uses [pre-commit](https://pre-commit.com), install the hooks:

```shell
pre-commit install
```

This project provides vscode extension recommendations and settings.
Please install them for a seamless developer experience.

The tools we use can either be invoked via `pre-commit` or directly.
For `pre-commit` you can run them all via `pre-commit run --all` or the desired hook via `pre-commit run ruff --all`.

### Linting

[ruff](https://docs.astral.sh/ruff/) is used for linting and formatting.
To invoke it directly:

```shell
# linting only
ruff check
# lint and autofix
ruff check --fix
# format (after fixing)
ruff format
```

Ensure that the [ruff vscode extension](https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff) is installed to fix and format on save.

### Static Type Checking

[mypy](https://www.mypy-lang.org/) is used for static type checking.
To invoke it directly:

```shell
mypy db_management
```

Ensure that the [mypy vscode extension](https://marketplace.visualstudio.com/items?itemName=ms-python.mypy-type-checker) to get type checking results in the text editor.

### Tests

[pytest](https://pytest.org/) is used to run tests.
To run all tests, execute:

```shell
pytest
```

We use the `pytest` plugin [`pytest-alembic`](https://github.com/schireson/pytest-alembic) to test alembic migrations.
The tests are also run in the pipeline.
In addition, an additional job ensures that the test data scripts succeed.

**Important:** The tests are currently run on the same database (not on an additional test database).
If you run `pytest` locally your databases will end up being downgraded after the test run.

## Running the databases with encrypted connections

If a developer chooses they can also enable SSL/TLS to enforce encryption of all DB connections and traffic.

Follow the guide to [generate self-signed certificates](https://opalmedapps.gitlab.io/docs/development/guides/self_signed_certificates/).

### Configuring the use of TLS

To enable TLS in MariaDB and all application containers:

1. In the `.env` file, set `USE_SSL=1` and fill in the `SSL_CA` variable with the path to the public key of the certificate authority file (e.g., `/certs/ca.pem`).
    Note that this file needs to be accessible inside the containers (the setup provides a volume moount from `./certs` to `/certs` already).

1. Finally, copy the docker compose SSL override file so that it automatically applies when running compose commands:

    ```shell
    cp compose.ssl.yaml compose.override.yaml
    ```

    You can verify that it is applied by running `docker compose config`.

    **Note:** [Windows users may have to re-save the `ssl.cnf` as 'read-only'](https://stackoverflow.com/a/51854668) for Docker to actually use the configs listed there.

## Alembic Database Revisions Management

[Alembic](https://alembic.sqlalchemy.org/en/latest/) is a database migrations tool written by the author of SQLAlchemy. It provides a system of object-oriented, ordered migration control for relational databases.

[SQLAlchemy](https://docs.sqlalchemy.org/en/latest/) uses an Object-Relational Mapper (ORM) similar to Django to maintain a consistent state between python objects and the SQL tables they represent.

An understanding of both is required to manage database revisions in this repository.

### Alembic commands

First assure your db-docker container is built and running so that Alembic can see and connect to it with the connection engine. When we make changes to the ORM (in models.py) and run alembic auto migrations, alembic will compare the state of the current database to it's "translation" in the ORM and produce a migration file to express the difference.

#### Altering database schema example

The models file contains schema for every table in the database. It's organized alphabetically-ish but you'd be wise to just use Ctrl-F to find your model.

To make a change to the database schema, we express our changes in the models file
and let the ORM determine how to translate those model changes into DDL.
Alembic provides an autogenerate feature to automatically translate the difference between the previous revision
and the current state of the models.
In models.py we could edit the Patient model as follows to add a new `LastLoginDate` field, for example:

```python
class Patient(Base):
    __tablename__ = 'Patient'
    PatientSerNum = Column(INTEGER(11), primary_key=True, index=True)
    PatientAriaSer = Column(INTEGER(11), nullable=False, index=True)
    PatientId = Column(String(50), nullable=False)
    ...
    ...
    ...
    LastLoginDate = Column("last_login_date", DateTime)
```

With the db container still running, open a separate bash CLI and run the autogenerate feature of alembic from a new alembic container. You will need to specify the name of the database in which you want to generate the migration, for example for OpalDB:

Call the autogenerate command:

```shell
docker compose run --rm app alembic --name opaldb revision --autogenerate -m 'add_last_login_to_patient'
```

Note: When interacting with `alembic` you need to provide the database you want to run commands on using the `--name` argument. In the example above we are specifying that the autogenerate feature should target OpalDB.

This will result in a migration file containing `upgrade` and `downgrade` functions used respectively to apply or revert the migration. Always double check the contents of the autogenerated file to ensure it is correct according to your specifications. Also be sure to pause the db-containers and re-run them with `docker compose up` to see your new migration successfully run. The migration file will look something like this after you have cleaned it up:

```python
from alembic import op
import sqlalchemy as sa

def upgrade():
    op.add_column('Patient', sa.Column('last_login_date', sa.DateTime))

def downgrade():
    op.drop_column('Patient', 'last_login_date')
```

It's important to generate migrations in this way (by first modifying `models.py` and then running `autogenerate`).
If migrations were written from scratch (without using `models.py`), the models file would fall behind the up-to-date state of the database,
and any future use of the autogenerate feature would cause Alembic to try to undo all of the manually-generated revisions.

Alembic inserts the version identifier tag of the latest migration file into the `alembic_version` table in the database to keep track of the database state. Be sure not to manually delete or otherwise edit that table.
Note: When interacting with `alembic` you need to provide the database you want to run commands on using the `--name` argument. For example, `alembic --name opaldb current`.

To go to the latest version for the database, simply run `alembic --name <dbname> </dbname>upgrade head` (prefixing the command with `docker compose run --rm...` as shown above). You can alternatively just pause the existing db-docker containers, then re-run them with the regular command `docker compose up`. Alembic will remember its previous revision number using the `alembic_version` table in OpalDB and it will see that there is a new 'head' revision that needs to be run.

#### Informational only: Inserting new test data

**Note:** The description of the ten commands below is left for informational purposes, but these are not required to be run if the `reset_data` script is called first (see the [inserting test data](#step-5-insert-test-data) section).

Optional: To remove data in all tables with the exception of the `alembic_version` run the following commands, noting that these sweeping truncates can only be run if the database's `BuildType` table is set to `Development`. This check is implemented to prevent accidentally truncating real Production databases.

```shell
docker compose run --rm app python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/truncate/
```

```shell
docker compose run --rm app python -m db_management.run_sql_scripts QuestionnaireDB db_management/questionnairedb/data/truncate/
```

```shell
docker compose run --rm app python -m db_management.run_sql_scripts OrmsDatabase db_management/ormsdb/data/truncate/
```

Insert initial data to OpalDB:

```shell
docker compose run --rm app python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/initial/
```

Insert data specific to the institution (patients, hospital sites etc.):

```shell
docker compose run --rm app python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/test/omi/
```

Note: Replace `omi` with `ohigph` to insert data for a general pediatric institute.

Insert test data to OpalDB:

```shell
docker compose run --rm app python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/test/ --disable-foreign-key-checks
```

The same commands can be used for inserting data to QuestionnaireDB and the OrmsDatabase databases, just change the database name in the first argument given to the `run_sql_scripts` module, as well as the path to the data.
So to complete your initial and test data insertions:

```shell
docker compose run --rm app python -m db_management.run_sql_scripts QuestionnaireDB db_management/questionnairedb/data/initial/
```

```shell
docker compose run --rm app python -m db_management.run_sql_scripts QuestionnaireDB db_management/questionnairedb/data/test/
```

```shell
docker compose run --rm app python -m db_management.run_sql_scripts OrmsDatabase db_management/ormsdb/data/initial/
```

```shell
docker compose run --rm app python -m db_management.run_sql_scripts OrmsDatabase db_management/ormsdb/data/test/
```

Foreign key checks are disabled by default for QuestionnaireDB due to a circular foreign key dependency between `language` and `dictionary`.

### Interacting with the Alembic container

Since the alembic container is set to exit after running, we would need to specify a command to the container to be run after the entrypoint completes.

```shell
docker compose run --rm app alembic --name <dbname> downgrade -1
```

We use the same process for any alembic-related revision work. For example to generate a new revision in OpalDB:

```shell
docker compose run --rm app alembic --name <dbname> revision --autogenerate -m 'Useful_description_of_change'
```

Note: The `--rm` flag is important as it removes this secondary alembic container generated by the compose command. If you omit the remove flag these alembic containers will pile up in your docker and potentially slow things down.

### Version controlling views, procedures, and triggers with ReplaceObjects

The model-based paradigm of vanilla SQLAlchemy/Alembic works well for tables but lacks a proper way of version controlling other database entities like views, procedures, and triggers. Our current work around is to define all of these entities with SQL in separate files and bulk create them at the start of the alembic revisions, but this is not ideal for a few reasons. First, if we wanted to support downgrading with these entities, it would mean we have to keep multiple copies of each view/procedure/trigger, one for each 'version' of that entity. Second, alembic migrations are designed to be database agnostic, which will help us in switching to a different database in the future. Using the pymysql connector library to do our manual SQL inserts also increases the overall footprint of the image, and isn't consistent with the general alembic workflow.

If we were using postgres, we could use [alembic_utils](https://github.com/olirice/alembic_utils) which provides a handy way of version-controlling these entities. However, vanilla alembic also has it's own cookbook-concept of [ReplaceableObjects](https://alembic.sqlalchemy.org/en/latest/cookbook.html#replaceable-objects) which we can use for our use-case. In order to create a new instance of a view, procedure, event, or trigger, follow the example set in the `_create_triggers` opaldb version file. It is as simple as creating an empty version file, then declaring a new `ReplaceableObject` with a name and sql text for that entity. Then call the custom operation on the entity and run the alembic upgrade as normal.

## Optional: Running DBV (legacy)

If you need to run DBV, you can use the last built image that contains the remaining DBV projects.
The below command shows an example where the required environment variables are loaded from a file and a custom certificate for the TLS connection to the DB server is used.

```shell
docker run --rm --env-file $PWD/envs/dbv.env --volume $PWD/certs/muhc-trust.crt:/certs/muhc-trust.crt -p 8080:8080 registry.gitlab.com/opalmedapps/db-docker/dbv:latest
```

You can then access it on the corresponding host on port `8080`.
