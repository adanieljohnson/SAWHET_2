#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    fixedPage(
      title = "SAWHET", 
      read_text(file.path("inst", "app", "header.txt")), 
      
      # Metadata
      h4("Please fill in information"), 
      textInput("name_first", label = "First name"), 
      textInput("name_last", label = "Last name"), 
      textInput("email", label = "Email Address"), 
      mod_courses_tas_ui("course_ta"), 
      mod_header_choices_ui(
        "report_n", "Is this the first or the second lab report of the semester?", 
        c("First", "Second", "Third")
      ), 
      mod_header_choices_ui(
        "submission", "Is this a submission, a revision from a previous lab report, or a one-time submission?", 
        c("Submission", "Revision", "Single-submission only"), 
        mod_help = mod_help_ui("submission_label", "choose a submission option")
      ), 
      
      
      # Lab report
      mod_text_box_ui(
        "title", "Title", 
        mod_help_ui("title", "write a title"), mce_text = FALSE
      ), 
      mod_text_box_ui(
        "abstract", "Abstract (should be written last)", 
        mod_help_ui("abstract", "write an abstract"), mce_text = FALSE
      ), 
      mod_text_box_ui(
        "introduction", "Introduction", 
        mod_help_ui("introduction", "write an introduction")
      ), 
      mod_text_box_ui(
        "materials_methods", "Materials and Methods", 
        mod_help_ui("materials_methods", "write the methods section")
      ), 
      mod_text_box_ui(
        "results", "Results", 
        mod_help_ui("results", "write the results")
      ), 
      mod_text_box_ui(
        "figure_table_captions", "Figure and Table Captions", 
        mod_help_ui("figure_table_captions", "create captions for my figures and tables")
      ), 
      mod_figure_table_upload_ui(
        "figure_table_upload", 
        mod_help_ui("figure_table_upload", "upload a figure or table")
      ),
      mod_text_box_ui(
        "discussion", "Discussion", 
        mod_help_ui("discussion", "write a discussion")
      ), 
      mod_text_box_ui(
        "literature_cited", "Literature Cited", 
        tagList(
          mod_help_ui("literature_cited_print", "format print sources"), 
          mod_help_ui("literature_cited_electronic", "format electronic sources")
        )
      ),
      mod_download_ui("download"),
      read_text(file.path("inst", "app", "license.txt"))
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'sawhet'
    ),
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
    useShinyjs()
  )
}

