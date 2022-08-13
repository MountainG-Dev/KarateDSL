@conduit-get
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
    And match response.articles[*].favoritesCount contains 1473
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





