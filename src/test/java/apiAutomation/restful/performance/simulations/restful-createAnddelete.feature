@restful-createarticle
Feature: CREATE AND DELETE API Test Performance
  Esta es la prueba de automatización de API para el metodo PUT Y DELETE MÁS GATLING

  # IMPORTANTE CAMBIAR VARIABLE GLOBAL DE AMBIENTE RESTFUL
  # METODO DELETE
  Background: Define URL y consulta Token de sesión
    Given header Content-Type = "application/json"
    And url apiURLRestful

  @tag1
  Scenario: CreateDelete
    # Crear reserva
    Given header Accept = "application/json"
    And path "booking"
    And request
    """
        {
          "firstname": "Karate3",
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
    When method POST
    Then status 200
    And match response.booking.firstname == "Karate3"
    * def bookingID = response.bookingid

    # Elimina la reserva creada con assertion de respuesta
    Given header Accept = "application/json"
    And path "booking/", bookingID
    When method DELETE
    Then status 201
    And match response == "Created"