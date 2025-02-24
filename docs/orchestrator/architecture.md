# ODTP Architecture

``` mermaid
graph TD;
    subgraph ODTP
    GUI[Graphical User Interface] --> ODTPCore
    CLI[Commandline Interface] --> ODTPCore
    ODTPCore[Core: register components, run executions, register Digital Twins for users]
    end
    ODTP -->|store operational data| MongoDBInstance
    ODTP -->|store data outputs of executions| MinioInstance
    ODTP -->|engine| Docker
    subgraph MongoDBInstance[MongoDB Instance]
    MongoDB[Operational Data]
    end
    subgraph MinioInstance[Minio S3]
    MinioS3[Capture Snapshots of Outputs]
    end
    subgraph Docker[Docker as engine]
    DockerInstance[run components via Docker]
    end
```

The architecture of the odtp include different core-modules dealing with specific task. Between parenthesis you can find the technologies that are being considered for this modules.

- GUI / Dashboard [Nicegui](https://nicegui.io/)
- CLI Python: [Typer](https://typer.tiangolo.com/)
- Snapshots/Data transferring [Minio S3](https://min.io/)
- Operational Data [Mongodb](https://www.mongodb.com/), see [Schema](schema.md)

See Roadmap for planned enhancements: [Roadmap](roadmap.md)
