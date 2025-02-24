[TOC]

## Prerequisites

In order to install ODTP you will need to download and install [Docker](https://www.docker.com/) in your machine, and [git](https://git-scm.com/).

## Installation Options

There are two ways of installing ODTP:

- Easy installation via Docker Compose
- Installation for permanent usage on a local server

!!! Note
    The installation on a local server is more complicated and requires you to also setup the required extra services such as mongodb and S3

[Easy install with docker compose (Recommended)](docker-compose_install.md){ .md-button }

[Install on a local server](local_server_install.md){ .md-button }

## Service Dependencies

The picture below shows the services that are needed by ODTP:

``` mermaid
graph TD;
    subgraph ODTP
    CLI[CLI]
    GUI[GUI]
    end
    ODTP -->|requires| MongoDB
    ODTP -->|requires| Minio
    MongoDBExpress -->|optional| MongoDB
style ODTP fill:white
```
