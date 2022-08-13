@restful-put
Feature: PUT API Test
  Esta es la prueba de automatización de API para el metodo PUT

  # IMPORTANTE CAMBIAR VARIABLE GLOBAL DE AMBIENTE RESTFUL
  # METODO PUT
  Background: Define URL y consulta Token de sesión
    Given header Content-Type = "application/json"
    And url apiURLRestful


  @tag1
  Scenario: Test Case 01 / Actualiza una reserva creada
    # Actualiza la reserva creada con assertion de respuesta
    Given header Accept = "application/json"
    And path "booking/", 2102
    When request
    """
        {
          "firstname": "Karate4",
          "lastname": "Karate28",
          "totalprice": 610,
          "depositpaid": true,
          "bookingdates": {
            "checkin": "2022-08-03",
            "checkout": "2022-08-03"
          },
          "additionalneeds": "Breakfast"
        }
    """
    And method PUT
    Then status 200
    And match response.firstname == "Karate4"
    And match response.depositpaid == true
