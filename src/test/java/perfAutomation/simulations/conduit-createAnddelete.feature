@conduit-createanddelete
Feature: CREATE AND DELETE API Conduit Test Performance
  Esta es la prueba de automatización de API para el metodo PUT Y DELETE MÁS GATLING

  # IMPORTANTE CAMBIAR VARIABLE GLOBAL DE AMBIENTE CONDUIT
  # IMPORTANTE CAMBIAR PATH DE VALIDADOR DE DATA GENERATOR
  Background: Precondiciones
    * url "https://api.realworld.io/api/"

    * def articleRequestBody = read("classpath:apiAutomation/conduit/json/newArticleRequest.json")
    * def dataGenerator = Java.type("apiAutomation.helpers.DataGenerator")

    * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
    * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description

#    * set articleRequestBody.article.title = __gatling.Title
#    * set articleRequestBody.article.description = __gatling.Description
    * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

  @tag1
  Scenario: Test Case 01 / Registrar y eliminar nuevo articulo
    * configure headers = {"Authorization": #('Token ' + __gatling.token)}
    # Crear articulo
    Given path "articles"
    And request articleRequestBody
    And header karate-name = "Create Article"
#    And header karate-name = "Title requested: " + __gatling.Title
    When method POST
    Then status 200
    * def articleId = response.article.slug

    # Simulación de tiempo de usuario gatling performance test
#    * karate.pause(5000)

    # Elimina la reserva creada con assertion de respuesta
    Given header Accept = "application/json"
    And path "articles", articleId
    And header karate-name = "Delete Article"
    When method DELETE
    Then status 200
    And match response == {}
