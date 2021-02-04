

###########################################################-
# Objective: Postwork Sesion 8
# Authors: Team 11
#          - Gabriel Sainz V?zquez
#          - Edgar Arellano Ruelas
#          - Aldo Omar Enriquez Velazquez
#          - Ivan Delgado de la paz
# Date Modified: 03/02/2021
###########################################################-

library(shiny)
library(shinydashboard)
library(shinythemes)
library(ggplot2)




ui <- 
    
    fluidPage(
        dashboardPage(
            dashboardHeader(title = "Prediccion de Resultados"),
            dashboardSidebar(
                sidebarMenu(
                    menuItem("Graficos de barras", tabName = "Dashboard", icon = icon("dashboard")),
                    menuItem("Goles casa - visitante", tabName = "goles", icon = icon("area-chart")),
                    menuItem("Data Table", tabName = "data_table", icon = icon("table")),
                    menuItem("Factores de ganancia", tabName = "momios", icon = icon("file-picture-o"))
                )
            ),
            dashboardBody(
                tabItems(
                   
                    tabItem(tabName = "Dashboard",
                            fluidRow(
                                titlePanel("Goles a favor y en contra por equipo"), 
                                selectInput("x", "Seleccione el valor de X",
                                            choices = c("home.score", "away.score")),
                                plotOutput("plot1", height = 450, width = 750)
                            )
                    ),
                    
                    tabItem(tabName = "goles", 
                            fluidRow(
                                titlePanel(h3("Probabilidad de goles en casa y visitante")),
                                
                                img(src = "casa.png") ,
                                img(src = "visitante.png"),
                                img(src = "conjunta.png")
                            )
                    ),
                    
                    tabItem(tabName = "data_table",
                            fluidRow(        
                                titlePanel(h3("Data Table")),
                                dataTableOutput ("data_table")
                            )
                    ), 
                    tabItem(tabName = "momios",
                            fluidRow(
                                titlePanel(h3("Imagen de calor para la correlacion de las variables")),
                                h3("Factor de ganancia Msximo"),
                                img( src = "Rplot.png", 
                                     height = 350, width = 550),
                                h3("Factor de ganancia Promedio"),
                                img( src = "Rplot01.png", 
                                     height = 350, width = 550)
                            )
                    )
                )
            )
        )
    )

server <- function(input, output) {
    library(ggplot2)
   
    output$plot1 <- renderPlot({
        data <-  read.csv("match.data.csv", header = T)
        data <- mutate(data, FTR = ifelse(home.score > away.score, "H", ifelse(home.score < away.score, "A", "D")))
        x <- data[,input$x]
      
        data %>% ggplot(aes(x, fill = FTR)) + 
            geom_bar() + 
            facet_wrap("away.team") +
            labs(x =input$x, y = "Goles") + 
            ylim(0,50)
    })
    
  
    output$output_momios <- renderPlot({ 
        
        ggplot(mtcars, aes(x =  mtcars[,input$a] , y = mtcars[,input$y], 
                           colour = mtcars[,input$z] )) + 
            geom_point() +
            ylab(input$y) +
            xlab(input$x) + 
            theme_linedraw() + 
            facet_grid(input$z)  
        
    })   
    #Data Table
    output$data_table <- renderDataTable( {data}, 
                                          options = list(aLengthMenu = c(10,25,50),
                                                         iDisplayLength = 10)
    )
}

 
shinyApp(ui = ui, server = server)
