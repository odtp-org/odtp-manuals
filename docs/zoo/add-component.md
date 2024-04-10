# Add component to the ODTP-org zoo

## Locate the github repsitory of the zoo.

The zoo db is located in a github repository: [ODTP-org Zoo](https://github.com/odtp-org/odtp-zoo-db)

In order to add a component you must submit it via a PR. It will then be added to
`index.json`, that lists all available components with their metadata. 

### How to submit a component

In order to submit a component you need to make an entry in the `components` directory using `component_template.yaml`. Please fill the template with all requested information and then open a pull request. 

#### Step by step instructions

1. Fork this repository.
2. Copy the `odtp.yml` and rename it as `component_version.yaml`.
3. Place the file into `components` directory.
5. Submit a pull request and wait for review. 
    - Components pull requests target `components` branch, after merging it will get automatically deployed to `main`.
    - Do not edit `index.json` directly, and do not modify any other file. 
    - The added date will be automatically populated after the merge. 

### Notes

- Only functional components will be accepted. You can make your tool compatible using the [`odtp-component-template`](https://github.com/odtp-org/odtp-component-template). 
- If you want to have your component removed, please open an issue or pull request.
