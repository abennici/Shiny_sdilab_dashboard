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
#source("https://raw.githubusercontent.com/eblondel/OpenFairViewer/master/src/resources/shinyModule/QueryInfo.R")
source("modules/QueryInfo.R")
source("modules/DataTableWide.R")
source("ui.R")
source("server.R")

