## Concept

The idea of odtp is to be installed as an instance in small-medium computing platform (such a servers, workstations, laptops, etc). However, it can be installed and used in local machines too. 

## Architecture

The architecture of the odtp include different core-modules dealing with specific task. Between parenthesis you can find the technologies that are being considered for this modules.

- Dashboard (Nicegui)
- CLI
- Authentication (eduID, GH)
- Workflow manager (Barfi)
- ODTP orchestrator (ODTP original)
- License manager (Swiss Data Custodian) #core-optional
- Data governance (Swiss Data Custodian) #core-optional
- Semantic validator engine (TopBrains) #core-optional
- KG/Ontology storing (GraphDB) #core-optional
- Snapshots/Data transferring (MINION S3)
- Performance Logging (Grafana) 

All these core modules will be available in the full instance. However, for those users who wants to try a lighter version they can omit the core-optional modules having only the following configuration.

- Core Modules
    - Dashboard (Nicegui)
    - CLI
    - Authentication (eduID, GH)
    - Workflow manager (Barfi)
    - ODTP orchestrator (ODTP original)
    - Traces/Logging/Users data storing (MongoDB)
    - Snapshots/Data transferring (MINION S3)
    - Performance Logging (Grafana) 

- Core-Optional Modules
    - Semantic validator engine (TopBrains) #core-optional
    - KG/Ontology storing (GraphDB) #core-optional
    - License manager (Swiss Data Custodian) #core-optional
    - Data governance (Swiss Data Custodian) #core-optional

Finally the ODTP will be complemented with a components zoo that will include extensions of 3 types:

- X number of dataloaders.
- Y number of analytical components.
- Z number of visualization components.

### Technologies involved

- Nicegui (UI)
- Barfi (Workflow manager)
- MongoDB (Document Database)
- S3 (Storage Sytem)
- Docker (Container Technology)

## Terminology

### ODTP
A tool designed to manage, run, and design digital twins. It offers an interface (CLI, and GUI) for running and managing digital twins. It wraps different open source technologies to provide a high level API for the final user. 

### Components (ODTP Term)
Extensions generated by us or the community that perform specific tasks in the digital twin. The input/output is validated semantically, and they run within a docker container as an independent micro-service. They can be one of the following categories:
	- Dataloader component. 
	- Analytical component.
	- Visualization component.

### Core/core-optional modules (ODTP Term)
These modules are the different parts that we are developing for the ODTP. These core modules include the different classes/methods needed to run the tool and wrap the services used. Some of these modules are not mandatory in order to run ODTP with the minimal features (i.e. running manually odtp components).

### Services
One service or micro-service, in a micro-services architecture refers to one logical unit that performs one specific task in an independent manner. In ODTP we use different servers to support core modules, such as MongoDB for the database, Minion for the storage, or GraphDB for the knowledge graph storing. But also, from a technical standpoint every component is turned into a micro-service when running. I think this is the part that’s bringing more confusion. 

<script src="https://hypothes.is/embed.js" async></script>
