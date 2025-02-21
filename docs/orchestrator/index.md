# ODTP Orchestrator Overview

The Orchestrator is the Application behind ODTP: it can be installed and run. 

``` mermaid
graph TD;
    ODTPOrchestrator --> |defines and runs| Executions
    ODTPOrchestrator --> |registers| ODTPComponents
    ODTPOrchestrator --> |registers| Workflows
    ODTPOrchestrator --> |provides service to| Users
    ODTPOrchestrator --> |registers| DigitalTwins
    Users --> |own| DigitalTwins
    DigitalTwins --> |are collections of| Executions
    Executions --> |correspond to| Workflows
    Executions --> |are configured pipelines of| ODTPComponents
    Workflows --> |are unconfigured pipelines of| ODTPComponents
    subgraph ODTPOrchestrator
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
