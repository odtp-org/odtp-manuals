# Causal Interventions

## Description

We provide another workflow for a digital twin that implements the mobility causal intervention framework to evaluate the robustness of deep learning models towards data distribution shifts, with the application of individual next location prediction [^1].

## Digital Twin Workflow

Overview of the mobility causal intervention workflow in ODTP:

``` mermaid
graph TB
    subgraph ODTP
        postgresql-dataloader --> odtp-mobility-simulation
        odtp-mobility-simulation --> odtp-mobility-metrics
        odtp-mobility-simulation --> odtp-next-location-prediction
    end    
```

The mobility simulation module is used to generate individual location sequences. It also incorporates the causal intervention mechanism to generate intervened synthetic data that represent different data distribution shifts. These synthetic data are fed into the next-location-prediction module to quantify a model’s robustness against interventions. Meanwhile, a mobility-metrics module is used to monitor the change in the characteristics of mobility data.

## Overview of the components

- [odtp-postgresql-dataloader](https://github.com/odtp-org/odtp-sql-to-csv): TBD
- [odtp-sql-dataloader](https://github.com/odtp-org/odtp-sql-dataloader): This component performs SQL queries to a compatible database and create a dataframe output in csv format. 
- [odtp-mobility-simulation](https://github.com/odtp-org/odtp-mobility-simulation): This module generates synthetic individual location visit sequences based on mechanistic mobility simulators (including EPR, IPT, Density-EPR, and DT-EPR models). The module also generates intervened synthetic mobility data based on causal interventions through the specification of parameters to be intervened and levels of the interventions.
- [odtp-mobility-metrics](https://github.com/odtp-org/odtp-mobility-metrics): This module includes multiple metrics to quantify the characteristics of individual mobility sequences, e.g., location visitation frequency, radius of gyration, real entropy, mobility motifs etc. 
- [odtp-next-location-prediction](https://github.com/odtp-org/odtp-next-location-prediction): This module includes two deep learning models for individual next location prediction, the LSTM model and the Multi-Head Self-Attentional (MHSA) model. 

## Contact

- [CSFM](https://csfm.ethz.ch/en/) or [SDSC](https://www.datascience.ch/)

[^1]:
    Hong, Y., Xin, Y., Dirmeier, S., Perez-Cruz, F., & Raubal, M. (2023). Revealing behavioral impact on mobility prediction networks through causal interventions. arXiv preprint arXiv:2311.11749.
