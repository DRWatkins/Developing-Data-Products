#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

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
                    column(12,hr(strong("Center Locations")),
                           tableOutput("table"),align="center")
          )
     )
)
)

