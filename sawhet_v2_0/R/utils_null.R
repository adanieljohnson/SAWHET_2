#' null_to_chr 
#'
#' @description Converts NULL to an empty string
#' NULL values mess up sprintf during output and are the default option
#' when no choice is selected
#'
#' @return Either the value or - if the value is NULL - an empty string
#'
#' @noRd
null_to_chr <- function(x) {
  if(is.null(x)) {
    return("")
  }
  
  x
}