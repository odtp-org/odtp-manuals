# Easy deployment with Docker compose

The easy way to test and develop with `ODTP` is by using Docker with our `docker-compose.yml`.
This offers the possibility of running "Docker in Docker" which can carry [some security issues](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/). Therefore it should only be used for testing and development.
For production environment running digital twins we recommend to install the tool and dependencies locally following [this guide](odtp-local-installation.md)
. 

The deployment in docker is done in three parts:
1. The crendentials are added in the `.env` file.
2. The containers are build with `docker compose up -d`.
3. The dependencies between containers and settings in containers are set.

!!! note

    - The third part is referenced by the first part and therefore it is important to follow this manual exactly, otherwise you will run into errors caused by the wrong execution order.

## 1. External dependencies

In order to install ODTP you will need to download and install [Docker](https://www.docker.com/) in your machine, and git. 

## 2. Folder configuration 
Create a folder (we recommend you name it `odtp`) where ODTP will locate all services, and files needed.
Create the following sub-folders: `mongodb`, `minio`, and `digital-twins`.
The file system structure should be like this:

```bash
└── odtp
    ├── mongodb
    ├── minio
    └── digital-twins
```

## 3. Get your IP and your Github Token
To complete the configuration of the `.env` we will need your Github Token: 

Go to the [Github Token page](https://github.com/settings/tokens) and generate a new classic token with full access rights.
Choose an appropriate expiration data to work with the token.
Save the name of the [GITHUB_TOKEN] for later use during the installation.

## 4. Clone the ODTP Repository
Pull the [ODTP](https://github.com/odtp-org/odtp/tree/main) repository.
We recommend to do it in the same folder you created before (e.g.. `odtp`)

```
git clone https://github.com/odtp-org/odtp.git
```

## 5. Edit `.env` 
The `.env` should be completed by adding administrator users, passwords and configuration for the different services: 

```
cp .env.dist .env
```

Then fill in your crendentials into `.env` as follows:

```
# local setup only
ODTP_MONGO_SERVER= # leave empty: will be set automatically
ODTP_S3_SERVER= # leve empty: will be set automatically

# local setup and compose
ODTP_MONGO_DB=odtp
ODTP_BUCKET_NAME=odtp
ODTP_ACCESS_KEY= # chose a user name for example: admin  
ODTP_SECRET_KEY= # chose a user name for example: test
GITHUB_TOKEN= # enter your github token

# compose only
MONGO_DB_USER= # chose a user name for example: admin
MONGO_DB_PASSWORD= # chose a user name for example: test1234
                   # (must be at least 8 characters)
MONGO_EXPRESS_USER= # chose a user name for example: admin
MONGO_EXPRESS_PASSWORD= # chose a user name for example: test1234
ODTP_PATH= # /Absolute/Path/To/ODTP/Services/Folder/digital-twins
MINIO_PATH= # /Absolute/Path/To/ODTP/Services/Folder/minio
MONGODB_PATH= # /Absolute/Path/To/ODTP/Services/Folder/mongodb
```

The `compose.yml` file will take the values from the `.env` file 
to populate its variables. You may also adjust the ports in the `compose.yml` file.

Test your configuration: 

```
docker compose config
```

This will print out a generated `docker-compose.yml` file as it will be 
used for the `docker compose up`. 

## 7. Execution 
Run `docker compose up -d`. This will retrieve all the services images and deploy them. 

<a name="bucket_creation"></a>
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
Inside the docker container you can create a new user: 

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
