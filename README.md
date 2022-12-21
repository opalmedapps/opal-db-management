# DBV Docker Container

Opal's databases are separated in 4 different repos. The purpose of this project is to run a Docker container that installs and manages all the DBs in one place.

## Prerequisites

- You need to have access to the 4 following repositories:

    1. OpalDB: https://gitlab.com/opalmedapps/dbv_opaldb
    2. QuestionnaireDB: https://gitlab.com/opalmedapps/dbv_questionnairedb
    3. registerdb: https://gitlab.com/opalmedapps/dbv_registerdb
    4. OpalRPT: https://gitlab.com/opalmedapps/dbv_opalrpt/

- Install docker on your local machine. It is strongly suggested to install [Docker Desktop](https://www.docker.com/products/docker-desktop) as well.

- Generate an SSH key to login to GitLab (if you haven't yet). See: https://gitlab.com/-/profile/keys
    - https://docs.gitlab.com/ee/ssh/index.html#generate-an-ssh-key-pair

> **Note:** This SSH key cannot have a passphrase. It is recommended to create a dedicated deploy key so your actual SSH key that you usually use can have a passphrase.

- Have git installed on your local machine

## Installation

### Step 1: Clone the current repository

```shell
git clone https://gitlab.com/opalmedapps/db-docker.git
```

### Step 2: Create a local `.env` file

Create a `.env` file at the root of the project and copy the content of `.env-sample` to it. The file will hold our database credentials and is ignored by git. You can add any other variables you want to keep locally.

### Step 3: Build the PHP Docker images

We need to build an image of the PHP setup to be able to clone the 4 dbv repos and pass our SSH private key to the Docker build process. The steps of this process can be found in the `Dockerfile` at the root of the repository. To build the image from the Dockerfile via docker-compose, ensure that the `SSH_KEY_PATH` variable is set in `.env`.run the following command at the root of the repository (due to missing support in `docker-compose` this step is separated currently):

```shell
docker compose build --build-arg CACHEBUST=$(date +%s)
```

If you prefer to build the image separately use the following command:

```shell
docker build --build-arg CACHEBUST=$(date +%s) --ssh ssh_key=/Users/localhostuser/.ssh/id_rsa -t opalmedapps/dbv:latest .
```

> **Note:** This feature requires *Buildkit*. If it is not enabled by default you can follow the official instructions to [enable Buildkit builds](https://docs.docker.com/develop/develop-images/build_enhancements/#to-enable-buildkit-builds).
> **Note:** The `CACHEBUST` build argument is required in order for the Docker builder to not use the cached `git clone` commands and ensure that the latest version from the cloned DBV repositories are retrieved.
> The `$(date +%s)` argument might not work on **Windows systems**. You can either:
>
> 1. Run this command in the Windows Subsystem for Linux (WSL2).
> 2. Remove `$(date +%s)` and manually write a unique value.
> 3. Use the --no-cache argument, which will bypass all the Docker cache system.

You can also pass arguments to target specifics branches of the DBVs repository using the `--build-arg` parameter as follow.

```shell
docker compose build --build-arg OPALDBV_BRANCH=staging --build-arg CACHEBUST=$(date +%s) -t opalmedapps/dbv:latest .
```

There are 4 possible arguments, all default to `development`:

1. OPALDBV_BRANCH="development"
2. REGISTERDBV_BRANCH="development"
3. QUESTIONNAIREDBV_BRANCH="development"
4. OPAL_REPORT_BRANCH="development"

> For more information about `docker build` view the [official Docker documentation](https://docs.docker.com/engine/reference/commandline/build/)

### Step 4

**Scaffold the project using docker compose**
The docker compose command uses the directive written in the `docker-compose.yml` file to initiate the required container for a project. In our case, it creates a database using the MariaDB image, a PHP environment using the image built in step 2 of this guide, then finally install `adminer`, a GUI to visualize the databases. Database information (username, password, etc) and port are set in the `.env` file.

To scaffold our project simply run the command:

```shell
docker compose up
```

**Hint:** append `-d` to run in detached mode and not keep it in the foreground.

If you open docker-desktop, you should see that you have a app called `opal-database` running with 3 container.
> For more information about Docker compose view the [official Docker documentation](https://docs.docker.com/compose/)

### Step 5: Run the databases revisions

With everything install it is now possible to run each DBV scripts to populate the 2 databases. In your web browser, go to the 3 following URL and run the scrips according to the on screen instructions.

1. http://localhost:8091/dbv/dbv_opaldb/
2. http://localhost:8091/dbv/dbv_registerdb
3. http://localhost:8091/dbv/dbv_questionnairedb/

### Step 6: Test your installation

As mentioned in step 3, the docker compose command also runs an `adminer` container. To access the UI in a web browser visit:

- http://localhost:8090/

The credentials for logging in can be found in the `.env` file.

You should by now have fully up and running opal databases that can be easily started and stopped using the docker desktop GUI (or via the command-line, whichever you prefer).

## Alembic Database Revisions Management

Alembic is a database migrations tool written by the author of SQLAlchemy. It provides a system of object-oriented, ordered migration control for relational databases.

https://alembic.sqlalchemy.org/en/latest/

SQLAlchemy uses an ORM similar to Django to maintain a consistent state between python objects and the sql tables they represent.

https://docs.sqlalchemy.org/en/14/

An understanding of both is required to manage database revisions in this repository.

### Alembic commands

First assure your db-docker container is built and running so that Alembic can see and connect to it with the connection engine. When we make changes to the ORM (in models.py) and run alembic auto migrations, alembic will compare the state of the current database to it's "translation" in the ORM and produce a migration file to express the difference.

Note the sections below describe the base alembic commands as if they were being run from a CLI, not a docker container. To run the alembic container and perform these commands, simply prefix with the command with `docker compose exec <container>`, in this case `docker compose exec alembic`

#### Altering database schema example

The models file contains schema for every table in the database. It's organized alphabetically-ish but you'd be wise to just use Ctrl-F to find your model.

Note we have two options for creating revisions - we can generate a blank revision file with `alembic revision -m "Add column to Patient model"`, then use alembic syntax to express our change. This first option would skip the ORM defined in models.py. In the revision file, we can add the following lines to the `upgrade()` and `downgrade()` functions:

```python
from alembic import op
import sqlalchemy as sa

def upgrade():
    op.add_column('patient', sa.Column('last_login_date', sa.DateTime))

def downgrade():
    op.drop_column('patient', 'last_login_date')
```

Option two is to express our changes in the ORM, then use alembic's autogenerate feature to automatically translate the difference between the previous revision and the current state of the models. In models.py we would edit the Patient model as follows:

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

Then call the autogenerate:

`alembic revision --autogenerate -m "Add last login date column to Patient model"`

 In general, we should be consistent about our choice of method because if we choose option 1 for several revisions, the models file will have fallen behind the up-to-date state of the database, and a future use of the autogenerate feature will cause alembic to try to un-do all of the manually-generated revisions.

Note: Alembic commands must be run from the directory corresponding to the database you want to make changes to

Finally, to apply your migration: `alembic upgrade head`
You can also optionally refer to a specific migration file with a shortened identifier code (as long as it uniquely identifies the file within that folder of versions)
For example to migrate to version file 'a7b8dd1c55b1_generate_initial_opaldb_structure_ddl_.py': `alembic upgrade a7b`

#### Version controlling triggers, events, functions, procedures

Object-oriented version control of these constructs isn't really supported 'natively' in Alembic, but there are workarounds like the one outlined here: https://stackoverflow.com/questions/67247268/how-to-version-control-functions-and-triggers-with-alembic. It still requires writing everything out in SQL though.

Note that when we first implemented Alembic, all of the existing views, triggers, events, functions, and procedures were imported with raq SQL in an initial DB setup migration.

### Generating initial model structure from existing databases

Note: This step is only necessary when the alembic models.py file is empty. It only needs to be run once initially and can be ignored afterwards.

SQLAlchemy has a support library designed to quickly generate SQLAlchemy models, given an existing SQL database and a connection url. This has been extra easy with the initial_model_populate file. In this file we specify the connection string for our dockerized OpalDB connection, and the library handles the rest and populates models.py with the table schema.

`cd alembic-<database-name>/`
`python initial_model_populate.py`

Known issues with sqlacodegen:

- For some reason is forgets to add the 's' at the end of Alias related tables so it'll be `class Alia` instead of `class Alias`
- In the situation when we have a foreign key or relationship between two tables, and those tables have identically named columns, we can get a warning because the same naming implies the mapping should combine the two columns and copy the data from one to the other. : https://docs.sqlalchemy.org/en/14/faq/ormconfiguration.html#i-m-getting-a-warning-or-error-about-implicitly-combining-column-x-under-attribute-y

### Interacting with the dockerized Alembic container

Not much changes for this, we just have to prefix our regular CLI alembic commands with the standard docker compose exec, plus the name of the container : `docker compose exec alembic`

For example to run the current revisions to the latest:

`docker compose exec alembic alembic upgrade head`
