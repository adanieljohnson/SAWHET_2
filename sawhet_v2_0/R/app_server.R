#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Metadata
  header_course_ta <- mod_courses_tas_server("course_ta")
  
  header_report_n <- mod_header_choices_server("report_n")
  
  mod_help_server("submission_label")
  header_submission <- mod_header_choices_server("submission")
  
  
  # Lab report
  mod_help_server("title")
  val_text_title <- mod_text_box_server("title", check_characters(5, 150))
  
  mod_help_server("abstract")
  val_text_abstract <- mod_text_box_server("abstract", check_words(100, 300))
  
  mod_help_server("introduction")
  val_text_introduction <- mod_text_box_server(
    "introduction", check_multiple(check_words(100), check_citations(1))
  )
  
  mod_help_server("materials_methods")
  val_text_materials_methods <- mod_text_box_server(
    "materials_methods", check_words(100)
  )
  
  mod_help_server("results")
  val_text_results <- mod_text_box_server("results", check_words(100))
  
  mod_help_server("figure_table_captions")
  val_text_figure_table_captions <- mod_text_box_server(
    "figure_table_captions", check_words()
  )
  
  mod_help_server("figure_table_upload")
  figures_tables <- mod_figure_table_upload_server("figure_table_upload")
  
  mod_help_server("discussion")
  val_text_discussion <- mod_text_box_server("discussion", check_words(100))
  
  mod_help_server("literature_cited_print")
  mod_help_server("literature_cited_electronic")
  val_text_literature_cited <- mod_text_box_server(
    "literature_cited", check_words()
  )
  
  # Download
  current_datetime <- reactive({
    # immediately invalidate the datetime so the next download has a new ID
    invalidateLater(0)
    
    Sys.time()
  })
  
  str_datetime <- reactive({
    current_datetime() |> 
      format()
  })
  
  file_id <- reactive({
    current_datetime() |> 
      as.integer() |> 
      as.character()
  })
  
  dl_metadata <- reactive({
    combine_metadata(
      input$name_first, input$name_last, input$email, header_course_ta(), 
      header_report_n(), header_submission(), str_datetime(), file_id()
    )
  })
  
  val_lab_report <- reactive({
    combine_unvalidated_text(
      list(
        val_text_title()$validated_text, val_text_abstract()$validated_text, 
        val_text_introduction()$validated_text, 
        val_text_materials_methods()$validated_text, 
        val_text_results()$validated_text, val_text_discussion()$validated_text, 
        val_text_literature_cited()$validated_text, 
        val_text_figure_table_captions()$validated_text
      )
    )
  })
  
  dl_lab_report <- reactive({
    combine_lab_report(
      val_text_title()$text, val_text_abstract()$text, 
      val_text_introduction()$text, val_text_materials_methods()$text, 
      val_text_results()$text, val_text_discussion()$text, 
      val_text_literature_cited()$text, figures_tables(), 
      val_text_figure_table_captions()$text
    )
  })
  
  mod_download_server(
    "download", file_id, dl_metadata, dl_lab_report, figures_tables, val_lab_report
  )
}
