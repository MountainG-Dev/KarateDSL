@restful-get
Feature: GET API Test Restful
  Esta es la prueba de automatización de API para el metodo GET

  # IMPORTANTE CAMBIAR VARIABLE GLOBAL DE AMBIENTE RESTFUL
  # METODO GET
  Background: Define URL
    Given header Content-Type = "application/json"
    * url apiURLRestful

  @tag1
  Scenario: Test Case 01 / Obtener lista de todos los id de reservas
    Given path "booking"
    When method GET
    Then status 200

  @tag2
  Scenario: Test Case 02 / Obtener lista de id de reserva filtrando parametros por nombre y apellido
    Given path "booking"
    And params {firstname:Karate3, lastname:Karate28}
    When method GET
    Then status 200

  @tag3
  Scenario: Test Case 03 / Obtener lista de id de reserva filtrado parametros por checkin y checkout
    Given path "booking"
    And params {checkin:2022-08-03, checkout:2022-08-03}
    When method GET
    Then status 200

  @tag4
  Scenario: Test Case 04 / Obtener datos de reserva especifico por id
    Given header Accept = "application/json"
    And path "booking/2985"
    When method GET
    Then status 200

  @tag5
  Scenario: Test Case 05 / Obtener datos de reserva especifico por id no encontrado
    Given header Accept = "application/json"
    And path "booking/0"
    When method GET
    Then status 404



