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
# This file should contain basic component information for your component.
component-name: Component Name
component-author: Component Author
component-version: Component Version
component-repository: Component Repository
component-license: Component License
component-type: ephemeral or interactive
component-description: Description
tags:
  - tag1
  - tag2

# Information about the tools
tools:
  - tool-name: tool's name
    tool-author: Tool's author
    tool-version: Tool version
    tool-repository: Tool's repository
    tool-license: Tool's license

# If your tool require some secrets token to be passed as ENV to the component
# This won't be traced
secrets:
  - name: Key of the argument
  - description: Description of the secret

# If the tool requires some building arguments such as Matlab license
build-args:
  - name: Key of the argument
  - description: Descriptio of the building argument
  - secret: Bool

# If applicable, ports exposed by the component
# Include Name, Description, and Port Value for each port
ports:
  - name: PORT A
    description: Description of Port A
    port-value: XXXX
  - name: PORT B
    description: Description of Port B
    port-value: YYYY

# If applicable, parameters exposed by the component
# Datatype can be str, int, float, or bool.
parameters:
  - name: PARAMETER A
    default-value: DEFAULT_VALUE_A
    datatype: DATATYPE_A
    description: Description of Parameter A
    parameter-bounds: # Boundaries for int and float datatype
      - 0 # Lower bound
      - inf # Upper bound
    options: null
    allow-custom-value: false # If true the user can add a custom value out of parameter-bounds, or options

  - name: PARAMETER B
    default-value: DEFAULT_VALUE_B
    datatype: DATATYPE_B
    description: Description of Parameter B
    parameter-bounds: null
    options: # If your string parameter is limited to a few option, please list them here. 
      - OptionA
      - OptionB
      - OptionC
    allow-custom-value: false # If true the user can add a custom value out of parameter-bounds, or options

# If applicable, data-input list required by the component
data-inputs:
  - name: INPUT A
    type: TYPE_A # Folder or filetype
    path: VALUE_A  
    description: Description of Input A
  - name: INPUT B
    type: TYPE_B # Folder or filetype
    path: VALUE_B  
    description: Description of Input B

# If applicable, data-output list produced by the component
data-output:
  - name: OUTPUT A
    type: TYPE_A # Folder or filetype
    path: VALUE_A
    description: Description of Output A
  - name: OUTPUT B
    type: TYPE_B # Folder or filetype
    path: VALUE_B
    description: Description of Output B

# If applicable, path to schemas to perform semantic validation.
# Still under development. Ignore.
schema-input: PATH_TO_INPUT_SCHEMA
schema-output: PATH_TO_OUTPUT_SCHEMA

# If applicable, define devices needed such as GPU.
devices:
  gpu: Bool
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
- Create your `.env` file with the following parameters.

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

ODTP relies on tagged versions of Component. In the ODTP Orchestrator you need a version tag for the Component to register it. Use [Semantic Versioning](https://semver.org/) for your Component.

## Step 7: Publish your tool in the ODTP Zoo.

Once your component has been tested you can publish it in the [ODTP Zoo](../zoo/index.md). 
See [Add component to the ODTP-org zoo](../zoo/add-component.md)
