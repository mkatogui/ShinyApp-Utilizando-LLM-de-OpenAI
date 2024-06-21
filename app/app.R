library(shiny)

# Define UI for application
ui <- fluidPage(
  navbarPage("Prueba con API OpenAI",
             tabPanel("Dibujar",
                      fluidRow(
                        column(7,
                               div(style="display: flex; align-items: flex-end;",
                                   tags$input(id= "url_input", 
                                              class = "pretty_input",
                                              type = "text",
                                              placeholder = "Escribe la descripción del dibujo a generar")
                               )
                        ),
                        column(3,
                               div(style="display: flex; align-items: flex-end;",
                                   actionButton("go_button", "Dibujar", class = "btn-success pretty_button", style = "width: 100%;")
                               )
                        ),
                        column(3, 
                               div(style="display: flex; align-items: flex-end;",
                                   textInput("api_key_input", label = NULL, value = "")
                               )
                        )
                      ), 
                      downloadButton("downloadImage", "Descargar Imagen", class = "btn-success pretty_button"),
                      tags$ul(
                        htmlOutput("image", container = tags$li, class = "custom-li-output")
                      )
             )
  ),
  tags$head(tags$script(HTML('
    $(document).ready(function() {
      $("#api_key_input").attr("placeholder", "API Key");
      $("#api_key_input").attr("type", "password");
      $("#api_key_input").addClass("pretty_input");
 });
  '))),
  tags$style(HTML("
    .pretty_input {
      width: 100%;
      padding: 12px 20px;
      margin: 8px 0;
      box-sizing: border-box;
      border: 2px solid green;
      border-radius: 4px;
    }
    .pretty_button {
      padding: 12px 20px;
      margin: 8px 0;
      box-sizing: border-box;
      border: 2px solid green;
      border-radius: 4px;
      background-color: green;
      color: white;
      font-weight: bold;
    }
  ")),
  tags$style(HTML("
  .custom-li-output {
    border: 3px solid #ccc; 
    padding: 10px;
    margin: 10px;
    width: 200px;
    height: 200px;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #f9f9f9;
    border-radius: 10px;
  }
  
  .custom-li-output img {
    width: 100%;
    height: 100%;
    object-fit: cover; /* This line ensures that the image covers the entire area of the box without distorting the aspect ratio */
  }
"))
)


# Define server logic
server <- function(input, output) {
  
  # Define a reactive expression to capture the change in input$url_input and input$api_key_input
  url_reactive <- eventReactive({input$go_button; isolate(input$api_key_input)}, {
    tryCatch({
      openai::create_image(openai_api_key=input$api_key_input, input$url_input)$data$url
    },
    error = function(e) {
      if (grepl("401", e$message)) {
        return("Por favor introduzca la API KEY")
      } else {
        stop(e)
      }
    })
  })
  
  # Use downloadHandler to download the image
  output$downloadImage <- downloadHandler(
    filename = function() {
      paste("image", Sys.Date(), ".jpg", sep="")
    },
    content = function(file) {
      download.file(url_reactive(), destfile = file, mode = "wb")
    }
  )
  
  output$image <- renderUI({
    if (url_reactive() == "Por favor introduzca la API KEY") {
      HTML("<h2 style='color:red;'>Por favor introduzca la API KEY</h2>")
    } else {
      tags$img(src = url_reactive())
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)
