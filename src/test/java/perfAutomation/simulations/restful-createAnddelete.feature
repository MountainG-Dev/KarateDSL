@restful-createanddelete
Feature: CREATE AND DELETE API Restful Test Performance
  Esta es la prueba de automatización de API para el metodo PUT Y DELETE MÁS GATLING

  # IMPORTANTE CAMBIAR VARIABLE GLOBAL DE AMBIENTE RESTFUL
  # METODO DELETE
  Background: Define URL y consulta Token de sesión
    Given header Content-Type = "application/json"
    And url apiURLRestful

    * def bookingRequestBody = read("classpath:apiAutomation/restful/json/nuevaReservaRequest.json")
    * def dataGenerator = Java.type("apiAutomation.helpers.DataGenerator")

    * set bookingRequestBody.firstname = __gatling.Tittle
    * set bookingRequestBody.lastname = __gatling.Description
    * set bookingRequestBody.totalprice = dataGenerator.getRandomBookingValues().totalprice
    * set bookingRequestBody.depositpaid = dataGenerator.getRandomBookingValues().depositpaid
    * set bookingRequestBody.bookingdates.checkin = dataGenerator.getRandomBookingValues().checkin
    * set bookingRequestBody.bookingdates.checkout = dataGenerator.getRandomBookingValues().checkout
    * set bookingRequestBody.additionalneeds = dataGenerator.getRandomBookingValues().additionalneeds

  @tag1
  Scenario: CreateDelete
    # Crear reserva
    Given header Accept = "application/json"
    And path "booking"
    And request bookingRequestBody
    When method POST
    Then status 200
    And match response.booking.firstname == bookingRequestBody.firstname
    * def bookingID = response.bookingid

#    # Simulación de tiempo de usuario gatling performance test
#    * karate.pause(5000)
#
    # Elimina la reserva creada con assertion de respuesta
    Given header Accept = "application/json"
    And path "booking/", bookingID
    When method DELETE
    Then status 201
    And match response == "Created"