# Easy deployment with Docker compose

${\textsf{\color{red}Disclaimer}}$: Under development. Only tested in OSX with Apple Sillicon. 

The easy way to test and develop with `ODTP` is by using Docker with our `docker-compose.yml`.
This offers the possibility of running "Docker in Docker" which can carry [some security issues](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/). Therefore it should only be used for testing and development.
For production environment running digital twins we recommend to install the tool and dependencies locally following [this guide](odtp-local-installation.md)
. 

## 1. External dependencies
In order to install ODTP you will need to download and install [Docker](https://www.docker.com/) in your machine, and git. 

## 2. Folder configuration 
Create a folder (we recommend `odtp`) where ODTP will locate all services, and files needed.
Create the following sub-folders: `mongodb`, `minion`, and `digital-twins`.
The file system structure should be like this:

```bash
└── odtp
    ├── mongodb
    ├── minion
    └── digital-twins
```

## 3. Get your IP and your Github Token
To complete the configuration of the `docker-compose.yml` we will need your `[LOCAL_IP]`: 

```
ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
```

Please have the IP ready for the configuration.

Also, go to the [Github Token page](https://github.com/settings/tokens) and generate a new classic token with full access rights.
Choose an appropriate expiration data to work with the token.
Save the name of the [GITHUB_TOKEN] for later use during the installation.

## 4. Clone the ODTP Repository
Pull the [ODTP](https://github.com/odtp-org/odtp/tree/main) repository.
We recommend to do it in the same folder you created before (e.g.. `odtp`)

```
git clone https://github.com/odtp-org/odtp.git
```

## 5. Edit `docker-compose.yml` 
The `docker-compose.yml` should be completed by adding administrator users, passwords and configuration for the different services.
There are four services we are going to need: `mongodb-instance`, `mongodb-express`, `minion-instance`, and `odtp`.
The variable you have to set yourself are in brackets `[]` and are used as credentials for the ODTP environment.

1. `mongodb-instance`: This is the database.
    1. Configure `environment` variables
        1. `MONGO_INITDB_ROOT_USERNAME`: `[MONGO_DB_USER]`
        2. `MONGO_INITDB_ROOT_USERNAME`: `[MONGO_DB_PASSWORD]`
        3. `MONGO_INITDB_DATABASE`: `[ODTP_DB]`, we recommend to name it `odtp`
    2. Configure volume: 
        1. Modify `/Absolute/Path/To/ODTP/Services/Folder/mongodb` to match your `mongodb` folder from step 2.
2. `mongodb-express`: This is the database dashboard
    1. Configure `environment` variables
        1. `ME_CONFIG_BASICAUTH_USERNAME`: `[MONGO_EXPRESS_USER]`
        2. `ME_CONFIG_BASICAUTH_PASSWORD`: `[MONGO_EXPRESS_PASSWORD]`
        3. `ME_CONFIG_MONGODB_URL`: `mongodb://[MONGO_DB_USER]:[MONGO_DB_PASSWORD]@[LOCAL_IP]:27017/`
3. `minion-instance`: This is the s3 server
    1. Configure `environment` variables
        1. `MINIO_ROOT_USER`: `[MINIO_USER]`
        2. `MINIO_ROOT_PASSWORD`: `[MINIO_PASSWORD]`
    2. Configure volume: 
        1. Modify `/Absolute/Path/To/ODTP/Services/Folder/minion` to match your `minion` folder
4. `odtp`: This is the odtp instance
    1. Configure `environment` variables
        1. `ODTP_MONGO_SERVER`: `mongodb://[MONGO_DB_USER]:[MONGO_DB_PASSWORD]@[LOCAL_IP]:27017/`
        2. `ODTP_S3_SERVER`: `http://[LOCAL_IP]:9000`
        3. `ODTP_BUCKET_NAME`: `[ODTP_BUCKET]`, we recommend to name it `odtp`
        4. `ODTP_ACCESS_KEY`: `[MINIO_USER]` 
        5. `ODTP_SECRET_KEY`: `[MINIO_PASSWORD]` 
        6. `GITHUB_TOKEN`: gh_...
        7. `ODTP_MONGO_DB`: `[ODTP_DB]`
    2. Configure volume: 
        1. Modify `/Absolute/Path/To/ODTP/DT/FOLDER` to match your `digital-twins` folder.
    3. Configure ports: Depending on the components you want to run you may add more ports mappings here. `8000` is reserved for ODTP GUI.

## 6. Configuring .env file. 

In order to connect to MongoDB and S3. You need to provide the credentials in an enviroment file with the following structure. This .env file needs to be in the folder where odtp is executed.

1. Rename `.env.dist` as `.env`
2. Populate it with all credentials that have been generated in the `docker-compose.yml`.

Your `.env`-file should look something similar to this with the correct credentials replacing the variable names:
```
ODTP_MONGO_SERVER= mongodb://[MONGO_DB_USER]:[MONGO_DB_PASSWORD]@[LOCAL_IP]:27017/
ODTP_MONGO_DB=[ODTP_DB]
ODTP_S3_SERVER= http://[LOCAL_IP]:9000
ODTP_BUCKET_NAME=[ODTP_BUCKET] 
ODTP_ACCESS_KEY=[MINIO_USER]       
ODTP_SECRET_KEY=[MINIO_PASSWORD]
GITHUB_TOKEN=[GITHUB_TOKEN]
```

## 7. Execution 
Run `docker compose up`. This will retrieve all the services images and deploy them. 

## 8. S3 Bucket creation in minion dashboard
Before start using `ODTP`, we need to manually create the bucket by accessing to `[LOCAL_IP]:9001`. Here access with the credentials you generated previously and create a new bucker call `odtp`. 

## 9. ODTP initial configuration
After this is done you should be able to execute `odtp setup initiate` which will finish the configuration of the database and s3 instance. This needs to be run in docker assuming that the container is called `odtp-odtp-1`:

```
docker exec -it odtp-odtp-1 odtp setup initiate
```

## 10. ODTP Execution and testing
Now you use `ODTP` directly via the CLI or via the GUI by executing `odtp dashboard`. 

You can test than the system is working by creating a new user in the database: 

``` bash
odtp new user-entry \
--name Pedro \
--email vote@for.pedro \
--github pedro
```

``` bash
user ID: 65c3648260106cc50f650bc1
```

Now that everything has been set up, you are ready to work. Head over to the [tutorials](tutorials/getting-started.md) 

<script src="https://hypothes.is/embed.js" async></script>
