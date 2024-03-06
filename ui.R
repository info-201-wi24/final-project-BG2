library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(plotly)
library(shinythemes)

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Introduction",
   h1("Introduction"),
   p("In today's digital age, the impact of social media on mental health is a topic of growing concern. Our project delves into the intricate relationship between social media usage patterns and their effects on psychological well-being."),
   p("Social media platforms play a significant role in shaping individuals' perceptions of themselves and their surroundings. The constant exposure to curated images and the pursuit of likes can contribute to negative emotions."),
   p("Our analysis revolves around three key questions: How does the frequency of Instagram usage correlate with users' mental health outcomes? Is there a correlation between feelings of depression and the time spent on social media? And what is the relationship between the frequency of seeking validation on social media and the duration of usage?"),
   p("To conduct our research, we utilized datasets from reputable sources. One dataset was obtained from Mendeley Data, collected by the Kisii University College Faculty of Health Sciences through online surveys and campus data collection methods. Additionally, we utilized a dataset from Kaggle, which originated from a university statistics course. This dataset was processed using machine learning algorithms to predict the need for professional help based on social media usage patterns."),
   p("It's important to note potential biases in our dataset, such as uneven distribution across demographic segments like gender and socioeconomic status. This non-representative sample may skew interpretations of the relationship between social media usage and mental health."),
   imageOutput("myImage")                      
)



#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Page 1 - start


## VIZ 1 TAB INFO
# Define UI
# Visualization 1 Sidebar with Inputs


ui <- navbarPage("Social Medias Affect On Mental Health",
 overview_tab,
 # Viz 1 Tab - I assume this is where you want your usageEmotionPlot to go
 viz_1_tab <- tabPanel("Usage & Emotion",
 sidebarLayout(
   sidebarPanel(
     h2("Filters"),
     selectInput("purposeless_usage", "Usage Without Specific Purpose",
                 choices = c("Very Rarely" = 1, "Rarely" = 2, "Occasionally" = 3, 
                             "Frequently" = 4, "Very Frequently" = 5)),
     sliderInput("depression_level", "Feelings of Depression",
                 min = 1, max = 5, value = c(1, 5))
   ),
   mainPanel(
     h2("Visualization"),
     plotOutput("usageEmotionPlot", height = "400px"))
   )
   ),
 )



#  
# Page 1 - end 
#--------------------------------------------------------------------------------------------------------------------------------------------------------




# notes: how different levels of Instagram use might be linked to feeling distracted or having trouble sleeping




#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Page 2 - begin 


## VIZ 2 TAB INFO
# Side bar info


# Page 2 - end
#--------------------------------------------------------------------------------------------------------------------------------------------------------

ui <- navbarPage("Impact Analysis Dashboard",
                 theme = shinytheme("flatly"),  # Apply a theme for better appearance
              viz_2_tab  <- tabPanel("Age-based Impact",
                          fluidPage(
                            titlePanel("ScatterPlot: Distribution of Mental Health Impact Scores based on social media users"),
                            sidebarLayout(
                              sidebarPanel(
                                h3("Filter by Gender"),
                                selectInput("gender", "Gender",
                                            choices = c("All", "Male", "Female"),
                                            selected = "All")
                              ),
                              mainPanel(
                                plotOutput("plot")
                              )
                            )
                          )
                 ),
             
)

#Notes: 


#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Page 3 - begin  
#Relationship between frequency of look to seek validation on social media and length of time using social media base on their relationship Status.	` 

## VIZ 3 TAB INFO
viz_3_sidebar <- sidebarPanel(
  h2("Social Media Validation Seeking and Daily Usage Time Based on Relationship Status"),
  checkboxGroupInput("relationship_status", "Relationship Status",
                     choices = c("In a relationship", "Single", "Married", "Divorced"),
                     selected = c("In a relationship", "Single", "Married", "Divorced")),
  selectInput("time_spent", "Average Time Spent on Social Media",
              choices = c("Less than an Hour", "Between 1 and 2 hours", "Between 2 and 3 hours", 
                          "Between 3 and 4 hours", "Between 4 and 5 hours", "More than 5 hours")),
  ###sliderInput("validation_freq", "Frequency of Seeking Validation",
              ###min = 1, max = 5, value = c(1, 5), step = 1)
)
viz_3_main_panel <- mainPanel(
  h2("Vizualization 3: relation plot"),
  plotOutput("relationshipPlot")
)

viz_3_tab <- tabPanel("Social Media Engagement by Relationship Status",
                      sidebarLayout(
                        viz_3_sidebar,
                        viz_3_main_panel
                      )
)

# Page 3 - end
#--------------------------------------------------------------------------------------------------------------------------------------------------------
#Notes: 





#--------------------------------------------------------------------------------------------------------------------------------------------------------
# page 4 - start



## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Our Findings",
 h1("SOur FIndings"),
 p("From what we observed, the data in both datasets show a 
   clear sighn of social media being a net negative on mentak health. In more interesting ways 
   than just one. For example in the 'Usage & Emotion' visualizaiton, the data points 
   to us that as we increase how frequent the social media users engange, the average 
   feelings of depression increased with them. When we delved a bit deeper and studied
   exactly what age and gender was being affected the most, we observed something very 
   interesting. Overall it seems like older individuals do much better in this social media 
   age because their mental health scores were through the roofs. Contrasting with younger individuals, 
   the score gets lower. Gender only really gave instances of outliers but younger aged females did alot better 
   than younger aged males did. Finally the most comprehensive finding was what all that means in the context of 
   active attention seeking through the lens of relationship status. The trends told us that the more hours people 
   spend on social media, the more attention seeking behaviors they often times show. Now the most interesting thing about
   the data was how married individuals showed sighns of seeking validation when only low hours were spent on social media vs single
   individuals showing sighns of validation seeking the higher the engaement got. ")
)

# page 4 - end
#--------------------------------------------------------------------------------------------------------------------------------------------------------


ui <- navbarPage("Social Medias Affect On Mental Health",
                 theme = shinytheme("flatly"),  # Apply a theme for better appearance
                 overview_tab,
                 viz_1_tab,
                 viz_2_tab,
                 viz_3_tab,
                 conclusion_tab
)
