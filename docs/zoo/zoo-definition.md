# ODTP Zoo

## What is a ODTP zoo?


``` mermaid
graph TD;
    subgraph ODTPOrchestrator
    CLI[CLI]
    GUI[GUI]
    end
    subgraph ODTPZoo
    Registery[index.yml/index.json]
    end   
    ODTPOrchestrator -->|use| ODTPComponentA
    ODTPOrchestrator -->|use| ODTPComponentB
    ODTPOrchestrator -->|use| ODTPComponentC
    ODTPComponentA -->|register| ODTPZoo
    ODTPComponentB -->|register| ODTPZoo
    ODTPComponentC -->|register| ODTPZoo
    subgraph ODTPZoo[Component Registry]
    end
    subgraph ODTPComponentA[ComponentA]
    end
    subgraph ODTPComponentB[ComponentB]
    end
    subgraph ODTPComponentC[ComponentC]
    end    
``` 

A ODTP zoo is a collection of ODTP components. 

- Components are registered in the zoo via an index file in order to make them discoverable for usage in the ODTP orchestrator

## Current Status

- Currently the ODTP.org zoo is under construction
- the zoo is not yet connected to the ODTP orchestrator

## ODTP Zoos

Currently there is just one ODTP zoo at for the ODTP organization

- [ODTP-org Zoo](https://github.com/odtp-org/odtp-zoo-db)

There could be more ODTP zoos: as not all components are open source, organiazations could build their own ODTP zoos that provide components that can be used within their organizations.

## Getting started with the zoo

See here for how to add a component to the ODTP-org zoo:

[Tutorial how to add a component to the ODTP-org Zoo](add-component.md){ .md-button }

