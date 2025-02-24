# How to run a single component?

This section assumes that you have installed ODTP. If this is not the case:

[Install ODTP](../installation/index.md){ .md-button }

## How to run a component with the ODTP Orchestrator

Components can only be run on the Command Line Interface (CLI), not from the Graphical User Interface(GUI).

In this example we are going to run [ODTP component example](https://github.com/odtp-org/odtp-component-example). First, we will prepare the component which will automatically download the repostory, build the image and prepare all the folders needed for the input / output data. 

First let's create a project folder called `digital_twin_project` on your local computer. In this folder is where all the folders will appear. 

``` bash
mkdir digital_twin_project
```
 
 Then we can prepare the project by running the following. This will download the repo and build the image and prepare the output folder structure

 ``` bash
 odtp component prepare \
 --folder /Users/carlosvivarrios/pro/odtp/digital_twin_project \
 --image_name image_test \
 --repository https://github.com/odtp-org/odtp-component-example
 ```

 Now we need to run the component: 

 ``` bash
 odtp component run \
 --folder /Users/carlosvivarrios/pro/odtp/digital_twin_project \
 --image_name image_test \
 --instance_name instance_test \
 --repository https://github.com/odtp-org/odtp-component-example \
 --commit 6471218336ce7de41a5162c9556c0ff68f9ec13c \
 --parameter_file /Users/carlosvivarrios/pro/odtp/digital_twin_project/.env
 ```

Then we can delete the instance by running. In docker terminology this will remove the container

``` bash
odtp component delete-instance --instance_name instance_test
```

And finally if we want to delete the image we can run:

``` bash
odtp component delete-image --image_name image_test 
```

## How to use a component in a Digital Twin?

To start using component in Digital Twin's executions, first you need to register the component into odtp, and using it. 

See the [tutorial](../tutorials/component-versions.md) on how to do this.
