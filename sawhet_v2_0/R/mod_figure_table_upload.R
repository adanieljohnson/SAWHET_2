#' figure_table_upload UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_figure_table_upload_ui <- function(id, mod_help){
  ns <- NS(id)
  
  fixedRow(
    h2("Figure or Table Upload"), 
    mod_help, 
    fileInput(
      ns("figure_table"), label = NULL, multiple = TRUE, 
      accept = c("image/png", "image/jpg", "image/tif")
    ), 
    div(id = ns("uploaded"))
  )
}
    
#' figure_table_upload Server Functions
#'
#' @noRd 
mod_figure_table_upload_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
    df_figures_tables <- reactive({
      if(!is.null(input$figure_table)) {
        tmp_figures_tables <- input$figure_table |> 
          mutate(
            datapath_old = datapath,
            datapath = file.path(dirname(datapath), name)
          )
        
        # rename files once before downloading to prevent trying to rename multiple
        # times during multiple uploads
        tmp_figures_tables |> 
          with(
            file.rename(datapath_old, datapath)
          )
        
        tmp_figures_tables |> 
          select(-datapath_old)
      }
    })
    
    observeEvent(
      df_figures_tables(), 
      {
        df_figures_tables() |> 
          pull(name) |> 
          paste(collapse = ", ") |> 
          {\(x) paste("You've uploaded:", x)}() |> 
          {\(x) html("uploaded", x)}()
      }
    )
    
    df_figures_tables
  })
}
    
## To be copied in the UI
# mod_figure_table_upload_ui("figure_table_upload_ui_1")
    
## To be copied in the server
# mod_figure_table_upload_server("figure_table_upload_ui_1")
