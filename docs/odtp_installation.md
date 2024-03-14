# ODTP Installation

## How to install and configure ODTP?

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
export ODTP_S3_SERVER='http://localhost:9000'
export ODTP_BUCKET_NAME='your-bucket-name'  # Replace 'your-bucket-name' with your actual bucket name
export ODTP_ACCESS_KEY=[MINIO_USER]         # Replace 'minioadmin' with your actual Minio access key
export ODTP_SECRET_KEY=[MINIO_PASSWORD]       # Replace 'minioadmin' with your actual Minio secret key
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

