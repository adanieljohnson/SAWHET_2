# Building a Prod-Ready, Robust Shiny Application.
# 
# README: each step of the dev files is optional, and you don't have to 
# fill every dev scripts before getting started. 
# 01_start.R should be filled at start. 
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
# 
# 
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Add one line by package you want to add as dependency
usethis::use_package( "shinyjs" )
usethis::use_dev_package("shinyMCE", remote = "mul118/shinyMCE")
usethis::use_package("rvest")
usethis::use_package("dplyr")
usethis::use_package("zip")
usethis::use_package("rdrop2")

## Imports
usethis::use_import_from("shinyjs", "useShinyjs")
usethis::use_import_from("shinyjs", "toggle")
usethis::use_import_from("shinyjs", "html")
usethis::use_import_from("shinyjs", "hide")

usethis::use_import_from("stringi", "stri_count")

usethis::use_import_from("rvest", "read_html")
usethis::use_import_from("rvest", "html_text")

usethis::use_import_from("dplyr", "pull")
usethis::use_import_from("dplyr", "filter")
usethis::use_import_from("dplyr", "mutate")
usethis::use_import_from("dplyr", "select")

usethis::use_import_from("zip", "zip")

usethis::use_import_from("rdrop2", "drop_upload")

## Add modules ----
## Create a module infrastructure in R/
golem::add_module( name = "text_box" )
golem::add_module( name = "help" )
golem::add_module( name = "header_choices" )
golem::add_module( name = "figure_table_upload" )
golem::add_module( name = "download" )
golem::add_module( name = "courses_tas" )

## Add helper functions ----
## Creates fct_* and utils_*
golem::add_fct( "text_box" ) 
golem::add_fct( "tinyMCE" )
golem::add_fct( "help" ) 
golem::add_fct( "metadata" ) 
golem::add_fct( "validate" ) 
golem::add_utils( "read_text" )
golem::add_utils( "null" )

## External resources
## Creates .js and .css files at inst/app/www
golem::add_js_file( "script" )
golem::add_js_handler( "handlers" )
golem::add_css_file( "custom" )

## Add internal datasets ----
## If you have data in your package
usethis::use_data_raw( name = "courses", open = FALSE ) 

## Tests ----
## Add one line by test you want to create
usethis::use_test( "app" )

# Documentation

## Vignette ----
usethis::use_vignette("sawhet")
devtools::build_vignettes()

## Code Coverage----
## Set the code coverage service ("codecov" or "coveralls")
usethis::use_coverage()

# Create a summary readme for the testthat subdirectory
covrpage::covrpage()

## CI ----
## Use this part of the script if you need to set up a CI
## service for your application
## 
## (You'll need GitHub there)
usethis::use_github()

# GitHub Actions
usethis::use_github_action() 
# Chose one of the three
# See https://usethis.r-lib.org/reference/use_github_action.html
usethis::use_github_action_check_release() 
usethis::use_github_action_check_standard() 
usethis::use_github_action_check_full() 
# Add action for PR
usethis::use_github_action_pr_commands()

# Travis CI
usethis::use_travis() 
usethis::use_travis_badge() 

# AppVeyor 
usethis::use_appveyor() 
usethis::use_appveyor_badge()

# Circle CI
usethis::use_circleci()
usethis::use_circleci_badge()

# Jenkins
usethis::use_jenkins()

# GitLab CI
usethis::use_gitlab_ci()

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")

