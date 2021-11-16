#Import packages:
library(tidyverse)
library(visdat)
library(stringr)
#Read the data
devices <- read_csv('data-raw/devices-1574540427.csv')	
events <- read_csv('data-raw/events-1574540448.csv')	
manufacturers <- read_csv('data-raw/manufacturers-1574540422.csv')

#Change the name of the columns that have the same name in 2 or more file(e.g. id, slug):
names(devices)[1] <- "device_id"
names(devices)[2] <- "device_classification"
names(devices)[7] <- "device_name"
names(events)[1] <- "event_id"
names(events)[3] <- "Recall_classification"
names(manufacturers) [1] <- "manufacturer_id"
names(manufacturers) [7] <- "manufacturers_slug"
names(manufacturers) [4] <- "manufacturers_name"

#Delete the columns that have the same information(Except the column that will use to marge the data frames)
events <- select(events, -c(slug, created_at, updated_at, country))
manufacturers <- select(manufacturers, -c(created_at, updated_at, source))


#Delete the columns that have parentage of missing value > 75% :

events <- select(events, -c(action_level, action_summary, create_date, date_updated, target_audience))
manufacturers <- select(manufacturers, -c(address, comment, representative))

#Remove the Irrelevant/uninformative columns:

devices <- select(devices, -c(number, slug, created_at, updated_at,code, description))
events <- select(events, -c(icij_notes, number, uid, uid_hash, url, documents, authorities_link, date))
manufacturers <- select(manufacturers, -c(manufacturers_slug))

# we can merge the manufacturers data with devices data using the manufacturer_id

Marge_data <- merge(devices, manufacturers, by = 'manufacturer_id')

# merging the devices data with events can be done by using ID and device_id

df <- merge(Marge_data, events, by = 'device_id')


#Remove the rows that contain NA:

df <- na.omit(df) 

#Remove the duplicate/ unique value along the columns:


df <- df %>% 
  distinct(device_id, .keep_all = TRUE)

#The only country we have is USA, so there is no need for the country, source column:
#Also, all the rows in the same type "Recall", and same status, so there is no need for these columns:


df <- select(df, -c(country, type, status, source))

#After linking the 3 data sets, we can remove the manufacturer_id and the event_id:

df <- select(df, -c(manufacturer_id, event_id))
#Remove the duplicate AGAIN

df <- df %>% 
  distinct(device_classification, device_name, action, reason,data_notes, .keep_all = TRUE)

#The information in the (distribute to) column are messy and can't be used for further EDA:
#I change it to be either(worldwide, nationwide, or undefined)

MedDevices <- df %>%
  mutate(distributed_to = case_when(
    str_detect(distributed_to, "Worldwide") ~ "worldwide",
    str_detect(distributed_to, "France") ~ "worldwide",
    str_detect(distributed_to, "Canada") ~ "worldwide",
    str_detect(distributed_to,"CANADA") ~ "worldwide",
    str_detect(distributed_to, "No foreign") ~ "nationwide",
    str_detect(distributed_to, "no foreign") ~ "nationwide",
    str_detect(distributed_to, "Foreign") ~ "worldwide",
    str_detect(distributed_to, "countries") ~ "worldwide",
    str_detect(distributed_to, "Internationally") ~ "worldwide",
    str_detect(distributed_to, "International") ~ "worldwide",
    str_detect(distributed_to, "Columbia") ~ "worldwide",
    str_detect(distributed_to, "Italy") ~ "worldwide",
    str_detect(distributed_to, "Belgium") ~ "worldwide",
    str_detect(distributed_to, "Australia") ~ "worldwide",
    str_detect(distributed_to, "Japan") ~ "worldwide",
    str_detect(distributed_to, "AUSTRIA") ~ "worldwide",
    str_detect(distributed_to, "Africa") ~ "worldwide",
    str_detect(distributed_to, "OUS") ~ "worldwide",
    str_detect(distributed_to, "Mexico") ~ "worldwide",
    str_detect(distributed_to, "worldwide") ~ "worldwide",
    str_detect(distributed_to, "Europe") ~ "worldwide",
    str_detect(distributed_to, "Saudi Arabia") ~ "worldwide",
    str_detect(distributed_to, "Germany") ~ "worldwide",
    str_detect(distributed_to, "Netherlands") ~ "worldwide",
    str_detect(distributed_to, "China") ~ "worldwide",
    str_detect(distributed_to, "Ireland") ~ "worldwide",
    str_detect(distributed_to, "Finland") ~ "worldwide",
    str_detect(distributed_to, "internationally") ~ "worldwide",
    str_detect(distributed_to, "no international") ~ "nationwide",
    str_detect(distributed_to, "international") ~ "worldwide",
    str_detect(distributed_to, "other foreign") ~ "worldwide",
    str_detect(distributed_to, "and foreign") ~ "worldwide",
    str_detect(distributed_to, "United Kingdom") ~ "worldwide",
    str_detect(distributed_to, "JAPAN") ~ "worldwide",
    str_detect(distributed_to, "Spain") ~ "worldwide",
    str_detect(distributed_to, "Wordwide") ~ "worldwide",
    str_detect(distributed_to, "ISRAEL") ~ "worldwide",
    str_detect(distributed_to, "UK") ~ "worldwide",
    str_detect(distributed_to, "Switzerland") ~ "worldwide",
    str_detect(distributed_to, "Nationwide and international") ~ "worldwide",
    str_detect(distributed_to, "Srialanka") ~ "worldwide",
    str_detect(distributed_to, "Sweden") ~ "worldwide",
    str_detect(distributed_to, "Kuwait") ~ "worldwide",
    str_detect(distributed_to, "Middle East") ~ "worldwide",
    str_detect(distributed_to, "Canadian") ~ "worldwide",
    str_detect(distributed_to, "KOREA") ~ "worldwide",
    str_detect(distributed_to, "Korea") ~ "worldwide",
    str_detect(distributed_to, "Brazil") ~ "worldwide",
    str_detect(distributed_to, "states") ~ "nationwide",
    str_detect(distributed_to, "state") ~ "nationwide",
    str_detect(distributed_to, "State") ~ "nationwide",
    str_detect(distributed_to, "States") ~ "nationwide",
    str_detect(distributed_to, "USA only") ~ "nationwide",
    str_detect(distributed_to, "To PR only") ~ "nationwide",
    str_detect(distributed_to, "nation wide") ~ "nationwide",
    str_detect(distributed_to, "nationwide") ~ "nationwide",
    str_detect(distributed_to, "Bentonville") ~ "nationwide",
    str_detect(distributed_to, "Nationally") ~ "nationwide",
    str_detect(distributed_to, "US distribution only") ~ "nationwide",
    str_detect(distributed_to, "Domestic") ~ "nationwide",
    str_detect(distributed_to, "US Distribution") ~ "nationwide",
    str_detect(distributed_to, "domestic") ~ "nationwide",
    str_detect(distributed_to, "Nationwide") ~ "nationwide",
    str_detect(distributed_to, "world") ~ "worldwide",
    str_detect(distributed_to, "Argentina") ~ "worldwide",
    str_detect(distributed_to, "US distribution") ~ "nationwide",
    str_detect(distributed_to, "AZ") ~ "nationwide",
    str_detect(distributed_to, "TX") ~ "nationwide",
    str_detect(distributed_to, "Distributed to") ~ "nationwide",
    str_detect(distributed_to, "throughout the") ~ "nationwide",
    str_detect(distributed_to, "PA") ~ "nationwide",
    str_detect(distributed_to, "CA") ~ "nationwide",
    str_detect(distributed_to, "FL") ~ "nationwide",
    str_detect(distributed_to, "Distributed in") ~ "nationwide",
    str_detect(distributed_to, "NY") ~ "nationwide",
    str_detect(distributed_to, "US") ~ "nationwide",
    str_detect(distributed_to, "Texas") ~ "nationwide",
    str_detect(distributed_to, "OH") ~ "nationwide",
    str_detect(distributed_to, "U.S.") ~ "nationwide",
    str_detect(distributed_to, "Single US") ~ "nationwide",
    str_detect(distributed_to, "single") ~ "nationwide",
    str_detect(distributed_to, "NC") ~ "nationwide",
    str_detect(distributed_to, "Indiana") ~ "nationwide",
    str_detect(distributed_to, "UT") ~ "nationwide",
    str_detect(distributed_to, "MA") ~ "nationwide",
    str_detect(distributed_to, "Maryland") ~ "nationwide",
    str_detect(distributed_to, "Florida") ~ "nationwide",
    str_detect(distributed_to, "California") ~ "nationwide",
    str_detect(distributed_to, "only") ~ "nationwide",
    str_detect(distributed_to, "Natonwide Distribution") ~ "nationwide",
    str_detect(distributed_to, "USA") ~ "nationwide",
    str_detect(distributed_to, "MO") ~ "nationwide",
    str_detect(distributed_to, "MN") ~ "nationwide",
    str_detect(distributed_to, "Puerto Rico") ~ "nationwide",
    str_detect(distributed_to, "Illinois") ~ "nationwide",
    str_detect(distributed_to, "IL") ~ "nationwide",
    str_detect(distributed_to, "MI") ~ "nationwide",
    str_detect(distributed_to, "one") ~ "nationwide",
    str_detect(distributed_to, "NJ") ~ "nationwide",
    str_detect(distributed_to, "CO") ~ "nationwide",
    str_detect(distributed_to, "DE") ~ "nationwide",
    str_detect(distributed_to, "LA") ~ "nationwide",
    str_detect(distributed_to, "MN") ~ "nationwide",
    str_detect(distributed_to, "Massachusetts") ~ "nationwide",
    str_detect(distributed_to, "VA") ~ "nationwide",
    str_detect(distributed_to, "Utah") ~ "nationwide",
    str_detect(distributed_to, "Pennsylvania") ~ "nationwide",
    str_detect(distributed_to, "Virginia") ~ "nationwide",
    str_detect(distributed_to, "Wisconsin") ~ "nationwide",
    str_detect(distributed_to, "OR") ~ "nationwide",
    str_detect(distributed_to, "GA") ~ "nationwide",
    str_detect(distributed_to, "NE") ~ "nationwide",
    str_detect(distributed_to, "The") ~ "undefind",
    str_detect(distributed_to, "later") ~ "undefind",
    str_detect(distributed_to, "Apple") ~ "undefind",
    str_detect(distributed_to, "list") ~ "undefind",
    str_detect(distributed_to, "population") ~ "undefind",
    
    TRUE ~ distributed_to
  ))

#Remove (Device Recall) from all names of devices:

MedDevices <- MedDevices %>%
  mutate(device_name = str_remove_all(device_name, "Device Recall"))

# Remove some rows that contain messy name:

MedDevices <- MedDevices[-c(6282, 11039, 7168), ]

#Remove the column that has very messy and not uniform data:

MedDevices <- select(MedDevices, -c(quantity_in_commerce, data_notes, action))

#Reorder the columns in data frame:

col_order <- c("device_id", "device_name", "device_classification","manufacturers_name", "parent_company","distributed_to",
               "implanted", "risk_class", "reason", "determined_cause", "Recall_classification", "date_initiated_by_firm",
               "date_posted", "date_terminated")
MedDevices <- MedDevices[, col_order]

# Fix the numbering of the (device_id):

MedDevices$device_id <- 1:nrow(MedDevices)

# MedDevices_load.R

usethis::use_data(MedDevices, overwrite = TRUE)
