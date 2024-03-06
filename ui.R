library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(plotly)

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Social media's Impact on Mental Health",
  h1("Introduction"),
  p("Social medias have continued affecting people’s mental health in the modern society. We aim to unravel the complex relationship between social media usage and its effects on users' psychological well-being. In an era where social media platforms dominate our daily interactions and self-perception, with their emphasis on visually curated lives, social media like twitter or instagram stands out for their potential to influence mental health. This journey seeks to explore and visualize the nuanced ways in which continuous exposure to idealized images, the pursuit of likes, and the pressure to maintain a perfect online persona contribute to increased feelings of anxiety, depression, and loneliness among its users."),
  p("Our investigation centers on three pivotal questions: How does the amount of time spent on Instagram correlate with the user's mental health outcomes? How often does user feel down correlated with the time they spend on Instagram? Lastly, Relationship between frequency of look to seek validation on social media and length of time using social media?"),
  p("Our team analyzed data from one dataset from ", a("Mendeley data", href="https://data.mendeley.com/datasets/jxkcm7s638/1"), ". The data was collected through the Kisii University College Faculty of Health Sciences. Online surveys and in campus data collection methods were used. John Ngugi analyzed the behaviors of participants and based it off of a self-report score and an actual score on their mental health from a different survey that would rank their actual well being to see if there were any biases that would cause people to say different."),
  p("Another dataset is from ", a("Kaggle data", href="https://www.kaggle.com/datasets/souvikahmed071/social-media-and-mental-health"), ". This dataset was collected through a Statistics course at a university, collecting data on the local campus and processed the information through a machine learning algorithm that was later used to create a predictive model to see if someone needs professional help or not. The survey has a bunch of different ways of actually narrowing down the symptoms that generate data which really homes in on the overall trend of social media use."),
  p("Our dataset may show a certain composition variable distribution, where the proportion of data points from various demographic segments, such as gender and socioeconomic status, does not reflect the broader user base. This uneven distribution may lead to skewed interpretations of the impact on mental health, as it does not accurately represent the diverse experiences of all users."),
  imageOutput("myImage")                      
)



#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Page 1 - start


## VIZ 1 TAB INFO
# Define UI
# Visualization 1 Sidebar with Inputs


viz_1_sidebar <- sidebarPanel(
  h2("Options for Visualization 1"),
  
  sliderInput("distractionLevel",
              "Distraction Level:",
              min = 1, max = 5, value = c(1,5)),
  
  selectInput("sleepIssue",
              "Sleep Issue Level:",
              choices = c("All" = 0, "Never" = 1, "Rarely" = 2, 
                          "Sometimes" = 3, "Often" = 4, "Always" = 5),
              selected = 0))

viz_1_main_panel <- mainPanel(
  h2("Visualization 1: Impact of Social Media Usage"),
  plotlyOutput(outputId = "impactPlot1"))

viz_1_tab <- tabPanel("Instagram Usage & Mental Health Impact",
                      sidebarLayout( viz_1_sidebar,viz_1_main_panel))

ui <- navbarPage("Social Media's Impact On Mental Health",
                viz_1_tab,
)






#  
# Page 1 - end 
#--------------------------------------------------------------------------------------------------------------------------------------------------------




# notes: how different levels of Instagram use might be linked to feeling distracted or having trouble sleeping




#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Page 2 - begin 


## VIZ 2 TAB INFO
# Side bar info
viz_2_sidebar <- sidebarPanel(
  h2("What does this mean?", style = "margin: auto;"),
  p("In exploring the impact of screen time on mental health, our analysis suggests that there is no clear direct correlation between the two factors based on the median results (to void outliers). After careful examination of the dataset, it becomes apparent that screentime usage does not consistently align with corresponding shifts in mental health scores. This relationship shows the complexity of variables contributing to mental health, emphasizing that screen time alone may not be a decisive indicator. While the data doesn't reveal a straightforward connection, it prompts further investigation into the multitude of variables that collectively shape individuals' mental health experiences."),
  p("Median (Rarely, Occasionaly, Frequently, Very Often): 4, 4.25, 3.5, 3.35"),
  style = "width: 600px; height: auto; display: flex; flex-direction: column; justify-content: center; align-items: center;"
)
# Main panel info
viz_2_main_panel <- mainPanel(
  h2("Effect of Screen Time on Mental Health"),
  plotlyOutput("scatterPlot")
)

viz_2_tab <- tabPanel("Effect of Screen Time on Mental Health",
                      sidebarLayout(
                        viz_2_sidebar,
                        viz_2_main_panel
                      )
)



# Page 2 - end
#--------------------------------------------------------------------------------------------------------------------------------------------------------


#Notes: 


#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Page 3 - begin  
#Relationship between frequency of look to seek validation on social media and length of time using social media base on their relationship Status.	` 

## VIZ 3 TAB INFO
viz_3_sidebar <- sidebarPanel(
  h2("Social Media Validation and Usage Time Based on Relationship Status"),
  checkboxGroupInput("relationship_status", "Relationship Status",
                     choices = c("In a relationship", "Single", "Married", "Divorced"),
                     selected = c("In a relationship", "Single", "Married", "Divorced")),
  selectInput("time_spent", "Average Time Spent on Social Media",
              choices = c("Less than an Hour", "Between 1 and 2 hours", "Between 2 and 3 hours", 
                          "Between 3 and 4 hours", "Between 4 and 5 hours", "More than 5 hours")),
  sliderInput("validation_freq", "Frequency of Seeking Validation",
              min = 1, max = 5, value = c(1, 5), step = 1)
)
viz_3_main_panel <- mainPanel(
  h2("Vizualization 3: relation plot"),
  plotOutput("relationshipPlot")
)

viz_3_tab <- tabPanel("Social Media Validation and Usage Time Based on Relationship Status",
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

conclusion_tab <- tabPanel("Conclusion Tab Title",
 h1("Some title"),
 p("some conclusions")
)

# page 4 - end
#--------------------------------------------------------------------------------------------------------------------------------------------------------


ui <- navbarPage("Social Medias Affect On Mental Health",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)
