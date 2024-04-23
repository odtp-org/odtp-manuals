# ODTP Orchestrator Overview

The Orchestrator is the Application behind ODTP: it can be installed and run. 

``` mermaid
graph TD;
    ODTPOrchestartor --> |defines and runs| Executions
    ODTPOrchestartor --> |registers| ODTPComponents
    ODTPOrchestartor --> |provides service to| Users
    ODTPOrchestartor --> |registers| DigitalTwins
    Users --> |own| DigitalTwins
    DigitalTwins --> |are collections of| Executions
    Executions --> |are pipelines of| ODTPComponents
    subgraph ODTPOrchestartor
    Minio[S3: store snapshots between component runs]
    Mongodb[Mongodb: store all Metadata]
    Docker[Docker: run executions]
    end
```  

The ODTP orchestrator registers [ODTP Components](../components/index.md) allows to combine them into executable workflows and to run these executions as docker containers.

This section explains that concepts behind ODTP and its technical implementation.

## Concepts

- [Concept](concept.md)
- [Architecture](architecture.md)
- [Schema](schema.md)
- [Roadmap](roadmap.md)


## Use the orchestrator

In order to use the ODTP orchestrator you need first to install it.

[Install ODTP](../installation/index.md){ .md-button }

In case you have it already installed: the tutorials will guide you on how to use it:

[Tutorials: get started with ODTP](../tutorials/index.md){ .md-button }
