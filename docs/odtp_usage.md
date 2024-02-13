# ODTP Usage

## How to use it?

This will guide you through the most usual tasks when working with ODTP.

### How to run a single component?

In this example we are going to run ()[ODTP component example]. First, we will prepare the component which will automatically download the repostory, build the image and prepare all the folders needed for the input / output data. 

First let's create a project folder called `digital_twin_project`. In this folder is where all the folders will appear. 

```
mkdir digital_twin_project
```
 
 Then we can prepare the project by running the following. This will download the repo and build the image. 

 ```
 odtp component prepare --folder /Users/carlosvivarrios/pro/odtp/digital_twin_project --image_name image_test --repository https://github.com/odtp-org/odtp-component-example
 ```

 Now we need to run the component: 

 ```
 odtp component run --folder /Users/carlosvivarrios/pro/odtp/digital_twin_project --image_name image_test --repository https://github.com/odtp-org/odtp-component-example --env_file /Users/carlosvivarrios/pro/odtp/digital_twin_project/.env --instance_name instance_test
 ```

Then we can delete the instance by running. In docker terminology this will remove the container

```
odtp component delete-instance --instance_name instance_test
```

And finally if we want to delete the image we can run:

```
odtp component delete-image --image_name image_test 
```

### How to add a new user? 

```
odtp new user-entry --name Pedro --email vote@for.pedro --github pedro
```

You can check that the user is correctly stored using:

```
odtp db get --id 65843acbe473dfffb95371d7 --collection users
```

This should deliver:

```
INFO (21/12/2023 02:18:34 PM): Connected to: <odtp.db.MongoManager object at 0x137689610> (LineL 22 [initial_setup.py])
{'_id': ObjectId('65843acbe473dfffb95371d7'), 'displayName': 'Pedro', 'email': 'vote@for.pedro', 'github': 'pedro', 'created_at': datetime.datetime(2023, 12, 21, 13, 16, 59, 857000), 'updated_at': datetime.datetime(2023, 12, 21, 13, 16, 59, 857000)}
{
    "_id": {
        "$oid": "65843acbe473dfffb95371d7"
    },
    "displayName": "Pedro",
    "email": "vote@for.pedro",
    "github": "pedro",
    "created_at": {
        "$date": 1703164619857
    },
    "updated_at": {
        "$date": 1703164619857
    }
}
```

### How to index a new component?

```
odtp new odtp-component-entry --name component-example --version 0.0.1 --component-version 0.0.1 --repository https://github.com/odtp-org/odtp-component-example
```

Info:
```
odtp db get --id 65843bdf57da36bb8e8da182 --collection components
odtp db get --id 65843be057da36bb8e8da184 --collection versions
```

### How to create a new digital twin? 

```
odtp new digital-twin-entry \
--user-id 65843acbe473dfffb95371d7 \
--name test
```

Info:
```
odtp db get --id 65843c6cae2082459baeb575 --collection digitalTwins
```

### How to create a new execution of a digital twin?

You can create an execution entry. For this you will need: 

- `digital-twin-id`: Obtained before. 
- `name`: A name for the execution
- `components`: All components involved in the workflow aligned sequentially and separated by commas. 
    - Components should be added before in order to obtain an ID. 
- `versions`: All versions involved in the workflow aligned sequentially and separated by commas. 
    - Versions order should match components. 
- `parameters`: Parameters files separated by commas.
    - This file should contain all parameters used like in a dotenv file format.
- `ports`: Ports matching used by the containers. 
    - Components ports should be separated by `+`. i.e. `8763:3000+8501:8501`
    - Place as many `+` as connections between components. If ports are not being used in the first, and second component: i.e. `++8501:8501`

```
odtp new execution-entry \
--digital-twin-id 65c36638f20bedbcd253df34 \
--name execution-example \
--components 65c36599a95e22284b07e823,65c365a9e94d273db99b6cec \
--versions 65c36599a95e22284b07e824,65c365a9e94d273db99b6ced \
--parameters /Users/carlosvivarrios/pro/ODTP/digital_twins/test-vis-component/env,/Users/carlosvivarrios/pro/ODTP/digital_twins/test-vis-component/env \
--ports +8501:8501
```

Info:
```
odtp db get --id 65843d8043feea167c5cbbe8 --collection executions
odtp db get --id 65843d8143feea167c5cbbea --collection steps
```

### How to prepare an execution with one ODTP Component?

Once the execution is configured and added to the database we can prepare it. This means that all the components will be downloaded and the docker images built. This step is necessary before running the execution.

```
odtp execution prepare \
--execution-id 65c3ab980c57d37eb076b6ba \
--project-path [Path to the project]
```

 A normal preparation should looks like:

 ```
INFO (21/12/2023 02:53:02 PM): Connected to: <odtp.db.MongoManager object at 0x138546950> (LineL 22 [initial_setup.py])
INFO (21/12/2023 02:53:03 PM): Connected to: <odtp.db.MongoManager object at 0x12eca4110> (LineL 22 [initial_setup.py])
INFO (21/12/2023 02:53:03 PM): Connected to: <odtp.db.MongoManager object at 0x138530bd0> (LineL 22 [initial_setup.py])
INFO (21/12/2023 02:53:04 PM): Removing all files and directories (LineL 23 [run.py])
INFO (21/12/2023 02:53:04 PM): Downloading repository from https://github.com/odtp-org/odtp-component-example to dt_test/component-example_0.0.1_0/repository (LineL 35 [run.py])
Cloning into 'dt_test/component-example_0.0.1_0/repository'...
remote: Enumerating objects: 65, done.
remote: Counting objects: 100% (65/65), done.
remote: Compressing objects: 100% (42/42), done.
remote: Total 65 (delta 30), reused 52 (delta 18), pack-reused 0
Receiving objects: 100% (65/65), 31.23 KiB | 376.00 KiB/s, done.
Resolving deltas: 100% (30/30), done.
INFO (21/12/2023 02:53:05 PM): Building Docker image component-example_0.0.1 from dt_test/component-example_0.0.1_0/repository (LineL 47 [run.py])

...

INFO (21/12/2023 03:24:36 PM): COMPONENTS DOWNLOADES AND BUILT (LineL 60 [workflow.py])
 ```

### How to run one execution with one ODTP Component?

We need to create one envfile containing the parameters per step.

```
odtp execution run \
--execution-id 65c3ab980c57d37eb076b6ba \
--project-path [Path to the project]
```

### How to run the GUI dashboard?

The dashboard functionality is limited right now and still require an update to the version v0.2.0. However it can be deployed by going to the repository folder and running: `odtp dashboard run`
