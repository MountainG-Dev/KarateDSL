@conduit-homework
Feature: Home Work

    # IMPORTANTE CAMBIAR VARIABLE GLOBAL DE AMBIENTE CONDUIT
    # IMPORTANTE CAMBIAR PATH DE VALIDADOR DE TIEMPO
    Background: Preconditions
      * header Content-Type = "application/json"
      * url apiURLConduit
      * def timeValidator = read("classpath:apiAutomation/helpers/timeValidator.js")

    @tag1
    Scenario: Favorite articles

    # Step 1: Get articles of the global feed
      Given path "articles"
      And params {limit:10, offset:0}
      When method GET
      Then status 200
      * print response

    # Step 2: Get the favorites count and slug ID for the first article, save it into variables
      * def favoritesVAR = response.articles[0].favoritesCount
      * def slugVAR = response.articles[0].slug
      * print favoritesVAR
      * print slugVAR

    # Step 3: Make POST request to incrase favorites count for the first article
      Given path "articles/" + slugVAR + "/favorite"
      And request {}
      When method POST
      Then status 200
      * print response

    # Step 4: Verify response schema
      # CUANDO EL RESPONSE CONTIENE UN SOLO OBJETO SE COMPARA DIRECTAMENTE
      And match response.article ==
      """
          {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
              "username": "#string",
              "bio": "##string",
              "image": "#string",
              "following": "#boolean"
            }
          }
      """

    # Step 5: Verify that favorites article incremented by 1
    # Example
#       * def initialCount = 0
#       * def response = {"favoritesCount": 1}
#       * match response.favoritesCount == initialCount + 1
      * def favoritesVAR2 = response.article.favoritesCount
      * match favoritesVAR2 == favoritesVAR + 1

    # Step 6: Get all favorite articles
      Given path "articles"
      And params {favorited:Karate30, limit:10 ,offset:0}
      When method GET
      Then status 200
      * print response

    # Step 7: Verify response schema
      # MATCH EACH SE UTILIZA CUANDO EL RESPONSE CONTIENE VARIOS OBJETOS CON EL MISMO ESQUEMA
      And match each response.articles ==
      """
          {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
              "username": "#string",
              "bio": "##string",
              "image": "#string",
              "following": "#boolean"
            }
          }
      """

    # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
      * match response.articles[*].slug contains slugVAR

   # Step 9: Delete favorites count made
      Given path "articles/" + slugVAR + "/favorite"
      When method DELETE
      Then status 200
      * print response


    @tag2
    Scenario: Comment articles

    # Step 1: Get articles of the global feed
      Given path "articles"
      And params {limit:10, offset:0}
      When method GET
      Then status 200
      * print response

    # Step 2: Get the slug ID for the second article, save it to variable
      * def slugVAR2 = response.articles[1].slug
      * print slugVAR2

    # Step 3: Make a GET call to 'comments' end-point to get all comments
      Given path "articles/" + slugVAR2 + "/comments"
      When method GET
      Then status 200
      * print response

    # Step 4: Verify response schema
    And match response.comments[0] ==
    """
        {
          "id": "#number",
          "createdAt": "#? timeValidator(_)",
          "updatedAt": "#? timeValidator(_)",
          "body": "#string",
          "author": {
            "username": "#string",
            "bio": "##string",
            "image": "#string",
            "following": "#boolean"
          }
        }
    """

    # Step 5: Get the count of the comments array length and save to variable
        # Example
#           * def responseWithComments = [{"article": "first"}, {article: "second"}]
#           * def articlesCount = responseWithComments
     * def articlesCount = response.comments.length
     * print articlesCount

    # Step 6: Make a POST request to publish a new comment
      * def bodyRequest = "bla bla"
      Given path "articles/" + slugVAR2 + "/comments"
      And request
      """
          {
            "comment":{
              "body":"#(bodyRequest)"
            }
          }
      """
      When method POST
      Then status 200
      * print response
      * def commentID = response.comment.id

    # Step 7: Verify response schema that should contain posted comment text
      And match response.comment[*] contains bodyRequest

    # Step 8: Get the list of all comments for this article one more time
      Given path "articles/" + slugVAR2 + "/comments"
      When method GET
      Then status 200
      * print response

    # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)
      * def articlesCount2 = response.comments.length
      * match articlesCount2 == articlesCount + 1
      * print articlesCount2

    # Step 10: Make a DELETE request to delete comment
      Given path "articles/" + slugVAR2 + "/comments/" + commentID
      When method DELETE
      Then status 200
      * print response

    # Step 11: Get all comments again and verify number of comments decreased by 1
      Given path "articles/" + slugVAR2 + "/comments"
      When method GET
      Then status 200
      * print response

      * def articlesCount3 = response.comments.length
      * match articlesCount3 == articlesCount2 - 1
      * print articlesCount3