#' courses_tas UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_courses_tas_ui <- function(id){
  ns <- NS(id)
  
  tagList(
    h4("For which course are you submitting a lab report?"), 
    radioButtons(
      ns("course"), 
      label = NULL, 
      choices = "course", 
      selected = character(0)
    ), 
    div(
      id = ns("tas"), 
      h4("Who is your TA?"),
      radioButtons(
        ns("ta"), 
        label = NULL, 
        choices = "ta", 
        selected = character(0)
      )
    )
  )
  
}
    
#' courses_tas Server Functions
#'
#' @noRd 
mod_courses_tas_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    vec_courses <- df_courses |> 
      pull(course) |> 
      unique()
    
    observe({
      updateRadioButtons(
        inputId = "course", 
        choices = vec_courses, 
        selected = character(0)
      )
      
      hide(id = "tas")
    })
 
    observeEvent(
      input$course, 
      {
        vec_tas <- df_courses |> 
          filter(course == input$course) |> 
          pull(ta)
        
        toggle(
          id = "tas",
          condition = !identical(input$course, character(0))
        )
        
        updateRadioButtons(
          inputId = "ta", 
          choices = vec_tas, 
          selected = character(0)
        )
      }
    )
    
    reactive({
      list(
        course = null_to_chr(input$course), 
        ta = null_to_chr(input$ta)
      )
    })
  })
}
    
## To be copied in the UI
# mod_courses_tas_ui("courses_tas_ui_1")
    
## To be copied in the server
# mod_courses_tas_server("courses_tas_ui_1")
