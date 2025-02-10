(promQuestion as text, promptInput as text, promptInput2 as text, promptInput3 as text) =>

let
    // Configuración de la API
    apiKey = "TU_API_KEY", // Aquí debe ir la API KEY
    urlBase = "https://api.openai.com/v1/chat/completions",

    // Definir los encabezados
    headers = [
        #"Content-Type" = "application/json",
        #"Authorization" = "Bearer " & apiKey
    ],

    // Definir el cuerpo de la solicitud
    requestBody = Json.FromValue([
        model = "gpt-3.5-turbo", // modelo asociado (puede ser CHAT GPT 4)
        messages = {
            [role = "system", content = "Actua como un experto en Social Media Engagement"],
            [role = "user", content = promQuestion & "" & promptInput & "" & promptInput2 & "" & promptInput3]
        },
        max_tokens = 100 // Indicar cuantos tokens usar
    ]),

    // Hacer la solicitud POST a la API
    response = Web.Contents(urlBase, [
        Headers = headers,
        Content = requestBody
    ]),

    // Procesar la respuesta JSON
    responseJson = Json.Document(response),

    // Obtener el contenido de la respuesta
    completionText = responseJson[choices]{0}[message][content]
in 
    completionText