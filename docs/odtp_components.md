# ODTP Components

An `odtp` compatible component is a docker container able to perform a functional unit of computing in the digital twin. You can think of it as a blackbox that takes inputs files and/or parameters and perfom a task. Usually this lead to some files as a result (Ephemeral component), or to a visualization (Interactive component).

Internally a component will run a bash script `./app/app.sh` that must include the commands for running your tool, and managing the input/output logic. While input files are located in the folder `/odtp/odtp-input`, parameters values are represented by environment variables within the component. In this way you can access to them by using `$` before the name of your variable. Finally, the output files generated are requested to be placed in `/odtp/odtp-output/`. Also components contains an `odtp.yml` file with relevant metadata about the component. 

ODTP will be able to validate the input/output files and parameters to determine if an execution workflow is valid or not. In order to do this we use SHACL validation if the developer provides valid schema. However, this feature is still under development and it will be available soon. 

## How to run a single component?

Components can only be run on the CLI, not from the GUI.

In this example we are going to run [ODTP component example](https://github.com/odtp-org/odtp-component-example). First, we will prepare the component which will automatically download the repostory, build the image and prepare all the folders needed for the input / output data. 

First let's create a project folder called `digital_twin_project`. In this folder is where all the folders will appear. 

```sh
mkdir digital_twin_project
```
 
 Then we can prepare the project by running the following. This will download the repo and build the image. 

 ```sh
 odtp component prepare \
 --folder /Users/carlosvivarrios/pro/odtp/digital_twin_project \
 --image_name image_test \
 --repository https://github.com/odtp-org/odtp-component-example
 ```

 Now we need to run the component: 

 ```sh
 odtp component run \
 --folder /Users/carlosvivarrios/pro/odtp/digital_twin_project \
 --image_name image_test \
 --instance_name instance_test \
 --repository https://github.com/odtp-org/odtp-component-example \
 --commit 6471218336ce7de41a5162c9556c0ff68f9ec13c \
 --parameter_file /Users/carlosvivarrios/pro/odtp/digital_twin_project/.env
 ```

Then we can delete the instance by running. In docker terminology this will remove the container

```
odtp component delete-instance --instance_name instance_test
```

And finally if we want to delete the image we can run:

```
odtp component delete-image --image_name image_test 
```

## How to use a component in a Digital Twin?

To start using component in Digital Twin's executions, first you need to register the component into odtp, and using it. 

See the [tutorial](tutorials/components-and-versions.md) on how to do this.

## How to develop a component

The best way to start developing a component is by using [`odtp-component-template`](https://github.com/odtp-org/odtp-component-template) and follow the instructions below.

### Internal data structure of a component

Before starting adapting your tool, it is necessary to understand the internal folder structure. 

- `/odtp`: The main folder.
- `/odtp/odtp-component-client`: This is the odtp client that will manage the execution, logging, and input/output functions of the component. It is include as a submodule, and the user doesn't need to modify it.
- `/odtp/odtp-app`: This folder have the content of `/app` folder in this template. It contains the tool execution bash script and the tool configuration files. 
- `/odtp/odtp-workdir`: This is the working directory where the tool repository should be placed and all the middle files such as cache folders.
- `/odtp/odtp-input`: Input folder that is be mounted as volume for the docker container.
- `/odtp/odtp-output`: Output folder that is mounted as volume for the docker container.
- `/odtp/odtp-logs`: Folder reserved for internal loggings. 
- `/odtp/odtp-config`: Folder reserved for odtp configuration. 

### Step to create your component based on `odtp-component-template`

1. Identify which parameters would you like to expose.
2. Configure the Dockerfile to install all the OS requirements needed for your tool to run. 
    1. (Optional) If your tool requires python, and the dependencies offered in the repo are not compatible with the docker image you can configure custom dependencies in requirements.txt
3. Configure the `app/app.sh` file to:
    1. Clone the repository of your tool and checkout to one specific commit. 
    2. (Optional) If your app uses a config file (i.e. `config.yml` or `config.json`), you need to provide a templace including placeholders for the variables you would like to expose. Placeholders can be defined by using double curly braces wrapping the name of the variable, such as `{{VARIABLE}}`. Then you can run `python3 /odtp/odtp-component-client/parameters.py PATH_TO_TEMPLATE PATH_TO_OUTPUT_CONFIG_FILE` and every placeholder will be replaced by the value in the environment variable.
    3. Copy (`cp -r`) or create symbolic links (`ln -s`) to locate the input files in `/odpt/odtp-input/` in the folder. 
    4. Run the tool. You can access to the parameters as environemnt variables (i.e. `$PARAMETER_A`)
    5. Manage the output exporting. At the end of the component execution all generated output should be located in `/odtp/odtp-output`. Copy all output files into this folder. 
4. Describe all the metadata in `odtp.yml`. Please check below for instructions.
5. Publish your tool in the ODTP Zoo. (Temporaly unavailable)


### Testing the component

There are 3 main ways in which you can test a component and the different odtp features. 

1. Testing it as a docker container
2. Testing it as a single component using `odtp`
3. Testing it in a `odtp` digital twin execution

When developing we recomend to start by testing the component via docker and then follow with the others.  

#### Testing the component as a docker container

The user will need to manually create the input/output folders and build the docker image.

1. Prepare the following folder structure:

```
- testing-folder
    - data-input
    - data-output
```

Place all required input files in `testing-folder/data-input`.

2. Create your `.env` file with the following parameters.

```
# ODTP COMPONENT VARIABLES
PARAMETER-A=.....
PARAMETER-B=.....
```

3. Build the dockerfile. 

```
docker build -t odtp-component .
```

4. Run the following command.

```
docker run -it --rm \ 
-v {PATH_TO_YOUR_INPUT_VOLUME}:/odtp/odtp-input \
-v {PATH_TO_YOUR_INPUT_VOLUME}:/odtp/odtp-output \
--env-file .env \
odtp-component
```

This command will run the component. If you want debug some errors and execute the docker in an interactive manner, you can use the flag `--entrypoint bash` when running docker.

Also if your tool is interactive such as an Streamlit app, don't forget to map the ports by using `-p XXXX:XXXX`. 

#### Testing the component as part of odtp

Please do it as it is described in section above titled: `How to run a single component?`

## `odtp.yml`

ODTP requires a set of metadata to work that it is define in a file called `odtp.yml` that should be in the root of the repository. These fields should be filled by the developers and they are used to provide a help to the users who wants to use your component.

```yml
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


