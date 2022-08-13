@restful-patch
Feature: PATCH API Test
  Esta es la prueba de automatización de API para el metodo PATCH

  # IMPORTANTE CAMBIAR VARIABLE GLOBAL DE AMBIENTE RESTFUL
  # METODO PATCH
  Background: Define URL y consulta Token de sesión
    Given header Content-Type = "application/json"
    And url apiURLRestful

  @tag1
  Scenario: Test Case 01 / Actualiza parcialmente una reserva creada
    # Actualiza parcialmente la reserva creada con assertion de respuesta
    Given header Accept = "application/json"
    And path "booking/", 2102
    When request
    """
        {
          "lastname": "Karate28",
          "totalprice": 630,
          "additionalneeds": "Breakfast"
        }
    """
    And method PATCH
    Then status 200
    And match response.lastname == "Karate28"
    And match response.totalprice == 630
    And match response.additionalneeds == "Breakfast"
