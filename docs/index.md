# ODTP Open Digital Twin Project

ODTP is a framework to combine independently developed tools into Digital Twins. 

## Getting started with ODTP

[Install ODTP](installation/index.md){ .md-button }
[ODTP Tutorials](tutorials/index.md){ .md-button }


## Concepts

Read about ODTP:

- [Orchestrator](orchestrator/index.md) describes the app ODTP and its architecture
- [Components](components/index.md) teaches you how to select and build components
- [Workflows](workflows/index.md) describes how to combine components into workflows
- [Zoo](zoo/index.md) describes a registry for components

``` mermaid
graph RL;
    subgraph ODTP
        direction TB
        ODTPWorkflows[ODTP Workflows] -.- combine -.-> ODTPComponents[ODTP Components]
        ODTPOrchestrator[ODTP Orchestrator] -.- executes -.-> ODTPWorkflows[ODTP Workflows]
        ODTPZoo[ODTP Zoo] -.- registers -.-> ODTPComponents[ODTP Components]
        subgraph ODTPComponents[ODTP Components]
            A1[Tool] -- transform --> A2[Component]
        end
        subgraph ODTPWorkflows[ODTP Workflows]
            B1[Components] -- combine --> B2[Workflows]
        end
        subgraph ODTPOrchestrator[ODTP Orchestrator]
            C1[Digital Twins > Executions of Workflows]
            C2[(S3:Snapshots of Data)]
            C3[(Mongo DB: Operational Metadata)]
            C1 --> C2
            C1 --> C3
        end
        subgraph ODTPZoo[ODTP Zoo]
            D1[Components] -- register --> D2[Index]
        end
    end
style ODTPComponents fill:white
style ODTPWorkflows fill:white
style ODTPOrchestrator fill:white
style ODTPZoo fill:white
```
