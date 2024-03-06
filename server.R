library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(plotly)




merged_dataset <- read_csv("merged_data_copy.csv")
merged_dataset$`Frequency of Social Media Interaction` <- factor(merged_dataset$`Frequency of Social Media Interaction`,
                                                                 levels = c("Rarely", "Occasionally", "Frequently", "Very Often"),
                                                                 ordered = TRUE)

smmh <- read_csv("smmh.csv")
server <- function(input, output) {
  #session
  
  
 #-------------------------------------------------------------------------------------------------------------------------------------------------
  # Page 1 - start
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
  
  # Rendering the plotly plot
     

    output$impactPlot1 <- renderPlotly({
      # data <- merged_dataset()
       # Ensure merged_dataset is not empty or NULL
      merged_data <- merged_dataset()

      filtered_data <- merged_data %>%
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
  
    
    output$scatterPlot <- renderPlotly({
      merged_data <- merged_dataset()
      
      # Order dataset column
      merged_data$Frequency.of.Social.Media.Interaction <- factor(
        merged_data$Frequency.of.Social.Media.Interaction,
        levels = c("Rarely", "Occasionally", "Frequently", "Very Often"),
        ordered = TRUE
      )
      # Make the plot
      plot_ly(merged_data, 
              x = ~`Frequency.of.Social.Media.Interaction`, 
              y = ~`Impact.on.Mental.Health..Score.`,
              type = "box", mode = "markers", 
              marker = list(size = 5, opacity = 0.5)) %>%
        layout(title = "",
               xaxis = list(title = "Frequency of Social Media Interaction"),
               yaxis = list(title = "Impact on Mental Health (Score 1-5)"))
    })

  
  
# Page 2 - end
#--------------------------------------------------------------------------------------------------------------------------------------------------------

  
  #Notes: 
  

#--------------------------------------------------------------------------------------------------------------------------------------------------------
  # Page 3 - begin  
  output$relationshipPlot <- renderPlot({
    ggplot(filtered_smmh(), aes(x = `17. How often do you look to seek validation from features of social media?`, fill = `3. Relationship Status`)) +
      geom_bar(position = "dodge") +
      labs(x = "Frequency of Seeking Validation", y = "Count", title = "Social Media Validation and Usage Time Based on Relationship Status") +
      theme_minimal()
  })
  
}
                                       
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
# Page 3 - end
#--------------------------------------------------------------------------------------------------------------------------------------------------------
  #Notes: 
  
  
  

  
#--------------------------------------------------------------------------------------------------------------------------------------------------------
  
}
