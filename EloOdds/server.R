#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# A read-only data set that will load once, when Shiny starts, and will be
# available to each user session
input_data <- "D:/Rstuff/BettingElo/data/allEloOdds.rds" #needs to be updated for the server to something like "/home/luks/Rprojects/BettingElo/data/allEloOdds.rds"
eloOdds <- readRDS(input_data)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$mytable = renderDataTable({
    eloOdds
  })
  
})
