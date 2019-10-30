# load library
require(tidyverse)

# read data
rd <- read_csv('data/IHME-GBD_2017_DATA-7f79a465-1.csv')

## Adjust val, upper and lower values for 16-19 age group

# Reduce the value by 20%
rd[rd$age_name == "15 to 19",]$val <- rd[rd$age_name == "15 to 19",]$val * 0.8
rd[rd$age_name == "15 to 19",]$upper <- rd[rd$age_name == "15 to 19",]$upper * 0.8
rd[rd$age_name == "15 to 19",]$lower <- rd[rd$age_name == "15 to 19",]$lower * 0.8

# Rename the age group
rd[rd$age_name == "15 to 19",]$age_name <- "16 to 19"

## Make the new age groups as 16-24, 25-34, 35-49, 50-64, 65-74, 75+
# age_groups <- c("16-24", "25-34", "35-49", "50-64", "65-74", "75+")

ag16_24 <- rd %>% filter(age_name %in% c('16 to 19', '20 to 24')) %>% 
  group_by(measure_id, measure_name, location_id, location_name, sex_id, sex_name, 
           cause_id, cause_name, metric_id, metric_name, year) %>% 
  summarise(val = sum(val), upper = sum(upper), lower = sum(lower), 
            age_name = first(age_name)) %>% 
  mutate(age_name = "16-24")

ag25_34 <- rd %>% filter(age_name %in% c('25 to 29', '30 to 34')) %>% 
  group_by(measure_id, measure_name, location_id, location_name, sex_id, sex_name, 
           cause_id, cause_name, metric_id, metric_name, year) %>% 
  summarise(val = sum(val), upper = sum(upper), lower = sum(lower), 
            age_name = first(age_name)) %>% 
  mutate(age_name = "25-34")

ag35_49 <- rd %>% filter(age_name %in% c('35 to 39', '40 to 44', '45 to 49')) %>% 
  group_by(measure_id, measure_name, location_id, location_name, sex_id, sex_name, 
           cause_id, cause_name, metric_id, metric_name, year) %>% 
  summarise(val = sum(val), upper = sum(upper), lower = sum(lower), 
            age_name = first(age_name)) %>% 
  mutate(age_name = "35-49")

ag50_64 <- rd %>% filter(age_name %in% c('50 to 54', '55 to 59', '60 to 64')) %>% 
  group_by(measure_id, measure_name, location_id, location_name, sex_id, sex_name, 
           cause_id, cause_name, metric_id, metric_name, year) %>% 
  summarise(val = sum(val), upper = sum(upper), lower = sum(lower), 
            age_name = first(age_name)) %>% 
  mutate(age_name = "50-64")

ag65_74 <- rd %>% filter(age_name %in% c('65 to 69', '70 to 74')) %>% 
  group_by(measure_id, measure_name, location_id, location_name, sex_id, sex_name, 
           cause_id, cause_name, metric_id, metric_name, year) %>% 
  summarise(val = sum(val), upper = sum(upper), lower = sum(lower), 
            age_name = first(age_name)) %>% 
  mutate(age_name = "65-74")

ag75plus <- rd %>% filter(age_name %in% c('75 to 79', '80 plus')) %>% 
  group_by(measure_id, measure_name, location_id, location_name, sex_id, sex_name, 
           cause_id, cause_name, metric_id, metric_name, year) %>% 
  summarise(val = sum(val), upper = sum(upper), lower = sum(lower), 
            age_name = first(age_name)) %>% 
  mutate(age_name = str_replace(age_name, "75 to 79", "75+"))

rdf <- rbind(ag16_24, ag25_34, ag35_49, ag50_64, ag65_74, ag75plus)

