# ODTP Introduction

ODTP offers a comprehensive suite of functionalities to enhance digital twins' management, operation, and analysis. In ODTP, a digital twin is an advanced virtual model, embodying a broad spectrum of scenarios and systems that mirror current conditions and forecast future scenarios, offering users a robust platform for strategic optimization and decision-making. With ODTP, the digital twin concept transcends traditional boundaries, providing a pivotal tool for various applications, ensuring adaptability, insight, and innovation across diverse domains.

## Features

- **Intuitive User Interface** to manage and operate your digital twins. 
- **Component Execution** to execute your or existing components for simulation, analysis or visualization.
- **Iteration Monitoring** to check digital twins iterations.
- **Log Analysis** to conveniently access and analyze container logs.
- **Workflow Design Tool** to design and run digital twins.
- **Schema Management & Testing** to restart and test different schemas for MongoDB / S3.
- **Result Analysis** to inspect outputs/snapshots and download results.

## What do we consider a Digital Twin?

In ODTP a digital Twin is composed by a set of executions with specific data inputs, analysis and parameters settings. Each execution represents a pipeline of `odtp components` that runs in individual docker containers. These `odtp components` are wrapper to individual modules for analysis, simulation, or data ingestion tools. On top of this, ODTP offers a solution for reproducibility and digital twin sharing by keeping track of all details and components used.

In v0.2.0 the pipeline is require to be linear. However, we are working to bring compatibility with DAG pipelines. 

## How can I run ODTP?

ODTP is a tool designed to be deployed in a server and shared across a number of users. Providing an easy to access environment to Digital Twin execution and management. It provides a user-frienly graphical user interface (GUI) that can be access through a web browser, and a command line interface (CLI) for those advance users. The [tutorials](tutorials/getting-started.md) will take you through both options in parallel.

<script src="https://hypothes.is/embed.js" async></script>
