# DBV Docker Container

Opal's databases are separated in 4 different repos. The purpose of this project is to run a Docker container that installs and manages all the DBs in one place.

## Prerequisites

- You need to have access to the 2 following repositories:

    1. OpalDB: https://gitlab.com/opalmedapps/dbv_opaldb
    2. OpalRPT: https://gitlab.com/opalmedapps/dbv_opalrpt/

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

Pay close attention to the following variables:

1. `SSH_KEY_PATH` - set this as the absolute path to the SSH private key
2. `USE_SSL` - set this to '0' unless you want to run the database with encrypted connections, which will require the generation of SSL certificates (see section below on Running the databases with encrypted connections)

### Step 3: Build the PHP Docker images

We need to build an image of the PHP setup to be able to clone the 4 dbv repos and pass our SSH private key to the Docker build process. The steps of this process can be found in the `Dockerfile` at the root of the repository. To build the image from the Dockerfile via docker-compose, ensure that the `SSH_KEY_PATH` variable is set in `.env`.

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
> For more information about `docker build` view the [official Docker documentation](https://docs.docker.com/engine/reference/commandline/build/)

### Step 4

**Scaffold the project using docker compose**
The docker compose command uses the directive written in the `docker-compose.yml` file to initiate the required container for a project. In our case, it creates a database using the MariaDB image, a PHP environment using the image built in step 2 of this guide, then finally install `adminer`, a GUI to visualize the databases. Database information (username, password, etc) and port are set in the `.env` file.

To scaffold our project simply run the command:

```shell
docker compose up
```

**Hint:** append `-d` to run in detached mode and not keep it in the foreground.

**Note:** There is a known bug wherein the alembic container can crash on the very first setup of a database. This can happen when the db container hasn't had enough time to actually create the databases before alembic runs and tries to connect to them. If this occurs you can simply re-run `docker compose up` and the second time alembic won't crash. Alternatively, you could choose to run the three containers in proper order to guarantee no errors will occur:

```shell
docker compose up -d dbv
```

```shell
docker compose up -d adminer
```

```shell
docker compose up -d alembic
```

If you open docker-desktop, you should see that you have a app called `opal-database` running with 3 container.
> For more information about Docker compose view the [official Docker documentation](https://docs.docker.com/compose/)

### Step 5: Run the databases revisions

For the time being, the OpalReportDB is maintained with dbv. All other databases are contained within the alembic code. Run dbv to populate the report db:

1. http://localhost:8091/dbv/dbv_opalreportdb

Please scroll down to the `Inserting new test data` section to see how we insert data into OpalDB.

### Step 6: Test your installation

As mentioned in step 3, the docker compose command also runs an `adminer` container. To access the UI in a web browser visit:

- http://localhost:8090/

The credentials for logging in can be found in the `.env` file.

You should by now have fully up and running opal databases that can be easily started and stopped using the docker desktop GUI (or via the command-line, whichever you prefer).

## Running the databases with encrypted connections

If a dev chooses they can also build the containers in this repo with SSL enabled to encrypt all db connections and traffic.

### Generating Self-signed Certificates

To generate the SSL certificates for the database container and the client applications:

1. Open a bash CLI and navigate to the `certs/` directory of your db-docker. There should be three files there already, an `openssl-ca.cnf`, an `openssl-server.cnf`, and a `v3.ext`. These provide the details for openssl to generate the various certificates required to enable encrypted connections between any client application container and the database container.
2. Generate the certificate authority (CA) certificate:

    ```shell
    # Create CA private key
    openssl genrsa 4096 > ca-key.pem
    # Create CA public key
    openssl req -config openssl-ca.cnf -new -x509 -nodes -days 3600 -key ca-key.pem -out ca.pem
    ```

3. Generate the server certificate:

    ```shell
    # Create the server's private key and a certificate request for the CA
    openssl req -config openssl-server.cnf -newkey rsa:4096 -nodes -keyout server-key.pem -out server-req.pem
    # let the CA issue a certificate for the server
    openssl x509 -req -in server-req.pem -days 3600 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem -sha256 -extfile v3.ext
    ```

4. Check the validity of these certs (a message like 'certificate OK' should appear.)

    ```shell
    openssl verify -CAfile ca.pem server-cert.pem
    openssl verify -CAfile ca.pem ca.pem
    ```

### Configuring the use of SSL/TLS

To enable SSL/TLS in MariaDB and all application containers:

1. In the `.env` file, set `USE_SSL=1` and fill in the `SSL_CA` variable with the path to the public key of the certificate authority file (e.g., `/certs/ca.pem`).

2. Finally, copy the docker compose SSL override file so that it automatically applies when running compose commands:

    ```shell
    cp docker-compose.ssl.yml docker-compose.override.yml
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
docker compose run --rm alembic alembic --name opaldb revision --autogenerate -m 'add_last_login_to_patient'
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

To go to the latest version for the database, simply run `alembic --name <dbname> </dbname>upgrade head` (prefixing the command with `docker compose run --rm...` as shown above). You can alterantively just pause the existing db-docker containers, then re-run them with the regular command `docker compose up`. Alembic will remember its previous revision number using the `alembic_version` table in OpalDB and it will see that there is a new 'head' revision that needs to be run.

#### Inserting new test data

In order to facilitate deployments to new institutions and development, we have split test data used by developers from 'initial' data used by institutions in production environments. These two sets of data can be inserted separately from the CLI. Note that, generally speaking, initial data should be considered the 'base' dataset upon which test data can optionally be added.

Insert initial data to OpalDB:

```shell
docker compose run --rm alembic python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/initial/
```

Insert test data to OpalDB:

```shell
docker compose run --rm alembic python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/test/ --disable-foreign-key-checks
```

The same commands can be used for inserting data to QuestionnaireDB, just change the database name in the first argument given to the `run_sql_scripts` module, as well as the path to the data. So to complete your initial and test data insertions:

```shell
docker compose run --rm alembic python -m db_management.run_sql_scripts QuestionnaireDB db_management/questionnairedb/data/initial/
```

and

```shell
docker compose run --rm alembic python -m db_management.run_sql_scripts QuestionnaireDB db_management/questionnairedb/data/test/
```

Note the `--disable-foreign-key-checks` flag is required for OpalDB test data because currently our test data has incorrect foreign key relationships expressed in the data which have not all been fixed. Foreign key checks are disabled by default for QuestionnaireDB due to a circular foreign key dependency between `language` and `dictionary`.

### Interacting with the dockerized Alembic container

Since the alembic container is set to exit after running, we would need to specify a command to the container to be run after the entrypoint completes.

```shell
docker compose run --rm alembic alembic --name <dbname> downgrade -1
```

We use the same process for any alembic-related revision work. For example to generate a new revision in OpalDB:

```shell
docker compose run --rm alembic alembic --name <dbname> revision --autogenerate -m 'Useful_description_of_change'
```

Note: The `--rm` flag is important as it removes this secondary alembic container generated by the compose command. If you omit the remove flag these alembic containers will pile up in your docker and potentially slow things down.
