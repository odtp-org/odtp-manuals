!!! Note
    For deploying digital twins we recommend to use ODTP as a local installation as described here. In a production environment running digital twins, a local installation on the operating system is preferable. Note that this requires additional third party services to be setup along side ODTP

[TOC]

## Prerequisites

In order to install ODTP you need: 

### Docker

- [Docker](https://www.docker.com/)

### Git 

- [git](https://git-scm.com/)

On a local server, ODTP needs additionally the following services to be setup:

### Mongodb

- [Mongodb](https://www.mongodb.com/docs/manual/installation/)

Form this installation you need the following variables:

- ==[MONGO_DB_USER]== and ==[MONGO_DB_PASSWORD]== and ==[MONGO_SERVER_URL]== from the Mongodb Installation

Optional: for the Mongodb it is advisable to install also a graphical user interface for the mongodb. Options are: ¨

- https://www.mongodb.com/products/tools/compass
- https://github.com/mongo-express/mongo-express

### Minio

- [Minio](https://min.io/docs/minio/linux/operations/installation.html)

From these installations you need the following variables:

- ==[MINIO_ROOT_USER]== and ==[MINIO_ROOT_PASSWORD]== and ==[MINIO_URL]== from the Minio Installation

### Github token

You need a github token: 

Go to the [Github Token page](https://github.com/settings/tokens) and generate a new classic token with full access rights.
Choose an appropriate expiration data to work with the token.

- Save the name of the ==[GITHUB_TOKEN]== for later use during the installation. You also need your ==[GITHUB_USER]==

### Python 3.11

You also need Python3.11 installed on your Server: https://www.python.org/downloads/. Save the `[PYTHON_3_11_PATH]` on your local server.

### Poetry

As  python dependency manager ODTP uses [poetry](https://python-poetry.org/docs/#installation)

## Docker network

ODTP needs a Docker network to be setup:

```bash
docker network create odtp_odtp-network 
```

## 1. Install ODTP

Clone the repository
 
```bash
git clone https://github.com/odtp-org/odtp.git
cd odtp
```

Install ODTP

```
poetry env use [PYTHON_3_11_PATH]
poetry shell
poetry install
```

!!! Note
    On a server with Apple Chip you might need to change the shell using this command: `env /usr/bin/arch -x86_64 /bin/bash --login` before the installation.


## 2. Set the environment variables: 

Create a `.env` file from the template `.env.dist.local`

```bash
cd odtp
cp .env.dist.local .env
```

By now you should have:

- ==[MINIO_ROOT_USER]== and ==[MINIO_ROOT_PASSWORD]== and ==[MINIO_URL]== from the Minio Installation
- ==[MONGO_DB_USER]== and ==[MONGO_DB_PASSWORD]== and ==[MONGO_SERVER_URL]== from the Mongodb Installation
- ==[GITHUB_TOKEN]== and ==[GITHUB_USER]== from your github

Additionally you need:

- Minio Bucket name: ==[MINIO_BUCKET_NAME]==, recommended `odtp`
- Minio Bucket name: ==[MONGO_DB_NAME]==, recommended `odtp`
- Dashboard port: ==[ODTP_PORT]==, recommended `8003` or some other port that is not frequently used
- Working directory: ==[ODTP_PATH]==: working directory for user of ODTP, where projects and data files can be stored


```yaml
# environment variables for local installation
# ----------------------------------------------
# fill these variables in case you want to 
# install otdp locally on your computer or 
# on a server

# mongo url: example "mongodb://localhost:27017/"
ODTP_MONGO_SERVER=[MONGODB_URL]
# S3 server url: example: "https://s3.epfl.ch"
ODTP_S3_SERVER=[MINIO_URL]

# odtp db instance in the mongo db: "odtp"
ODTP_MONGO_DB=[MINIO_BUCKET_NAME]
[MONGO_DB_USER]` and `[MONGO_DB_PASSWORD]` and `[MONGO_SERVER_URL]`
# s3 bucket name: "odtp" 
ODTP_BUCKET_NAME=[MONGO_DB_NAME]

# s3 access and secret key
ODTP_ACCESS_KEY=[MINIO_ROOT_USER]     
ODTP_SECRET_KEY=[MINIO_ROOT_PASSWORD]

# your github token
GITHUB_TOKEN=[GITHUB_TOKEN]

# Dashboard parameters
ODTP_DASHBOARD_PORT=[ODTP_PORT]
ODTP_DASHBOARD_RELOAD=False


```

ODTP will use the .env file to access the services and github. Please make sure that you have entered all information correctly.

!!! note

    - Under OSX, you may be asked to accept the type change through renaming of the .env file. If you don't accept, it will be named .env but will still be of type .env.dist meaning the installation will fail. This can be fixed by creating a new file named .env with the same contents.
    - The `[ODTP_S3_SERVER]` requires the http:// 


## 5. Install ODTP and dependencies locally

We provide installation of ODTP via poetry

### Using poetry

You can install odtp by using [poetry](https://python-poetry.org/) and running: 

1. (Required for OSX) Run `poetry env use 3.11`. 
2. Run `poetry install`
3. Run `poetry shell`
4. Run `odtp --help`

This should print out the help for `odtp`.

!!! note

- For OSX, the environment needs to be set to 3.11 because there is no wheel for duckdb on arm64 (Apple Silicon) for python 3.12 and higher (last checked April 1, 2024). Poetry selects python 3.12 because there is no dependency issues but missing wheels are not accounted for.

## 6 Configure MongoDB and S3 bucket

After deployin the different services you need to run the following command in order to finish the configuration of the collections required. 

```
odtp setup initiate 
```

This command will create the collections needed in mongoDB and S3 automatically. 

## How to test that everything works? 

In order to do some test we need to create first an user: 


```
odtp new user-entry \
--name Pedro \
--email vote@for.pedro \
--github pedro
```

```
user ID: 65c3648260106cc50f650bc1
```

Now that everything has been set up, you are ready to work. Head over to the [tutorials](../tutorials/getting-started.md) 


[TOC]

Below, you can see an overview of the dependencies of services required to run ODTP. 
Ports are defined by default. Please adjust them according to your installation.

``` mermaid
graph TD;
    subgraph ODTP
    CLI[CLI]
    GUI[GUI in port 8000]
    end
    ODTP -->|requires| MongoDBInstance
    ODTP -->|requires| MinioInstance
    subgraph MongoDBInstance[MongoDB Instance]
    MongoDB[API in port 27017]
    end
    subgraph MongoDBExpress[MongoDB Express]
    MDBEGUI[GUI in port 8081]
    end
    subgraph MinioInstance[Minio Instance]
    MinioAPI[API in port 9000]
    MinioGUI[GUI in port 9001]
    end
    MongoDBExpress -->|dashboard for| MongoDBInstance
``` 