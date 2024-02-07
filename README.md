# odtp-manuals
All manuals, instructions, documentation and information you need to work with ODTP.

## How to serve this documentation in a docker?

The easier way to deployt this documentation is by using docker. This will create a server that will host the documentation.

1. `docker build -t odtp-docs .`
2. `docker run -it --rm -p 8000:8000 odtp-docs`

This will serve the documentation in: http://0.0.0.0:8000/odtp-org/

## Development

### How to create and activate a virtual environment? 

This will create a `venv` folder and it will install `mkdocs-material` in a local environemnt.

1. `python -m venv venv`
2. `source venv/bin/activate`
3.  Run `poetry install --no-root`
4.  Run `poetry shell`

### How to serve this documentation in local? 

In order to create an HTTP server to host the documentation we can use `mkdocs serve`. This is useful when developing as it allows you to see the changes in real time. 

1. Go to the root of this repository.
2. `mkdocs serve`

This will start an HTTP server and provide you a link to the page. By default: http://0.0.0.0:8000/odtp-org/

### How to build?

Mkdocs is a tool to create a documentation as a static webpage. In order to produce this page we need to build it using the command `mkdocs build`

1. Go to the root of this repository.
2. `mkdocs build`