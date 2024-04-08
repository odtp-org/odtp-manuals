## Architecture

In this section we describe the current architecture of ODTP. 


The 

architecture of the odtp include different core-modules dealing with specific task. Between parenthesis you can find the technologies that are being considered for this modules.

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

