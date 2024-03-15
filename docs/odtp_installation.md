# ODTP Installation

## Easy deployment with Docker compose

Disclaimer: Under development. Tested in OSX with Apple Sillicon. 

The easier way to test `ODTP` is by using Docker with `docker-compose.yml`. This offers the possibility of running Docker in a docker which can carry some security issues. Therefore it should only be used for testing and development. For production environment we recommend to install the tool and dependencies as described below. 

1. In order to install ODTP you will need to download and install [Docker](https://www.docker.com/) in your machine.
2. Create a folder where ODTP will locate all services, and files needed.
    1. Create the following folders: `mongodb`, `minion`, and `digital-twins`
3. Get your IP address by using: `ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'`
4. Pull the [ODTP](https://github.com/odtp-org/odtp/tree/main) Repository: `git pull https://github.com/odtp-org/odtp.git`
5. Edit `docker-compose.yml` 
    1. `mongodb-instance`: This is the database.
        1. Configure `environment` variables
            1. `MONGO_INITDB_ROOT_USERNAME`: Username for MongoDB
            2. `MONGO_INITDB_ROOT_USERNAME`: Password for MongoDB
        2. Configure volume: 
            1. Modify `/Absolute/Path/To/ODTP/Services/Folder/mongodb` to match your `mongodb` folder
    2. `mongodb-express`: This is the database dashboard
        1. Configure `environment` variables
            1. `ME_CONFIG_BASICAUTH_USERNAME`: Username to access the dashboard
            2. `ME_CONFIG_BASICAUTH_PASSWORD`: Password to access the dashboard
            3. `ME_CONFIG_MONGODB_URL`: Mongo URL using above credentials: `mongodb://[MONGO_INITDB_ROOT_USERNAME]:[PASMONGO_INITDB_ROOT_USERNAMESWORD]@[YOUR_IP]:27017/`
    3. `minion-instance`: This is the s3 server
        1. Configure `environment` variables
            1. `MINIO_ROOT_USER`: Username for S3 login
            2. `MINIO_ROOT_PASSWORD`: Password for S3 login
        2. Configure volume: 
            1. Modify `/Absolute/Path/To/ODTP/Services/Folder/minion` to match your `minion` folder
    4. `odtp`: This is the odtp instance
        1. Configure `environment` variables
            1. `ODTP_MONGO_SERVER`: Mongo URL using above credentials: ``
            2. `ODTP_S3_SERVER`: [YOUR_IP]:9000
            3. `ODTP_BUCKET_NAME`: odtp
            4. `ODTP_ACCESS_KEY`: [MINIO_ROOT_USER] 
            5. `ODTP_SECRET_KEY`: [MINIO_ROOT_PASSWORD] 
            6. `GITHUB_TOKEN`: gh_...
            7. `ODTP_MONGO_DB`: `mongodb://[MONGO_INITDB_ROOT_USERNAME]:[PASMONGO_INITDB_ROOT_USERNAMESWORD]@[YOUR_IP]:27017/`
        2. Configure volume: 
            1. Modify `/Absolute/Path/To/ODTP/DT/FOLDER` to match your `digital-twins` folder.
        3. Configure ports: Depending on the components you want to run you may add more ports mappings here. `8000` is reserved for ODTP GUI.
6. Copy the file `.env.dist` in `.env` and add add the values you previously configured in the `odtp` environment section. 
7. Run `docker compose up`. This will retrieve all the services images and deploy them. 
8. Before start using `ODTP`, we need to manually create the bucket by accessing to `[YOUR_IP]:9001`. Here access with the credentials you generated previously and create a new bucker call `odtp`. 
9. After this is done you should be able to execute `odtp setup initiate` which will finish the configuration of the database and s3 instance. 
10. Now you use `ODTP` directly via the CLI or via the GUI by executing `odtp dashboard`. 


## How to install and configure ODTP locally?

You can install odtp by using [poetry](https://python-poetry.org/) and running: 

1. Download the repository. 
2. (Optional) Rename `.env.dist` as `.env` and populate it with the right credentials. This is essential if you want to use S3 and MongoDB. 
2. Run `poetry install`
3. Run `poetry shell`
4. Run `odtp --help`

This should print out the help for `odtp`

### Using PDM

As an alterntive [PDM](https://pdm-project.org/latest/) can be used. 

1. Download the repository. 
2. (Optional) Rename `.env.dist` as `.env` and populate it with the right credentials. This is essential if you want to use S3 and MongoDB. 
3. Run `pdm run odtp --help`

This should print out the help for `odtp`

### Configuring .env file. 

In order to connect to MongoDB and S3. You need to provide the credentials in an enviroment file with the following structure. This .env file needs to be in the folder where odtp is executed.

```
ODTP_MONGO_SERVER=
ODTP_MONGO_DB=
ODTP_S3_SERVER=
ODTP_BUCKET_NAME=
ODTP_ACCESS_KEY=
ODTP_SECRET_KEY=
GITHUB_TOKEN=
```

## Services needed

### MongoDB

You can deploy a mongoDB in an ubuntu server by using:

```
docker run --name mongodb-instance -it -v /home/[USER]/mongodb:/data/db -e MONGO_INITDB_ROOT_USERNAME=[USER] -e MONGO_INITDB_ROOT_PASSWORD=[PASS] -e MONGO_INITDB_DATABASE=odtp -p 27017:27017 mongo:latest
```

#### MongoDB Dashboard

https://github.com/mongo-express/mongo-express

```
docker run -it --rm \
    --name mongo-express-caviri \
    -p 8082:8081 \
    -e ME_CONFIG_OPTIONS_EDITORTHEME="ambiance" \
    -e ME_CONFIG_BASICAUTH_USERNAME=[USERNAME] \
    -e ME_CONFIG_BASICAUTH_PASSWORD=[PASSWORD] \
    -e ME_CONFIG_MONGODB_URL="mongodb://[USERNAME]:[PASSWORD]@xx.xx.xx.xx:xxxx/" \
    mongo-express
```

### Minion S3

Currently we use an S3 hosted at EPFL. The open source minion S3 is still to be tested. 

```
docker run -p 9000:9000 -p 9001:9001 --name minio-instance -e "MINIO_ROOT_USER=[MINIO_USER]" -e "MINIO_ROOT_PASSWORD=[MINIO_PASSWORD]" -v /home/[USER]/minio/data:/data minio/minio server --console-address :9001 /data
```

In this case the variables would be: 

```
ODTP_S3_SERVER='http://localhost:9000'
ODTP_BUCKET_NAME='your-bucket-name'  # Replace 'your-bucket-name' with your actual bucket name
ODTP_ACCESS_KEY=[MINIO_USER]         # Replace 'minioadmin' with your actual Minio access key
ODTP_SECRET_KEY=[MINIO_PASSWORD]       # Replace 'minioadmin' with your actual Minio secret key
```

Entrypoints:

```
localhost:9000
localhost:9001
```

Now you need to go to `localhost:9001` and create a bucket called `odtp`


## How to configure initially the DB and S3?

Run

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

Now that everything has been set up, you are ready to work. Head over to the [tutorials](tutorials/getting-started.md) 

