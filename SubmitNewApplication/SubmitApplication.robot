*** Settings ***
Documentation     A test suite with a single Gherkin style test.
...
...               This test is functionally identical to the example in
...               valid_login.robot file.
Resource          resource.robot
Test Teardown     Close Browser

*** Test Cases ***
Submit New Application
    Given Open Application in Browser
    When Allow All cookies
    When Login As User
    When Submit a new application
    When Fill-Out Required Field
    Then Verify Values in Summary Page
    When Click Validate and Send
    Then Validate Thank You Page
