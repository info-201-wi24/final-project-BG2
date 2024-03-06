library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(plotly)
library(viridis)
library(readxl)
library(pheatmap)





smmh <- read_csv("smmh.csv", show_col_types = FALSE)
data <- readxl::read_excel("Digital Behavior and Mental Health Survey 2022.xlsx")


server <- function(input, output) {
  
  #session
  #-------------------------------------------------------------------------------------------------------------------------------------------------
  # Page 1 - start
  
  # Rendering the plotly plot
  output$usageEmotionPlot <- renderPlot({
    filtered_data <- smmh %>%
      filter(`9. How often do you find yourself using Social media without a specific purpose?` >= input$purposeless_usage,
             `18. How often do you feel depressed or down?` >= input$depression_level[1],
             `18. How often do you feel depressed or down?` <= input$depression_level[2])
    
    usage_labels <- c('1' = 'Very Rarely', '2' = 'Rarely', '3' = 'Occasionally', 
                      '4' = 'Frequently', '5' = 'Very Frequently')
    
    filtered_data <- filtered_data %>%
      mutate(`Usage Category` = factor(`9. How often do you find yourself using Social media without a specific purpose?`, 
                                       levels = c('1', '2', '3', '4', '5'), 
                                       labels = usage_labels))
    
    aggregated_data <- filtered_data %>%
      group_by(`Usage Category`) %>%
      summarize(Avg_Depression = mean(`18. How often do you feel depressed or down?`), .groups = 'drop')
    
    ggplot(aggregated_data, aes(x = `Usage Category`, y = Avg_Depression, fill = `Usage Category`)) +
      geom_bar(stat = "identity") +
      scale_fill_viridis_d(option = "D", direction = -1) +  # Reverse the default color palette
      labs(x = "Usage Without Specific Purpose", y = "Average Feelings of Depression", 
           title = "Social Media Usage vs. Emotional Impact") +
      theme_minimal() +
      theme(legend.position = "bottom", plot.title = element_text(hjust = 0.5)) 
  })
  
  
  
  
  # Page 1 - end 
  #--------------------------------------------------------------------------------------------------------------------------------------------------------
  
  
  
  
  # notes: 
  
  
  
  
  #--------------------------------------------------------------------------------------------------------------------------------------------------------
  # Page 2 - begin 
  output$plot <- renderPlot({
    filtered_data <- if (input$gender == "All") {
      data
    } else {
      data %>% 
        filter(Gender == input$gender)
    }
    ggplot(filtered_data, aes(x = Age, y = `Impact on Mental Health (Score)`)) +
      geom_point(color = "blue") +
      labs(x = "Age", y = "Impact on Mental Health (Score)") +
      theme_minimal()
  })
  
  
  # Page 2 - end
  #--------------------------------------------------------------------------------------------------------------------------------------------------------
  
  
  #Notes: 
  
  
  #--------------------------------------------------------------------------------------------------------------------------------------------------------
  # Page 3 - begin 
  
  output$myImage <- renderImage({
    list(src = "IMG_3156.WEBP",
         align = "center",
         width = "100%",
         height = 500)
    
  }, deleteFile = F)
  
  filtered_data <-reactive({
    merged_dataset
  })
  
  filtered_smmh <-reactive({
    smmh[smmh$`3. Relationship Status` %in% input$relationship_status &
           smmh$`8. What is the average time you spend on social media every day?` == input$time_spent, ]
  })
  
  output$relationshipPlot <- renderPlot({
    filtered_smmh <- smmh %>%
      filter(`3. Relationship Status` %in% input$relationship_status &
               `8. What is the average time you spend on social media every day?` == input$time_spent)
    
    ggplot(filtered_smmh, aes(x = `17. How often do you look to seek validation from features of social media?`, fill = `3. Relationship Status`)) +
      geom_bar(position = "dodge") +
      labs(x = "Frequency of Seeking Validation", y = "Count", title = "Social Media Validation and Usage Time Based on Relationship Status") +
      theme_minimal()
  })
  
  
  
  
  # Page 3 - end
  #--------------------------------------------------------------------------------------------------------------------------------------------------------
  #Notes: 
  
  
  
  
  
  #--------------------------------------------------------------------------------------------------------------------------------------------------------
  
}