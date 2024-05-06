# How to develop a component

Here you find instructions on how to turn an existing tool into an ODTP component:


``` mermaid
graph LR;
    Tool -->|transform| ODTPComponent
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
- Give the component a name similar to "odtp-name of your tool"

The resulting repo has the following structure:

Folders:

- `app`: app folder to connect to your tool
- `odtp-component-client`: client for the odtp orchestrator in order to use functions and methods in the docker container

Files:

- `env.dist`: 

## Step2: Adapt the Dockerfile and Installations

In this step you will adapt the Build Instructions for the Docker Image: 

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

## Step3: Adapt the app/app.sh to install your tool

Change the section below so that a version of your tool is checked out

```
#########################################################
# 1. GITHUB CLONING OF REPO
# Clone the repository of your tool and checkout to one specific commit. 
#########################################################

# git clone https://github.com/odtp-org/tool-example.git /odtp/odtp-workdir/tool-example
# cd /odtp/odtp-workdir/tool-example
# git checkout xxxxxxxxxxxx
```

## Step 3: Adapt the App to so that it runs your tool

Configure the `app/app.sh` file in the following way:

1. Clone the repository of your tool and checkout to one specific commit. We recommend to specify the commit with a tag for a semantic version.
2. (Optional) If your app uses a config file (i.e. `config.yml` or `config.json`), you need to provide a templace including placeholders for the variables you would like to expose. Placeholders can be defined by using double curly braces wrapping the name of the variable, such as `{{VARIABLE}}`. Then you can run `python3 /odtp/odtp-component-client/parameters.py PATH_TO_TEMPLATE PATH_TO_OUTPUT_CONFIG_FILE` and every placeholder will be replaced by the value in the environment variable.
3. Copy (`cp -r`) or create symbolic links (`ln -s`) to locate the input files in `/odpt/odtp-input/` in the folder. 
4. Run the tool. You can access to the parameters as environment variables (i.e. `$PARAMETER_A`)
5. Manage the output exporting. At the end of the component execution all generated output should be located in `/odtp/odtp-output`. Copy all output files into this folder. 
6. Describe all the metadata in `odtp.yml`. Please check below for instructions.
7. Publish your tool in the [ODTP Zoo](../zoo/index.md).

## Step4: Expose parameters

If your app uses a config file (i.e. `config.yml` or `config.json`), you need to provide a template including placeholders for the variables you would like to expose. Placeholders can be defined by using double curly braces wrapping the name of the variable, such as `{{VARIABLE}}`. Then you can run `python3 /odtp/odtp-component-client/parameters.py PATH_TO_TEMPLATE PATH_TO_OUTPUT_CONFIG_FILE` and every placeholder will be replaced by the value in the environment variable.

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

Create your `.env` file with the following parameters.

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
-v {PATH_TO_YOUR_INPUT_VOLUME}:/odtp/odtp-output \
--env-file .env \
odtp-component
```

This command will run the component. If you want debug some errors and execute the docker in an interactive manner, you can use the flag `--entrypoint bash` when running docker.

Also if your tool is interactive such as an [Streamlit](https://streamlit.io/) app, don't forget to map the ports by using `-p XXXX`. 

### Testing the component as part of odtp

Please do it as it is described in section above titled: `How to run a single component?`
## Step 6: Version your Component

ODTP relies on tagged versions of Component. In the ODTP Orchestrator you need a version tag for the Component to register it. Use [Semantic Versioning](https://semver.org/) for your Component.

## Step 7: Provide Metadata for the Component

ODTP requires a set of metadata to work that it is defined in a file called `odtp.yml` that should be in the root of the repository. These fields should be filled by the developers and they are used to provide a help to the users who wants to use your component.

``` yaml title="yaml component file"
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

# Information about the tool
tool-name: Tool name
tool-author: Tool's author
tool-version: Tool version
tool-repository: Tool's repository
tool-license: Tool's license

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
  - name: PARAMETER B
    default-value: DEFAULT_VALUE_B
    datatype: DATATYPE_B
    description: Description of Parameter B

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
  gpu: false
```
