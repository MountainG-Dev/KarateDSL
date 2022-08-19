@conduit-hooks
Feature: Hooks

  Background: hooks
  # BEFORE HOOKS
    * def result = callonce read("classpath:apiAutomation/helpers/dummy.feature")
    * def username = result.username

  # AFTER HOOKS
    * configure afterScenario = function(){ karate.call("classpath:apiAutomation/helpers/dummy.feature") }
    * configure afterFeature =
  """
       function(){
             karate.log("After Feature Text")
       }
  """


  Scenario: First scenario
    * print "username"
    * print "This is first scenario"

  Scenario: Second scenario
    * print "username"
    * print "This is second scenario"