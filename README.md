# SAWHET 2 Is Coming Summer 2022
Watch this space for the next iteration of the STEM Automated Writing Help Tool (SAWHET). This web-based form checks student lab reports to ensure they are complete. SAWHET automatically checks for basic elements such as:

* Are all of the required parts there?
* Are some sections too short or long?
* Does the text have citations in correct format in the correct sections?

Students can use SAWHET as often as they like to check reports. When a student clicks __Download__, SAWHET combines the text, tables, figures, and metadata in one zip file for easy submission. Only the final version is submitted for grading. 

The first iteration of SAWHET was written in Java and used GATE (Generalized Architecture for Text Engineering) plus proprietary SaaS. SAWHET 2 was built entirely in R Shiny, so:

* Users can revise the application more easily, and
* We can distribute SAWHET with more permissive licensing.

The complete code required to set up a new instance of the R Shiny version of SAWHET is available from this repository. 

* [Demo of the current version of SAWHET-2](https://evan-cutler-anway.shinyapps.io/sawhet-draft/). 
* [Minimal working version of SAWHET-2](https://yelr6j-dan-johnson.shinyapps.io/sawhet2/). 


## SAWHET v2.0 versus MVP

There are two versions of SAWHET available. **Version 2.#** is the one under active development. Older versions that have been replaced are stored in the __Archived__ folder. 

__MVP__ is in a separate folder. This is the minimum viable product. It lacks several customizations found in v2.# but still provides the essential functions. This core app may be easier for other Shiny editors to adapt to their needs. We do not plan to continue developing this version.   
