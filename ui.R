library(shinydashboard)
library(shiny)
library(DT)
vgames <- read.csv(file = "~/Shiny_Project/Shiny_Project_PLZ/vgames.csv")
###
dashboardPage(skin = "black",
  
  dashboardHeader(title = "Video Game Analysis"),
  
  dashboardSidebar(
      hr(),
      h4(" Choose a Year"),
      selectInput(inputId = "Year", label = "Year", 
                  choices = sort(unique(vgames$Year_of_Release, desc = T))),
    sidebarMenu(menuItem("Overview", tabName = "Overview")),
    sidebarMenu(menuItem("Regional", tabName = "Regional")),
    sidebarMenu(menuItem("Trends", tabName = "Trends"))
    ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "Overview",
      fluidRow(
      tabBox(width = 300,
        tabPanel(title = "Best Sellers",
          tableOutput("The_Overview")
        ),
        tabPanel(title = "Highest Critic Score",
          tableOutput("rating")
        )
      )
    )
  ),
      
      tabItem(tabName = "Regional",
      fluidRow(
      tabBox(width = 300,
        tabPanel(title = "Regional Sales",
          plotOutput("Region")
        )
        )
      )
    ),
      
      tabItem(tabName = "Trends",
      fluidRow(
      tabBox(width = 300,
        tabPanel(title = "Console Wars",
          plotOutput("consolewar")
        ),
        tabPanel(title = "Genre Changes",
          plotOutput("genretime")
        ),
        tabPanel(title = "Publisher Shifts",
          plotOutput("toppubs")
        )
        )
      )
      )
      )
    )
  )



        


      
      
    













      






