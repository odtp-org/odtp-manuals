# Executions

!!! note

    - Components are not owned by users
    - To specify a digital twin you need to select components and versions
    - Before you add a component you have to build and test it

## Add a component with a version

Add a component with a version and select the component:

- you can select a component multiple times
- since your workflow can containt the component multiple times

=== "Dashboard GUI"

    ![Dashboard Add component version](../static/add-component-version.png){ width="500" }
    ![Dashboard Select component version](../static/select-component-version1.png){ width="500" }
    ![Dashboard Select component version](../static/select-component-version2.png){ width="500" }
    ![Dashboard Select component version](../static/select-component-version3.png){ width="500" }

=== "Command Line CLI"

    ``` sh
    odtp new odtp-component-entry --name component-example --version 0.0.1 --component-version 0.0.1 --repository https://github.com/odtp-org/odtp-component-example --commit 497e5bd4dce372a5db0070b12e3de5b7cef5a7a3
    ```
    output: `A component has been added`` ==65c3ab02b4afbca32db08738==