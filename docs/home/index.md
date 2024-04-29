# ODTP Introduction

## About ODTP
ODTP is a framework that allows to combine tools that have been developed independently from each other into Digital Twins.

OTDP originated in the mobility sector, see [Acknowledgement and Funding](../legal/acknowledgement.md) to enable the composition of Digital Twins. But the framework can be used for any purpose where independent tools need to be combined into workflows.

## ODTP as a workflow managers

ODTP's features as workflow manager are the following:

- integrate heterogenous tools in the way they have been developed 
- wrap these tools and transform them into [Components](../components/index.md) to make them usable by the [ODTP Orchestrator](../orchestrator/index.md)
- combine [Components](../components/index.md) into [Workflows](../workflows/index.md) and run them as Executions
- monitor the executed Workflows and capture outputs, logs and configuration
- enhance interoperability by using sematic validation of inputs and outputs of Executions
- group Workflows into Digital Twins and allow to compare results between its executions
- register Components and Workflows in an [ODTP Zoo](../zoo/index.md) to make them discoverable and reusable

ODTP has both a Commandline Interface and a Graphical User Interface. It uses S3 to store outputs and Mongodb to capture Components, Workflows and Execution Metadata.

!!! Note
    Not all features of ODTP are yet operational. It is a POC, that is still under development. We encourage you to use it an give us feedback, see [Contributing](../contributing/index.md)

``` mermaid
graph RL;
    subgraph ODTP     
        direction TB
        ODTPWorkflows -.- combine -.-> ODTPComponents
        ODTPOrchestrator -.- executes -.-> ODTPWorkflows
        ODTPZoo -.- registers -.-> ODTPComponents
        subgraph ODTPComponents
            A1[Tool] -- transform --> A2[Component]
        end
        subgraph ODTPWorkflows
            B1[Components] -- combine --> B2[Workflows]
        end
        subgraph ODTPOrchestrator
            C1[Digital Twins > Executions of Workflows]
            C2[(S3:Snapshots of Data)]
            C3[(Mongo DB: Operational Metadata)]
            C1 --> C2
            C1 --> C3
        end
        subgraph ODTPZoo
            D1[Components] -- register --> D2[Index]
        end           
    end
style ODTPComponents fill:white
style ODTPWorkflows fill:white
style ODTPOrchestrator fill:white
style ODTPZoo fill:white 
``` 



## Getting started with ODTP

Depending on your interest we recommend the following ways to get started with ODTP:

In order to be able to use the framework you need to install it first:

[Install ODTP](../installation/index.md){ .md-button }

If you have have already installed ODTP, we have a tutorial that teaches you  how to use ODTP:

[Use ODTP: Getting started Tutorial](../tutorials/index.md){ .md-button }

## ODTP Concepts

If you want to understand the framework:

- [Orchestrator](../orchestrator/index.md) describes the app ODTP and its architecture
- [Components](../components/index.md) teaches you how to select and build components
- [Workflows](../workflows/index.md) describes how to combine components into workflows
- [Zoo](../zoo/index.md) describes a registry for components and how to add components there
