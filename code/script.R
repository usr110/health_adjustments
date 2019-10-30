# load library
require(tidyverse)

# read data
rd <- read_csv('data/IHME-GBD_2017_DATA-7f79a465-1.csv')

## Adjust val, upper and lower values for 16-19 age group

# Reduce the value by 20%
rd[rd$age_name == "15 to 19",]$val <- rd[rd$age_name == "15 to 19",]$val * 0.8
rd[rd$age_name == "15 to 19",]$upper <- rd[rd$age_name == "15 to 19",]$lower * 0.8
rd[rd$age_name == "15 to 19",]$lower <- rd[rd$age_name == "15 to 19",]$lower * 0.8

# Rename the age group
rd[rd$age_name == "15 to 19",]$age_name <- "16 to 19"