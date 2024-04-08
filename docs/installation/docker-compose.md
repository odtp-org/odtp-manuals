# Easy deployment with Docker compose

Disclaimer: Under development. Tested in OSX with Apple Sillicon. 

The easier way to test `ODTP` is by using Docker with `docker-compose.yml`. This offers the possibility of running Docker in a docker which can carry some security issues. Therefore it should only be used for testing and development. For production environment we recommend to install the tool and dependencies as described below. 

## 1. External dependencies
In order to install ODTP you will need to download and install [Docker](https://www.docker.com/) in your machine, and git. 

## 2. Folder configuration 
Create a folder where ODTP will locate all services, and files needed. Create the following folders: `mongodb`, `minion`, and `digital-twins`

## 3. Get your IP and your Github Token
To complete the configuration of the `docker-compose.yml` we will need some information. 

1. Get your IP address by using: `ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'`
2. Get your Github Token in github.com

## 4. Clone the ODTP Repository
Pull the [ODTP](https://github.com/odtp-org/odtp/tree/main) repository. We recommend to do it in the same folder you created before. 

```
git clone https://github.com/odtp-org/odtp.git
```

## 5. Edit `docker-compose.yml` 
The `docker-compose.yml` should be edited by adding administrator users, passwords and configuration for the different services we are going to need: `mongodb-instance`, `mongodb-express`, `minion-instance`, and `odtp`.

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
        1. `ODTP_MONGO_SERVER`: Mongo URL using above credentials: `mongodb://[MONGO_INITDB_ROOT_USERNAME]:[PASMONGO_INITDB_ROOT_USERNAMESWORD]@[YOUR_IP]:27017/`
        2. `ODTP_S3_SERVER`: [YOUR_IP]:9000
        3. `ODTP_BUCKET_NAME`: odtp
        4. `ODTP_ACCESS_KEY`: [MINIO_ROOT_USER] 
        5. `ODTP_SECRET_KEY`: [MINIO_ROOT_PASSWORD] 
        6. `GITHUB_TOKEN`: gh_...
        7. `ODTP_MONGO_DB`: odtp
    2. Configure volume: 
        1. Modify `/Absolute/Path/To/ODTP/DT/FOLDER` to match your `digital-twins` folder.
    3. Configure ports: Depending on the components you want to run you may add more ports mappings here. `8000` is reserved for ODTP GUI.

## 6. Configure the `.env` file
Copy the file `.env.dist` in `.env` and add add the values you previously configured in the `odtp` environment section. 

## 7. Execution 
Run `docker compose up`. This will retrieve all the services images and deploy them. 

## 8. S3 Bucket creation in minion dashboard
Before start using `ODTP`, we need to manually create the bucket by accessing to `[YOUR_IP]:9001`. Here access with the credentials you generated previously and create a new bucker call `odtp`. 

## 9. ODTP initial configuration
After this is done you should be able to execute `odtp setup initiate` which will finish the configuration of the database and s3 instance. 

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
