# ODTP Introduction

<legal:ODTP> is a framework that allows to combine tools that have been developed independently from each other into workflows that can achieve a common goal. 

OTDP originated in the mobility sector, see [Acknowledgement and Funding](legal-notice/acknowledgement.md) to enable the composition of Digital Twins. But the framework can be used for any purpose where tools need to be combined into workflows.

## How ODTP stands out from other workflow managers

Most workflow managers fall into two categories:

- Workflows are build within a homogenous project and defined in just one programming language, example [Metaflow](https://metaflow.org/)
- Workflow tasks are written in a special language, example [Airflow](https://airflow.apache.org/)

The goal of ODTP is instead:

- use heterogenous tools in the way they have been developed 
- wrap them and transform them into ODTP components to make them usable by the ODTP Orchestrator

``` mermaid
graph LR;
    ToolVersion -->|transform into reusable component| ODTPComponent
    subgraph ODTPComponent[Component]
    Component[ODTPAdapter]
    Commit[ToolVersion]
    end
``` 

## Tools that can be turned into ODTPComponents

The tools can be of the following kinds:

- Data loading
- Data preparation
- Data analysis
- Data visualization

See [component Types](components/types.md).

## Workflow of Components

The tools that have been transformed into components can then be used in Workflows: ODTP aims to support workflows that are acyclic graphs, but so far only linear pipelines are supported.

``` mermaid
graph RL;
    subgraph ODTP     
        direction LR
        ODTPComponentA --> ODTPComponentB
        ODTPComponentB --> ODTPComponentC
        subgraph ODTPComponentA[ComponentA]
            AAdapter[ODTPAdapter]
            ATool[ToolA]
        end
        subgraph ODTPComponentB[ComponentB]
            BAdapter[ODTPAdapter]
            BTool[ToolB]
        end
        subgraph ODTPComponentC[ComponentC]
            CAdapter[ODTPAdapter]
            CTool[ToolB]
        end  
    end
    ToolA
    ToolB
    ToolC
``` 

## Getting started with ODTP

Depending on your interest we recommend the following ways to get started with ODTP:

### Usage

In order to be able to use the framework you need to install it

[Install ODTP](installation/index.md){ .md-button }

If you have it installed then we have a tutorial that teaches you  how to use ODTP:

[ODTP Tutorials](tutorials/index.md){ .md-button }

### Concepts

If you want to understand the framework:

- [ODTP Orchestrator](orchestrator/index.md) describes the app ODTP and its architecture
- [ODTP Components](components/index.md) teaches you how to select and build components
- [ODTP Workflows](workflows/index.md) describes how to combine components into workflows
- [ODTP Zoo](zoo/index.md) describes a planned but not yet implemented registry for components
