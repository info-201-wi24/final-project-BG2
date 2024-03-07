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
  
  output$variableDistributionPlot <- renderPlot({
    filtered_data <- smmh %>%
      filter(`1. What is your age?` >= input$ageRange[1],
             `1. What is your age?` <= input$ageRange[2],
             `8. What is the average time you spend on social media every day?` == input$socialMediaTimeSpent)
    
    ggplot(filtered_data, aes(x = `1. What is your age?`)) +
      geom_histogram(binwidth = 1, fill = "red", color = "black") +
      labs(x = "Age", y = "Social Media Users") +
      xlim(input$ageRange[1], input$ageRange[2]) +  
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))  
  })

  

  
# Page 1 - end 
#--------------------------------------------------------------------------------------------------------------------------------------------------------

  
  

#--------------------------------------------------------------------------------------------------------------------------------------------------------
  # Page 2 - begin 
output$plot <- renderPlot({
  filtered_data <- if (input$gender == "All") {
    data
  } else {
    data %>% 
      dplyr::filter(Gender == input$gender)
  }
  
  p <- ggplot(filtered_data) + theme_minimal() + 
    labs(x = "Age", y = "Score")

  if (input$selfReportedCheck && "Self-reported Mental Health Status" %in% names(filtered_data)) {
    p <- p + geom_point(data = filtered_data %>% filter(!is.na(`Self-reported Mental Health Status`)), 
                        aes(x = Age, y = `Self-reported Mental Health Status`), 
                        color = "blue")
  }
  
  if (input$actualScoreCheck && "Impact on Mental Health (Score)" %in% names(filtered_data)) {
    p <- p + geom_point(data = filtered_data %>% filter(!is.na(`Impact on Mental Health (Score)`)), 
                        aes(x = Age, y = `Impact on Mental Health (Score)`), 
                        color = "red")
  }

  p
})
  
# Page 2 - end
#--------------------------------------------------------------------------------------------------------------------------------------------------------

  

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
}
