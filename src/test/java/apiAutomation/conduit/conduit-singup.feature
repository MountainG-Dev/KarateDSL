@conduit-singup
Feature: Expresiones incrustadas y multilinea
  Esta es la prueba de automatización de Expresiones incrustadas y multilinea

  # IMPORTANTE CAMBIAR VARIABLE GLOBAL DE AMBIENTE CONDUIT
  # IMPORTANTE CAMBIAR PATH DE VALIDADOR DE DATA GENERATOR
  Background: Precondiciones
    * def dataGenerator = Java.type("apiAutomation.helpers.DataGenerator")
    * url apiURLConduit
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()

  @tag1
  Scenario: Test Case 01 / Registrar nuevo usuario
#    Given def userData = {"email":"karate39@test.com","username":"Karate39"}
    Given path "users"
    And request
    """
        {
           "user":{
              "email": "#(randomEmail)",
              "password": "karate123",
              "username": "#(randomUsername)"
           }
        }
    """
    When method POST
    Then status 200
    And match response ==
    """
        {
          "user": {
            "email": "#(randomEmail)",
            "username": "#(randomUsername)",
            "bio": null,
            "image": null,
            "token": "#string"
          }
        }
    """

  @tag2
  Scenario: Test Case 02 / Validar registro de usuario con error
    Given path "users"
    And request
  """
      {
         "user":{
            "email": "karate35@test.com",
            "password": "karate123",
            "username": "#(randomUsername)"
         }
      }
  """
    When method POST
    Then status 422


  @tag3
  Scenario Outline: Test Case 03 / Validar respuestas de error de registro <index> para usuario <username> generador de data
    Given path "users"
    When request
    """
        {
           "user":{
              "email": "#(<email>)",
              "password": "#(<password>)",
              "username": "#(<username>)"
           }
        }
    """
    And method POST
    Then status 422
    And match response == errorResponse
    Examples:
      | index! | email               | password   | username!              | errorResponse!                                                                     |
      | 1      | randomEmail         | 'Karate35' | 'Karate35'             | {"errors":{"username":["has already been taken"]}}                                 |
      | 2      | 'karate39@test.com' | 'Karate35' | randomUsername         | {"errors":{"email":["has already been taken"]}}                                    |
      | 3      | ''                  | 'Karate35' | randomUsername         | {"errors":{"email":["can't be blank"]}}                                            |
      | 4      | 'karate50@test.com' | ''         | randomUsername         | {"errors":{"password":["can't be blank"]}}                                         |
      | 5      | 'karate39@test.com' | 'Karate35' | ''                     | {"errors":{"username":["can't be blank"]}}                                         |
#      | 6      | #(randomEmail)      | Karate35   |                        | {"errors":{"username":["can't be blank","is too short (minimum is 1 characters"]}} |
#      | 7      | KarateUser1         | Karate35   | #(randomUsername)      | {"errors":{"email":["is invalid"]}}                                                |
#      | 8      | #(randomEmail)      | Karate35   | KarateUser353535353535 | {"errors":{"username":["is too long (maximum is 20 characters"]}}                  |
#      | 9      | #(randomEmail)      | Kar        | #(randomUsername)      | {"errors":{"password":["is too short (minimum is 8 characters"]}}                  |
#      | 10     | #(randomEmail)      | Karate35   | #(randomUsername)      | {"errors":{"username":["is too short (minimum is 8 characters"]}}                  |
