# ODTP Installation

## How to install and configure it?

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
ODTP_MONGO_URL=
ODTP_S3_SERVER=
ODTP_BUCKET_NAME=
ODTP_ACCESS_KEY=
ODTP_SECRET_KEY=
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

Now let's add a couple of components that will be run in sequence. And we save their ids. 

```
odtp new odtp-component-entry \
--name component-example \
--odtp-version 0.2.0 \
--component-version 0.0.1 \
--repository https://github.com/odtp-org/odtp-component-example \
--commit 6471218


odtp new odtp-component-entry \
--name component-test-vis \
--odtp-version 0.2.0 \
--component-version 0.0.1 \
--repository https://github.com/odtp-org/odtp-vis-test \
--commit 8c027e9
```

In our case is, in yours the id will be different:
```
component-example ID: 65c36599a95e22284b07e823
component-example version ID:   65c36599a95e22284b07e824

component-test-vis ID: 65c365a9e94d273db99b6cec
compoent-test-vis version ID: 65c365a9e94d273db99b6ced
```

Now we need to create a new digital twin entry that should be associated to an user. So copy and replace the `user-id` obtained before.

```
odtp new digital-twin-entry \
--user-id 65c3648260106cc50f650bc1 \
--name test
```

It should provide a digitalTwin ID:

```
digitalTwin ID: 65c36638f20bedbcd253df34
```

Now you can create an execution entry. For this you will need: 

- `digital-twin-id`: Obtained before. 
- `name`: A name for the execution
- `components`: All components involved in the workflow aligned sequentially and separated by commas. 
    - Components should be added before in order to obtain an ID. 
- `versions`: All versions involved in the workflow aligned sequentially and separated by commas. 
    - Versions order should match components. 
- `parameters`: Parameters files separated by commas.
    - This file should contain all parameters used like in a dotenv file format.
- `ports`: Ports matching used by the containers. 
    - Components ports should be separated by `+`. i.e. `8763:3000+8501:8501`
    - Place as many `+` as connections between components. If ports are not being used in the first, and second component: i.e. `++8501:8501`

```
odtp new execution-entry \
--digital-twin-id 65c36638f20bedbcd253df34 \
--name execution-example \
--components 65c36599a95e22284b07e823,65c365a9e94d273db99b6cec \
--versions 65c36599a95e22284b07e824,65c365a9e94d273db99b6ced \
--parameters [Project to env file],[Project to env file] \
--ports +8501:8501
```

```
Execution ID: 65c3ab980c57d37eb076b6ba
```

Now we prepare the execution within one folder that we need to create previously. 

```
odtp execution prepare \
--execution-id 65c3ab980c57d37eb076b6ba \
--project-path [Project path]
```

And finally we run the execution. 

```
odtp execution run \
--execution-id 65c3ab980c57d37eb076b6ba \
--project-path [Project path]
```
