Feature: Add likes

  Background:
    * url apiURLConduit

    Scenario: add likes
      Given path "articles/" + slugVAR + "/favorite"
      And request {}
      When method POST
      Then status 200
      * def likesCount = response.article.favoritesCount