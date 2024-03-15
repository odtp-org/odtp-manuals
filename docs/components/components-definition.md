# ODTP Components

An `odtp` compatible component is a docker container able to perform a functional unit of computing in the digital twin. You can think of it as a blackbox that takes inputs files and/or parameters and perfom a task. Usually this lead to some files as a result (Ephemeral component), or to a visualization (Interactive component).

Internally a component will run a bash script `./app/app.sh` that must include the commands for running your tool, and managing the input/output logic. While input files are located in the folder `/odtp/odtp-input`, parameters values are represented by environment variables within the component. In this way you can access to them by using `$` before the name of your variable. Finally, the output files generated are requested to be placed in `/odtp/odtp-output/`. Also components contains an `odtp.yml` file with relevant metadata about the component. 

ODTP will be able to validate the input/output files and parameters to determine if an execution workflow is valid or not. In order to do this we use SHACL validation if the developer provides valid schema. However, this feature is still under development and it will be available soon. 

## Types of components

There are three main types of components in our system: Ephemeral, Interactive, and API. API mode is still under development. 

### Ephemeral components

Ephemeral components are temporary and do not persist data. They are used for short-lived analytical operations and are discarded after use. They are built when preparing the digital twin execution, and only used in one single exeuction step.

### Interactive components

Interactive components are designed to interact with the user. Their images are built when needed and used in one single digital twin execution. These components are often used in user interfaces or visualizations. They will be running until the user stops the execution.

### API components (Under development)

API components will be built only once and can be reused in multiples executions. This kind of component is useful when the building process takes a large amount on time, or when a long task can be reused in multiple executions. An example of this is the loading of a machine learning model into memory.

## Common component examples

Here are some common examples of components used in our system.

### Dataloader

The Dataloader component is responsible for loading data from various sources. It can handle different types of data formats and sources. Is usually placed at the beginning of the execution workflow. Examples of this can be found in the `odtp-file-dataloader`, or the `odtp-sql-dataloader`.

### Analytical

The Analytical component is used for analyzing or transforming data. It can perform various types of data analysis, such as statistical analysis, predictive analysis, etc.

### Visualization

The Visualization component is used for visualizing data. It can generate various types of charts, graphs, and other visual representations of data.

### Dataexporter

By default any outputr is stored in the S3 Server. However, when dealing with specific digital twins output the user may require to export specific datasets or logs to external data storage. The Dataexporter component is used for exporting data to various formats and destinations. It can handle different types of data formats and destinations, such as CSV files, databases, or cloud storage. This component is usually placed at the end of the execution workflow to ensure that the results of the data processing are properly stored and accessible for further use. Examples of this can be found in the `odtp-file-dataexporter`, or the `odtp-sql-dataexporter`.


Checkout the following topis:

-  [How to run a component](how-to-run-a-component)
-  [How to create a component](components-development)




