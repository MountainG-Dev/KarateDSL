@restful-delete
Feature: DELETE API Test
  Esta es la prueba de automatización de API para el metodo DELETE

  # IMPORTANTE CAMBIAR VARIABLE GLOBAL DE AMBIENTE RESTFUL
  # METODO DELETE
  Background: Define URL y consulta Token de sesión
    Given header Content-Type = "application/json"
    And url apiURLRestful

  @tag1
  Scenario: Test Case 01 / Elimina una reserva creada
    # Elimina la reserva creada con assertion de respuesta
    Given header Accept = "application/json"
    And path "booking/", 6736
    When method DELETE
    Then status 201
    And match response == "Created"

  @tag2
  Scenario: Test Case 02 / Crear y eliminar una nueva reserva con assertion de validación
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

    # Validar reserva creada con assertion en campo firstname
    Given header Accept = "application/json"
    And path "booking/", bookingID
    When method GET
    Then status 200
    And match response.firstname == "Karate3"

    # Elimina la reserva creada con assertion de respuesta
    Given header Accept = "application/json"
    And path "booking/", bookingID
    When method DELETE
    Then status 201
    And match response == "Created"

    # Valida que reserva creada en un inicio, no se encuentre contenida en el array de objetos filtrado de entre fechas
    Given header Accept = "application/json"
    And path "booking"
    And params {checkin:2022-08-04, checkout:2022-08-06}
    When method GET
    Then status 200
    And match response[*].bookingid !contains + bookingID
#    And match response contains {"bookingid":4445}  // Casos de prueba




