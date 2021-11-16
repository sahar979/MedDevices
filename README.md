
# MedDevices


<!-- badges: start -->
<!-- badges: end -->
## Overview
MedDevices is a data package has data set of medical devices and medical devices recall details. The source of data is The United States Food and Drug Administration (FDA). The data represents the devices distributed over 13 classifications and the details of the posted recall for each device.

## Data Variables

`device_id` Distinction number for each device in the data.

`device_name` Name of the device.

`device_classification` Denoting the class of the device base on hospital department that the device used in.It include 13 classes

`manufacturers_name` Name of device's manufacturer

`parent_company` Name of manfacturer's parent company


## Installation

You can install the development version of MedDevices from [GitHub](https://github.com/sahar979/MedDevices) with:

``` r
# install.packages("devtools")
devtools::install_github("sahar979/MedDevices")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(MedDevices)
## basic example code
```

