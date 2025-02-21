# How to develop a component

Here you find instructions on how to turn an existing tool into an ODTP component:

!!! Note
    Not every component needs to come from an external tool: you can also develop a component that is unrelated to a tool


``` mermaid
graph LR;
    Tool -.->|transform| ODTPComponent
    Template -->|use| ODTPComponent
    subgraph ODTPComponent[Component]
    Component[ODTP Client]
    Commit[checkout tool version]
    Metadata[odtp.yml]
    Docker[Dockerfile]
    end
``` 

[TOC]

## Step 1: Use the `odtp-component-template` to create a github repo for the component

Start with the ODTP component template:

- go to [`odtp-component-template`](https://github.com/odtp-org/odtp-component-template)
- Click on "Use this template": "Open a new repository"
- Give the component a name similar to "odtp-your-tool-name"

!!! Note
    This repository makes use of submodules. Therefore, when cloning it you need to include them.
    
    ```bash 
    git clone --recurse-submodules https://github.com/your-organization/odtp-your-tool-name
    ```
    
    See [README](https://github.com/odtp-org/odtp-component-template?tab=readme-ov-file#how-to-clone-this-repository)

The resulting repo has the following structure:

```
├── Dockerfile
├── LICENSE
├── README.md
├── README.template.md
├── app
│   ├── app.sh
│   └── config_templates
│       └── template.yml
├── odtp-component-client
│   ├── LICENSE
│   ├── README.md
│   ├── __init__.py
│   ├── logger.py
│   ├── odtp-app.sh
│   ├── parameters.py
│   ├── requirements.txt
│   ├── s3uploader.py
│   └── startup.sh
├── odtp.yml
├── .env.dist
└── requirements.txt
```

Files and Folders that need to get modified:

- `app`: contains `app.sh` and additional configuration for it: this script will checkout and run your tool. It will get started by the `startup.sh` that is part of the `odtp-component-client` and serves as an entrypoint for the Dockerfile.
- `Dockerfile`: check whether you need additional installations for your tool to run and add this to the Dockerfile: you may also use `requirements.txt` in case your tool is in python
- `odtp.yml`: this will contain the metadata for your component
- `.env.dist`: includes the environment variables that your component needs and that are also specified in `odtp.yml`
- `README.md`: there is a template `README.template.md` that you can started on making a `README.md` that describes your component.

Mounted as git submodule (should not be modify):

- `odtp-component-client`: client for the odtp orchestrator: `startup.sh` serves as an entrypoint in Docker

All changes will be further described in the steps below. So no need to do them now already.

## Step 2: Adapt the Dockerfile and Installations

In this step you will adapt the build instructions for the Docker Image: 

- If your tool runs on python: adapt the `requirements.txt` file and add the libraries that you need.
- Adapt the Dockerfile and install the needed libraries that your tool needs to run:

```
FROM ubuntu:22.04

RUN apt update
RUN apt install python3.10 python3-pip -y 

##################################################
# Ubuntu setup
##################################################

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
    unzip \
    nano \
    git \ 
    g++ \
    gcc \
    htop \
    zip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

##################################################
# ODTP setup
##################################################

COPY odtp-component-client/requirements.txt /tmp/odtp.requirements.txt
RUN pip install -r /tmp/odtp.requirements.txt


#######################################################################
# PLEASE INSTALL HERE ALL SYSTEM DEPENDENCIES RELATED TO YOUR TOOL
#######################################################################

# Installing dependencies from the app
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
```

Don't touch the second part of the Dockerfile, from this line onwards:

```
######################################################################
# ODTP COMPONENT CONFIGURATION. 
# DO NOT TOUCH UNLESS YOU KNOW WHAT YOU ARE DOING.
######################################################################
```

## Step 3: Adapt the app/app.sh

Change the section below so that a version of your tool is checked out: 

Clone the repository of your tool and checkout to one specific commit. We recommend to specify the commit with a tag for a semantic version.

```
#########################################################
# 1. GITHUB CLONING OF REPO
# Clone the repository of your tool and checkout to one specific commit. 
#########################################################

# git clone https://github.com/odtp-org/tool-example.git /odtp/odtp-workdir/tool-example
# cd /odtp/odtp-workdir/tool-example
# git checkout xxxxxxxxxxxx
```

(Optional) If your app uses a config file (i.e. `config.yml` or `config.json`), you need to provide a templace including placeholders for the variables you would like to expose. Placeholders can be defined by using double curly braces wrapping the name of the variable, such as `{{VARIABLE}}`. Then you can run `python3 /odtp/odtp-component-client/parameters.py PATH_TO_TEMPLATE PATH_TO_OUTPUT_CONFIG_FILE` and every placeholder will be replaced by the value in the environment variable.

```
#########################################################
# 2. CONFIG FILE CONFIGURATION
# Read placeholders and create config file from Environment  
#########################################################

# python3 /odtp/odtp-component-client/parameters.py /odtp/odtp-app/config_templates/template.yml /odtp/odtp-workdir/config.yml
```

Copy (`cp -r`) or create symbolic links (`ln -s`) to locate the input files in `/odpt/odtp-input/` in the folder. 

```
#########################################################
# 3. INPUT FOLDER MANAGEMENT
#########################################################

# ln -s /odtp/odtp-input/... /odtp/odtp-workdir/...
```

Run the tool. You can access to the parameters as environment variables (i.e. `$PARAMETER_A`)

```
#########################################################
# 4. TOOL EXECUTION
# While the output is managed by ODTP and placed in /odtp/odtp-output/
#########################################################

# COMMAND $PARAMETER_A #PARAMETER_B /odtp/odtp-input/data
```

Manage the output exporting. At the end of the component execution all generated output should be located in `/odtp/odtp-output`. Copy all output files into this folder.

```
#########################################################
# 5. OUTPUT FOLDER MANAGEMENT
# The selected output files generated should be placed in the output folder
#########################################################

# cp -r /odtp/odtp-workdir/output/* /odtp/odtp-output
```

## Step 4: Provide Metadata for the Component

ODTP requires a set of metadata to work that it is defined in a file called `odtp.yml` that should be in the root of the repository. These fields should be filled by the developers and they are used to provide a help to the users who wants to use your component.

``` yaml title="odtp.yml"
# Schema version for tracking updates to the schema format
schema-version: "v0.5.0"

# Component Information
component-name: Component Name
component-authors:
  - name: Author One
    orcid: "https://orcid.org/0000-0001-2345-6789"
  - name: Author Two
    orcid: "https://orcid.org/0000-0002-3456-7890"
component-version: "1.0.0"
component-repository:
  url: "https://github.com/organization/component-repo"
  doi: "https://doi.org/10.1234/component.doi"
component-license: Component License
component-type: ephemeral or interactive
component-description: Description of the component's function
component-docker-image: "dockeruser/dockerimage:label"
tags:
  - tag1
  - tag2

# Tool Information
tools:
  - tool-name: Tool Name
    tool-authors:
      - name: Tool Author
        orcid: "https://orcid.org/0000-0001-1234-5678"
    tool-version: Tool Version
    tool-repository:
      url: "https://github.com/organization/tool-repo"
      doi: "https://doi.org/10.1234/tool.doi"
    tool-license: Tool License

# Secrets (ENV variables)
secrets:
  - name: API_KEY
    description: API key for authentication
    type: str

# Build Arguments (if any)
build-args:
  - name: MATLAB_LICENSE
    description: License key for Matlab
    secret: true # Mark as secret if sensitive

# Exposed Ports
ports:
  - name: PORT_A
    description: Main server port
    port-value: 8080
  - name: PORT_B
    description: Auxiliary service port
    port-value: 9090

# Parameters for the Component
parameters:
  - name: PARAMETER_A
    default-value: 10
    datatype: int
    description: Max retries allowed
    parameter-bounds: 
      - 0 # Minimum value
      - 100 # Maximum value
    options: null
    allow-custom-value: false

  - name: PARAMETER_B
    default-value: OptionA
    datatype: str
    description: Select a mode
    options: 
      - OptionA
      - OptionB
      - OptionC # Limited choices for str type
    allow-custom-value: false

# Data Inputs
data-inputs:
  - name: INPUT_A
    type: .txt
    path: /path/to/input/SIMPLE_INPUT.txt
    description: Single static input file
    naming-convention: "SIMPLE_INPUT.txt"

  - name: INPUT_B
    type: TYPE_B
    path: /path/to/input/folder_A
    description: Folder containing dynamically named input files
    naming-convention: "data_{PARAMETER_A}_{PARAMETER_B}_v{number}.ext"
    dynamic-naming-based-on:
      - PARAMETER_A
      - PARAMETER_B
    sequence:
      start: 1
      increment: 1

  - name: INPUT_C
    type: TYPE_C
    path: /path/to/input/folder_B
    description: Folder with structured input files
    folder-structure:
      required-files:
        - file-pattern: "summary_{PARAMETER_C}_{date}.txt"
        - file-pattern: "log_{PARAMETER_C}_{number}.json"
      naming-convention: "parameter_and_numeric_based"
      dynamic-naming-based-on:
        - PARAMETER_C
      date-format: "YYYYMMDD"
      sequence:
        start: 1
        increment: 1

# Data Outputs
data-outputs:
  - name: OUTPUT_A
    type: .txt
    path: /path/to/output/SIMPLE_OUTPUT.txt
    description: Static output file
    naming-convention: "SIMPLE_OUTPUT.txt"

  - name: OUTPUT_B
    type: TYPE_B
    path: /path/to/output/folder_A
    description: Folder for dynamic output files
    naming-convention: "prefix_{PARAMETER_A}_{PARAMETER_B}_v{number}.ext"
    dynamic-naming-based-on:
      - PARAMETER_A
      - PARAMETER_B
    sequence:
      start: 1
      increment: 1

  - name: OUTPUT_C
    type: TYPE_C
    path: /path/to/output/folder_B
    description: Folder for structured output files
    folder-structure:
      required-files:
        - file-pattern: "output_summary_{PARAMETER_C}_{date}.txt"
        - file-pattern: "log_{PARAMETER_C}_{number}.json"
      naming-convention: "parameter_and_numeric_based"
      dynamic-naming-based-on:
        - PARAMETER_C
      date-format: "YYYYMMDD"
      sequence:
        start: 1
        increment: 1

# Validation Schemas (Future Development)
schema-input: PATH_TO_INPUT_SCHEMA
schema-output: PATH_TO_OUTPUT_SCHEMA

# Device Requirements
devices:
  - type: gpu
    required: true
```

## Step 5: Test the component

There are 3 main ways in which you can test a component and the different odtp features.

1. Testing it as a docker container
2. Testing it as a single component using `odtp`
3. Testing it in a `odtp` digital twin execution

When developing we recommend to start by testing the component via docker and then follow with the others.

### Testing the component as a docker container

The user will need to manually create the input/output folders and build the docker image.

Prepare the following folder structure:

``` bash
- testing-folder
    - data-input
    - data-output
```

Place all required input files in `testing-folder/data-input`.

In case you have parameters specified in the `odtp.yaml` file:

- `cp .env.dist .env`
- Create your `.env` file with the following parameters. If you don't have parameters you can omit this.

``` bash
# ODTP COMPONENT VARIABLES
PARAMETER-A=.....
PARAMETER-B=.....
```

Build the dockerfile.

``` bash
docker build -t odtp-component .
```

Run the following command.

``` bash
docker run -it --rm \
-v {PATH_TO_YOUR_INPUT_VOLUME}:/odtp/odtp-input \
-v {PATH_TO_YOUR_OUTPUT_VOLUME}:/odtp/odtp-output \
--env-file .env \
odtp-component
```

This command will run the component. If you want debug some errors and execute the docker in an interactive manner, you can use the flag `--entrypoint bash` when running docker.

Also if your tool is interactive such as an [Streamlit](https://streamlit.io/) app, don't forget to map the ports by using `-p XXXX:XXXX`.

### Testing the component as part of odtp

For this you need to have odtp installed: see [Install ODTP](../installation/index.md)
Then run the component as described in [How to tun a single component](../components/run.md)

## Step 6: Version your Component

ODTP relies on tagged versions of Component. In the ODTP Orchestrator you need a version tag for the Component to register it. Use [Semantic Versioning](https://semver.org/) for your Component. For instance: `v0.1.0` or `v0.2.0-alpha`.

## Step 7: Publish your tool in the ODTP Zoo.

Once your component has been tested you can publish it in the [ODTP Zoo](../zoo/index.md).
See [Add component to the ODTP-org zoo](../zoo/add-component.md)
