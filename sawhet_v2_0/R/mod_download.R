#' download UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_download_ui <- function(id){
  ns <- NS(id)
  fixedRow(
    h1("Download"),
    div(id = ns("dl_warning")),
    checkboxInput(ns("dl_ready"), label = "Ready to Download?"),
    div(
      id = ns("dl_button"),
      downloadButton(ns("download"))
    )
  )
}
    
#' download Server Functions
#'
#' @noRd 
mod_download_server <- function(id, file_id, metadata, lab_report, figures_tables, val_lab_report){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
    observe({
      html(
        "dl_warning", 
        paste0(
          "<p>Are you sure you're ready to download? There are still some remaining errors:</p>",
          val_lab_report()$text
        )
      )
      
      toggle(
        id = "dl_warning",
        condition = !val_lab_report()$result & input$dl_ready
      )
    })
    
    observe({
      updateCheckboxInput(inputId = "dl_ready", value = val_lab_report()$result)
    })
    
    observe({
      toggle(
        id = "dl_button",
        condition = input$dl_ready
      )
    })
    
    text_output <-  reactive({
      combine_output(metadata(), lab_report())
    })
    
    output$download <- downloadHandler(
      filename = function() {
        zipfile_name(file_id())
      },
      content = function(con) {
        zip_content(con, file_id(), text_output(), figures_tables())
      }, 
      contentType = "application/zip"
    )
  })
}
    
## To be copied in the UI
# mod_download_ui("download_ui_1")
    
## To be copied in the server
# mod_download_server("download_ui_1")
