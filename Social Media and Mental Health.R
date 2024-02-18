library(readr)
library(readxl)
Social_Media_Mental_Health <- read_csv("C:/Users/Thien/Downloads/archive/smmh.csv")
Digital_Behavior_and_Mental_Health_Survey_2022 <- read_excel("C:/Users/Thien/Downloads/mental health and social media/mental health and social media/Digital Behavior and Mental Health Survey 2022.xlsx")

Social_Media_Mental_Health$`9. How often do you find yourself using Social media without a specific purpose?` <- NULL