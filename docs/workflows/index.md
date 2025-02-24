# Workflow Concept

## Workflow Terminology

- **Components**: The ODTP framework allows to combine independently developed tools into pipelines by wrapping the tools and turning them into [ODTP components](../components/index.md). Components have default parameters that are described in the `odtp.yml` file.
- **Workflows**: Components can then be combined into pipelines by the [ODTP orchestrator](../orchestrator/index.md). These pipelines are then called Workflows. Workflows specify the sequence of components before the parameters are set and before a run time has been decided. They are reusable in the same way that components are reusable.
- **Executions**: An execution of a **Workflow** happens when at a **specific date and time** a workflow is run with **parameters**, **ports** and if necessary **secrets**. The execution is build and run as a sequence of **docker containers**. The outputs and results of Executions are captured by the [ODTP orchestrator](../orchestrator/index.md).

!!! Note
    - **Components** and **Executions** are not owned by users as they are abstract objects
    - **Digital Twins** and **Executions** are owned by user
    - **Executions** execute a workflow with a certain configuration, that is specified by parameters, ports and secrets
    - **Executions** can be repeated as **partial runs**: times will then be overwritten and the output might change
    - **Digital Twins** are collections of **Executions**

``` mermaid
graph TB;
    subgraph Shared building blocks: Components and Workflows
        direction LR
        subgraph CS[Components]
            direction TB
            A[Component A]
            B[Component B]
            C[Component C]
            D[Component D]
            E[Component E]
        end
        CA0[Component A]
        CB0[Component B]
        CC0[Component C]
        CD0[Component D]
        CE0[Component E]
        subgraph Workflows
            direction TB
            subgraph W1[Workflow1]
                direction LR
                CA0 --> CB0
                CB0 --> CC0
            end
            subgraph W2[Workflow2]
                direction LR
                CD0 --> CE0
            end
        end
    end
    style CS fill:white
    style W1 fill:white
    style W2 fill:white
```


``` mermaid
graph TB;
    subgraph Execution of Workflows
        direction TB
        CA1[Component A]
        CB1[Component B]
        CC1[Component C]
        CA2[Component A <br/>with Configuration <br/>]
        CB2[Component B <br/>with Configuration <br/>]
        CC2[Component C <br/>with Configuration <br/>]
        subgraph W[Shared: Workflow]
            direction LR
            CA1 --> CB1
            CB1 --> CC1
        end
        subgraph E[User Owned: Execution: run at time, steps can be repeated]
            direction LR
            CA2 --> CB2
            CB2 --> CC2
        end
        W -.- t[use as blueprint, add configuration and execution time] -.-> E
    end
style W fill:white
style E fill:white
```

## Workflow Examples

See the [use cases](../usecases/index.md) for workflow examples

## Workflow Structure

Currently the [ODTP orchestrator](../orchestrator/index.md) supports only linear workflows. But it is planned to also support acyclic graphs in the future, see our [roadmap](../orchestrator/roadmap.md)

!!! Note

    If your pipeline involves loading multiple data inputs into a single step, you can solve this by adding all of them sequentially and activating the environment variable `TRANSFER_INPUT_TO_OUTPUT=TRUE` in the Dataloader. This will transfer the input from one dataloader to the next, accumulating all inputs for the analytical component.
