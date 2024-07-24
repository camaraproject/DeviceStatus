
@DeviceRoamingStatusSanity
Feature: CAMARA Device Roaming Status API, v0.6.0 - Operations Device Status

  # Input to be provided by the implementation to the tests
  # References to OAS spec schemas refer to schemas specifies in device-roaming-status.yaml, version v0.6.0

  Background: Common Device Roaming status setup
    Given the resource "/device-roaming-status/v0/retrieve"                                                              |
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
	And the header "x-correlator" is set to a UUID value
    And the request body is set by default to a request body compliant with the schema
	
	
  @Device_Roaming_Status_01_RoamingStatusTrue
  Scenario: Check the roaming state and the country information synchronously if the device is in the roaming mode
    Given Use BaseURL
    When Request roaming status for "$.msisdn"
    Then Response code is 200
	And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/RoamingStatusResponse"
	And the response property "$.status" is 200
    And the response property "$.code" is "OK"
    And the response property "$.message" contains a user friendly text
    Then The roaming status is true

  @Device_Roaming_Status_02_RoamingStatusFalse
  Scenario: Check the roaming state synchronously if the device is not in the roaming mode
    Given Use BaseURL
    When request roaming status for "$.msisdn"
    Then response code is 200
    Then the roaming status is false

  @Device_Roaming_Status_03_DeviceStatus_WithoutDoubleQuoteInMsisdn
  Scenario: Device status request with missing double quote in json request body
    Given Use BaseURL
    When Request device status with missing double quote in json payload
    Then Response code is 400
	And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text
	And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/RoamingStatusResponse"

  @Device_Roaming_Status_04_DeviceStatusWithMissingBracket
  Scenario: Device status request with missing bracket in json request
    Given Use BaseURL
    When Request device status with missing bracket in json payload
    Then Response code is 400
	And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @Device_Roaming_Status_05_DeviceStatusWithIncorrectEventType
  Scenario: Device status request with incorrect EventType
    Given Use BaseURL
    When Request device status with with incorrect EventType
    Then Response code is 400
	And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @Device_Roaming_Status_06_DeviceStatusWithIncorrectIpAddress
  Scenario: Device status request with incorrect ipaddress
    Given Use BaseURL
    When Request device status with incorrect ipaddress in json payload
    Then Response code is 400
	And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @Device_Roaming_Status_07_DeviceStatusWithIncorrectHTTPMethod
  Scenario: Device status request with incorrect HTTP request method
    Given Use BaseURL
    When Put request for DeviceStatus Status
    Then Response code is 405
	And the response property "$.status" is 405
    And the response property "$.code" is "Method_Not_Allowed"
    And the response property "$.message" contains a user friendly text

 @Device_Roaming_Status_08_DeviceStatusServiceUnavailable
  Scenario: Server not available
	  Given Use the BaseURL
      Test for Create when service unavailable
      When Verify DeviceStatus with valid msisdn when service is not available
      Then Response code is 503
	  And the response property "$.status" is 503
      And the response property "$.code" is "Service_Unavailable"
      And the response property "$.message" contains a user friendly text
