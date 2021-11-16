
# MedDevices


<!-- badges: start -->
<!-- badges: end -->
## Overview
MedDevices is a data package has data set of medical devices and medical devices recall details. The source of data is The United States Food and Drug Administration (FDA). The data represents the devices distributed over 16 classifications and the details of the posted recall for each device.

## Data Variables

`device_id` Distinction number for each device in the data.

`device_name` Name of the device.

`device_classification` The class of the device base on hospital department that the device used in.It include 16 classes.

`manufacturers_name` Name of device's manufacturer.

`parent_company` Name of manufacturer's parent company.

`distributed_to` The spatial distribution of the device.

`implanted` The device implantable or not. 

`risk_class` The class of the device base on risk level.

`reason` The potential danger due to recalled malfunction.

`determined_cause` The cause of the malfunction.

`Recall_classification` The relative degree of risk.

`date_initiated_by_firm` Initiation date of recall by the company.

`date_posted` Date of posting the recall by FDA in database.

`date_terminated` Date of terminating the recall.

## Target

This package was build to provide a public, easy to read and easy to download data for medical devices. 
The data can be used:

- As a learning tool of data science and Rstodio.

- NLP analysis projects.

- Devices evaluation, by health authorities, the hospital, medical company, field service biomedical engineers. 

## Installation

You can install the development version of MedDevices from [GitHub](https://github.com/sahar979/MedDevices) with:

``` r
# install.packages("devtools")
devtools::install_github("sahar979/MedDevices")
```
## Enhancement

Further improvement can be done to:
- Add some function to the package to make the EDA easy.
- Add quantity in commerce variable and formalize it (numeric, same matrices)
- Use local data from Saudi Food and Drug Authority (SFDA)

## Source

Source of the raw data: [ICIJ](https://medicaldevices.icij.org/p/download)
