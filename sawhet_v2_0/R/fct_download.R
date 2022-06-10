#' Combine metadata
#'
#' @description Combine metadata inputs into text for download
#'
#' @return A string of metadata text for download
#'
#' @noRd
combine_metadata <- function(first_name, last_name, email, course_ta, report_n, submission, datetime, file_id) {
  template <- switch(
    getOption("output"),
    text = "inst/app/download/metadata.txt",
    html = "inst/app/download/metadata.html"
  )
  
  combine_text(
    template, 
    report_n, submission, datetime, first_name, last_name, email, file_id, 
    course_ta$course, course_ta$ta
  )
}

#' Combine lab report
#'
#' @description Combine lab report inputs into text for download
#'
#' @return A string of lab report text for download
#'
#' @noRd
combine_lab_report <- function(title, abstract, introduction, materials_methods, results, discussion, literature_cited, figures_tables, figures_tables_legends) {
  template <- switch(
    getOption("output"),
    text = "inst/app/download/lab_report.txt",
    html = "inst/app/download/lab_report.html"
  )
  
  txt_figures_tables <- figures_tables$name |> 
    get_figures_tables_text()
  
  combine_text(
    template, 
    title, abstract, introduction, materials_methods, results, discussion, 
    literature_cited, txt_figures_tables, figures_tables_legends
  )
}

#' Get figures and tables text
#'
#' @description Combine figure and table inputs into text for download
#'
#' @return A string of figure and table text for download
#'
#' @noRd
get_figures_tables_text <- function(figures_tables_names) {
  output_option <- getOption("output")
  
  if(output_option == "text") {
    figures_tables_text <- figures_tables_names |> 
      {\(x) sprintf("Figure %i: %s", seq_along(x), x)}() |> 
      paste(collapse = "\n\n")
    
    return(figures_tables_text)
  }
  
  if(output_option == "html") {
    # be careful with '%' symbols in the html text: sprintf has special 
    # requirements for interpreting characters
    figures_tables_text <- combine_text(
      "inst/app/download/figure.html",
      figures_tables_names, 
      sprintf("Figure %i", seq_along(figures_tables_names))
    ) |> 
      paste(collapse = "")
    
    return(figures_tables_text)
  }
}

#' Combine text
#'
#' @description Combine text inputs into text template for download
#'
#' @param template_file A file path to a format string template for sprintf
#' @param ... values to be passed into sprintf string template
#'
#' @return A string of combined text
#'
#' @noRd
combine_text <- function(template_file, ...) {
  template_file |> 
    readLines(encoding = "UTF-8", warn = FALSE) |> 
    paste(collapse = "\n") |> 
    sprintf(...) |> 
    strsplit("\n") |> 
    unlist()
}

#' Combine output
#'
#' @description Combine text metadata and lab report for file output
#'
#' @param metadata A string of metadata for output
#' @param lab_report A string of the lab report for output
#'
#' @return A string of combined text with separators for output
#'
#' @noRd
combine_output <- function(metadata, lab_report) {
  output_option <- getOption("output")
  
  if(output_option == "text") {
    separator <- "inst/app/download/separator.txt" |> 
      readLines(encoding = "UTF-8", warn = FALSE)
    
    combined_output <- c(
      separator, 
      metadata, 
      separator, 
      lab_report, 
      separator
    )
    
    return(combined_output)
  }
  
  if(output_option == "html") {
    combined_output <- c(
      # could add header information to head
      "<!DOCTYPE html><html><body>", 
      metadata, lab_report,
      "</body></html>"
    )
    
    return(combined_output)
  }
}

#' Create zip file name
#'
#' @description Create zipfile name from the file ID
#'
#' @param file_id File identifier
#'
#' @return A zip file name
#'
#' @noRd
zipfile_name <- function(file_id) {
  file_id |> 
    paste0('.zip')
}

#' Combine output
#'
#' @description Combine text metadata and lab report for file output
#'
#' @param metadata A string of metadata for output
#' @param lab_report A string of the lab report for output
#'
#' @return A string of combined text with separators for output
#'
#' @noRd
zip_content <- function(con, file_id, text_output, figures_tables) {
  paste("Downloading:", file_id) |> 
    print()
  
  output_ext <- switch(
    getOption("output"),
    text = ".txt",
    html = ".html"
  )
  
  path_temp_text_output <- tempdir() |> 
    file.path(paste0(file_id, output_ext))
  
  text_output |> 
    writeLines(path_temp_text_output)
  
  if(!is.null(figures_tables)) {
    vec_figures_tables <- figures_tables |> 
      pull(datapath)
  } else {
    vec_figures_tables <- NULL
  }
  
  temp_files <- c(path_temp_text_output, vec_figures_tables)
  
  # create one file to download
  zip(
    zipfile = con, files = temp_files, root = tempdir(), 
    mode = "cherry-pick"
  )
  
  # create a second file to upload to dropbox
  # uncomment this section to enable uploads to dropbox
  # zipfile_drop <- zipfile_name(file_id)
  # 
  # zip(
  #   zipfile = zipfile_drop, files = temp_files, root = tempdir(), 
  #   mode = "cherry-pick"
  # )
  # 
  # token <- file.path("secrets", "token.rds") |> 
  #   readRDS()
  # 
  # drop_upload(
  #   file.path(tempdir(), zipfile_drop), path = "SAWHET", dtoken = token
  # )
}
