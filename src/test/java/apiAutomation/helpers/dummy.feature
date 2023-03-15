Feature: Dummy

  Scenario: Dummy
    * def dataGenerator = Java.type("apiAutomation.helpers.DataGenerator")
    * def username = dataGenerator.getRandomUsername()
    * print username
