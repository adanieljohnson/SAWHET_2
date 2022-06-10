#' Get text box
#'
#' @description Get the appropriate text box, either plain or MCE
#'
#' @return A text box for the UI.
#'
#' @noRd
get_text_box <- function(id, mce_text) {
  if(mce_text) {
    tinyMCE(
      inputId = id, 
      content = "", 
      options = 'plugins: ["lists charmap"],
      toolbar: "bold italic | bullist numlist"'
    )
  } else (
    textAreaInput(inputId = id, label = NULL)
  )
}

#' HTML to ASCII
#'
#' @description Remove HTML tags from text and convert to ASCII characters
#'
#' @return Plain text without HTML tags
#'
#' @noRd
html_to_ascii <- function(text) {
  text |> 
    get_html_text() |> 
    convert_to_ascii()
}

#' Clean text
#'
#' @description Replace unicode characters and line breaks
#'
#' @return Plain text without special characters
#'
#' @noRd
clean_text <- function(text) {
  text |> 
    replace_unicode_characters() |> 
    replace_line_breaks()
}

#' Get HTML text
#'
#' @description Gets the text component of HTML, removing the HTML tags and other characters
#'
#' @return Plain text (ASCII) with HTML tags replaced
#'
#' @noRd
get_html_text <- function(text) {
  if(text == "") {
    return("")
  }
  
  text |>
    charToRaw() |>
    read_html() |>
    html_text()
}

#' Converts text from UTF-8 to ASCII and replaces special characters
#'
#' @description Replaces special characters with Unicode (<U+...>)
#'
#' @return Plain text (ASCII) with Unicode for special characters
#'
#' @noRd
convert_to_ascii <- function(text) {
  text |> 
    iconv(from = "UTF-8", "ASCII", sub = "Unicode")
}

#' Replace Unicode character patterns
#'
#' @description Replaces Unicode special characters in ASCII plain text with another character(s)
#'
#' @return Plain text (ASCII) with Unicode special characters replaced
#'
#' @noRd
replace_unicode_characters <- function(text, replacement = "_") {
  # remove non-breaking spaces first so they aren't replaced by a non-whitespace character
  text_nbsp <- gsub("<U\\+00A0>", " ", text)
  gsub("<U\\+.+?>", replacement, text_nbsp)
}

#' Replace line breaks
#'
#' @description Removes line breaks from text. Useful for counting characters.
#'
#' @return Plain text (ASCII) with line breaks replaced
#'
#' @noRd
replace_line_breaks <- function(text, replacement = " ") {
  gsub("[\r\n]", replacement, text)
}

