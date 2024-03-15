# ODTP Tool installation

!!! note

    - Remember that before running ODTP the services are required to be up and running.

    ``` mermaid
    graph TD;
        subgraph ODTP
        CLI[CLI]
        GUI[GUI in port 8000]
        end
        ODTP -->|requires| MongoDBInstance
        ODTP -->|requires| MinionInstance
        subgraph MongoDBInstance[MongoDB Instance]
        MongoDB[API in port 27017]
        end
        subgraph MongoDBExpress[MongoDB Express]
        MDBEGUI[GUI in port 8081]
        end
        subgraph MinionInstance[Minion Instance]
        MinionAPI[API in port 9000]
        MinionGUI[GUI in port 9001]
        end
        MongoDBExpress -->|dashboard for| MongoDBInstance
        
    ``` 


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
ODTP_MONGO_SERVER=
ODTP_S3_SERVER=
ODTP_BUCKET_NAME=
ODTP_ACCESS_KEY=
ODTP_SECRET_KEY=
GITHUB_TOKEN=
```

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