# ODTP Developing

## MongoDB Schema

### MongoDB Schema

This is the schema for odtp database. 

v.0.2.0 Schema

```python
# Users Collection
users = {
    "_id": ObjectId(),
    "displayName": "John Doe",
    "email": "john@example.com",
    "github": "johnDoeRepo",
    "created_at": datetime.utcnow(),
    "updated_at": datetime.utcnow(),
    "digitalTwins": [ObjectId()]  # Array of ObjectIds referencing digitalTwins collection
}

# Components Collection
components = {
    "_id": ObjectId(),
    "author": "Test",
    "componentName": "ComponentX",
    "repoLink": "https://github.com/odtp-org/odtp-component-example",
    "status": "active",
    "title": "Title for ComponentX",
    "description": "Description for ComponentX",
    "tags": ["tag1", "tag2"],
    "created_at": datetime.utcnow(),
    "updated_at": datetime.utcnow(),
    "versions": [ObjectId()]  # Array of ObjectIds referencing Versions collection
}

# Versions Collection
versions = {
    "_id": ObjectId(),
    "componentId": ObjectId(),
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

# DigitalTwins Collection
digitalTwins = {
    "_id": ObjectId(),
    "userRef": ObjectId(),
    "name" : "title",
    "status": "active",
    "public": True,
    "created_at": datetime.utcnow(),
    "updated_at": datetime.utcnow(),
    "executions": [ObjectId()]  # Array of ObjectIds referencing Executions collection
}

# Executions
executions = {
    "_id": ObjectId(),
    "digitalTwinRef": ObjectId(),  # Reference to DigitalTwins collection
    "title": "Title for Execution",
    "description": "Description for Execution",
    "tags": ["tag1", "tag2"],
    "workflowSchema": {
        "workflowExecutor": "barfi",
        "workflowExecutorVersion": "v2.0",
        "components": [{"component": ObjectId(),
                        "version": ObjectId() }],  # Array of ObjectIds for components
        "WorkflowExecutorSchema": {}
    },
    "start_timestamp": datetime.utcnow(),
    "end_timestamp": datetime.utcnow(),
    "steps": [ObjectId()]  # Array of ObjectIds referencing Steps collection. Change in a future by DAG graph.
}

# Steps
steps = {
    "_id": ObjectId(),
    "executionRef": ObjectId(),  # Reference to Executions collection
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
    "component": ObjectId(),
    "component_version": ObjectId(),
    "parameters": {},
    "output": ObjectId()
}

output = {
    "_id": ObjectId(),
    "stepRef": ObjectId(),  # Reference to the Step this output is associated with
    "output_type": "snapshot" or "output",
    "s3_bucket": "bucket_name",  # Name of the S3 bucket where the output is stored
    "s3_key": "path/to/output",  # The key (path) in the S3 bucket to the output
    "file_name": "output_file_name",  # The name of the file in the output
    "file_size": 123456,  # Size of the file in bytes
    "file_type": "image/jpeg",  # MIME type or file type
    "created_at": datetime.utcnow(),  # Timestamp when the output was created
    "updated_at": datetime.utcnow(),  # Timestamp when the output was last updated
    "metadata": {  # Additional metadata associated with the output
        "description": "Description of the output",
        "tags": ["tag1", "tag2"],
        "other_info": "Other relevant information"
    },
    "access_control": {  # Information about who can access this output
        "public": False,  # Indicates if the output is public or private
        "authorized_users": [ObjectId()],  # Array of User ObjectIds who have access
    }
}

# Results Collection
results = {
    "_id": ObjectId(),
    "executionRef": ObjectId(),
    "digitalTwinRef": ObjectId(),  # Direct reference to the DigitalTwin
    "output": [ObjectId()],
    "title": "Title for Result",
    "description": "Description for Result",
    "tags": ["tag1", "tag2"],
    "created_at": datetime.utcnow(),
    "updated_at": datetime.utcnow(),
}