# odtp-manuals
All manuals, instructions, documentation and information you need to work with ODTP.

## How to serve this documentation in a docker? 

1. `docker build -t odtp-docs .`
2. `docker run -it --rm -p 8000:8000 odtp-docs`

This will serve the documentation in: http://0.0.0.0:8000/odtp-org/

## How to build this documentation using docker? 

 TOBEDONE

## Development

### Installing third-party dependences. 

In order to use emojis and [social cards](https://squidfunk.github.io/mkdocs-material/setup/setting-up-social-cards/) we need to install the plugin `imaging` from mkdocs-material using pip. This plugin require the following dependencies outside python: `cairo` `freetype` `libffi` `libjpeg` `libpng` `zlib`. For more information about this plugin please enter [here](https://squidfunk.github.io/mkdocs-material/plugins/requirements/image-processing/).

#### Mac
You can use `brew`: `brew install cairo freetype libffi libjpeg libpng zlib`

#### Ubuntu
You can use `apt-get`: `apt-get install libcairo2-dev libfreetype6-dev libffi-dev libjpeg-dev libpng-dev libz-dev`

### How to serve this documentation in local? 

DISCLAIMER: Still to be properly tested
1. `pip install mkdocs-material`
2. `pip install "mkdocs-material[imaging]"`
3. `mkdocs serve`


### How to build?

DISCLAIMER: Still to be properly tested
0. `env /usr/bin/arch -x86_64 /bin/bash --login`
1. `python -m venv venv`
2. `source venv/bin/activate`
3. `pip install mkdocs-material`
4. `pip install "mkdocs-material[imaging]"`