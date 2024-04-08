# ODTP Introduction

ODTP is a framework that allows to combine tools that have been developed independently from each other into workflows that can acchieve a common goal. 

The goal that ODTP has in mind is enabling digital twins and OTDP originated in the mobility sector, see [Acknowlegdemet and Funding](legal-notice/acknowledgement.md). But the framework can be used for any purpose where tools need to be combined into workflows.

## How ODTP stands out from other workflow managers

Most workflow managers fall into two categories:

- Workflows are build within a homogenous project and defined in just one programming language, example [Metaflow](https://metaflow.org/)
- Workflow tasks are written in a special language, example [Airflow](https://airflow.apache.org/)

The goal of ODTP is instead:

- use heterogenous tools in the way they have been developed 
- wrap them and transform them into ODTP components to make them usable by the ODTP Orchestrator

``` mermaid
graph TD;
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

## Workflow of Components

The tools that have been transformed into components can then be used in Workflows:

``` mermaid
graph TD;
    ToolA
    ToolB
    ToolC
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
``` 

## ODTP Parts 

The ODTP framework consists of the following three parts:

**ODTP components**: Developing ODTP components is a precondition to using them in the ODTP framework: See what components already exist and how to add new components: [Getting started with ODTP components](components/index.md){ .md-button }

**ODTP Orchestrator**: The ODTP orchestrator allows to combine the existing components into workflows. The workflows can then be excuted, monitored and outputs and results can be saved:
[Getting started with the ODTP orchestrator](components/index.md){ .md-button }

**ODTP Zoo**: Components can be regitered and then discovered in the ODTP Zoo: [Getting started with the ODTP zoo](zoo/index.md){ .md-button }
