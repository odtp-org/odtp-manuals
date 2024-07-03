# Workflow Concept

!!! warning end "Under Construction"

    - Currently only Executions are implemented in the ODTP Orchestrator: That means Workflow templates and Workflows are not yet part of the ODTP.

## Workflow Terminology    

The ODTP framework allows to combine independently developed tools into pipelines by wrapping the tools and turning them into [ODTP components](../components/index.md). Components can then be combined into pipelines by the [ODTP orchestrator](../orchestrator/index.md). The orchestrator runs them as Executions: the exact terminonlogy of ODTP is decribed below:

- The **Workflow template** is a specification of a pipeline of components before specifying the parameters: the workflow templates can be acyclic graphs.
- The **Workflow** is a derived from the **Workflow template** by a specifying the configuration parameters.
- An **Execution** is the execution of a **Workflow** at a **specific date and time**: this is the actual execution of the workflow when it is run as a sequence of **docker containers**. The outputs and results of Executions are captured by the [ODTP orchestrator](../orchestrator/index.md).

``` mermaid
graph TB;
    subgraph ODTP
        direction TB   
        CA0[Component A]
        CB0[Component B]
        CC0[Component C]
        CA1[Component A <br/>with Configuration]
        CB1[Component B <br/>with Configuration]
        CC1[Component C <br/>with Configuration]
        CA2[Component A <br/>with Configuration <br/>executed]
        CB2[Component B <br/>with Configuration <br/>executed]
        CC2[Component C <br/>with Configuration <br/>executed]                
        subgraph WT[Workflow Template]
            direction LR
            CA0 --> CB0
            CB0 --> CC0
        end
        subgraph W[Workflow]
            direction LR        
            CA1 --> CB1
            CB1 --> CC1
        end
        subgraph E[Execution]
            direction LR        
            CA2 --> CB2
            CB2 --> CC2
        end   
        WT -.- c[add configuration] -.-> W 
        W -.- t[add execution time] -.-> E             
    end
style WT fill:white    
style W fill:white 
style E fill:white   
``` 

## Workflow Examples

See the [use cases](../usecases/index.md) for workflow examples

## Supported Workflow Structure

Currently the [ODTP orchestrator](../orchestrator/index.md) supports only linear workflows. But it is planned to also support acyclic graphs in the future, see our [roadmap](../orchestrator/roadmap.md)

!!! Note

    If your pipeline involves loading multiple data inputs into a single step, you can solve this by adding all of them sequentially and activating the environment variable `TRANSFER_INPUT_TO_OUTPUT=TRUE` in the Dataloader. This will transfer the input from one dataloader to the next, accumulating all inputs for the analytical component. 
