# ODTP Installation

There are 2 main ways of installing ODTP. You can deploy all the services and execute ODTP via the `docker-compose.yml` we provide, or install the python tool and all the third-party dependencies manually. 

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

## Easy deployment with `docker-compose.yml`
For test and development purposes we recommend to use the former, however this makes use of Docker in Docker to run the digital executions which can lead to security issues. More information [here]()

[Configure and deploy using docker compose](docker-compose.md){ .md-button }

## Manual deployment

1. First deploy all third-party dependencies following this [guide](odtp-third-party-services.md)
2. Then install ODTP locally following these [instructions](odtp-local-installation.md)
