!!! Note
    For test and development purposes we recommend to use the dockerized ODTP.
    However this makes use of "Docker in Docker" to run the digital executions which can lead to security issues. More information [here](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/).

For the setup with docker compose the following is provided at [https://github.com/odtp-org/odtp](https://github.com/odtp-org/odtp)

- `compose.yml` production docker compose setup that is used by default with `docker compose`
- `.env.dist` explaining the env variables and should be copied to `.env`
- `compose.dev.yml` development setup of  docker compose: can be used via `docker compose -f `compose.dev.yml`

The Installation  is done in the following steps:

[TOC]

## Prerequisites

In order to install ODTP with Docker compose you need [Docker compose](https://docs.docker.com/compose/install/) additionally to [Docker](https://www.docker.com/) and [git](https://git-scm.com/).

## 1. Set up a folder configuration

Create a folder (we recommend you name it `odtp`) where ODTP will locate all services, and files needed.
Create the following sub-folders: `mongodb`, `minio`, and `digital-twins`. This folders will serve as volumes for the odtp services.

The file system structure should look like this:

```bash
└── odtp
    ├── digital-twins
    ├── minio
    |   └── odtp
    └── mongodb
```

Save the name of the path names for later use during the installation:

- absolute path to the `digital-twins` folder as `[ODTP_PATH]`
- absolute path to the `minio` folder as `[MINIO_PATH]`
- absolute path to the `mongodb` folder as `[MONGODB_PATH]`

!!! Note
    Windows users need to use Linux style syntax such as: `ODTP_PATH=/c/odtp/digitaltwins`

## 2. Get your your Github Token

To complete the configuration of the `.env` we will need your Github Token:

Go to the [Github Token page](https://github.com/settings/tokens) and generate a new classic token with full access rights.
Choose an appropriate expiration data to work with the token.

Save the name of the `[GITHUB_TOKEN]` for later use during the installation.

## 3. Clone the ODTP Repository

Pull the [ODTP](https://github.com/odtp-org/odtp/tree/main) repository.
We recommend to do it in the same folder you created before (e.g.. `odtp`)

```
git clone https://github.com/odtp-org/odtp.git
```

Afterwards your folder structure will look like this:

```bash
└── odtp
    ├── digital-twins
    ├── minio
    |   └── odtp
    └── mongodb
    └── odtp
        └── compose.yml
        └── .env.dist.compose
        ...
```

## 4. Setup the environment variables

The `.env` should be completed by adding administrator users, passwords and configuration for the different services:

```bash
cd odtp
cp .env.dist .env
```

Then fill in your credentials into `.env` as follows: you can delete parts of the
`.env` file that are only needed for the setup method `[VM]`.
In case you are not setting up the project for development, you can also delete the
sections that are only needed for `[DEV]`.

Decide on credentials for the different services

- user and password for the Mongodb: `[MONGO_DB_USER]`, `[MONGO_DB_PASSWORD]`
- user and password for Mongodb Express: `[MONGO_EXPRESS_USER]`, `[MONGO_EXPRESS_PASSWORD]`
- user and password for Minio: `[MINIO_ROOT_USER]`, `[MINIO_ROOT_PASSWORD]`

For a docker compose production setup, your `.env` file will look like this:

```yaml
# ===========================================================
# Environment variables for odtp
# Setup options:
# - [COMPOSE] `docker compose` (recommended)
# - [DEV] `docker compose -f compose.dev.yml` (for development)
# - [VM] server setup with poetry
# ===========================================================

# ===========================================================
# Credentials with other services
# - needed for all setup methods
# ===========================================================

# Credentials github
# your github token
GITHUB_TOKEN=[GITHUB_TOKEN]

# ===========================================================
# Credentials that you can choose on setup
# - needed for all setup methods
# ===========================================================

# Credentials S3
ODTP_ACCESS_KEY=[MINIO_ROOT_USER]
ODTP_SECRET_KEY=[MINIO_ROOT_PASSWORD]

# mongodb user and password
MONGO_DB_USER=[MONGO_DB_USER]
MONGO_DB_PASSWORD=[MONGO_DB_PASSWORD]

# mongoexpress user and password
MONGO_EXPRESS_USER=[MONGO_EXPRESS_USER]
MONGO_EXPRESS_PASSWORD=[MONGO_EXPRESS_PASSWORD]

# ===========================================================
# Database names
# - needed for all setup methods
# ===========================================================

# odtp db instance in the mongo db: "odtp"
ODTP_MONGO_DB=odtp

# s3 bucket name: "odtp"
ODTP_BUCKET_NAME=odtp

# ===========================================================
# ODTP Path is where the dashboard will store users,
# digital twins and executions
# - needed for all setup methods
# ===========================================================

# path where your executions run and the digital twins are stored
ODTP_PATH=[ODTP_PATH]

# ===========================================================
# Volumes to persist database content
# these must match path on your local computer
# - only needed for setup methods [COMPOSE], [DEV]
# ===========================================================

# path where s3 data is stored
MINIO_PATH=[MINIO_PATH]

# path where mongodb content is stored
MONGODB_PATH=[MONGODB_PATH]

# ===========================================================
# Operational settings: change only if needed
# ===========================================================

# Dashboard parameters
# you can chose a different port to serve the dashboard in case port
# 8003 is not available as port on your computer
ODTP_DASHBOARD_PORT=8003
# this setting should only be True during development but False in
# production
ODTP_DASHBOARD_RELOAD=False

# Log level
# Log level for the dashboard
ODTP_LOG_LEVEL=ERROR
# log level for the component runs
RUN_LOG_LEVEL=INFO

# Set to False if your docker installation does not allow the flag --gpus all
# Set to True in case you want to use GPUs
ALLOW_DOCKER_GPUS=False
```

!!! Note
    The variables `APP_PATH` and `PIP_INSTALL_ARGS="--editable"` are
    only needed for the development setup of the project with `docker compose -f compose.dev.yml`.
    In that case `APP_PATH` should be the path to the project directory on your local computer.
    For a production setup this section of the `.env` file can be deleted.

## 5. Test the docker compose configuration

Test your configuration:

```bash
docker compose config
```

This will print out a generated `docker-compose.yml` file as it will be
used for the `docker compose up`.

## 6. Build the docker containers

Run the docker compose build command in the `odtp` directory where the `compose.yml` file resides:
The build might take up to 30 minutes. As long as it is progressing from step to step it should be fine.

```bash
docker compose build --no-cache
```

## 7. Run the docker containers

Once the containers have been build, you can run them. You need to repeat this step each time you start your computer.
In case you just want to update the environment variables in the `.env` file, you can use the flag `--force-recreate`.
The `-d` flag means that the containers are going to be run in detached mode. If you want to see the logs on the terminal, omit this flag

```bash
docker compose up --force-recreate -d
```

## 8. ODTP initial configuration

Enter the Docker container `odtp-odtp-1` and execute: `odtp setup initiate`. This will finish the configuration of the database and s3 instance:

```bash
docker exec -it odtp-odtp-1 odtp setup initiate
```

## 9. Ready to use ODTP

Now you are ready use `ODTP` directly via the CLI or via the GUI:

Start with the Commandline Interface of ODTP:

```bash
docker exec -it odtp-odtp-1 sh
```

Start using the ODTP Dashboard:

```bash
docker exec -it odtp-odtp-1 odtp dashboard
```

[ODTP Tutorials](../tutorials/index.md){ .md-button }
