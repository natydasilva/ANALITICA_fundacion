# Esta es una aplicación shiny. Podés correr la aplicación apretando
# El botón 'Run App' que se encuentra arriba
# Más info sobre aplicaciones shiny en:  http://shiny.rstudio.com/

library(shiny)

# Define la interface de usuario de la aplicación (UI) 
# donde se grafica un histograma

ui <- fluidPage(
   
   # Título de la aplicación
   titlePanel("Datos del géiser old faithful"),
   
   # Barra laterar con control deslizante para el número de bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Número de bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Muestro el gráfico de la distribución generada
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Definimos en el server la lógica requerida para dibujar el histograma
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generamos los bins basados en input$bins de ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # dibujamos el histograma con el número especificado de bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
}

# Corremos la aplicación
shinyApp(ui = ui, server = server)

