# ODTP Zoo

A zoo is a collection of ODTP components located in github. ODTP allows you to load components that are indexed in different ODTP Zoos. 

## How to load components from a zoo? 

TO BE DEVELOPED

## List of ODTP Zoos

- [ODTP-org Zoo](https://github.com/odtp-org/odtp-zoo-db)

## How to add a component to a zoo.

Each zoo db is located in a github repository. In order to add a component you must submit it by performing a PR. ODTP accesses `index.yaml`/`index.json` from this repo to list all compatible components and metadata. 

### How to submit a component

In order to submit a component you need to make an entry in `components` directory using `component_template.yaml`. Please fill the template with all requested info and then open a pull request. 

#### Step by step instructions

1. Fork this repository.
2. Copy and rename `component_template.yaml`
3. Fill the data
4. Place the file into `components` directory.
5. Submit a pull request and wait for review. 
    - Components pull requests target `components` branch, after merging it will get automatically deployed to `main`.
    - Do not edit `index.yaml` or `index.json` directly, and do not modify any other file. 
    - The added date will be automatically populated after the merge. 

### Notes

- Only functional components will be accepted. You can adapt your tool using the odtp-component-template. 
- If you want to have your component removed, please open an issue or pull request. 

## How to deploy your own zoo

TO BE DEVELOPED
