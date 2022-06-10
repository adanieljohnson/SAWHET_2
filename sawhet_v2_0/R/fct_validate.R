#' validated_text
#'
#' @description A validation class.
#'
#' @return A class with validation results (i.e., pass / fail) and formatted text
#'
#' @noRd
validated_text <- function(result, text) {
  if(!is.logical(result)) stop("Result must be logical.")
  if(!is.character(text)) stop("Text must be character.")
  
  structure(
    list(result = result, text = text),
    class = "validated_text"
  )
}

#' combine_validated_text
#'
#' @description Combine validated text objects
#'
#' @return A single validated text
#'
#' @noRd
combine_validated_text <- function(x) {
  result <- sapply(x, \(y) y$result) |> 
    all()
  
  text <- sapply(x, \(y) y$text) |> 
    paste(collapse = "")
  
  validated_text(result = result, text = text)
}

#' combine_validated_text
#'
#' @description Combine validated text objects
#'
#' @return A single validated text
#'
#' @noRd
combine_unvalidated_text <- function(x) {
  Filter(\(y) !y$result, x) |> 
    combine_validated_text()
}

#' Check words
#'
#' @description Check the number of words against a min and max.
#'
#' @return A function to check the number of words.
#'
#' @noRd
check_words <- function(min_words = 0, max_words = Inf) {
  function(text) {
    stri_count(text, regex = "\\S+") |> 
      check_length(min_words, max_words, "word")
  }
}

#' Check characters
#'
#' @description Check the number of characters against a min and max.
#'
#' @return A function to check the number of characters
#'
#' @noRd
check_characters <- function(min_chars = 0, max_chars = Inf) {
  function(text) {
    stri_count(text, regex = "\\S") |> 
      check_length(min_chars, max_chars, "character")
  }
}

#' Check citations
#'
#' @description Check the number of citations against a min and max.
#'
#' @return A function to check the number of citations
#'
#' @noRd
check_citations <- function(min_citations = 0, max_citations = Inf) {
  function(text) {
    stri_count(text, regex = "\\(.+, \\d{4}\\)") |> 
      check_length(min_citations, max_citations, "citation")
  }
}

#' Perform multiple validation checks
#'
#' @description Perform multiple validation checks
#'
#' @return A function to perform multiple validation checks
#'
#' @noRd
check_multiple <- function(...) {
  function(val_text) {
    lapply(list(...), do.call, list(val_text)) |> 
      combine_validated_text()
  }
}

#' Check length
#'
#' @description Check a number against a min and max.
#'
#' @return A string of the check results, either too short, too long, or just right.
#'
#' @noRd
check_length <- function(text_length, min_length, max_length, check_text) {
  check_text_plural <- paste0(check_text, "s")
  
  check_text_actual <- ifelse(
    text_length == 1, check_text, check_text_plural
  )
  
  check_text_min <- ifelse(
    min_length == 1, check_text, check_text_plural
  )
  
  check_text_max <- ifelse(
    max_length == 1, check_text, check_text_plural
  )
  
  if(text_length < min_length) {
    sprintf(
      "Text is too short. At least %d %s expected, %d %s found.", 
      min_length, check_text_min, text_length, check_text_actual
    ) |> 
      format_valid_fail()
  } else if(text_length > max_length) {
    sprintf(
      "Text is too long. At most %d %s expected, %d %s found.", 
      max_length, check_text_max, text_length, check_text_actual
    ) |> 
      format_valid_fail()
  } else {
    sprintf("Text meets required validation checks for %s.", check_text_plural) |> 
      format_valid_pass()
  }
}

#' Format validation failure
#'
#' @description Format a validation failure message.
#'
#' @return A string of an HTML paragraph
#'
#' @noRd
format_valid_fail <- function(text) {
  text <- sprintf(
    "<p style = 'color:red'>%s</p>", text
  )
  
  validated_text(result = FALSE, text = text)
}

#' Format validation success
#'
#' @description Format a validation success message.
#'
#' @return A string of an HTML paragraph
#'
#' @noRd
format_valid_pass <- function(text) {
  text <- sprintf(
    "<p style = 'color:green'>%s</p>", text
  )
  
  validated_text(result = TRUE, text = text)
}
