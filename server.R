library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(plotly)
library(viridis)
library(readxl)
library(pheatmap)





smmh <- read_csv("smmh.csv", show_col_types = FALSE)
data <- read_csv("merged_data_final.csv", show_col_types = FALSE)


server <- function(input, output) {
  
  #session
  #-------------------------------------------------------------------------------------------------------------------------------------------------
  # Page 1 - start
  
  # Rendering the plotly plot
  output$variableDistributionPlot <- renderPlot({
    # Filter the data based on the selected age range and social media usage
    filtered_data <- smmh %>%
      filter(`1. What is your age?` >= input$ageRange[1],
             `1. What is your age?` <= input$ageRange[2],
             `6. Do you use social media?` == input$socialMediaUsage)
    
    # Create a histogram or bar plot of age distribution for the selected range
    ggplot(filtered_data, aes(x = `1. What is your age?`)) +
      geom_histogram(binwidth = 1, fill = "dodgerblue", color = "black") +
      labs(x = "Age", y = "Count") +
      xlim(input$ageRange[1], input$ageRange[2]) +  # Set x limits to match the slider input
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate the x labels for better readability
  })

  

  
# Page 1 - end 
#--------------------------------------------------------------------------------------------------------------------------------------------------------

  
  
  
  # notes: 
  
  
  

#--------------------------------------------------------------------------------------------------------------------------------------------------------
  # Page 2 - begin 
output$plot <- renderPlot({
  # Filter based on gender selection
  filtered_data <- if (input$gender == "All") {
    data
  } else {
    data %>% 
      dplyr::filter(Gender == input$gender)
  }
  
  # Start the plot
  p <- ggplot(filtered_data) + theme_minimal() + 
    labs(x = "Age", y = "Score")

  # Add self-reported scores if checkbox is checked
  if (input$selfReportedCheck && "Self-reported Mental Health Status" %in% names(filtered_data)) {
    p <- p + geom_point(data = filtered_data %>% filter(!is.na(`Self-reported Mental Health Status`)), 
                        aes(x = Age, y = `Self-reported Mental Health Status`), 
                        color = "blue")
  }
  
  # Add actual scores if checkbox is checked
  if (input$actualScoreCheck && "Impact on Mental Health (Score)" %in% names(filtered_data)) {
    p <- p + geom_point(data = filtered_data %>% filter(!is.na(`Impact on Mental Health (Score)`)), 
                        aes(x = Age, y = `Impact on Mental Health (Score)`), 
                        color = "red")
  }

  # Return the plot
  p
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
