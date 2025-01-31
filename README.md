This is the README
# DBV Docker Container
Opal's databases are separared in 3 differents repos. The purpose of this project is to run a Docker container that install and manage all the DBS in one place.
## Prerequisites
- You need to have access to the 3 following repositories:
    1. OpalDB: https://gitlab.com/opalmedapps/dbv_opaldb
    2. QuestionnaireDB: https://gitlab.com/opalmedapps/dbv_questionnairedb
    3. registerdb: https://gitlab.com/opalmedapps/dbv_registerdb

- Install docker on your local machine. It is stongly suggested to install Docker-desktop as well.
    - https://www.docker.com/products/docker-desktop

- Generate an SSH key to login to Gitlab.
    - https://docs.gitlab.com/ee/ssh/index.html#generate-an-ssh-key-pair

- Have git install on your local machine

## Installation
### Step 1
**Clone the current repository**
```
git clone TBA
```
### Step 2
**Build the PHP Docker images.**
We need to build an images of the PHP setup to be able to clone the 3 dvs repos and pass our SSH public key to the Docker container. The steps of this process can be found in the `Dockerfile` at the root of the repository. to build the image from the Dockerfile run the following command at the root of the repository:
```
docker build --no-cache --ssh ssh_key=/Users/localhostuser/.ssh/id_rsa -t opaldatabases:latest .
```
You can also pass argumnents to target specifics branches of the DBVs repository using the `--build-arg` parameter as follow.
```
docker build --build-arg OPALDBV_BRANCH=staging --no-cache --ssh ssh_key=/Users/localhostuser/.ssh/id_rsa -t opaldatabases:latest .
```
There are 3 possible arguments, all default to `development`
1. OPALDBV_BRANCH="development"
2. REGISTERDBV_BRANCH="development"
3. QUESTIONNAIREDBV_BRANCH="development"
> For more information about Docker build view the [official Docker documentation](https://docs.docker.com/engine/reference/commandline/build/)

### Step 3
**Scaffold the project using docker compose**
The docker compose command use the directive writen in the `docker.compose.yml` file to initiate the required container for a project. In our case, it create a database using the MariaDb image, a PHP environement using the image built on step 2 of this guide, then finally install `adminer`, a GUI to visualise the databases. Database informations (username, password, etc) and port are also set in the `docker.compose.yml` file.

To scaffold our projet simply run the command:
```
docker compose up --build
```
If you open docker-desktop, you should see that you have a app called `opal-database` running with 3 container.
> For more information about Docker compose view the [official Docker documentation](https://docs.docker.com/compose/)

### Step 4
**Run the databases revisions**

With everything install it is now possible to run each DBV scripts to populate the 2 databases. In your web browser, go to the 3 following URL and run the scrips according to the on screen instructions.
1. http://localhost:8000/dbv/dbv_opaldb/
2. http://localhost:8000/dbv/dbv_registerdb
3. http://localhost:8000/dbv/dbv_questionnairedb/

### Step 5
**Test your installation**

As mention in step 3, the docker compose command also install adminer. To test your installation in a web browser by visiting:
- http://localhost:8090/

The credentials for logging in can be found in the `docker.compose.yml` file.

You should by now have a fully up and running opal database that can be easily start and stop using the docker desktop GUI.
