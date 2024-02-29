# ODTP Components

## Development of components

ODTP is needs components. This guide shows you how to run a single component before
you register it on ODTP

### How to run a single component?

Components can only be run on the CLI, not from the GUI

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

### How to index a new component?

Once your component is tested you can register it on odtp: 
See the [tutorial](tutorials/components-and-versions.md) on how to do this.
