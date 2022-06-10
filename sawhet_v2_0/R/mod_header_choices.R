#' header_choices UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_header_choices_ui <- function(id, title, choices, mod_help = NULL){
  ns <- NS(id)
  
  tagList(
    h4(title), 
    mod_help, 
    radioButtons(
      ns("choice"), 
      label = NULL, 
      choices = choices, 
      selected = character(0)
    )
  )
}

#' header_choices Server Functions
#'
#' @noRd 
mod_header_choices_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    reactive({
      null_to_chr(input$choice)
    })
  })
}

## To be copied in the UI
# mod_header_choices_ui("header_choices_ui_1")
    
## To be copied in the server
# mod_header_choices_server("header_choices_ui_1")
