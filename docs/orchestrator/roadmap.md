ODTP has been setup as a POC. With the experience of ODTP our learning have been captured in the [Open Digital Twin Component Standard ODTWS](https://odtp-org.github.io/ODTWS/odtws.html).

The roadmap below explains possible extensions of ODTP that bring it closer to an implementation of ODTWS.

[TOC]

### User Authentication and Authorization

Even though ODTP has user owned parts such as Digital Twins and Executions, Authentication hasn't been added yet. We plan to implement it using Keycloak and the OpenID Connect protocol.

### Semantic Output Validation

ODTP plans to provide the sematic input and output validation for the data that are exchanged between components and stored in the S3. That way it can be made sure in an automated way that components are compatible with each other.

- automatically extract semantic information about a directory (recursively analyze the files in a folder, and extract some metadata about the columns/properties of each file) and write it to a RDF graph.
- This “instance data” (metadata about the input dataset) will be validated against the “Schema data” provided by an Component.
- The validation be implemented  using [SHACL](https://www.w3.org/TR/shacl/). The ODTP Orchestrator will run the SHACL validation engine on this combination to generate a report which provides information about the conformance of the dataset with the schema.
- the Orchestrators will warn users of non-conforming component connections. it may deny the execution of a workflow that is not conforming. The mode for warning will be called “Lazy execution”, where a workflow may run until an error occurs. The mode for strict conformance will be called “Safe execution”, where a workflow is not run if non-conforming.

### Shared Results within a Digital Twin

Some step outputs can be collected and arranged as results. These special outputs will be considered in later stages for multi-execution analysis or data visualizations. The implementation of Results will be changed so that they span multiple executions of a Digital Twin. That way they can be used for multi-execution analysis or data visualizations.

### Checker for compatibility of licenses

Since ODTP components originate from independent tools, it is not clear whether their licenses are compatible with each other. The license checker is an app that checks whether components have licenses that can be combined. It is planned to add a license checker to ODTP.

### Support of complex components

API-based persistent components will be added as [component types](../components/types.md)

### Zoo integration
While a Component's metadata is now fetched automatically from `odtp.yml` in the [ODTP Orchestrator](../orchestrator/index.md), the orchestrator is not yet connected to the [ODTP Zoo](../zoo/index.md). Currently the metadata is fetched from the `odtp.yml` file in the component's github repository.

### Export Workflows as compose files

The goal of ODTP is to prioritize the flexibility and independence of the Digital Twins generated. That's why we are developing the exporting of each digital twin into an `odtp-compose.yml` file that can be executed directly by Docker. This file will offer the user the possibility to run one specific execution in an isolated and reproducible environment, ensuring consistency across different executions and facilitating collaboration and sharing among users. The `odtp-compose.yml` will include definitions for all the services involved in the execution, their configuration, inter-service dependencies, and any necessary environment variables or volume mounts.

While some use cases already have a docker-compose.yml file, it is not yet automatically generated.

### Performance and efficiency improvements

I/O operations optimization and enhancement of the Mongodb Schema are possible improvements

### Scheduler for workflow executions

Another possible enhancement would be to schedule Execution runs.

### Compatibility with the Swiss Data Custodian

An integration of ODTP with the [Swiss Data Custodian](https://www.datascience.ch/resources/swiss-data-custodian) might make sense, so that ODTP can better support use cases with sensitive data.

### Support Directed Acyclic Graphs

ODTP should be able to support not only linear workflows but also workflows that resemble directed acyclic graphs.
