# Welcome to SAWHET v2
SAWHET v2 is an R Shiny based web form that checks student lab reports to ensure they are complete. SAWHET v2 automatically checks for basic elements such as:

* Are all of the required parts there?
* Are some sections too short or long?
* Does the text have citations in correct format in the correct sections?

Students can use SAWHET as often as they like to check reports. When a student clicks __Download__, SAWHET merges the text, tables, figures, and metadata in one zip file for submission. Only the final version is submitted for grading. 

* [Demo of the current version of SAWHET-2](https://evan-cutler-anway.shinyapps.io/sawhet-draft/). 
* [Minimal working version of SAWHET-2](https://yelr6j-dan-johnson.shinyapps.io/sawhet2/). 

The first iteration of SAWHET was written in Java and used GATE (Generalized Architecture for Text Engineering) plus proprietary SaaS. SAWHET 2 was built entirely in R Shiny, so:

* Users can revise the application more easily, and
* We can distribute SAWHET with more permissive licensing.


## SAWHET v2.0 versus MVP

The files code required to set up a new instance of SAWHET v2 are available from this repository. 

**Version 2.#** on the main branch is the one under active development. To view individual files in the app, go to the __sawhet_v2_0__ folder. To download a complete copy of the app files without cloning the repository, choose the __ZIP file__.

The __Archived__ folder contains older versions of the app. 

The __MVP__ folder contains a ZIP archive for the minimum viable product. This core version may be easier for other Shiny editors to adapt to their needs. This version is no longer under development.   

