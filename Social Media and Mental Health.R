library(readr)
library(readxl)
library(dplyr)
Social_Media_Mental_Health <- read_csv("smmh.csv")
Digital_Behavior_and_Mental_Health_Survey_2022 <- read_excel("Digital Behavior and Mental Health Survey 2022.xlsx")


#Cleaning data to relevant subjects 
Social_Media_Mental_Health <- Social_Media_Mental_Health[-c(1, 3, 4, 6, 12, 15, 16, 19)]
Digital_Behavior_and_Mental_Health_Survey_2022  <- Digital_Behavior_and_Mental_Health_Survey_2022 [-c(1)]

# Combining datasets
merged_dataset <- bind_rows(Social_Media_Mental_Health, Digital_Behavior_and_Mental_Health_Survey_2022)

