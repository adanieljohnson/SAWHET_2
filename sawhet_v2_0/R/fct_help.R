#' Read help text
#'
#' @description A function to read and format HTML help text
#'
#' @return Formatted HTML help text.
#'
#' @noRd
read_help_text <- function(file_name) {
  paste0(file_name, ".txt") |> 
    {\(x) file.path("inst", "app", "help", x)}() |> 
    read_text()
}