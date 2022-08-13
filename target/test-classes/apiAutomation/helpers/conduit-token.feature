@conduit-token
Feature: Crear Token auth
  Esta función permite crear el token de sesión

  Scenario: Crear Token de sesión
    Given header Content-Type = "application/json"
    And url "https://api.realworld.io/api/"
    And path "users/login"
    And request {"user": {"email": "#(userEmail)","password": "#(userPassword)"}}
    When method POST
    Then status 200
    * def authTokenConduit = response.user.token

