@conduit-workwithdb
Feature: DB API Test Conduit
  Esta es la prueba de automatización de API con conexión a base de datos

  # IMPORTANTE CAMBIAR VARIABLE GLOBAL DE AMBIENTE CONDUIT
  Background: Conectar a BD
    * def dbHandler = Java.type("apiAutomation.helpers.DbHandler")

  @tag1
  Scenario: Test Case 01 / Poblar base de datos con nueva promoción
    * eval dbHandler.addNewPromotionWithName("2023 Spring Promotion")

  @tag2
  Scenario: Test Case 02 / Obtener fechas de la promoción
    * def dates = dbHandler.getStartAndExpiredDateFromPromotions("2023 Spring Promotion")
    * print dates.startDate
    * print dates.expiredDate
    And match dates.startDate == "2023-06-01"
    And match dates.expiredDate == "2023-07-01"