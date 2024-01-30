# ODTP Diagrams


## **User registration and login sequence diagram**
The user should always register and login to create and execute a digital twin.<br />
A user does not need authentication to explore the components.


``` mermaid
sequenceDiagram
  autonumber
   User->>+ODTP-UI(NiceGUI): GET Login page
   ODTP-UI(NiceGUI)->>+Keycloack(Custodian): POST login request
   Keycloack(Custodian)-->>-User: GET login form
   User->>+Keycloack(Custodian): POST login information (name,email,git-repo)
   Keycloack(Custodian)-->>-ODTP-UI(NiceGUI): GET code and callback
   ODTP-UI(NiceGUI)->>+Keycloack(Custodian): POST Request for tokens
   Keycloack(Custodian)-->>-ODTP-UI(NiceGUI): GET token and store in session
   ODTP-UI(NiceGUI)->>+Keycloack(Custodian): POST Request to add user to group
   Keycloack(Custodian)-->>-ODTP-UI(NiceGUI): GET user added to group
   ODTP-UI(NiceGUI)-->>-User: GET Logged in
   ODTP-UI(NiceGUI)->>+ODTP-Mongodb: INSERT user
   ODTP-Mongodb->>+ODTP-UI(NiceGUI): SEND 200 ok

```


## **Component registration sequence diagram**
We register the component wwith the name, version and git-repo in a database (mongodb).

``` mermaid
sequenceDiagram
  autonumber
   ODTP-UI(NiceGUI)->>+ODTP-UI(NiceGUI): ADD Component information
   ODTP-UI(NiceGUI)->>+ODTP-Backend: POST Component information
   ODTP-Backend->>+ODTP-Mongodb: INSERT Component information
   ODTP-Mongodb-->>+ODTP-Backend: GET 200 ok
   ODTP-Backend->>+ODTP-UI(NiceGUI): GET Component information
```


## **Digital Twin registration Sequence diagram**
We register the dt with the name, and the user-id in a database (mongodb).

``` mermaid
sequenceDiagram
  autonumber
   ODTP-UI(NiceGUI)->>+ODTP-UI(NiceGUI): ADD DT information
   ODTP-UI(NiceGUI)->>+ODTP-Backend: POST DT information
   ODTP-Backend->>+ODTP-Mongodb: INSERT DT information
   ODTP-Mongodb-->>+ODTP-Backend: GET 200 ok
   ODTP-Backend->>+ODTP-UI(NiceGUI): GET DT information
```

## **Execution registration Sequence diagram**
We register the execution with the DT_id,execution_name user_id in a database (mongodb).

``` mermaid
sequenceDiagram
  autonumber
   ODTP-UI(NiceGUI)->>+ODTP-UI(NiceGUI): ADD execution information
   ODTP-UI(NiceGUI)->>+ODTP-Backend: POST execution information
   ODTP-Backend->>+ODTP-Mongodb: INSERT execution information
   ODTP-Mongodb-->>+ODTP-Backend: GET 200 ok
   ODTP-Backend->>+ODTP-UI(NiceGUI): GET execution information
```
## **Execution preparation Sequence diagram**
We prepare the execution with the DT_id,execution_name user_id, folder-path.

``` mermaid
sequenceDiagram
  autonumber
   ODTP-UI(NiceGUI)->>+ODTP-UI(NiceGUI): ADD Execution information
   ODTP-UI(NiceGUI)->>+ODTP-Backend: POST Execution information
   ODTP-Backend->>+local-virtual-machine: Build docker image
   local-virtual-machine->>+ODTP-Backend: GET 200 ok
   ODTP-Backend-->>+ODTP-UI(NiceGUI): GET execution preparation_info

```


## **Execution running Sequence diagram**
We execute the DT workflow with the dt_id,execution_name,components[],version[],workflow, user_id, env-variables.

``` mermaid
sequenceDiagram
  autonumber
   ODTP-UI(NiceGUI)->>+ODTP-UI(NiceGUI): GET Execution information
   ODTP-UI(NiceGUI)->>+ODTP-Backend: RUN Execution
   ODTP-Backend->>+local-virtual-machine: ADD output
   local-virtual-machine->>+ODTP-Backend: GET 200 ok
   ODTP-Backend-->>+ODTP-UI(NiceGUI): GET execution result
```