
## ui.R ##
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("QueryInfo", tabName = "QueryInfo", icon = icon("dashboard")),
    menuItem("Table", icon = icon("th"), tabName = "Table")
  )
)

body <- dashboardBody(
    tabItems(
    tabItem(tabName = "QueryInfo",
            h2("Dashboard tab content"),QueryInfoUI(id = "id_1")
    ),

    tabItem(tabName = "Table",
            h2("Table"),DataTableWideUI(id = "id_2")
    )
  )
)

# Put them together into a dashboardPage
dashboardPage(
  dashboardHeader(title = "Sdilab Dashboard",tags$li(class = "dropdown",
                                                     tags$a(href="https://www.blue-cloud.org", target="_blank", 
                                                            tags$img(height = "30px", alt="SNAP Logo", src="https://www.blue-cloud.org/sites/all/themes/arcadia/logo.png")
                                                     )
  )),
  sidebar,
  body
)

