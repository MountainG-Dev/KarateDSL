@parallel=false
Feature: Login UI Test
  Esta es la prueba de automatización GUI

  @tag1
  Scenario: Test Case 01 / Login con credenciales validas en microsoft edge
    * configure driver = {type: "msedge"}
    Given driver "https://www.saucedemo.com/"
    And input("//input[@id='user-name']", "standard_user")
    And input("//input[@id='password']", "secret_sauce")
    * highlight("//input[@id='login-button']")
    * screenshot()
    When click("//input[@id='login-button']")
    Then match driver.title == "Swag Labs"
    And match driver.url == "https://www.saucedemo.com/inventory.html"

  @tag2
  Scenario: Test Case 02 / Login con credenciales validas en chrome
    * configure driver = {type: "chrome"}
    Given driver "https://www.saucedemo.com/"
    * delay(2000)
    And input("//input[@id='user-name']", "standard_user")
    And input("//input[@id='password']", "secret_sauce")
    When click("//input[@id='login-button']")
    Then match driver.title == "Swag Labs"
    And match driver.url == "https://www.saucedemo.com/inventory.html"

  @tag3
  Scenario: Test Case 03 / Login con credenciales validas en chrome con headless
    * configure driver = {type: "chrome", headless: true}
    Given driver "https://www.saucedemo.com/"
    And input("//input[@id='user-name']", "standard_user")
    And input("//input[@id='password']", "secret_sauce")
    When click("//input[@id='login-button']")
    Then match driver.title == "Swag Labs"
    And match driver.url == "https://www.saucedemo.com/inventory.html"

  @debug
  Scenario: Test Case 04 / Login con credenciales validas en chrome con headless y webdriver
    * def ChromeSession = { capabilities: { browserName: 'chrome', alwaysMatch: { "goog:chromeOptions": { args: [ "-headless" ] } } } }
    * configure driver = {type: "chromedriver", executable: "src/test/drivers/chromedriver.exe", webDriverSession:"#(ChromeSession)" }
    Given driver "https://www.saucedemo.com/"
    And input("//input[@id='user-name']", "standard_user")
    And input("//input[@id='password']", "secret_sauce")
    * screenshot()
    When click("//input[@id='login-button']")
    Then match driver.title == "Swag Labs"
    And match driver.url == "https://www.saucedemo.com/inventory.html"

  @tag5
  Scenario: Test Case 05 / Login con credenciales validas en firefox
    * configure driver = {type: "geckodriver", executable: "src/test/drivers/geckodriver.exe"}
    Given driver "https://www.saucedemo.com/"
    And input("//input[@id='user-name']", "standard_user")
    And input("//input[@id='password']", "secret_sauce")
    When click("//input[@id='login-button']")
    Then match driver.title == "Swag Labs"
    And match driver.url == "https://www.saucedemo.com/inventory.html"

  @debug
  Scenario: Test Case 06 / Login con credenciales validas en firefox con headless
    * def FirefoxSession = { capabilities: { browserName: 'firefox', alwaysMatch: { "moz:firefoxOptions": { args: ["-headless"] } } } }
    * configure driver = {type: "geckodriver", executable: "src/test/drivers/geckodriver.exe", webDriverSession:"#(FirefoxSession)" }
    Given driver "https://www.saucedemo.com/"
    And input("//input[@id='user-name']", "standard_user")
    And input("//input[@id='password']", "secret_sauce")
    When click("//input[@id='login-button']")
    Then match driver.title == "Swag Labs"
    And match driver.url == "https://www.saucedemo.com/inventory.html"
    * delay(2000)
    * screenshot()

  @tag7
  Scenario: Test Case 07 / Login con credenciales validas en docker chrome headless
    * configure driverTarget = { docker: 'justinribeiro/chrome-headless', showDriverLog: false }
    Given driver "https://www.saucedemo.com/"
    And input("//input[@id='user-name']", "standard_user")
    And input("//input[@id='password']", "secret_sauce")
    * screenshot()
    When click("//input[@id='login-button']")
    Then match driver.title == "Swag Labs"
    And match driver.url == "https://www.saucedemo.com/inventory.html"
    And click("//img[@alt='Sauce Labs Backpack']")
    * screenshot()

  @tag8
  Scenario: Test Case 08 / Login con credenciales validas en docker chrome full con video
    * configure driverTarget = { docker: 'ptrthomas/karate-chrome', showDriverLog: false}
    Given driver "https://www.saucedemo.com/"
    And input("//input[@id='user-name']", "standard_user")
    And input("//input[@id='password']", "secret_sauce")
    * screenshot()
    When click("//input[@id='login-button']")
    Then match driver.title == "Swag Labs"
    And match driver.url == "https://www.saucedemo.com/inventory.html"
    And click("//img[@alt='Sauce Labs Backpack']")
    * screenshot()
