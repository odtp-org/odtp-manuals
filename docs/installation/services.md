# Third party services needed by ODTP

ODTP requires two external services to function.
Please ensure that you have installed them in docker on your machine.
In square bracket "[]" you find variables that you have to provide before running a command.
These variable are also reused in the installation of ODTP and other services, please have them ready.

## 1. Get your IP address
To connect the services we will need your IP address and remember it is `[LOCAL_IP]`. 

```
ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
```


## 2. Install MongoDB

You can deploy a mongoDB in an ubuntu server by using the following docker command.

```
docker run -it \
    --name mongodb-instance\
    -v /home/[OS_USER]/mongodb:/data/db \
    -e MONGO_INITDB_ROOT_USERNAME=[MONGO_DB_USER] \
    -e MONGO_INITDB_ROOT_PASSWORD=[MONGO_DB_PASSWORD] \
    -e MONGO_INITDB_DATABASE=[ODTP_DB] \
    -p 27017:27017 \
    mongo:latest
```
You need to provide the `[OS_USER]` on which you are installing ODTP.
With this command you are also creating a `[MONGO_DB_USER]` and `[MONGO_DB_PASSWORD]` that ODTP will use to log information.
Select the name for the `[ODTP_DB]`, we recommend `odtp`.

!!! note

    - If your operation system is OSX, the -v directory is not /home/[OS_USER] but /Users/[OS_USER]
    
### 3. Install MongoDB Dashboard

To inspect and ODTP logs, you can use the [Mongo-Express dashboard](https://github.com/mongo-express/mongo-express) which you can install with the following command in docker:

```
docker run -it --rm \
    --name mongo-express-odtp\
    -p 8082:8081 \
    -e ME_CONFIG_OPTIONS_EDITORTHEME="ambiance" \
    -e ME_CONFIG_BASICAUTH_USERNAME=[MONGO_EXPRESS_USER] \
    -e ME_CONFIG_BASICAUTH_PASSWORD=[MONGO_EXPRESS_PASSWORD] \
    -e ME_CONFIG_MONGODB_URL="mongodb://[MONGO_DB_USER]:[MONGO_DB_PASSWORD]@x[LOCAL_IP]:27017/" \
    mongo-express
```

You have to reuse `[MONGO_DB_USER]` and `[MONGO_DB_PASSWORD]` from step 2 of installing MongoDB and your local IP from step 1.
With this command you are also creating a `[MONGO_EXPRESS_USER]` and `[MONGO_EXPRESS_PASSWORD]` that you can use to access the dashboard for MongoDB.

## 4. Install and setup Minion S3

${\textsf{\color{red}Disclaimer}}$: Under development. The open source minion S3 is still to be tested extensively.  

The digital twins will store information in Minio and the following command creates the minio server:

```
docker run \
    -p 9000:9000\
    -p 9001:9001\
    --name minio-instance\
    -e "MINIO_ROOT_USER=[MINIO_USER]"\
    -e "MINIO_ROOT_PASSWORD=[MINIO_PASSWORD]"\
    -v /home/[OS_USER]/minio/data:/data minio/minio server\
    --console-address :9001 /data
```

You need to provide the `[OS_USER]` on which you are installing ODTP.
With this command you are also creating a `[MINIO_USER]` and `[MINIO_PASSWORD]` that you can use to access the Minio for MongoDB.


!!! note

    - If your operation system is OSX, the `[MINIO_USER]` and `[MINIO_PASSWORD]` need to be registered with OSX. You either need to create a new account for ODTP on your OS or reuse your own credentials at your own peril.
    
    - If your operation system is OSX, the -v directory is not /home/[OS_USER] but /Users/[OS_USER]

Once the Minio is running, proceed to `localhost:9001` in a browser and create a bucket with the name `[ODTP_BUCKET]`.
We recommend to call it `odtp`.


## 5. Continue ODTP installation

Please head back to the main [local installation guide](odtp-local-installation.md).
