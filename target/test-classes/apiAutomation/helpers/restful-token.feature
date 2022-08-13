@token-restful
Feature: Crear Token auth
  Esta función permite crear el token de sesión

  Scenario: Crear Token de sesión
    Given header Content-Type = "application/json"
    And url "https://restful-booker.herokuapp.com/"
    And path "auth"
    And request {"username": "#(userUsername)","password": "#(userPassword)"}
    When method POST
    Then status 200
    * def authTokenRestful = response.token