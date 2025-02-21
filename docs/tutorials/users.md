# Users

!!! note
    * The username has to be unique and the github user has to exist.
    * Some commands have equivalents in the GUI such as the user add command. Others have not.

## Setup a user

So the first thing you need is a user:

=== "Dashboard GUI"

    ![Dashboard Add user](../static/tutorials/users/add-user.png){ width="800" }

=== "Command Line CLI"

    ``` sh
    odtp new user-entry \
    --name Max \
    --email max@mail.com \
    --github max
    ```

    The output should looks like:
    ```
    A user has been added: 65c3ab02b4afbca32db08738
    ```

## Select a User

As a next step you can select the user and add additional information:

![Select a User](../static/tutorials/users/select-user.png){ width="800" }

## Upload Secrets

You can upload named files with secrets.

!!! note
    * The secret files are stored encrypted on the server.
    * Once you uploaded secrets the application will test whether it can do the encryption and
    show you the keys that are stored in the file.

![Select a User](../static/tutorials/users/pick-secret-file.png){ width="400" }

![Select a User](../static/tutorials/users/upload-secrets-file.png){ width="400" }

![Select a User](../static/tutorials/users/display-uploaded-secret.png){ width="400" }

![Select a User](../static/tutorials/users/user-with-secrets.png){ width="800" }