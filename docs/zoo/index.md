# ODTP Zoo

!!! warning end "Under Construction"

    [The Zoo is available](https://odtp-org.github.io/odtp-zoo/). It is still under construction and also not yet connected to the [ODTP Orchestrator](../orchestrator/index.md)

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

A ODTP zoo is a collection of [ODTP Components](../components/index.md) that have been validated and can therefore be used by the [ODTP Orchestrator](../orchestrator/index.md) to build Executions.

## How it works:

Components are registered in the zoo by an index file. The goal is to make them discoverable via their metadata.

## ODTP Zoos

Currently there is just one ODTP zoo at for the ODTP organization

- [ODTPOrg Zoo](https://github.com/odtp-org/odtp-zoo-db)

There could be more ODTP zoos. As not all components are open source, organizations could build their own ODTP zoos that provide components that can be used within their organizations.

## Getting started with the zoo

See here for how to add a component to the ODTP-org zoo:

[Add a component to the ODTP Zoo](add-component.md){ .md-button }    

## ODTP Zoo Public Page

<div class="map">
  <iframe src="https://odtp-org.github.io/odtp-zoo/" width=1000px height=500px></iframe>
</div>
