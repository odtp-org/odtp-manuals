# Commandline Tutorial

ODTP can also be used via the commandline interface:

## Getting Started

If you are using poetry, you can go to `odtp` folder and run `poetry shell`. This will load the environment with all dependencies.

On the other hand, if you are using the `docker-compose` solution you can just run `odtp` command directly.

``` sh
odtp --help
```

So you can start working:

![Terminal ready](../static/tutorials/command-line/cli-start.png){ width="800" }

## Component Versions

Component Versions are the building blocks in ODTP: they are used in [Workflows](#workflows) and [Executions](#executions)

* you need the github repository url
* you also need a version tag for the version you want to add
* the github repository needs to be an ODTP component with a valid [`odtp.yml`](../components/odtp-yml.md) file

In case the `odtp.yml` file cannot be parsed you will see error messages:

``` sh
odtp new odtp-component-entry \
--component-version v0.1.1 \
--repository https://github.com/odtp-org/odtp-component-example
```

An error response:

```sh
❌ ERROR: Validation error occurred when parsing odtp.yml: Validation failed for odtp.yml:
('schema-version',): Field required (type: missing)
('component-authors',): Field required (type: missing)
('component-repository',): Input should be a valid dictionary or instance of ToolRepository (type: model_type)
('tools', 0, 'tool-authors'): Field required (type: missing)
('tools', 0, 'tool-repository'): Input should be a valid dictionary or instance of ToolRepository (type: model_type)
('devices',): Input should be a valid list (type: list_type)
```

When the `odtp.yml` file can be parsed the output will look like this:

```sh
✅ odtp.yml is valid!
✅ SUCCESS: Component added with details:
 - Component ID: 67ba3cef8a31ac0f177181b9
 - Version ID: 67ba3cef8a31ac0f177181ba
```

If the Component Version already exists you will get a warning:

```sh
 WARNING: Component was not added in db: document for repository https://github.com/odtp-org/odtp-component-example and version v0.1.1 already exists
```

## Workflows

!!! note
    In the commandline you don't have to enter a workflow before entering an execution. The workflow will be created automatically when entering an execution.

But there is a command to add workflows:

```sh
odtp new workflow-entry \
--name example-workflow \
--component-tags odtp-component-example:v0.1.8,odtp-pygwalker:v0.1.6
```

The expected output:

```sh
✅ SUCCESS: Workflow has been added:
 - Workflow ID: 67ba3ad6cf79ccdfd1adf6e6
```

## Users

So the first thing you need is a user:

* the username must be unique
* `github` should be your valid github username
* `email` should be your email

Both `name` and `email` are used for identification in later steps.

```sh
odtp new user-entry \
--name Max \
--email max@mail.com \
--github max
```

The output should looks like:

```sh
✅ SUCCESS: User with User Id 67bb22f7001a20f7b20347da has been added!
```

## Digital Twins

In the CLI you need the you can add a Digital Twin for a User by providing next to the Digital Twin name the user email:

```sh
odtp new digital-twin-entry \
--user-email max@mail.com \
--name example
```

The output will look like this:

```sh
✅ SUCCESS: Digital Twin with id 67bb278dc764755ea9438bfe has been added!
```

## Executions

For creating an execution you need:

- `digital-twin-name` Name of the digital twin. Alternatively, you can use the `digital-twin-id`.
- `name`: A name for the execution
- `component-tags`: All components tags (`componentA:v0.1.0`) involved in the workflow aligned sequentially and separated by commas.
- `parameter-files`: Parameters files separated by commas.
    - This file should contain all parameters used like in a dotenv file format.
- `ports`: Ports matching used by the containers.
    - Components ports should be separated by `,`. i.e. `8763:3000,8501:8501`
    - Place as many `,` as connections between components (steps). If ports are not being used in the first, and second component: i.e. `,,8501:8501`
    - If multiple ports are being use in the same step please use `+`: i.e. `,,8501:8501+3000:3000`


A parameter file would look like this: it contains variables and their values:

```
DATASET=rf3
CATEGORY=Health
BATCH_SIZE=100
```

An execution can be added like this: in case the workflow does not exist yet, it will be created automatically when the execution is added:

```sh
odtp new execution-entry \
--digital-twin-name example-workflow \
--name execution-example \
--component-tags odtp-dataloader:v1.0.1,odtp-data-dashboard:v1.2.0 \
--parameter-files /path/params1,path/params2 \
--ports 80:80,8501:8501+80:80
```

The output should look like this:

```sh
✅ SUCCESS: execution has been added: see above for the details.
 - execution id: 67bb3139864fecb07899dd68
 - step_ids: [ObjectId('67bb3139864fecb07899dd69'), ObjectId('67bb3139864fecb07899dd6a')]
```

## Prepare Execution

Next you need to prepare the execution. This will generate all the folder structure and build all necessary docker images for our digital twin. ODTP will check for available images before building, if no image is available then the repository will be pulled and the docker image will be built.

An empty folder must be provided to generate the data folder required, and we recommend placing it in a preconfigured digital twin folder.

```sh
odtp execution prepare \
--execution-name example \
--project-path /usr/odtp/project/path/for/example
```

odtp execution prepare \
--execution-name dt-example-execution-3 \
--project-path /Users/smaennel/WORK/ODTP/odtp/docker-compose/digital-twins/test-example2


Expected output end:

```sh
✅ SUCCESS: images for the execution have been build!
```

In case the project-path is not empty at the start you get:

```sh
⚠️ WARNING: Project path exists and is not an empty directory
```

After this the project path should have the Component repository downloaded with a directory for each step:

```sh
test-example2
├── 0_odtp-component-example_v0.1.8
│   ├── odtp-input
│   ├── odtp-logs
│   ├── odtp-output
│   └── repository
└── 1_odtp-pygwalker_v0.1.6
    ├── odtp-input
    ├── odtp-logs
    ├── odtp-output
    └── repository
```

## Run Execution

Once your execution is prepared, it's time to run it! When running an execution you can provide some secrets for your components separated by commas (`,`) similar to how you define the pipeline in the execution generation. Secrets files are structure in a similar way to parameters files: they contain keys and values:

```
password=mypassword
```

``` sh
odtp execution run \
--execution-name execution-example \
--secrets-files /path/Secrets001,/path/Secrets001 \
```

This will run the docker containers. They will exchange data via S3 snapshots.

You can find logs on the `project-path` that you specified in the [`execution prepare` command](#prepare-execution)

```sh
/Users/smaennel/WORK/ODTP/odtp/docker-compose/digital-twins/test-example
├── 0_odtp-component-example_v0.1.8
│   ├── odtp-input
│   ├── odtp-logs
│   │   ├── log.txt
│   │   ├── odtpLoggerDebugging.txt
│   │   └── odtpS3UploadedDebugging.txt
│   ├── odtp-output
│   │   ├── odtp-logs.zip
│   │   ├── odtp-output.zip
│   │   └── rotten_tomatoes
│   │       ├── test.csv
│   │       ├── train.csv
│   │       └── validation.csv
│   └── repository
└── 1_odtp-pygwalker_v0.1.6
    ├── odtp-input
    │   └── rotten_tomatoes
    │       ├── test.csv
    │       ├── train.csv
    │       └── validation.csv
    ├── odtp-logs
    ├── odtp-output
    └── repository

```

## Example Use Case with CLI commands:

See [dt-example workflow](https://github.com/odtp-org/dt-example). It includes a script with the CLI commands `dt-example.sh`

## List Documents from the MongoDB

You can use the following commands to get an overview of the documents in ODTP:
it takes as argument the collection names, see [../orchestrator/schema.md]

```sh
odtp db ls executions
```

```sh
+--------------------------+------------------------+---------------------------+----------------------------+---------------+--------------------------+
|           _id            |         title          |        description        |      start_timestamp       | end_timestamp |      digitalTwinRef      |
+--------------------------+------------------------+---------------------------+----------------------------+---------------+--------------------------+
| 67a9c69149d18fbe0f1ee424 |      test-example      | Description for Execution | 2025-02-14 06:46:27.458000 |      None     | 67a9c66f49d18fbe0f1ee3f8 |
| 67aee703b4c8a9d770b0de62 |         test-2         | Description for Execution | 2025-02-14 06:47:49.016000 |      None     | 67a9c66f49d18fbe0f1ee3f8 |
| 67b99408f74e0dbe2b93e555 |    test-dt-example     | Description for Execution |            None            |      None     | 67a9c66f49d18fbe0f1ee3f8 |
| 67b9bb7df74e0dbe2b93e588 |         test4          | Description for Execution | 2025-02-22 14:57:30.892000 |      None     | 67a9c66f49d18fbe0f1ee3f8 |
| 67b9bc25f74e0dbe2b93e5dd |    test dataloader     | Description for Execution |            None            |      None     | 67a9c66f49d18fbe0f1ee3f8 |
| 67bb3139864fecb07899dd68 | dt-example-execution-3 | Description for Execution | 2025-02-23 15:58:23.671000 |      None     | 67bb31389f79ef56cba361a3 |
+--------------------------+------------------------+---------------------------+----------------------------+---------------+--------------------------+
```

## Delete an execution

Executions and all associated data, such as MongoDB entries, S3 Files, and project path folders can be easily deleted. In `v0.5.0` this feature is only available in the CLI. In the [GUI Executions can be deprecated](executions.md#manage-executions) instead.

=== "Command Line CLI"

    ```sh
    odtp execution delete \
    --execution-name execution-example \
    --project-path /path/exeuction
    ```

Existing executions can be selected in order to run them: when you select an execution you see a
button: "PREPARE AND RUN EXECUTION": click on it and you will get to a run page where you can run the
execution: see [run executions](run-executions.md)
