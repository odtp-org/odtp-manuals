## Types of components

ODTP offers the following types of components:

``` mermaid
mindmap
  root((Component Types and Examples))
    Component Type: Ephemeral
      Dataloader
      Analytical
      Data Exporter
    Component Type: Interactive
      Visualization
      Dashboard
    Component Type: API
      Service that is difficult to set up and is therefore shared
```

### Ephemeral components


``` mermaid
flowchart LR
    DockerBuild[Build Docker Image] --> DockerRun[Run Docker Container]
    DockerRun[Run Docker Container] --> Stop[Stop]
```

Ephemeral components are docker container that run once and exit after they have run the tool that they wrap. The docker container is discarded after use.

Examples for Ephemeral components are:

- Dataloader: loading data from various sources
- Data Analysis / data sciene: analyzing or transforming data for statistic or predictive analysis
- Data Exporter: export to external data storage

### Interactive components

``` mermaid
flowchart LR
    DockerBuild[Build Docker Image] --> DockerRun[Run Docker Container]
```

Interactive components are designed to interact with the user. Their docker container will be kept running until the user stops it. They usually have inputs (file or database) and they usually provide a webservice that is run on a port, that will be exposed, so that the user can change it.

Examples for Interactive components are:

- Dashboards
- Visualizations

### API components

!!! warning end "Under Construction"

    - Api components are currently under construction and not yet available

``` mermaid
flowchart LR
    DockerRun[Run Docker Container]
```

An API component by itself is similar to an interactive component: It mounts a long running service that will only end when termintated by the user.

API components differ though in the way they are handled by the ODTP orchestrator: Components are combined into an Workflow and then the workflow can be executed by a Execution. Usually the docker container for a component is build per execution, when the execution is prepared. But with API components they will be build independently of the workflows and executions that they are part of and will provide long lasting services that can still be integrated into workflows and executions with out the need to build the component

This kind of component is useful when the component building process (in docker)  takes a large amount of time, or when a long-lasting task can be reused in multiple executions. An example of this is the loading of a machine learning model into memory.

The API component receives the parameters as JSON in the request’s payload. This allows a more complex configuration of parameters than in the other two component types. Input data can be provided in the request, or, if the file-size is big, as a item in the S3 storage.
