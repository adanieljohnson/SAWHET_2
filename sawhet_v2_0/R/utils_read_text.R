#' Read text file as HTML
#'
#' @description Read a local text file and format it as HTML
#'
#' @return Formatted HTML text.
#'
#' @noRd
read_text <- function(file_path) {
  file_path |> 
    readLines(encoding = "UTF-8", warn = FALSE) |> 
    HTML()
}
