library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(readxl)

Social_Media_Mental_Health <- read_csv("path/to/smmh.csv")
Digital_Behavior_and_Mental_Health_Survey_2022 <- read_excel("path/to/Digital Behavior and Mental Health Survey 2022.xlsx")

#if anyone is reading this, its very messsy right now, still needs alot of work

server <- function(input, output) {
  
  output$viz1Plot <- renderPlot({
    ggplot(data, aes(x=..., y=...)) + 
      geom_point() +
      theme_minimal() +
      labs(title="Visualization 1: Impact of Instagram Usage on Mental Health", x="X-axis Label", y="Y-axis Label")
  })
  
  output$viz2Plot <- renderPlot({
    filtered_data <- merged_dataset %>%
      filter(`How often do you find yourself using social media without purpose?` %in% if(input$usageWithoutPurpose == "All") unique(merged_dataset$`How often do you find yourself using social media without purpose?`) else input$usageWithoutPurpose,
             `How often do you get distracted by social media when you are busy?` %in% if(input$distractionLevel == "All") unique(merged_dataset$`How often do you get distracted by social media when you are busy?`) else input$distractionLevel,
             `How often do you seek validation from features of social media?` %in% if(input$validationSeeking == "All") unique(merged_dataset$`How often do you seek validation from features of social media?`) else input$validationSeeking)
    
    ggplot(filtered_data, aes(x=..., y=...)) + 
      geom_point() +
      labs(title="Visualization 2: ", x="X-axis Label", y="Y-axis Label")
  })
}
