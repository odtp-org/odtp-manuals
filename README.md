# odtp-manuals
All manuals, instructions, documentation and information you need to work with ODTP.

## How to serve this documentation in a docker? 

1. `docker build -t optp-docs .`
2. `docker run -it --rm --p 8000:8000 odtp-docs`

This will serve the documentation in: http://0.0.0.0:8000/odtp-org/

## Development

### How to serve this documentation in local? 

DISCLAIMER: Still to be properly tested

1. `pip install mkdocs-material`
2. `brew install cairo freetype libffi libjpeg libpng zlib`
3. `pip install "mkdocs-material[imaging]"`
4. `mkdocs new`
5. `mkdocs serve`


### How to create a running development environment?

DISCLAIMER: Still to be properly tested

1. `python -m venv venv`
2. `source venv/bin/activate`
3. `pip install mkdocs-material`
4. `pip install "mkdocs-material[imaging]"`

### Plugins and dependencies

Some of the dependencies and plugins used require separate instalation. Here you can find more information: https://squidfunk.github.io/mkdocs-material/plugins/requirements/image-processing/#cairo-graphics-macos
