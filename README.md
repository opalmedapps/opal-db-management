# DBV Docker Container

Opal's databases are separated in 3 different repos. The purpose of this project is to run a Docker container that installs and manages all the DBs in one place.

## Prerequisites

- You need to have access to the 3 following repositories:
    1. OpalDB: https://gitlab.com/opalmedapps/dbv_opaldb
    2. QuestionnaireDB: https://gitlab.com/opalmedapps/dbv_questionnairedb
    3. registerdb: https://gitlab.com/opalmedapps/dbv_registerdb

- Install docker on your local machine. It is strongly suggested to install Docker-desktop as well.
    - https://www.docker.com/products/docker-desktop

- Generate an SSH key to login to GitLab (if you haven't yet).
    - https://docs.gitlab.com/ee/ssh/index.html#generate-an-ssh-key-pair

> **Note:** This SSH key cannot have a passphrase. It is recommended to create a dedicated deploy key so your actual SSH key that you usually use can have a passphrase.

- Have git installed on your local machine

## Installation

### Step 1: Clone the current repository

```shell
git clone https://gitlab.com/opalmedapps/db-docker.git
```

### Step 2: Create a local `.env` file

Create a `.env` file at the root of the project and copy the content of `.env-sample` to it. The file will hold our database credentials and is ignore by GIT. You can add any other variables you want to keep local.

### Step 3: Build the PHP Docker images

We need to build an image of the PHP setup to be able to clone the 3 dbv repos and pass our SSH public key to the Docker build process. The steps of this process can be found in the `Dockerfile` at the root of the repository. To build the image from the Dockerfile run the following command at the root of the repository (due to missing support in `docker-compose` this step is separated currently):

```shell
docker build --build-arg CACHEBUST=$(date +%s) --ssh ssh_key=/Users/localhostuser/.ssh/id_rsa -t opalmedapps/dbv:latest .
```

> **Note:** This feature requires *Buildkit*. If it is not enabled by default you can follow the official instructions to [enable Buildkit builds](https://docs.docker.com/develop/develop-images/build_enhancements/#to-enable-buildkit-builds).
> **Note:** The `CACHEBUST` build argument is required in order for the Docker builder to not use the cached `git clone` commands and ensure that the latest version from the cloned DBV repositories are retrieved.
> The `$(date +%s)` argument might not work on Windows systems. You can either;
> 1- Run this command in the Windows Subsystem for Linux (WSL2).
> 2- Remove `$(date +%s)` and manually write a unique value.
> 3- Use the --no-cache argumes, which will bypass all the Docker cache system.

You can also pass argumnents to target specifics branches of the DBVs repository using the `--build-arg` parameter as follow.

```shell
docker build --build-arg OPALDBV_BRANCH=staging --build-arg CACHEBUST=$(date +%s) --ssh ssh_key=/Users/localhostuser/.ssh/id_rsa -t opalmedapps/dbv:latest .
```

There are 3 possible arguments, all default to `development`

1. OPALDBV_BRANCH="development"
2. REGISTERDBV_BRANCH="development"
3. QUESTIONNAIREDBV_BRANCH="development"

> For more information about Docker build view the [official Docker documentation](https://docs.docker.com/engine/reference/commandline/build/)

### Step 4

**Scaffold the project using docker compose**
The docker compose command uses the directive written in the `docker.compose.yml` file to initiate the required container for a project. In our case, it creates a database using the MariaDB image, a PHP environment using the image built in step 2 of this guide, then finally install `adminer`, a GUI to visualise the databases. Database information (username, password, etc) and port are set in the `.env` file.

To scaffold our projet simply run the command:

```shell
docker compose up
```

If you open docker-desktop, you should see that you have a app called `opal-database` running with 3 container.
> For more information about Docker compose view the [official Docker documentation](https://docs.docker.com/compose/)

### Step 5: Run the databases revisions

With everything install it is now possible to run each DBV scripts to populate the 2 databases. In your web browser, go to the 3 following URL and run the scrips according to the on screen instructions.

1. http://localhost:8091/dbv/dbv_opaldb/
2. http://localhost:8091/dbv/dbv_registerdb
3. http://localhost:8091/dbv/dbv_questionnairedb/

### Step 6: Test your installation

As mention in step 3, the docker compose command also install adminer. To test your installation in a web browser by visiting:

- http://localhost:8090/

The credentials for logging in can be found in the `docker.compose.yml` file.

You should by now have a fully up and running opal database that can be easily start and stop using the docker desktop GUI.
