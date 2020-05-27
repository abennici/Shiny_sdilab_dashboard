#---------------------------------------------------------------------------------------------------------
#packages
library("ows4R")
library("sp")
library("shiny")
########################
ui <- fluidPage(
    h3("Parsed query string"),
    verbatimTextOutput("queryText"),
    tableOutput('table')
)

server <- function(input, output, session) {
    resume.table<-data.frame(NULL)
    output$queryText <- renderText({
        query <- parseQueryString(session$clientData$url_search)
        paste(sep = "",
              "pid: ", query$pid, "\n",
              "layer: ", query$layer, "\n",
              "wfs_server: ",query$wfs_server, "\n",
              "wfs_version: ", query$wfs_version, "\n",
              "strategy: ", query$strategy, "\n",
              "par: ", query$par, "\n")
    })
    observe({
        query <- parseQueryString(session$clientData$url_search)
        
        pid <- if (!is.null(query$pid)){
            as.character(query$pid)
        }else{
            NULL
        }
        layer <-if (!is.null(query$layer)){
            as.character(query$layer)
        }else{
            NULL
        }
        
        wfs_server <-if (!is.null(query$wfs_server)){
            as.character(query$wfs_server)
        }else{
            NULL
        }
        
        wfs_version <-if (!is.null(query$wfs_version)){
            as.character(query$wfs_version)
        }else{
            NULL
        }
        
        strategy <-if (!is.null(query$strategy)){
            as.character(query$strategy)
        }else{
            NULL
        }
        
        par <-if (!is.null(query$par)){
            as.character(query$par)
        }else{
            NULL
        }
        
        if(!is.null(pid)&!is.null(layer)&!is.null(wfs_server)&!is.null(wfs_version)&!is.null(strategy)&!is.null(par)){
            
            # #Connect to OGC CSW Catalogue to get METADATA
            CSW <- CSWClient$new(
                url = "https://geonetwork-sdi-lab.d4science.org/geonetwork/srv/eng/csw",
                serviceVersion = "2.0.2",
                logger = "INFO"
            )
            #Get metadata for dataset
            md <- CSW$getRecordById(pid, outputSchema = "http://www.isotc211.org/2005/gmd")
            
            #Connect to OGC WFS to get DATA
            WFS <- WFSClient$new(
                url = wfs_server,
                serviceVersion = wfs_version,
                logger = "INFO"
            )
            #Get feature type for dataset
            ft <- WFS$capabilities$findFeatureTypeByName(layer)
            #Get data features for dataset
            data.sf <- switch(strategy,
                              "ogc_filter"=ft$getFeatures(if(!is.null(par)){cql_filter = gsub(" ", "%20", gsub("''", "%27%27", URLencode(par)))}),
                              "ogc_viewparams"=ft$getFeatures(if(!is.null(par)){viewparams = URLencode(par)})
            )
            data.sp <- as(data.sf, "Spatial")
            resume.table<<-as.data.frame(head(data.sp))
            
        }else{}
    })
    
    if(exists("resume.table")){output$table <- renderTable({head(resume.table)})}else{}
    
}

shinyApp(ui, server)
