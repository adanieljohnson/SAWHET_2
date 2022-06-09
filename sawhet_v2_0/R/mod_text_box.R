#' text_box UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_text_box_ui <- function(id, title, mod_help, mce_text = TRUE){
  ns <- NS(id)
  
  fixedRow(
    h2(title), 
    mod_help, 
    get_text_box(ns("text"), mce_text),
    actionButton("validate", "Validate Text"),
    div(id = ns("validation"))
  )
}
    
#' text_box Server Functions
#'
#' @noRd 
mod_text_box_server <- function(id, fct_validation){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    text_ascii <- reactive({
      input$text |> 
        html_to_ascii()
    })
    
    text_clean <- reactive({
      text_ascii() |> 
        clean_text()
    })
    
    text_validated <- reactive({
      text_clean() |> 
        fct_validation()
    })
    
    observeEvent(
      input$text, 
      {
        html("validation", html = text_validated()$text)
      }
    )
    
    text_output <- reactive({
      switch(
        getOption("output"),
        text = text_ascii(),
        html = input$text
      )
    })
    
    reactive({
      list(
        validated_text = text_validated(), 
        text = text_output()
      )
    })
  })
}
    
## To be copied in the UI
# mod_text_box_ui("text_box_ui_1")
    
## To be copied in the server
# mod_text_box_server("text_box_ui_1")
