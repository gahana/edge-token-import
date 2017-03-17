Feature: An external access token can be imported into Edge and used on APIs

Scenario: A resource call should fail without access token
  When I GET /edge-utils/v1/import-token-test
  Then response code should be 401
    And response body should not contain Imported access token works!

Scenario: Importing a client credentials token with valid parameters
	Given I set query parameters to
      | parameter             | value              |  
      | external_access_token | mytoken-001        |  
    And I set form data to
      | name                  | value              |  
      | client_id             | `APP_KEY`          |  
      | grant_type            | client_credentials |  
  When I POST to /edge-utils/v1/import-token
  Then response code should be 200
    And response body path $.access_token should be mytoken-001
    And I store the value of body path $.access_token as access token

Scenario: A resource call should succeed with imported access token
  Given I set bearer token
  When I GET /edge-utils/v1/import-token-test
  Then response code should be 200
    And response body should contain Imported access token works!
