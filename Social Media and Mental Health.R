library(readr)
library(readxl)
library(dplyr)

Social_Media_Mental_Health <- read_csv("smmh.csv")
Digital_Behavior_and_Mental_Health_Survey_2022 <- read_excel("Digital Behavior and Mental Health Survey 2022.xlsx")


# Cleaning data to relevant subjects 
Social_Media_Mental_Health <- Social_Media_Mental_Health[-c(1, 3, 4, 6, 12, 15, 16, 17, 19)]
Digital_Behavior_and_Mental_Health_Survey_2022  <- Digital_Behavior_and_Mental_Health_Survey_2022 

print(Digital_Behavior_and_Mental_Health_Survey_2022 )
# Merge the datasets

# Convert column from one data set to another
Social_Media_Mental_Health <- Social_Media_Mental_Health  %>%
  mutate(time_to_frequency = case_when(
    `8. What is the average time you spend on social media every day?` %in% c("Less than an Hour") ~ "Rarely",
    `8. What is the average time you spend on social media every day?` %in% c("Between 1 and 2 hours", "Between 2 and 3 hours") ~ "Occasionally",
    `8. What is the average time you spend on social media every day?` %in% c("Between 3 and 4 hours", "Between 4 and 5 hours") ~ "Frequently",
    `8. What is the average time you spend on social media every day?` == "More than 5 hours" ~ "Very often",
    TRUE ~ NA_character_
  ))

merged_dataset <- bind_rows(Social_Media_Mental_Health, Digital_Behavior_and_Mental_Health_Survey_2022) #after

# Replace values in 'Frequency of Social Media Interaction' column
merged_dataset$`Frequency of Social Media Interaction` <- ifelse(
  merged_dataset$time_to_frequency %in% c("Rarely", "Occasionally", "Frequently", "Very often"),
  merged_dataset$time_to_frequency,
  merged_dataset$`Frequency of Social Media Interaction`
)

# Merge Age from one dataset to the other
merged_dataset <- merged_dataset %>%
  mutate(`1. What is your age?` = ifelse(is.na(`1. What is your age?`), Age, `1. What is your age?`))

# Delete unnecessary columns
merged_dataset <- select(merged_dataset, -time_to_frequency, -5, -Age, -Gender)
# Rename columns
merged_dataset <- merged_dataset %>%
  rename(
    Occupation = `4. Occupation Status`,
    Age = `1. What is your age?`,
    `Do you use Social Media?` = `6. Do you use social media?`,
    `What social media platform?` = `7. What social media platforms do you commonly use?`,
    `How often do you find yourself using social media without purpose?` = `9. How often do you find yourself using Social media without a specific purpose?`,
    `How often do you get distracted by social media when you are busy?` = `10. How often do you get distracted by Social media when you are busy doing something?`,
    `On a scale from 1 to 5, how easily distracted are you?` = `12. On a scale of 1 to 5, how easily distracted are you?`,
    `On a scale from 1 to 5, how much are you bothered by your worries?` = `13. On a scale of 1 to 5, how much are you bothered by worries?`,
    `How often do you seek validation from features of social media?` = `17. How often do you look to seek validation from features of social media?`,
    `On a scale from 1 to 5, how frequently does your interest in daily activities fluctuate?` = `19. On a scale of 1 to 5, how frequently does your interest in daily activities fluctuate?`,
    `On a scale from 1 to 5, how often do you face issues regarding sleep?` = `20. On a scale of 1 to 5, how often do you face issues regarding sleep?`

  )


write_csv(merged_dataset, "merged_data_final.csv")

