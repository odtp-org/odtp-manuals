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

In ODTP a digital Twin is compose by a set of executions with specific data inputs, analysis and parameters settings. Each executions represents a pipeline of `odtp components` that runs in individual docker containers. These `odtp components` are wrapper to individual modules for analysis, simulation, or data ingestion tools. On top of this, ODTP offers a solution for reproducibility and digital twin sharing by keeping track of all details and components used.

In v0.2.0 the pipeline is require to be linear. However, we are working to bring compatibility with DAG pipelines. 

## How can I run ODTP?

ODTP is a tool designed to be deployed in a server and shared across a number of users. Providing an easy to access environment to Digital Twin execution and management. It provides a user-frienly graphical user interface (GUI) that can be access through a web browser, and a command line interface (CLI) for those advance users. The [tutorials](tutorials/getting-started.md) will take you through both options in parallel.

# Acknowledgments, Copyright, and Licensing
## Acknowledgments and Funding
This work is part of the broader project **O**pen **D**igital **T**win **P**latform of the **S**wiss **M**obility **S**ystem (ODTP-SMS) funded by Swissuniversities CHORD grant Track B - Establish Projects. ODTP-SMS project is a joint endeavour by the Center for Sustainable Future Mobility - CSFM (ETH Zürich) and the Swiss Data Science Center - SDSC (EPFL and ETH Zürich). 
The Swiss Data Science Center (SDSC) develops domain-agnostic standards and containerized components to manage digital twins. This includes the creation of the Core Platform (both back-end and front-end), Service Component Integration Templates, Component Ontology, and the Component Zoo template. 
The Center for Sustainable Future Mobility (CSFM) develops mobility services and utilizes the components produced by SDSC to deploy a mobility digital twin platform. CSFM focuses on integrating mobility services and collecting available components in the mobility zoo, thereby applying the digital twin concept in the realm of mobility.
 
## Copyright
Copyright © 2023-2024 Swiss Data Science Center (SDSC), www.datascience.ch. All rights reserved.
The SDSC is jointly established and legally represented by the École Polytechnique Fédérale de Lausanne (EPFL) and the Eidgenössische Technische Hochschule Zürich (ETH Zürich). This copyright encompasses all materials, software, documentation, and other content created and developed by the SDSC.

## Intellectual Property (IP) Rights
The Open Digital Twin Platform (ODTP) is the result of a collaborative effort between ETH Zurich (ETHZ) and the École Polytechnique Fédérale de Lausanne (EPFL). Both institutions hold equal intellectual property rights for the ODTP project, reflecting the equitable and shared contributions of EPFL and ETH Zürich in the development and advancement of this initiative.  
 
## Licensing
The core component of the ODTP software is distributed as open-source under the AGPLv3 license. This ensures that all modifications and derivatives remain open source, fostering a collaborative and shared development environment. Detailed terms of the AGPLv3 license can be found in the LICENSE file within this distribution package.

### Distinct Licensing for Other Components
Service Component Integration Templates are licensed under the BSD-3 license, allowing for broad compatibility and standardization.
Ontology: The foundational ODTP ontology is licensed under the Creative Commons Attribution-ShareAlike (CC BY-SA), promoting open use and ensuring that any derivatives also remain open.
Component Zoo Template: The template for the Component Zoo operates under the BSD-3 license, emphasizing broad compatibility and open development. It's important to note that individual components within the Zoo retain their original licenses.

### Alternative Commercial Licensing
Alternative commercial licensing options for the core platform and other components are available and can be negotiated through the EPFL Technology Transfer Office (https://tto.epfl.ch) or ETH Zürich Technology Transfer Office (https://ethz.ch/en/industry/transfer.html).

## Ethical Use and Legal Compliance Disclaimer
Please note that this software should not be used to harm any individual or entity. Users and developers must adhere to ethical guidelines and use the software responsibly and legally. This disclaimer serves to remind all parties involved in the use or development of this software to engage in practices that are ethical, lawful, and in accordance with the intended purpose of the software.