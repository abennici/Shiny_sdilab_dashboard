
server <- function(input, output, session) {
  
  data<-callModule(module = QueryInfo, id = "id_1")
  callModule(module = DataTableWide,id="id_2",reactive(data$data.sf),reactive(data$meta))
  

}