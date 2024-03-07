library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(plotly)
library(shinythemes)

## OVERVIEW TAB INFO
overview_tab <- tabPanel("Introduction",
  h1("Exploring the Depths of Social Media's Impact"),
  h2("By: Yiman Liu, Haiyi Luo, Ash Siwakoti, Thien Tran"),
  p("In the digital age, social media has stayed close onto our lives, raising questions about its impact on mental health and well-being. Our project trys to understand the complex relationship between social media usage patterns and their psychological effects. With increasing screen times and horrible habits, understanding these dynamics has never been more important"),
  p("Our goal is followed by three really important questions, each forming the cornerstone of our analysis. First, we want to understand how age correlates with social media usage and whether certain age groups are more susceptible to its allure. This question aims to shed light on generational differences in social media interaction and its implications."),
  p("Secondly, we get into the realm of self-perception versus reality by looking into how individuals' self-reported mental health assessments compare with their actual mental health scores. This comparison will hopefully let us understand people and the impact social media has on them."),
  p("Lastly, we explore the dynamics of validation-seeking behavior on social media. How does one's relationship status influence their pursuit of validation and approval through likes, comments, and shares? This question uncovers the social mechanics at play within these digital interactions."),
  p("We as a group aim to uncover the nuanced ways in which social media consumption shapes mental health. Join us as we dive deep into the data, trying to find answers that may inform better digital well-being practices and policies."),
  p("Our team analyzed data from one dataset from ", a("Mendeley data", href="https://data.mendeley.com/datasets/jxkcm7s638/1"), ". The data was collected through the Kisii University College Faculty of Health Sciences. Online surveys and in campus data collection methods were used. John Ngugi analyzed the behaviors of participants and based it off of a self-report score and an actual score on their mental health from a different survey that would rank their actual well being to see if there were any biases that would cause people to say different."),
  p("Another dataset is from ", a("Kaggle data", href="https://www.kaggle.com/datasets/souvikahmed071/social-media-and-mental-health"), ". This dataset was collected through a Statistics course at a university, collecting data on the local campus and processed the information through a machine learning algorithm that was later used to create a predictive model to see if someone needs professional help or not. The survey has a bunch of different ways of actually narrowing down the symptoms that generate data which really homes in on the overall trend of social media use."),
  p("Our dataset may show a certain composition variable distribution, where the proportion of data points from various demographic segments, such as gender and socioeconomic status, does not reflect the broader Instagram user base. This uneven distribution may lead to skewed interpretations of the impact on mental health, as it does not accurately represent the diverse experiences of all users."),
   imageOutput("myImage")                      
)

#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Page 1 - start
## VIZ 1 TAB INFO
# Define UI
# Visualization 1 Sidebar with Inputs

ui <- navbarPage("Social Medias Affect On Mental Health",
   overview_tab,
   viz_1_tab <- tabPanel("Usage & Emotion",
     sidebarLayout(
       sidebarPanel(
         h2("Age relevancy to Social Media Usage"),
         sliderInput("ageRange", "Age Range",
                     min = min(smmh$`1. What is your age?`, na.rm = TRUE), 
                     max = max(smmh$`1. What is your age?`, na.rm = TRUE), 
                     value = c(min(smmh$`1. What is your age?`, na.rm = TRUE), max(smmh$`1. What is your age?`, na.rm = TRUE)),
                     step = 1),
         selectInput("socialMediaTimeSpent", "Average Time Spent on Social Media",
                     choices = unique(smmh$`8. What is the average time you spend on social media every day?`))
       ),
       mainPanel(
         h2(),
         plotOutput("variableDistributionPlot", height = "400px"))
     )
   ),
)

#  
# Page 1 - end 
#--------------------------------------------------------------------------------------------------------------------------------------------------------



#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Page 2 - begin 

viz_2_tab <- tabPanel("Age-based Impact",
  viz_2_tab <- tabPanel("Age-based Impact",
    fluidPage(
      titlePanel("ScatterPlot: Distribution of Mental Health Impact Scores based on social media users"),
      sidebarLayout(
        sidebarPanel(
          h3("Filter by Gender"),
          selectInput("gender", "Gender", choices = c("All", "Male", "Female"), selected = "All"),
          h3("Select Score Types"),
          checkboxInput("selfReportedCheck", "Self-reported Mental Health Status (Red)", value = TRUE),
          checkboxInput("actualScoreCheck", "Actual Score (Blue)", value = TRUE)
        ),
        mainPanel(
          plotOutput("plot")
        )
      )
    )
  )
)




# Page 2 - end
#--------------------------------------------------------------------------------------------------------------------------------------------------------



#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Page 3 - begin  

## VIZ 3 TAB INFO
viz_3_sidebar <- sidebarPanel(
  h2("Social Media Validation Seeking and Daily Usage Time Based on Relationship Status"),
  checkboxGroupInput("relationship_status", "Relationship Status",
                     choices = c("In a relationship", "Single", "Married", "Divorced"),
                     selected = c("In a relationship", "Single", "Married", "Divorced")),
  selectInput("time_spent", "Average Time Spent on Social Media",
              choices = c("Less than an Hour", "Between 1 and 2 hours", "Between 2 and 3 hours", 
                          "Between 3 and 4 hours", "Between 4 and 5 hours", "More than 5 hours")),
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





#--------------------------------------------------------------------------------------------------------------------------------------------------------
# page 4 - start




conclusion_tab <- tabPanel("Our Findings",
                           h1("Our Findings"),
                           p("While delving into the  patterns of social media use and its psychological impacts, we uncovered alot of compelling data. 
                           Starting with the first page of our analysis, which focuses on the correlation between age and social media usage, we found a interesting trend:
                           a giant portion of individuals, engage with the platform for an average of 4-5 hours daily, with many exceeding 5 hours. 
                           This extensive use show us a prevailing trend towards heavy consumption. Upon taking a closer look on self-reported mental health assessments, a curious pattern popped up, 
                           especially among men. Many reported feeling worse about their mental state than what their actual mental health scores suggested. This hints at a complex 
                           psychological situation where the perception of distress is multiplied beyond the reality of their own mental well-being. Our investigation into social media validation-seeking
                           behaviors revealed another nuanced dynamic. Married individuals exhibited patterns of seeking validation in short, intense bursts, in contrast to single individuals, who displayed 
                           a consistent pursuit of validation. This insight paints a bigger picture of social media's grip on users, shwoing us how these platforms can plant and grow negative
                           psychological traits, such as validation seeking and self-critical judgment. Taking a closer look it becomes very obioues that social media consumption creates a  
                           relationship with its users thats very negative. Most of the time occupied by individuals dedicating more than 5 hours daily to these platforms, social media not only perpetuates a cycle of mental health 
                           decline but also ensnares users in a quest for loneliness. The data we've explored paints a sharp picture of a parasitic relationship, where the consumption of social media
                           becomes a horrible path."))

# page 4 - end
#--------------------------------------------------------------------------------------------------------------------------------------------------------


ui <- navbarPage("Social Medias Affect On Mental Health",
  theme = shinytheme("flatly"),  
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)
