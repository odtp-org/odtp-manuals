Here you can find the main principles and concepts of the ODTP

[TOC]

### Tools are turned into Components that run as Docker containers 

ODTPComponents are build and run as docker containers.

``` mermaid
graph TD;
    ToolVersion -->|transform into reusable component| ODTPComponent
    ODTPComponent -->|build| ComponentDockerImage
    ComponentDockerImage -->|run| ComponentDockerContainer
    subgraph ODTPComponent[Component]
    Component[ODTPAdapter]
    Commit[ToolVersion]
    Dockerfile[Dockerfile]
    end
``` 

### Workflows are run as chains of Docker containers that exchange data

When ODTP Components are combined into Workflows: they are run as a chain of docker containers:

``` mermaid
graph LR;
    ComponentA -->|run| OutputInput
    OutputInput -->|run| ComponentB
    subgraph OutputInput[Output = Input]
    Output[Output]
    Input[Input]
    end    
```    

### Semantic Sepcification and Validation of Inputs and Outputs

In order to make sure that components workflow run smoothly, OTDP suggests the following use of Semantic Technologies:

- Describe a components input as RDF
- Provide Shacl validation  of a components intput
- If possible derive the input specifications automaitcally (A tool for that is under construction

