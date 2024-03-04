library(shiny)
library(ggplot2)
library(dplyr)
library(readr)



server <- function(input, output, session) {
  # Reactive expression to load the dataset
  merged_dataset <- reactive({
    read.csv("merged_data_copy.csv", stringsAsFactors = FALSE)
  })
  
  output$impactPlot1 <- renderPlotly({
    # Obtain the actual data from the reactive expression
    data <- merged_dataset()
    
    # Now you can use the filter function on 'data', which is a dataframe
    filtered_data <- data %>%
      filter(`On a scale from 1 to 5, how easily distracted are you?` >= input$distractionLevel[1],
             `On a scale from 1 to 5, how easily distracted are you?` <= input$distractionLevel[2]) %>%
      filter(if (input$sleepIssue == 0) TRUE else `On a scale from 1 to 5, how often do you face issues regarding sleep?` == input$sleepIssue)
    
    # Generate the plot
    plot <- ggplot(filtered_data, aes(x = `Frequency of Social Media Interaction`, y = `Impact on Mental Health (Score)`)) +
      geom_point(aes(color = `Self-reported Mental Health Status`)) +
      geom_smooth(method = "lm", color = "blue", se = FALSE) +
      theme_minimal() +
      labs(title = "Impact of Social Media Interaction on Mental Health",
           x = "Frequency of Social Media Interaction", 
           y = "Impact on Mental Health (Score)")
    
    # Convert to a Plotly object
    ggplotly(plot)
  })
}







#server <- function(input, output) {
#  merged_dataset <- reactive({
#    read.csv("merged_data_copy.csv", stringsAsFactors = FALSE)
#  }) # Adjust the path as needed
  
  # Assuming 'merged_dataset.csv' is the correct path to your dataset
  # Ensure this dataset is loaded outside of the server function if it's not reactive
  # or consider using reactive expressions if the dataset loading depends on user input
 # data <- merged_dataset()
  
 # output$impactPlot1 <- renderPlotly({
    # Assuming merged_dataset is already loaded and available here
    # If it's not, you need to load the dataset within this function or use a reactive expression
    
    # Filter the dataset based on input values
#    filtered_data <- data %>%
#      filter(`On a scale from 1 to 5, how easily distracted are you?` >= input$distractionLevel[1],
#             `On a scale from 1 to 5, how easily distracted are you?` <= input$distractionLevel[2]) %>%
#      filter(if (input$sleepIssue == 0) TRUE else `On a scale from 1 to 5, how often do you face issues regarding sleep?` == input$sleepIssue)
#    
#    # Generate the plot with specified X-axis and Y-axis
#    plot <- ggplot(filtered_data, aes(x = `Frequency of Social Media Interaction`, y = `Impact on Mental Health (Score)`)) +
#      geom_point(aes(color = `Self-reported Mental Health Status`)) +  # Color-code by mental health status for additional insight
#      geom_smooth(method = "lm", color = "blue", se = FALSE) +  # Add a linear regression line to see the trend
#      theme_minimal() +
#      labs(title = "Impact of Social Media Interaction on Mental Health",
#           x = "Frequency of Social Media Interaction", 
#           y = "Impact on Mental Health (Score)")
#    
#    ggplotly(plot)  # Convert ggplot object to Plotly for interactivity
#  })
#}







# Assuming 'merged_dataset.csv' contains your data

#server <- function(input, output) {
#  dataset_path <- "merged_dataset.csv"  # Adjust the path as needed
  
#  output$impactPlot1 <- renderPlotly({
    # Filter dataset based on input values
  #  filtered_data <- merged_dataset %>%
  #    filter(`On a scale from 1 to 5, how easily distracted are you?` >= input$distractionLevel[1],
   #          `On a scale from 1 to 5, how easily distracted are you?` <= input$distractionLevel[2],
 #            if (input$sleepIssue == 0) TRUE else `On a scale from 1 to 5, how often do you face issues regarding sleep?` == input$sleepIssue)
    
    # Generate plot (update this to reflect your actual data analysis goal)
 #   plot <- ggplot(filtered_data, aes(x = `Some Relevant X-axis Variable`, y = `Impact on Mental Health (Score)`)) +
#      geom_point() +
     # theme_minimal() +
    #  labs(title = "Title Reflecting Analysis Goal", x = "X-axis Label", y = "Impact on Mental Health (Score)")
   # 
  #  ggplotly(plot)  # Make it interactive with Plotly
 # })
#}

