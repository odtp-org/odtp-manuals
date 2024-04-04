# ODTP Installation

There are 2 main ways of installing ODTP depending on whether you are developing or deploying digital twins:

- For development, you can deploy all the services and execute ODTP via the `docker compose`
- or for deployment you can install the python tool and all the third-party dependencies manually

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

## Easy deployment with `docker-compose.yml`
For test and development purposes we recommend to use the dockerized ODTP.
However this makes use of "Docker in Docker" to run the digital executions which can lead to security issues. More information [here](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/).

[Configure and deploy using docker compose](docker-compose.md){ .md-button }

## Manual deployment

For deploying digital twins we recommend to use ODTP as a local installation.
Two steps are required to get ODTP running locally on your machine:
1. Deploy all third-party dependencies following this [guide](odtp-third-party-services.md).
2. Install ODTP locally following these [instructions](odtp-local-installation.md).

<script src="https://hypothes.is/embed.js" async></script>
