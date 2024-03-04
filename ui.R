library(shiny)
library(plotly)
library(dplyr)

## OVERVIEW TAB INFO

#overview_tab <- tabPanel("Instagram's Impact on Mental Health",
  #h1("Introduction"),
 # p("Social medias have continued affecting people’s mental health in the modern society. We aim to unravel the complex relationship between social media usage and its effects on users' psychological well-being. In an era where social media platforms dominate our daily interactions and self-perception, with their emphasis on visually curated lives, social media like twitter or instagram stands out for their potential to influence mental health. This journey seeks to explore and visualize the nuanced ways in which continuous exposure to idealized images, the pursuit of likes, and the pressure to maintain a perfect online persona contribute to increased feelings of anxiety, depression, and loneliness among its users."),
  #p("Our investigation centers on three pivotal questions: How does the amount of time spent on Instagram correlate with the user's mental health outcomes? How often does user feel down correlated with the time they spend on Instagram? Lastly, how often do people look to seek validation from features of Instagram??"),
  #p("Our team analyzed data from one dataset from ", a("Mendeley data", href="https://data.mendeley.com/datasets/jxkcm7s638/1"), ". The data was collected through the Kisii University College Faculty of Health Sciences. Online surveys and in campus data collection methods were used. John Ngugi analyzed the behaviors of participants and based it off of a self-report score and an actual score on their mental health from a different survey that would rank their actual well being to see if there were any biases that would cause people to say different."),
  #p("Another dataset is from ", a("Kaggle data", href="https://www.kaggle.com/datasets/souvikahmed071/social-media-and-mental-health"), ". This dataset was collected through a Statistics course at a university, collecting data on the local campus and processed the information through a machine learning algorithm that was later used to create a predictive model to see if someone needs professional help or not. The survey has a bunch of different ways of actually narrowing down the symptoms that generate data which really homes in on the overall trend of social media use."),
  #p("Our dataset may show a certain composition variable distribution, where the proportion of data points from various demographic segments, such as gender and socioeconomic status, does not reflect the broader user base. This uneven distribution may lead to skewed interpretations of the impact on mental health, as it does not accurately represent the diverse experiences of all users."),
  #img(src = "https://github.com/info-201-wi24/final-project-thientran01/blob/main/Introduction%20image.jpg", height = "200px", width = "auto"),                       
  #)

overview_tab <- tabPanel("Social Medias Impact On Mental Health",
   h1("Introduction"),
   p("In our project, we delve into the complex dynamics between Instagram usage and mental health. Leveraging comprehensive datasets from Mendeley and Kaggle, our analysis aims to decipher the nuanced relationship between social media engagement and its psychological effects. Through meticulous data manipulation and visualization, we explore the ways in which time spent on Instagram, the pursuit of online validation, and the exposure to idealized images contribute to feelings of anxiety, depression, and loneliness."),
   p("Our research is guided by targeted questions: What is the correlation between time spent on Instagram and mental health outcomes? How does seeking validation on Instagram affect users' mental well-being? And, how do these interactions vary across different demographics? Our analysis, rooted in data from diverse sources, seeks to provide a data-driven understanding of these questions."),
   p("The datasets include a detailed survey from Kisii University College, analyzing participants' self-reported mental health against their actual well-being, and a machine learning-derived dataset from a university Statistics course, aimed at identifying the need for professional mental health services. Our data manipulation involves cleaning, merging, and categorizing data to reveal insightful patterns."),
   p("However, our datasets reveal a challenge: a skewed composition that might not fully represent the diverse experiences of Instagram users. This limitation notwithstanding, our visualizations strive to illuminate the intricate ways in which Instagram usage impacts mental health."),
   img(src = "https://github.com/info-201-wi24/final-project-thientran01/blob/main/Introduction%20image.jpg", height = "200px", width = "auto")
)


## VIZ 1 TAB INFO

#Our investigation centers on three pivotal questions: 
#How does the amount of time spent on Instagram correlate with the user's mental health outcomes?
#How often does user feel down correlated with the time they spend on Instagram? 
#Lastly, how often do people look to seek validation from features of Instagram??



# Define UI
# Visualization 1 Sidebar with Inputs
viz_1_sidebar <- sidebarPanel(
  h2("Options for Visualization 1"),
  
  # Slider for distraction levels (assuming a 1-5 scale based on your dataset)
  sliderInput("distractionLevel",
              "Distraction Level:",
              min = 1, max = 5, value = c(1,5)),
  
  # Select input for sleep issues (using your provided scale and options)
  selectInput("sleepIssue",
              "Sleep Issue Level:",
              choices = c("All" = 0, "Never" = 1, "Rarely" = 2, "Sometimes" = 3, "Often" = 4, "Always" = 5),
              selected = 0)
)

# Visualization 1 Main Panel with Plot Output
viz_1_main_panel <- mainPanel(
  h2("Visualization 1: Impact of Social Media Usage"),
  plotlyOutput(outputId = "impactPlot1")  # Assuming use of Plotly for interactive plots
)

# Integrating Sidebar and Main Panel into Visualization 1 Tab
viz_1_tab <- tabPanel("Instagram Usage & Mental Health Impact",
                      sidebarLayout(
                        viz_1_sidebar,
                        viz_1_main_panel
                      )
)

# Assuming 'overview_tab', 'viz_2_tab', 'viz_3_tab', and 'conclusion_tab' are defined elsewhere
ui <- navbarPage("Social Media's Impact On Mental Health",
                 viz_1_tab,
                 # Include other tabs here
)




## VIZ 2 TAB INFO

viz_2_sidebar <- sidebarPanel(
  h2("Options for Visualization 2"),
  selectInput("usageWithoutPurpose", "Usage Without Specific Purpose:",
              choices = c("All", "Never", "Rarely", "Sometimes", "Often", "Always")),
  selectInput("distractionLevel", "Distraction Level When Busy:",
              choices = c("All", "Not at all", "Slightly", "Moderately", "Very", "Extremely")),
  selectInput("validationSeeking", "Seeking Validation from Social Media:",
              choices = c("All", "Never", "Rarely", "Occasionally", "Frequently", "Very often"))
)



viz_2_main_panel <- mainPanel(
  h2("Vizualization 2 Title"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_2_tab <- tabPanel("Viz 2 tab title",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)

## VIZ 3 TAB INFO

viz_3_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
)

viz_3_main_panel <- mainPanel(
  h2("Vizualization 3 Title"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_3_tab <- tabPanel("Viz 3 tab title",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  )
)

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Conclusion Tab Title",
 h1("Some title"),
 p("some conclusions")
)



ui <- navbarPage("Social Medias Affect On Mental Health",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)
