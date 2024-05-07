## Combining tools into workflows

The concept of ODTP starts with tools that have been deveoped independently: they may be in different programming languages and have not be designed to run in combination. ODTP offers a solutions to combine these tools in pipeline without permanently linking them or integrating them into a monolytic application.

``` mermaid
---
title: Independet Tools can be combined into pipelines by turning them into Components
---
graph LR;
    ComponentA[Component A: Example Dataloader] -->|run| ComponentB[Component B: Example ML Model]
    ComponentB[Component B: Example ML Model] -->|run| ComponentC[Component C: Example Dashboard]
``` 
``` mermaid
graph TD;
    ToolA[Tool A: Example Dataloader]
    ToolB[Tool B: Example ML Model]
    ToolC[Tool C: Example Dashboard]  
```

ODTP does this by turning the tools into components that are combatible and can be run by the ODTP Orchestrator. Each tool runs as an independent service (as Docker Container). Data between Components can be transfered via the help of Data Snapshots. Input and Outputs are semantically described and can be validated using Shacl. Not all these features have been implemented yet, see [architecture](architecture.md) and [roadmap](roadmap.md) for the currrent status.

## Classes in the ODTP: 

- **DigitalTwins**: One or more Executions are managed as a Digital Twin. The Executions of a Digital Twin can be rerun of similar or different workflows, that are grouped by a common goal or Use Case. Digital Twins are owned by Users. 
- **Users**: are the Users of ODTP. They define and then own Executions and Digital Twins. Components are not owned by Users but shared by all Users and just added once with updates of their Versions
- **Components**: Components are the building blocks: they come in Versions that correspond to the versions of the tool that they wrap or versions of the Component code. Read about [ODTP Components](../components/index.md)
- **Executions**: they can be combined into Workflows that are acyclic graphs (currently graphs have to be linear). These workflows are run as Executions. In an Executios each Component becomes a Step


``` mermaid
---
title: User defined Executions of a Digital Twin that share a common result
---
flowchart LR
  subgraph ODTP
    subgraph User
        direction TB
        subgraph DigitalTwin
            direction LR
            subgraph ExecutionA
                direction LR
                Step1A --> Step2A
                Step2A --> Step3A
                subgraph Step1A[Step1A = Component1]
                end 
                subgraph Step2A[Step2A = Component2]
                end
                subgraph Step3A[Step3A = Component3]
                end            
            end 
            subgraph ExecutionB
                direction LR
                Step1B --> Step2B
                Step2B --> Step3B
                subgraph Step1B[Step1B = Component1]
                end 
                subgraph Step2B[Step2B = Component2]
                end
                subgraph Step3B[Step3B = Component3]
                end          
            end
            ExecutionA --> Result
            ExecutionB --> Result
            Result --> Visualize
            subgraph Result
            end    
            subgraph Visualize
            end             
        end
    end
    subgraph MongoDB
    end    
    subgraph S3
    end   
  end
DigitalTwin -- Operational data of all steps --> MongoDB
DigitalTwin -- Transfers of Data between steps--> S3  
style ODTP fill:white 
``` 

### ODTP Executions

The Executions are a core concept of ODTP

## Tools can be turned into ODTPComponents

The tools can be of the following kinds:

- Data loading
- Data preparation
- Data analysis
- Data visualization

See [component Types](../components/types.md).

## ODTP executes Workflows that combine Components

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
``` 
