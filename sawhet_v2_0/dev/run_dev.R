# Set options here
# golem.app.prod: TRUE = production mode, FALSE = development mode
# output: either "text" (for ASCII) or "html" for HTML download / output
options(golem.app.prod = FALSE, output = "html") 

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
# rm(list=ls(all.names = TRUE))

# Document and reload your package
golem::document_and_reload()

# Run the application
run_app()
