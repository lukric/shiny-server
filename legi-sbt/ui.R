#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Legionella SBT"),
  
  HTML(paste0("Upload your data of allelic profiles of Legionella pneumophila including the variables <i>", paste0(allelic.profile, collapse = ", "), 
              "</i> and download it including 
              the appropriate Sequence Type. Your data is expected to be in Excel format (xls/xlsx) or CSV format (csv/txt).
              The database was received from Public Health England, also visit 
              <a href='http://www.hpa-bioinformatics.org.uk/legionella/legionella_sbt/php/sbt_allelic_profile_st_lookup.php' target='blank'>
              Legionella pneumophila Sequence-Based Typing</a>.")),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      # Input: Select a file ----
      fileInput("file1", "Choose Excel/CSV File",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv",
                           ".xlsx",
                           ".xls")),
      
      # # Horizontal line ----
      # tags$hr(),
      # 
      # # Input: Checkbox if file has header ----
      # checkboxInput("header", "Header", TRUE),
      # 
      # Input: Select separator ----
      radioButtons("sep", "Separator (only used for csv/txt)",
                   choices = c(Comma = ",",
                               Semicolon = ";",
                               Tab = "\t"),
                   selected = ","),

      # # Input: Select quotes ----
      # radioButtons("quote", "Quote",
      #              choices = c(None = "",
      #                          "Double Quote" = '"',
      #                          "Single Quote" = "'"),
      #              selected = '"'),
      # 
      # # Horizontal line ----
      # tags$hr(),
      # 
      # # Input: Select number of rows to display ----
      # radioButtons("disp", "Display",
      #              choices = c(Head = "head",
      #                          All = "all"),
      #              selected = "head"),
      
      NULL
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      htmlOutput("msg"),
      uiOutput("download1"),
      # downloadButton("downloadCsv", "Download CSV"),
      NULL
    )
  )
))
