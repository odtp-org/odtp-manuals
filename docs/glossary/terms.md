# Glossary

components:Component
:   An ODTP component is a wrapper for a tool that allows to run the tool by the ODTP orchestrator as a service that can be combined in a workflow with other services

orchestrator:DigitalTwin 
:   A project in <orchestrator:ODTP> where components are combined to provide analysis and visualization of some data

orchestrator:Execution
:   Execution of a <workflows:Workflow> by the odtp orchestrator

orchestrator:ODTP
:   An application that enables to manage, run, and design digital twins. It offers an interface (CLI, and GUI) for running and managing digital twins. It wraps different open source technologies to provide a high level API for the final user. 

usecases:UseCase
:   An ODTP use Case, see [here](../usecases/index.md)

orchestrator:User
:   User of <orchestrator:ODTP> that defines and owns <orchestrator:DigitalTwin>s

components:Version
:   Version of a Component: a new version might be triggered to an update of the tool or an update of the component building recipe, see [develop components](../components/develop.md)

workflows:WorkflowTemplates
:   The arrangement of components into a pipeline is called a workflow-template. See [section workflows](../workflows/index.md).

workflows:Workflow
:   The arrangement of components into a sequence is called workflow. In principle a workflow can be an acyclic graph. Currently ODTP only supports linear sequences. 
