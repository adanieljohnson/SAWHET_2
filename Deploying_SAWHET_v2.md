# Deploying SAWHET v2.\#

_Last update: 6/9/2022_

## Overview

The steps to deploy the app to your own Shinyapps.io account are:

1. Create a TinyMCE account and link it to the app.
2. Link the app to a Dropbox account (optional.)
3. Modify and pre-check the application by running it locally inside R Studio.
3. Deploy the working application to Shinyapps.io.


## Create & Link to a TinyMCE Account

The app uses the TinyMCE web service to provide rich text formatting.

1. Create an account with Tiny (https://www.tiny.cloud/auth/signup/). 

2. Add your shinyapps.io domain (http://shinyapps.io/) to the approved list. 
    + Log in to Tiny, and navigate to Approved Domains.
    + Add your shinyapps.io domain (e.g., stem-writing-project.shinyapps.io, see below). 
 
3. Update the API key. 
    + Log in to Tiny, navigate to your Dashboard, and find your Tiny API Key. It will be a 48-character string.
    + Copy this Key.
    + In your files, open "R/fct_tinyMCE.R"
    + In line 20, paste in your personal API. (i.e., //cdn.tiny.cloud/1/[API_KEY_HERE]/tinymce/5/tinymce.min.js).
    + Save the updated file.


## Link to a Dropbox Account (Optional)

To minimize potential security risks, we chose not to connect the public version of SAWHET v2 to a central database. Compiled reports are downloaded directly to the user for submission then deleted from the public version of the app. Only the data activity log is preserved.

Users who have secure Dropbox service at their institution can activate an option to store copies of the files in a dedicated Dropbox folder. 

1. Create an account with Dropbox (https://dropbox.com/), or log into your institutional account. 

2. Create a private folder named "SAWHET" 
    + If you change this folder name, also update file "R/fct_download.R" line 139. 

3. [Follow the instructions here](https://github.com/karthik/rdrop2#accessing-dropbox-on-shiny-and-remote-servers) to create a token and save it in a folder named "secrets" in the project root directory (this folder is not tracked by Git). 

4. Uncomment lines 128-140 in "R/fct_download.R". 

Other Dropbox authentication options are also available, e.g., https://shiny.rstudio.com/articles/persistent-data-storage.html#dropbox.


## Test, Modify, and Deploy the Application

1. Create an account with __Shinyapps.io__ (https://www.shinyapps.io/). Put the domain your account is assigned in the approved Tiny domains list (Item #2 in the above section, "Create & Link to a TinyMCE Account".

2. In RStudio, go to your local folder that contains the files for SAWHET v2.

3. Open "app.R" and follow the instructions at the top of the file. Or, click "Run App" to start SAWHET v2.

4. App files can be edited and tested using the locally running version before deployment.

5. When the app is ready to be deployed:
    + Click on the __Publish/Re-Publish__ button at the top right of the active app window. 
    + R Studio will take a few minutes to compile the app, then push a copy to the associated ShinyApps.io account.
    + The app can now be accessed via the web using its ShinyApps.io URL.

6. Once the app has been deployed to ShinyApps.io, it does not need to be recompiled unless a change is made to the code or text.


## Troubleshooting the Installation

1. R Studio requires the [shinyMCE package](https://github.com/mul118/shinyMCE). The default installer does not always recognize Mac computers. To install the package on a Mac, clone the repository for the package into a personal GitHub account and install it to your local R installation from there. 

2. End users will have a subfolder in the folder "/rsconnect/shinyapps.io/" that controls access to ShinyApps.io. If you can run the application locally but cannot connect it to the web server, check here first for problems.


## Next Steps
### Localizing SAWHET v2

These are the most common items to modify. After changing files, the app will need to be re-published to incorporate the changes.

1. The file "/inst/app/header.txt" contains the text and link to the image logo file that display at the top of the web form. Edit this as needed.

2. The folder "/inst/app/www/" contains the image logo file, and the CSS styling file. Edit them as needed.

3. The file "/data-raw/courses.csv" contains the list of courses and instructors that displays at the top of the app. Edit this file as needed to match local courses and instructors each semester. 

4. Files in the folder "/inst/app/help/" contain the text for the helper prompts that users can click on to display. Edit contents of these files (but NOT the file names) to match local requirements.


### Modifying SAWHET v2 Functions

1. The folder "/R" contains most of the working sub-scripts. Additional screening scripts will likely go here. Scripts will need to be included in the main program files, "app\_config.R, app\_server.R, app\_ui.R".

2. SAWHET v2 can be modified to write compiled files to a database for storage, but it is not a simple task. 
    + We recommend working with an experienced R Shiny developer who can set up and secure the database.
    + Always consult your local IS security team before storing student assignments. Rules on what is or is not allowed vary greatly by institution.

2. By default SAWHET v2 times out a session after 15 minutes, but gives no warning. Users may want to add that function to their local edition.


### Sharing Your Experiences

We hope that others using SAWHET v2 will share their experiences and modifications with the community. You can:

* Post on QUBES Hub,
* Add a comment or create a new branch in GitHub, or
* Send us an email.

