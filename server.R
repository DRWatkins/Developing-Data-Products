#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.table)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
     
     dat<-reactive({
          dt<-data.table(Group = numeric(60*as.numeric(input$clusters_true)),
                         X_axis = numeric(60*as.numeric(input$clusters_true)),
                         Y_axis = numeric(60*as.numeric(input$clusters_true)))
          
          for (i in seq(1,as.numeric(input$clusters_true))) {
               dt[60*(i-1)+1:60, c("Group","X_axis","Y_axis"):=
                       list(i,rnorm(60,i+1,as.numeric(input$x_sd)),
                            rnorm(60,2*i,as.numeric(input$y_sd)))]
          } 
          dt 
     })
     
     clusters<-reactive({
          clust<-kmeans(dat()[,.SD,.SDcols=2:3],
                        centers=as.numeric(input$clusters_try),iter.max = 20)
          clust<-as.data.table(clust$centers)
          clust
     })
     
     output$plotme<-renderPlotly({
          plot_ly(data=dat(),x=~X_axis,y=~Y_axis,color=~factor(Group),
                  type="scatter",mode="markers",symbol=0) %>%
               add_markers(inherit = F, data=clusters(),x=~X_axis,y=~Y_axis,
                           symbol=I("3"),size=I(24), color=I("black"),
                           text="Center", hoverinfo="text", showlegend=F) %>%
               layout(xaxis=list(title=input$X_axis),yaxis=list(title=input$Y_axis),
                      title=input$title)
     })
     
     output$table<-renderTable(clusters())
     
})