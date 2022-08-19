@conduit-homepage
Feature: GET API Test Conduit
  Esta es la prueba de automatización de API para el metodo GET

  # IMPORTANTE CAMBIAR VARIABLE GLOBAL DE AMBIENTE CONDUIT
  # IMPORTANTE CAMBIAR PATH DE VALIDADOR DE TIEMPO
  # METODO GET
  Background: Define URL
    * header Content-Type = "application/json"
    * url apiURLConduit
    * def timeValidator = read("classpath:apiAutomation/helpers/timeValidator.js")

  @tag1
  Scenario: Test Case 01 / Obtener lista de todos los articulos con limite de parámetros/json
    Given path "articles"
    And params {limit:10, offset:0}
    When method GET
    Then status 200

  @tag2
  Scenario: Test Case 02 / Obtener todos los tags con assertions a tags
    Given path "tags"
    When method GET
    Then status 200
    And match response.tags contains "welcome"
    And match response.tags contains ["welcome", "codebaseShow"]
    And match response.tags !contains "truck"
    And match response.tags contains any ["introduction", "implementations"]
    And match response.tags == "#array"
    And match each response.tags == "#string"

  @tag3
  Scenario: Test Case 03 / Obtener lista de todos los usuarios con limite de parámetros y assertions
    Given path "articles"
    And params {limit:10, offset:0}
    When method GET
    Then status 200

    # Tipos de assertions
    And match response.articles == "#[3]"
    And match response.articlesCount == 3
    And match response.articlesCount != 1
    And match response == {"articles": "#array", "articlesCount": 3}
    And match response.articles[0].createdAt contains "2021"
    * def favoritesVAR = response.articles[0].favoritesCount
    And match response.articles[*].favoritesCount contains favoritesVAR
    And match each response..favoritesCount == "#number"
    And match response..bio contains null
    And match each response..following == false

    # Validación de tipos de datos obligatorios y opcionales null
    And match each response..following == "#boolean"
    And match each response..bio == "##String"

    # Validación de esquemas pruebas reales
    And match response == {"articles": "#[3]", "articlesCount": 3}
    And match each response.articles ==
    """
        {
          "slug": "#string",
          "title": "#string",
          "description": "#string",
          "body": "#string",
          "tagList": "#array",
          "createdAt": "#? timeValidator(_)",
          "updatedAt": "#? timeValidator(_)",
          "favorited": "#boolean",
          "favoritesCount": "#number",
          "author": {
            "username": "#string",
            "bio": "##string",
            "image": "#string",
            "following": "#boolean"
          }
        }
    """

  @tag4
  Scenario: Test Case 04 / Condición lógica
    Given path "articles"
    And params {limit:10, offset:0}
    When method GET
    Then status 200
    * def favoritesCount = response.articles[0].favoritesCount
    * def article = response.articles[0]

  # Variable slugVAR es heredable a add.likes.feature en el path
    * def slugVAR = response.articles[0].slug

  # 1era condición lógica if con variable incrustada
#    * if (favoritesCount == 3556) karate.call("classpath:apiAutomation/helpers/add-likes.feature", article)

  # 2da condición lógica con def obteniendo variable heredada desde add-likes.feature y luego almacenando respuesta en variable
    * def result = favoritesCount == 3556 ? karate.call("classpath:apiAutomation/helpers/add-likes.feature", article).likesCount : favoritesCount
    * print result

    Given path "articles"
    And params {limit:10, offset:0}
    When method GET
    Then status 200
    And match response.articles[0].favoritesCount == result

  # Step 9: Delete favorites count made
    Given path "articles/" + slugVAR + "/favorite"
    When method DELETE
    Then status 200
    * print response

  @tag5
  Scenario: Test Case 05 / reintento de llamada
    * configure retry = {count: 10, interval: 5000}

    Given path "articles"
    And params {limit:10, offset:0}
    And retry until response.articles[0].favoritesCount == 3561
    When method GET
    Then status 200
    And match response.articles[0].favoritesCount == 3561

  @tag6
  Scenario: Test Case 06 / llamada detenida
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

    Given path "articles"
    And params {limit:10, offset:0}
    When method GET
    * eval sleep(5000)
    Then status 200

  @tag7
  Scenario: Test Case 07 / Convertir número a string
    * def foo = 10
    * def json = {"bar": #(foo+"")}
    * match json == {"bar": "10"}

  @tag8
  Scenario: Test Case 08 / Convertir string a numero
    # Entero
    * def foo = "10"
    * def json = {"bar": #(~~foo)}
    * def json2 = {"bar": #(foo * 1)}
    # Decimal
    * def foo2 = "10.5"
    * def json3 = {"bar": #(~~(foo * 1))}
    # Validación
    * match json == {"bar": 10}
    * match json2 == {"bar": 10}
    * match json3 == {"bar": 10}