#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  filetype <- reactive({
    file_ext(input$file1$datapath)
  })
  
  df <- reactive({
    req(input$file1)
    if (filetype() %in% c("xlsx", "xls")) {
      openxlsx::read.xlsx(input$file1$datapath)
    } else if (filetype() %in% c("csv", "txt")) {
      readr::read_delim(input$file1$datapath,
                        delim = input$sep)
    } else {
      "Input file has wrong format! Please provide a CSV (csv and txt) or Excel (xlsx and xls) file."
    }
  })
  
  output$test <- renderTable({
    head(df())
  })
  
  # add SBT to uploaded data
  df.new <- reactive({
    if (sum(allelic.profile %in% colnames(df())) == length(allelic.profile)) {
      # head(df())
      out <- df() %>% left_join(profiles, by = allelic.profile, suffix = c("", ".added"))
      out
    }
  })
  
  # download handler for csv/txt
  output$downloadCsv <- downloadHandler(
    filename = function() {
      input$file1$name
    },
    content = function(file) {
      write_delim(df.new(), file, delim = input$sep)
    }
  )
  # download handler for xls/xlsx
  output$downloadExcel <- downloadHandler(
    filename = function() {
      input$file1$name
    },
    content = function(file) {
      openxlsx::write.xlsx(df.new(), file)
    }
  )
  # send the according download button to UI
  output$download1 <- renderUI({
    if(!is.null(df.new())) {
      if (filetype() %in% c("csv", "txt")) {
        downloadButton("downloadCsv", "Download")
      } else if (filetype() %in% c("xls", "xlsx")) {
        downloadButton("downloadExcel", "Download")
      }
    }
  })
  
  # output message according to input etc.
  output$msg <- renderText({
    req(filetype())
    if (filetype() %in% c("csv", "txt", "xlsx", "xls")) {
      if (sum(allelic.profile %in% colnames(df())) == length(allelic.profile)) {
        paste("Your data is ready for download:</br>")
      } else {
        paste("The following variables are <b>missing</b> in your uploaded data (case sensitive!):</br>",
              "<font color=\"#FF0000\"><b>",
              paste0(allelic.profile[!allelic.profile %in% colnames(df())], collapse = ", "),
              "</b></font>")
      }
    } else {
      paste("<font color=\"#FF0000\"><b>Sorry, we expected a *.csv, *.txt, *.xls or *.xlsx file.</b></font>")
    }
    
  })
 
 
  
})
