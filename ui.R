library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(plotly)
library(shinythemes)
library(rsconnect)

#link to shiny app: https://finalproject23.shinyapps.io/final-project-thientran01/

## OVERVIEW TAB INFO
overview_tab <- tabPanel("Introduction",
    h1("Introduction"),
    p("In today's digital age, the impact of social media on mental health is a topic of growing concern. Our project delves into the intricate relationship between social media usage patterns and their effects on psychological well-being."),
    p("Social media platforms play a significant role in shaping individuals' perceptions of themselves and their surroundings. The constant exposure to curated images and the pursuit of likes can contribute to negative emotions."),
    p("Our analysis revolves around three key questions: How does the frequency of Social Media usage correlate with age? Is there a correlation between negative mental health and age when using social media? And what is the relationship between the frequency of seeking validation on social media and the duration of usage?"),
    p("To conduct our research, we utilized datasets from reputable sources. One dataset was obtained from ", a("Mendeley data", href="https://data.mendeley.com/datasets/jxkcm7s638/1"), ", collected by the Kisii University College Faculty of Health Sciences through online surveys and campus data collection methods. Additionally, we utilized a dataset from ",
    a("Kaggle data", href="https://www.kaggle.com/datasets/souvikahmed071/social-media-and-mental-health"), ", which originated from a university statistics course. This dataset was processed using machine learning algorithms to predict the need for professional help based on social media usage patterns."),
    p("It's important to note potential biases in our dataset, such as uneven distribution across demographic segments like gender and socioeconomic status. This non-representative sample may skew interpretations of the relationship between social media usage and mental health."),
    imageOutput("myImage"))



#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Page 1 - start
# The UI definition 
ui <- navbarPage("Social Medias Affect On Mental Health",
  overview_tab, # Defined somewhere else group!
  
  # The relationship between age, social media usage, and emotion.
  viz_1_tab <- tabPanel("Usage & Emotion",
   sidebarLayout(
     sidebarPanel(
       # Focus on age and social media usage.
       h2("Age relevancy to Social Media Usage"),
       # Slider input for selecting an age range. Its DYNAMIC!!
       sliderInput("ageRange", "Age Range",
                   min = min(smmh$`1. What is your age?`, na.rm = TRUE), 
                   max = max(smmh$`1. What is your age?`, na.rm = TRUE), 
                   value = c(min(smmh$`1. What is your age?`, na.rm = TRUE), max(smmh$`1. What is your age?`, na.rm = TRUE)),
                   step = 1),
       # Dropdown to select the average time spent on social media.
       selectInput("socialMediaTimeSpent", "Average Time Spent on Social Media",
                   choices = unique(smmh$`8. What is the average time you spend on social media every day?`))
     ),
     mainPanel(
       h2(), # What is this? Ask someone!
       # Output area for a plot.
       plotOutput("variableDistributionPlot", height = "400px"))
    )
  ),
)


# Page 1 - end 
#--------------------------------------------------------------------------------------------------------------------------------------------------------

#Notes

#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Page 2 - begin 

# This one you guys, focuses on the impact of age on mental health in the context of social media use.
viz_2_tab <- tabPanel("Age-based Impact",
    viz_2_tab <- tabPanel("Age-based Impact",
    fluidPage(
      # a scatter plot.
      titlePanel("ScatterPlot: Distribution of Mental Health Impact Scores based on social media users"),
      sidebarLayout(
        sidebarPanel(
          # Provides an option to filter the displayed data by gender.
          h3("Filter by Gender"),
          selectInput("gender", "Gender", choices = c("All", "Male", "Female"), selected = "All"),
          # Allows us to select which types of scores to display on the plot.
          h3("Select Score Types"),
          checkboxInput("selfReportedCheck", "Self-reported Mental Health Status (Red)", value = TRUE),
          checkboxInput("actualScoreCheck", "Actual Score (Blue)", value = TRUE)
        ),
        mainPanel(
          # Placeholder for the actual scatter plot visualization.
          plotOutput("plot")
        )
      )
    )
  )
)
# End of the second tab's definition, but watch out for that duplicate definition issue.


# Page 2 - end
#--------------------------------------------------------------------------------------------------------------------------------------------------------

#Notes: 

#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Page 3 - begin  

# social media usage in the context of relationship status.
viz_3_sidebar <- sidebarPanel(
  # focus on relationship status and social media usage.
  h2("Social Media Validation Seeking and Daily Usage Time Based on Relationship Status"),
  # selecting one or more relationship statuses to filter the data.
  checkboxGroupInput("relationship_status", "Relationship Status",
                     choices = c("In a relationship", "Single", "Married", "Divorced"),
                     selected = c("In a relationship", "Single", "Married", "Divorced")),
  # selecting average time spent on social media
  selectInput("time_spent", "Average Time Spent on Social Media",
              choices = c("Less than an Hour", "Between 1 and 2 hours", "Between 2 and 3 hours", 
                          "Between 3 and 4 hours", "Between 4 and 5 hours", "More than 5 hours")),
)
viz_3_main_panel <- mainPanel(
  #  visualization will be shown from here.
  h2("Vizualization 3: relation plot"),
  plotOutput("relationshipPlot")
  )

#then we have a cookie
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
conclusion_tab <- tabPanel("Our Findings",
   h1("What We've Found"),
   p("Diving into the world of likes, shares, and endless scrolling, there lays a story in the numbers. One of the first things that we noticed was actually that a whole lot of people are glued to their screens for 4-5 hours a day, and that's just the average; from the way the data looks, if there was a option for 8 hours, people would most likely relate towards that even more."),
   p("When we really looked at the self-rated mental health scene it showed us something very interesting. It looks like there's a gap between how bad people think they're doing and their actual mental health scores, especially for males more so than females. It's like there's this mental filter that's making the bad seem worse, people are saying they feel worse than what their mental health score is."),
   p("Then there's the hunt for virtual thumbs-ups. Married individuals seem to dive into this world in short, intense bursts, while the singles seem to be married to the likes.  It's crazy to think about it like that, the data actually is  showing us just how tangled people can get in the world of social media, chasing after that next hit of digital validation"),
   p("We got the asnwers we were looking for but theres still the big picture. The data seems to show us that spending more hours on social media has real downsides, affecting our heads more than some of us think. It's kind of like a digital parasite, where the more you use, the more you want to use which might put you in a not-so-great place, mentally speaking."),
   p("With all the numbers that got curnched in this project, our takeaway is this: social media's a double-edged sword, and it's sharp on both sides. It's a space that connects us but also a place that, if we're not careful, can disconnect us from ourselves.")
)


# page 4 - end
#--------------------------------------------------------------------------------------------------------------------------------------------------------

#declared!!!!!!!!

ui <- navbarPage("Social Medias Affect On Mental Health",
    theme = shinytheme("flatly"),  
    overview_tab,
    viz_1_tab,
    viz_2_tab,
    viz_3_tab,
    conclusion_tab
)
