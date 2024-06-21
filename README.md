# Aplicación de Generación de Imágenes OpenAI

Esta es una aplicación Shiny que utiliza la API de OpenAI para generar imágenes basadas en la entrada del usuario.

## Características

-   **Campo de Texto**: Ingrese la descripción de la imagen que desea generar.
-   **Botón Ir**: Haga clic en este botón para generar la imagen en base a su entrada.
-   **Campo de Entrada de la Clave API**: Ingrese aquí su clave API de OpenAI. Este campo está oculto por razones de seguridad.
-   **Botón de Descarga**: Descargue la imagen generada.

## Cómo Usar

1.  Ingrese la descripción de la imagen que desea generar en el campo de texto.
2.  Ingrese su clave API de OpenAI en el campo de entrada de la clave API.
3.  Haga clic en el botón "Ir" para generar la imagen.
4.  Una vez generada la imagen, se mostrará en la página. Puede hacer clic en el botón "Descargar Imagen" para descargar la imagen.

## Resumen del Código

La interfaz de usuario de la aplicación se define en el objeto `ui`. Incluye una página de barra de navegación con un panel de pestañas para la generación de imágenes. El panel de pestañas incluye un campo de entrada de texto para la descripción de la imagen, un botón de acción para generar la imagen y un botón de descarga para descargar la imagen.

La lógica del servidor de la aplicación se define en la función `server`. Incluye una expresión reactiva para capturar cambios en los campos de entrada de la descripción de la imagen y la clave API. Cuando se hace clic en el botón "Ir", se llama a la función `create_image` del paquete `openai` con la clave API ingresada y la descripción de la imagen como argumentos. La URL de la imagen generada se almacena luego en la expresión reactiva.

La función `downloadHandler` se utiliza para descargar la imagen cuando se hace clic en el botón "Descargar Imagen". El nombre del archivo de la imagen descargada se establece en "image" seguido de la fecha actual.

La función `renderUI` se utiliza para mostrar la imagen generada en la página. Si no se introduce la clave API, se muestra un mensaje pidiendo al usuario que introduzca la clave API.

## Ejecutando la Aplicación

Para ejecutar la aplicación, utilice la función `shinyApp` con los objetos `ui` y `server` como argumentos.

https://m-katogui.shinyapps.io/OpenAIGeneracionDeImagenes/ 

![image](https://github.com/mkatogui/LLM/assets/60530366/8acb9f63-1594-4120-b80a-f3ae24c77998)

