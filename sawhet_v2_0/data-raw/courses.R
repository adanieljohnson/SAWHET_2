## code to prepare `course` dataset goes here

df_courses <- "data-raw/coursesFa22.csv" |> 
  read.csv()

usethis::use_data(df_courses, internal = TRUE, overwrite = TRUE)
