# ODTP Components

## What is a Component in ODTP?

Components are the way tools are made available in ODTP: 

- the **tool** can be any github repo, that performs a function that is necessary for a Digital Twin, such as loading, processing or visualizing data, see [Component types](types.md)
- the **Component** is a second github repo, that checks out a version of the tool and is enables the [ODTP orchestrator](../orchestrator/index.md) to run the tool in a Docker container within ODTP, so that the execution of the tool is monitored by ODTP and the outputs are captured and can be used by other ODTP components, so that pipelines can be established. 

``` mermaid
graph LR;
    Tool -->|transform| ODTPComponent
    subgraph ODTPComponent[Component]
    Component[ODTP Client]
    Commit[checkout tool version]
    Metadata[odtp.yml]
    Docker[Dockerfile]
    end
``` 

## Component Requirements

An ODTP Component needs the following parts:

- A **Dockerfile**: that builds the Component as Docker image, so that it can be run by the [ODTP Orchestrator](../orchestrator/index.md)
- An **App script**: that will be started in the Docker container. It runs the tool and communicates its outputs, results and logs to the ODTP orchestrator
-  An **ODTP client** library is installed in the Dockerfile, so that the App script can use predefined functions to communicate with the ODTP orchestrator

``` mermaid
graph LR;
    ODTPComponent -->|run| DockerContainer
    subgraph ODTPComponent[Component]
    Client[Dockerfile: mount ODTP Client]
    App[App: call ODTP Client]
    Docker[Dockerfile: Start App]
    end
``` 

## Component as a Blackbox

You can think of the Component as a blackbox that takes inputs files and/or parameters to perfom a task. Usually this leads to some files as a result (Ephemeral component), or to a visualization (Interactive component), see [Component types](types.md)

[Develop a Component](develop.md){ .md-button }
