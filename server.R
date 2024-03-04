library(shiny)
library(ggplot2)
library(dplyr)
library(readr)




server <- function(input, output) {
  #session
  
  

#--------------------------------------------------------------------------------------------------------------------------------------------------------
  # Page 1 - start
  
  
  merged_dataset <- reactive({
    read.csv("merged_data_copy.csv", stringsAsFactors = FALSE)
  })
  
  output$impactPlot1 <- renderPlotly({
    data <- merged_dataset()
    
    filtered_data <- data %>%
      filter(`On a scale from 1 to 5, how easily distracted are you?` >= input$distractionLevel[1],
             `On a scale from 1 to 5, how easily distracted are you?` <= input$distractionLevel[2]) %>%
      filter(if (input$sleepIssue == 0) TRUE else `On a scale from 1 to 5, how often do you face issues regarding sleep?` == input$sleepIssue)
    
    # Generate the plot ask if the object error is something wrong with it 
    plot <- ggplot(filtered_data, aes(x = `Frequency of Social Media Interaction`, y = `Impact on Mental Health (Score)`)) +
      geom_point(aes(color = `Self-reported Mental Health Status`)) +
      geom_smooth(method = "lm", color = "blue", se = FALSE) +
      theme_minimal() +
      labs(title = "Impact of Social Media Interaction on Mental Health",
           x = "Frequency of Social Media Interaction", 
           y = "Impact on Mental Health (Score)")
    
    ggplotly(plot)
  })

  
# Page 1 - end 
#--------------------------------------------------------------------------------------------------------------------------------------------------------

  
  
  
  # notes: 
  
  
  

#--------------------------------------------------------------------------------------------------------------------------------------------------------
  # Page 2 - begin 
  
  
  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    
  
# Page 2 - end
#--------------------------------------------------------------------------------------------------------------------------------------------------------

  
  #Notes: 
  

#--------------------------------------------------------------------------------------------------------------------------------------------------------
  # Page 3 - begin  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
# Page 3 - end
#--------------------------------------------------------------------------------------------------------------------------------------------------------
  #Notes: 
  
  
  

  
#--------------------------------------------------------------------------------------------------------------------------------------------------------
  
}