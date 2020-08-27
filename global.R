#---------------------------------------------------------------------------------------------------------
#packages
library("ows4R")
library("sp")
library("shiny")
library("DT")
library("shinyWidgets")
library("shinycssloaders")
library("jsonlite")
library("shinydashboard")

#load module functions
source("https://raw.githubusercontent.com/abennici/ShinySdilabpopup/master/modules/QueryInfo.R")
source("modules/DataTableWide.R")
source("https://raw.githubusercontent.com/abennici/ShinySdilabpopup/master/functions.R")
source("ui.R")
source("server.R")

