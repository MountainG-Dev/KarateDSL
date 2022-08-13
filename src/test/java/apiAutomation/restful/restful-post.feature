@restful-post
Feature: POST API Test
  Esta es la prueba de automatización de API para el metodo POST

  # IMPORTANTE CAMBIAR VARIABLE GLOBAL DE AMBIENTE RESTFUL
  # IMPORTANTE CAMBIAR PATH DE VALIDADOR DE DATA GENERATOR
  # METODO POST
  Background: Define URL y consulta Token de sesión
    * url apiURLRestful

    # Creación de objetos JSON normal y con uso de generador de data
    * def bookingRequestBody1 = read("classpath:apiAutomation/restful/json/nuevaReservaRequest.json")
    * def bookingRequestBody2 = read("classpath:apiAutomation/restful/json/nuevaReservaRequest.json")
    * def dataGenerator = Java.type("apiAutomation.helpers.DataGenerator")

    # Incrustar variables definidas a JSON Object
    * set bookingRequestBody2.firstname = dataGenerator.getRandomBookingValues().firstname
    * set bookingRequestBody2.lastname = dataGenerator.getRandomBookingValues().lastname
    * set bookingRequestBody2.totalprice = dataGenerator.getRandomBookingValues().totalprice
    * set bookingRequestBody2.depositpaid = dataGenerator.getRandomBookingValues().depositpaid
    * set bookingRequestBody2.bookingdates.checkin = dataGenerator.getRandomBookingValues().checkin
    * set bookingRequestBody2.bookingdates.checkout = dataGenerator.getRandomBookingValues().checkout
    * set bookingRequestBody2.additionalneeds = dataGenerator.getRandomBookingValues().additionalneeds

  @tag1
  Scenario: Test Case 01 / Crear una nueva reserva con assertion de validación y Json body
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

  @tag2
  Scenario: Test Case 02 / Crear una nueva reserva con assertion de validación desde archivo json
    Given header Accept = "application/json"
    And path "booking"
    And request bookingRequestBody1
    When method POST
    Then status 200
    And match response.booking.firstname == "Karate3"

  @tag3
  Scenario: Test Case 03 / Crear una nueva reserva con assertion de validación y comparación desde JSON Object
    Given header Accept = "application/json"
    And path "booking"
    And request bookingRequestBody2
    When method POST
    Then status 200
    And match response.booking.firstname == bookingRequestBody.firstname
    And match response.booking.totalprice == bookingRequestBody.totalprice
    And match response.booking.depositpaid == bookingRequestBody.depositpaid
    And match response.booking.bookingdates.checkin == dataGenerator.getRandomBookingValues().checkin

