# ODTP Diagrams


## **User login Sequence diagram**
This part is required only if the user want access to sensitive data or private component.



``` mermaid
sequenceDiagram
  autonumber
   User->>+ODTP-UI(NiceGUI): Open()
   User->>+ODTP-UI(NiceGUI): Connect()
   ODTP-UI(NiceGUI)->>+Keycloack(Custodian): Redirect()
   Keycloack(Custodian)->>+Keycloack(Custodian): Authenticate(userID, passwword)
   Keycloack(Custodian)-->>-ODTP-UI(NiceGUI): 200 ok & JWT
```

## **Component preparation Sequence diagram**

``` mermaid
sequenceDiagram
  autonumber
   ODTP-UI(NiceGUI)->>+ODTP-UI(NiceGUI): Add(folder-path,repo,image)
   ODTP-UI(NiceGUI)->>+ODTP-Backend: Do(Prepare-component(path,repo,image))
   ODTP-Backend->>+ODTP-Backend: Build(component-image)
   ODTP-Backend-->>+ODTP-UI(NiceGUI): Send(component-id, component-name)
```

## **Component running Sequence diagram**

``` mermaid
sequenceDiagram
  autonumber
   ODTP-UI(NiceGUI)->>+ODTP-UI(NiceGUI): Add(folder-path,repo,image, env-file, instance-name)
   ODTP-UI(NiceGUI)->>+ODTP-Backend: Do(Run-component(component-id)
   ODTP-Backend->>+ODTP-Backend: Deploy(component-image)
```



## **User registration Sequence diagram**

``` mermaid
sequenceDiagram
  autonumber
   ODTP-UI(NiceGUI)->>+ODTP-UI(NiceGUI): Add-User(name,email,git-repo)
   ODTP-UI(NiceGUI)->>+ODTP-Mongodb: Store-User(user)
   ODTP-Mongodb->>+ODTP-UI(NiceGUI): Get-User(name)
```


## **Component registration Sequence diagram**

``` mermaid
sequenceDiagram
  autonumber
   ODTP-UI(NiceGUI)->>+ODTP-UI(NiceGUI): Add-Component(name,version,git-repo)
   ODTP-UI(NiceGUI)->>+ODTP-Mongodb: Store-Component(component)
   ODTP-Mongodb->>+ODTP-UI(NiceGUI): Get-Component(name)
```


## **Digital Twin registration Sequence diagram**

``` mermaid
sequenceDiagram
  autonumber
   ODTP-UI(NiceGUI)->>+ODTP-UI(NiceGUI): Add-dt(dt_name, user_id)
   ODTP-UI(NiceGUI)->>+ODTP-Mongodb: Store-dt(dt)
   ODTP-Mongodb->>+ODTP-UI(NiceGUI): Get-dt(dt)
```

## **Execution registration Sequence diagram**

``` mermaid
sequenceDiagram
  autonumber
   ODTP-UI(NiceGUI)->>+ODTP-UI(NiceGUI): Add-execution(dt_id,execution_name,components[],version[],workflow, user_id)
   ODTP-UI(NiceGUI)->>+ODTP-Mongodb: Store-execution(execution, steps)
   ODTP-Mongodb->>+ODTP-UI(NiceGUI): Get-execution(execution_name)
```


## **Execution running Sequence diagram**

``` mermaid
sequenceDiagram
  autonumber
   ODTP-UI(NiceGUI)->>+ODTP-UI(NiceGUI): Add(execution_name, folder-path)
   ODTP-UI(NiceGUI)->>+ODTP-Backend: Do(Prepare-Execution(execution_id, folder-path)
   ODTP-Backend->>+ODTP-Backend: Do(Ruun-Execution(execution_id, folder-path, env-variables)
```