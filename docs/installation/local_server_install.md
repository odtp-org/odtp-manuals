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

- `[MONGO_DB_USER]` and `[MONGO_DB_PASSWORD]` and `[MONGODB_URL]` from the Mongodb Installation

Optional: for the Mongodb it is advisable to install also a graphical user interface for the mongodb. Options are: ¨

- https://www.mongodb.com/products/tools/compass
- https://github.com/mongo-express/mongo-express

### Minio

- [Minio](https://min.io/docs/minio/linux/operations/installation.html)

From these installations you need the following variables:

- `[MINIO_ROOT_USER]` and `[MINIO_ROOT_PASSWORD]` and `[MINIO_URL]` from the Minio Installation

### Github token

You need a github token: 

Go to the [Github Token page](https://github.com/settings/tokens) and generate a new classic token with full access rights.
Choose an appropriate expiration data to work with the token. Save the name of the `[GITHUB_TOKEN]` for later use during the installation.

### Python 3.11

You also need Python3.11 installed on your Server: https://www.python.org/downloads/. Save the `[PYTHON_3_11_PATH]` on your local server.

### Poetry

As  python dependency manager ODTP uses [poetry](https://python-poetry.org/docs/#installation)

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

```yaml
# environment variables for local installation
# ----------------------------------------------
# fill these variables in case you want to 
# install otdp locally on your computer or 
# on a server

# mongo url: example "mongodb://localhost:27017/"
ODTP_MONGO_SERVER=
# S3 server url: example: "https://s3.epfl.ch"
ODTP_S3_SERVER=[Minio or S3 Server URL]

# odtp db instance in the mongo db: "odtp"
ODTP_MONGO_DB=
[MONGO_DB_USER]` and `[MONGO_DB_PASSWORD]` and `[MONGODB_URL]`
# s3 bucket name: "odtp" 
ODTP_BUCKET_NAME=

# s3 access and secret key
ODTP_ACCESS_KEY=     
ODTP_SECRET_KEY=

# your github token
GITHUB_TOKEN=

# Dashboard parameters
ODTP_DASHBOARD_PORT=
ODTP_DASHBOARD_RELOAD=
```





These requirements a

In a production environment running digital twins, a local installation on the operating system is preferable. 

## 1. External dependencies
In order to install ODTP you will need to download and install [Docker](https://www.docker.com/) in your machine, and git. 

## 2. Third party-services

!!! note

    - Remember that before running ODTP these services are required to be up and running.

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
        subgraph MinionInstance[Minio Instance]
        MinioAPI[API in port 9000]
        MinioGUI[GUI in port 9001]
        end
        MongoDBExpress -->|dashboard for| MongoDBInstance
        
    ``` 
To install third party services, please follow this [guide](odtp-third-party-services.md).

## 3. Download and prepare ODTP

We provide installation of ODTP via poetry as package and dependency manager.

1. Create `odtp` folder.
2. Download the [odtp](https://github.com/odtp-org/odtp) repository into the folder.

## 4. Configuring .env file. 

In order to connect to MongoDB and S3. You need to provide the credentials in an enviroment file with the following structure. This .env file needs to be in the folder where odtp is executed.

1. Copy `.env.dist.local` to `.env`
2. Populate it with all credentials
   1. The credentials have been generated while [installing third party services](odtp-third-party-services.md).
   2. Please go to the [Github Token page](https://github.com/settings/tokens) and generate a new classic token with full access rights. Choose an appropriate expiration data to work with the token. Save the name of the [GITHUB_TOKEN] for later use during the installation.

Your `.env`-file should look something similar to this with the correct credentials replacing the variable names:

```yaml
# environment variables for local installation
# ----------------------------------------------
# fill these variables in case you want to 
# install otdp locally on your computer or 
# on a server

# mongo url: example "mongodb://localhost:27017/"
ODTP_MONGO_SERVER=mongodb://[MONGO_DB_USER]:[MONGO_DB_PASSWORD]@[LOCAL_IP]:27017/
# S3 server url: example: "https://s3.epfl.ch"
ODTP_S3_SERVER=http://[LOCAL_IP]:9000

# odtp db instance in the mongo db: "odtp"
ODTP_MONGO_DB=odtp

# s3 bucket name: "odtp" 
ODTP_BUCKET_NAME=odtp

# s3 access and secret key
ODTP_ACCESS_KEY=[MINIO_USER]     
ODTP_SECRET_KEY=[MINIO_PASSWORD]

# your github token
GITHUB_TOKEN=[GITHUB_TOKEN]

# Dashboard parameters
ODTP_DASHBOARD_PORT= # some port, for example: 8003
ODTP_DASHBOARD_RELOAD=false # true is needed for development
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