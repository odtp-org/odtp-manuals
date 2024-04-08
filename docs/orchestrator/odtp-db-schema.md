# MongoDB Schema

This is the schema for odtp database. 

## Collections

**Users and Projects:**
[users]: #users

- **users**: users of the system
- **digitalTwins**: projects that are owned by users

**Code**

- **components**: github repos 
- **versions**: specific states / commits of the repos

**Code Runs**

- **executions**: executable specification of a digitalTwin, that can also be executed: it consists of steps that run in sequence, each step corresponds to a version of a component
- **steps**: steps are component version with parameters and ports, etc
- **output**: output of a step: mostly file output
- **results**: result of an execution run

### Users

- Users are the owning and running projects
- these projects are called Digital Twins

``` json
users = {
    "_id": ObjectId(),
    "displayName": "John Doe",
    "email": "john@example.com",
    "github": "johnDoeRepo",
    "created_at": datetime.utcnow(),
    "updated_at": datetime.utcnow(),
    "digitalTwins": [ObjectId()]  
}
```

### DigitalTwins

- Digital Twins are the projects
- they have a name and executions
- all details are defined in the executions 

``` json
digitalTwins = {
    "_id": ObjectId(),
    "userRef": ObjectId(),
    "name" : "title",
    "status": "active",
    "public": True,
    "created_at": datetime.utcnow(),
    "updated_at": datetime.utcnow(),
    "executions": [ObjectId()] 
}
```

### Components

- Components are github repos
- they are not owned by users
- each component can have versions
- versions correspond to commits in the repo


``` json
components = {
    "_id": ObjectId(),
    "author": "Test",
    "componentName": "ComponentX",
    "repoLink": "https://github.com/odtp-org/odtp-component-example",
    "status": "active",
    "title": "Title for ComponentX",
    “type”: “persistent”, 
    "description": "Description for ComponentX",
    "tags": ["tag1", "tag2"],
    "created_at": datetime.utcnow(),
    "updated_at": datetime.utcnow(),
    "versions": [ObjectId()] # 1:n relationship with components  
}
```

### Versions 

- versions are versions of the components and correspond to versions of the github repo

``` json
versions = {
    "_id": ObjectId(),
    "Component”: # n:1 relationship with components 
      “ComponentId": ObjectId(),
      "componentName": "ComponentX", 
      "repoLink": "https://github.com/odtp-org/odtp-component-example",
      “type”: “persistent”,
    } 
    "version": "v1.0",
    "component_version": "1.0.0",
    "commitHash": "6471218336ce7de41a5162c9556c0ff68f9ec13c",
    "dockerHubLink": "https://hub.docker.com/...",
    "parameters": {},
    "title": "Title for Version v1.0",
    "description": "Description for Version v1.0",
    "tags": ["tag1", "tag2"],
    "created_at": datetime.utcnow(),
    "updated_at": datetime.utcnow()
}
```

### Executions

- Executions are what runs 
- they combine component versions as workflows
- one versions runs after the other, currently only in linear sequence
- later workflows should be allowed to be acyclic graphs
- each component version corresponds to a step
- execution have outputs and a result

``` json
executions = {
    "_id": ObjectId(),
    "digitalTwinRef": ObjectId(), 
    "title": "Title for Execution",
    "description": "Description for Execution",
    "tags": ["tag1", "tag2"],
    "workflowSchema": {
        "workflowExecutor": "barfi",
        "workflowExecutorVersion": "v2.0",
        "component_versions": [{"version": ObjectId()}],
        "WorkflowExecutorSchema": {}
    },
    "start_timestamp": datetime.utcnow(),
    "end_timestamp": datetime.utcnow(),
    "steps": [ObjectId()]
}
```

### Steps

- each step corresponds to a component version

``` json
steps = {
    "_id": ObjectId(),
    "executionRef": ObjectId(),  # Reference to an executions
    "timestamp": datetime.utcnow(),
    "start_timestamp": datetime.utcnow(),
    "end_timestamp": datetime.utcnow(),
    "type": "interactive" or "ephemeral",
    "logs": [{
        "timestamp": datetime.utcnow(),
        "type": "DEBUG",
        "logstring": "Test log"
    }],
    "inputs": {},
    "outputs": {},
    "component_version": ObjectId() # 1:1 reference to a version
    "parameters": {},
    "output": ObjectId() 1:1 reference to an output
}
```

### Output

- output of a step

``` json
output = {
    "_id": ObjectId(),
    "stepRef": ObjectId(), # reference to a step,      
    "output_type": "snapshot" or "output",
    "s3_bucket": "bucket_name",      
    "s3_key": "path/to/output",  
    "file_name": "output_file_name",  # The name of the file in the output
    "file_size": 123456,  # Size of the file in bytes
    "file_type": "image/jpeg",  # MIME type or file type
    "created_at": datetime.utcnow(),  # Timestamp when the output was created
    "updated_at": datetime.utcnow(),      
    "metadata": {  # Additional metadata associated with the output
        "description": "Description of the output",
        "tags": ["tag1", "tag2"],
        "other_info": "Other relevant information"
    },
    "access_control": {  # Information about who can access this output
        "public": False,  # Indicates if the output is public or private
        "authorized_users": [ObjectId()],      
    }
}
```

### Results

- overall result of an execution run
- the outputs of all steps

``` json
results = {
    "_id": ObjectId(),
    "executionRef": ObjectId(), # reference to an execution,
    "digitalTwinRef": ObjectId(),  # reference to the digitalTwin
    "output": [ObjectId()], # reference to an output,
    "title": "Title for Result",
    "description": "Description for Result",
    "tags": ["tag1", "tag2"],
    "created_at": datetime.utcnow(),
    "updated_at": datetime.utcnow(),
}
```

<script src="https://hypothes.is/embed.js" async></script>
