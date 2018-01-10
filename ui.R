library(shiny)
library(data.table)
library(plotly)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
     titlePanel("Experimenting with Clusters"),
     sidebarLayout(
          sidebarPanel(
               selectInput("clusters_true", label = "Number of clusters:",
                           choices = 1:6, selected = 3),
               
               selectInput("clusters_try", label = "Clusters to look for:",
                           choices = 1:6, selected = 3),
               sliderInput("x_sd", label = "X Standard Deviation",
                           min = 0,max=1,step=.05,value = .5),
               sliderInput("y_sd", label = "Y Standard Deviation",
                           min = 0,max=2,step=.05,value = 1),
               textInput("title", label = "Plot Title", value = "Blobs of Dots"),
               textInput("X_axis", label = "X-axis label:",value = "Horizontal Blobs"),
               textInput("Y_axis", label = "Y-axis label:",value = "Vertical Blobs"),
               submitButton(text = "Done")
          ),
          mainPanel(plotlyOutput("plotme"),
                    column(hr(strong("Center Locations")),width = 2,
                           tableOutput("table"),align="center"),
                    column(hr(strong("Instructions")), width= 5,
                           hr("Use the dropdowns to select number of clusters generated and sought."),
                           hr("Use the sliders to adjust the dispersion of the clusters."),
                           hr("Use the text box inputs to change the title and axes labels.")),
                    column(hr(strong("Interpretation")), width=5,
                           hr("For each cluster generated, 60 datapoints will be created."),
                           hr("The higher the specified standard deviation, the more disperse the clusters will be."),
                           hr("The plusses indicate centers identified by the kmeans algorithm.")),
                    column(hr(strong("Server and UI code available on github:")), width=12,
                           a("Developing Data Products Github Repo",
                             href="https://github.com/DRWatkins/Developing-Data-Products/tree/master"))
          )
     )
)
)

