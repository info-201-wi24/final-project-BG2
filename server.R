library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(plotly)
library(viridis)
library(readxl)
library(pheatmap)




#reading crap in, we included a merged data set and we used it!!
smmh <- read_csv("smmh.csv", show_col_types = FALSE)
data <- read_csv("merged_data_copy.csv", show_col_types = FALSE)
# Defined the server logic for the Shiny app
server <- function(input, output) {
  
  #-------------------------------------------------------------------------------------------------------------------------------------------------
  # Page 1 - start
  
  # Render a plot in the UI output placeholder 'variableDistributionPlot'
  output$variableDistributionPlot <- renderPlot({
    
    # Filter 'smmh' data based on age range and social media usage inputs
    filtered_data <- smmh %>%
      filter(`1. What is your age?` >= input$ageRange[1],
             `1. What is your age?` <= input$ageRange[2],
             `8. What is the average time you spend on social media every day?` == input$socialMediaTimeSpent)
    
    # Create and return a histogram of filtered data with aesthetic mappings and styles
    ggplot(filtered_data, aes(x = `1. What is your age?`)) +
      geom_histogram(binwidth = 1, fill = "red", color = "black") +
      labs(x = "Age", y = "Social Media Users") +
      xlim(input$ageRange[1], input$ageRange[2]) +  
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))  
  })
  
  
  
  
  # Page 1 - end 
  #--------------------------------------------------------------------------------------------------------------------------------------------------------
  
  # you dont have to use the same code but remeber to add the github and stack overflow citation
  
  
  #--------------------------------------------------------------------------------------------------------------------------------------------------------
  # Page 2 - begin 
  
  # Renders yet another plot in the UI output placeholder 'plot'
  output$plot <- renderPlot({
    filtered_data <- if (input$gender == "All") {
      data
    } else {
      data %>% 
        dplyr::filter(Gender == input$gender)
    }
    
    # Begin constructing the plot with age on x-axis and style it
    p <- ggplot(filtered_data) + theme_minimal() + 
      labs(x = "Age", y = "Score")
    
    # Add self-reported mental health status points to the plot if selected
    if (input$selfReportedCheck && "Self-reported Mental Health Status" %in% names(filtered_data)) {
      p <- p + geom_point(data = filtered_data %>% filter(!is.na(`Self-reported Mental Health Status`)), 
                          aes(x = Age, y = `Self-reported Mental Health Status`), 
                          color = "blue")
    }
    
    # Add actual mental health score points to the plot if selected
    if (input$actualScoreCheck && "Impact on Mental Health (Score)" %in% names(filtered_data)) {
      p <- p + geom_point(data = filtered_data %>% filter(!is.na(`Impact on Mental Health (Score)`)), 
                          aes(x = Age, y = `Impact on Mental Health (Score)`), 
                          color = "red")
    }
    
    p
  })
  
  # Page 2 - end
  #--------------------------------------------------------------------------------------------------------------------------------------------------------
  
  # use reactive for this one
  
  #--------------------------------------------------------------------------------------------------------------------------------------------------------
  # Page 3 - begin 
  
  # Render an image in the UI output placeholder 'myImage'
  output$myImage <- renderImage({
    list(src = "IMG_3156.WEBP",
         align = "center",
         width = "100%",
         height = 500)
  }, deleteFile = F)
  
  # Prepare reactive filtered data based on some conditions
  filtered_data <-reactive({
    merged_dataset
  })
  
  # Prepare another set of reactive filtered data based on relationship status and time spent on social media
  filtered_smmh <-reactive({
    smmh[smmh$`3. Relationship Status` %in% input$relationship_status &
           smmh$`8. What is the average time you spend on social media every day?` == input$time_spent, ]
  })
  
  # Render a bar plot in the UI output placeholder 'relationshipPlot'
  output$relationshipPlot <- renderPlot({
    filtered_smmh <- smmh %>%
      filter(`3. Relationship Status` %in% input$relationship_status &
               `8. What is the average time you spend on social media every day?` == input$time_spent)
    
    # Create and return a bar plot showing validation seeking behavior by relationship status
    ggplot(filtered_smmh, aes(x = `17. How often do you look to seek validation from features of social media?`, fill = `3. Relationship Status`)) +
      geom_bar(position = "dodge") +
      labs(x = "Frequency of Seeking Validation", y = "Count", title = "Social Media Validation and Usage Time Based on Relationship Status") +
      theme_minimal()
  })
}
