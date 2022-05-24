install.packages("dplyr") 
library(dplyr)
install.packages("tidyverse")
library(tidyverse)
install.packages('ggcorrplot')
library(ggcorrplot)

gun <- read.csv("/Users/onafolchaloy/Desktop/data_todo.csv", header = TRUE)
head(gun)
                   
a <- select(gun,  'date', 'n_injured', 'state', 'city_or_county', 
                                'n_killed', 
                                'latitude', 'longitude', 
                                'n_guns_involved', 'participant_age', 
                                'participant_age_group', 'participant_gender', 
                                'participant_status', 
                                'participant_type', 'state_house_district', 
                                'state_senate_district')


a$state <- as.numeric(as.factor(a$state),  na.rm = TRUE)
a$date <- as.numeric(as.factor(a$date),  na.rm = TRUE)
a$city_or_county <- as.numeric(as.factor(a$city_or_county),  na.rm = TRUE)
a$gun_type <- as.numeric(as.factor(a$gun_type),  na.rm = TRUE)
a$participant_age <- as.numeric(as.factor(a$participant_age),  na.rm = TRUE)
a$participant_age_group <- as.numeric(as.factor(a$participant_age_group),  na.rm = TRUE)
a$participant_gender <- as.numeric(as.factor(a$participant_gender),  na.rm = TRUE)
a$participant_status <- as.numeric(as.factor(a$participant_status),  na.rm = TRUE)
a$participant_type <- as.numeric(as.factor(a$participant_type),  na.rm = TRUE)

a[is.na(a)] <- 0
cormat <- round(cor(a), 2)

ggcorrplot(cormat, lab = TRUE, type = 'lower')
