ODTP is still in its infancy. It has been setup as a POC. Many important features have not yet been implemented and will be described in this section:

[TOC]

### Checker for compatibility of licenses

Since ODTP components originate from independent tools, it is not clear whether their licenses match. The license checker is an app that checks wether components have licenses that can be combined. It is planned to add a license checker to ODTP

### Authetication 

Currently ODTP has no authetication. In principle each user is able to create digital twins and executions. But without authetications the work of a user is not yet protected. It is planned to add authetication in order to provide this protection.

Another concern in that regard is that some components are private or have extra licensing requirements. By authentication of user it can be made sure that users only have access to components for which they fullfil the requirements.

### Semantic Input/Output Schema and validation

When components are combined into workflows, the output of a component will be used as input for the next component.




### Semantic Validation of Workflows

### DAG workflows compatibility
### Results' analysis/visualization
### Zoo integration
- Zoo static page

### Support of complex components

- API-based persistent components

### Automatic 
- Component's information fetching from `odtp.yml`

### Export Workflows as compose files

- Definition and exporting of digital twin in `odtp-compose.yml`

### Perfomance and efficency improvements

- I/O operations optimization
- Enhancement of the Mongo DB Schema

### Scheduler for workflow executions
- Automatic executions planner
