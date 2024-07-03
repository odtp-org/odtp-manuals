!!! Note
    For test and development purposes we recommend to use the dockerized ODTP.
    However this makes use of "Docker in Docker" to run the digital executions which can lead to security issues. More information [here](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/).

For the setup with docker compose the following is provided at [https://github.com/odtp-org/odtp](https://github.com/odtp-org/odtp)

- `compose.yml` file that contains secrets as variables
- `.env.dist.compose` file that contains all variables that need to be set for the `docker compose`

The Installation  is done in the following steps: 

[TOC]

## Prerequisites

In order to install ODTP with Docker compose you need [Docker compose](https://docs.docker.com/compose/install/) additionally to [Docker](https://www.docker.com/) and [git](https://git-scm.com/).

## 1. Set up a folder configuration 

Create a folder (we recommend you name it `odtp`) where ODTP will locate all services, and files needed.
Create the following sub-folders: `mongodb`, `minio`, and `digital-twins`.
The file system structure should be like this:

```bash
└── odtp
    ├── mongodb
    ├── digital-twins
    └── minio
        └── odtp
```

Save the name of the path names for later use during the installation:

- absolute path to the `digital-twins` folder as `[ODTP_PATH]`
- absolute path to the `minio` folder as `[MINIO_PATH]`
- absolute path to the `mongodb` folder as `[MONGODB_PATH]`

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
    ├── mongodb
    ├── minio
    |   └── odtp
    └── digital-twins
    └── odtp
        └── compose.yml
        └── .env.dist.compose
        ...
```

## 4. Setup the enviroment variables

The `.env` should be completed by adding administrator users, passwords and configuration for the different services: 

```bash
cd odtp
cp .env.dist.compose .env
```

Then fill in your crendentials into `.env` as follows:

Decide on crendentials for the different services

- user and password for the Mongodb: `[MONGO_DB_USER]`, `[MONGO_DB_PASSWORD]` 
- user and password for Mongodb Express: `[MONGO_EXPRESS_USER]`, `[MONGO_EXPRESS_PASSWORD]` 
- user and password for Minio: `[MINIO_ROOT_USER]`, `[MINIO_ROOT_PASSWORD]` 

Decide on a port to run the OTPD Dasboard on: `[DASHBOARD_PORT]`, for example `8003`

```yaml
# environment variables for installation with docker compose
# -----------------------------------------------------------
# fill these variables in case you want to install odtp with
# docker compose

# local setup and compose

# odtp db instance in the mongo db: "odtp"
ODTP_MONGO_DB=odtp
# s3 bucket name: "odtp" 
ODTP_BUCKET_NAME=odtp

# s3 access and secret key
ODTP_ACCESS_KEY=[MINIO_ROOT_USER]      
ODTP_SECRET_KEY=[MINIO_ROOT_PASSWORD]

# your github token
GITHUB_TOKEN=[GITHUB_TOKEN]

# mongodb user and password
MONGO_DB_USER=[MONGO_DB_USER]
MONGO_DB_PASSWORD=[MONGO_DB_PASSWORD]

# mongoexpress user and password
MONGO_EXPRESS_USER=[MONGO_EXPRESS_USER]
MONGO_EXPRESS_PASSWORD=[MONGO_EXPRESS_PASSWORD]

# absolute path for docker volumes
ODTP_PATH=[ODTP_PATH]
MINIO_PATH=[MINIO_PATH]
MONGODB_PATH=[MONGODB_PATH]

# Dashboard parameters
ODTP_DASHBOARD_PORT=[DASHBOARD_PORT]
ODTP_DASHBOARD_RELOAD=False 
ODTP_DASHBOARD_JSON_EDITOR=True

# Log Level General
ODTP_LOG_LEVEL=ERROR

# Log Level when running executions
RUN_LOG_LEVEL=INFO
```

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
The `-d` flag means that the containers are going to be run in detached mode. If you want to see the logs on the terminal, omit this flag. 

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
docker exec -it odtp-odtp-1 bash
```

Start using the ODTP Dashboard: 

```bash
docker exec -it odtp-odtp-1 odtp dashboard 
```

[ODTP Tutorials](tutorials/index.md){ .md-button }
