# Users and digital twins

!!! note

    Digital Twins are owned by users (at least for now)

## Setup a user

So the first thing you need is a user:

=== "Dashboard GUI"

    ![Dashboard Add user](../static/tutorials/users-and-digital-twins/add-user.png){ width="800" }
    ![Dashboard Select user](../static/tutorials/users-and-digital-twins/select-user.png){ width="800" }

=== "Command Line CLI"

    ``` sh
    odtp new user-entry \
    --name Max \
    --email maxm@gmail.com \
    --github maxm
    ```
    output: `A user has been added`` ==65c3ab02b4afbca32db08738==

## Setup a digital twin project

Once you have a user, you can set up a digital twin


=== "Dashboard GUI"

    ![Dashboard Add user](../static/tutorials/users-and-digital-twins/add-digital-twin.png){ width="800" }
    ![Dashboard Select user](../static/tutorials/users-and-digital-twins/select-digital-twin.png){ width="800" }

=== "Command Line CLI"

    In the CLI you need the ``user_id`` from the previous step 
    ``` sh
    odtp new digital-twin-entry \
    --user-id 65c3ab02b4afbca32db08738 \
    --name example
    ```
    output: ``A digital twin has been added`` ==65a7c735732ae1d3fee2b946==
