#' help UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_help_ui <- function(id, help_label){
  ns <- NS(id)
  
  fixedRow(
    checkboxInput(
      inputId = ns("show_help"), label = paste("Show me how to", help_label)
    ), 
    id |> 
      read_help_text() |> 
      div(id = ns("help"))
  )
}
    
#' help Server Functions
#'
#' @noRd 
mod_help_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
    # Separate observe event that ignores the initialization so logging isn't
    # full of "Hiding...".
    # Can't add it to the other observe event because then the checkboxes
    # won't start as hidden
    observeEvent(
      input$show_help, 
      {
        ifelse(
          input$show_help, 
          "Showing", 
          "Hiding"
        ) |> 
          paste("help for:", id) |> 
          print()
      }, 
      ignoreInit = TRUE
    )
    
    observeEvent(
      input$show_help, 
      {
        toggle(
          id = "help",
          condition = input$show_help
        )
      }
    )
  })
}
    
## To be copied in the UI
# mod_help_ui("help_ui_1")
    
## To be copied in the server
# mod_help_server("help_ui_1")
