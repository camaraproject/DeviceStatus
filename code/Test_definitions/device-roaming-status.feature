
@Device_Roaming_Status
Feature: CAMARA Device Roaming Status API, v0.6.0 - Operations for Roaming Status

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specifies in device-roaming-status.yaml, version v0.6.0

  Background: Common Device Roaming status setup
    Given the resource "{api-root}/device-roaming-status/v0.6/retrieve" set as base-url                                                             |
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
	
#############Happy Path Scenarios##################	

  @device_roaming_status_01_roaming_status_true
  Scenario: Check the roaming status when device is in the roaming mode
    Given the request body property "$.phoneNumber" is set to valid value
    When the  request "getRoamingStatus" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/RoamingStatusResponse"
    And the response property "$.status" is 200
    And the response property "$.code" is "OK"
    And the response property "$.message" contains a user friendly text
    Then the roaming status is true

  @device_roaming_status_02_roaming_status_false
  Scenario: Check the roaming state synchronously if the device is not in the roaming mode
    Given a valid devicestatus request body with "$.phoneNumber"
    When the request "getRoamingStatus" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/RoamingStatusResponse"
    And the response property "$.status" is 200
    And the response property "$.code" is "OK"
    Then the roaming status is false

#############Error Response Scenarios##################
	
  @device_roaming_status_03_deviceStatus_with_invalid_parameter
  Scenario: Device status request with invalid parameter 
    Given the request body is not compliant with the schema "/components/schemas/RequestRoamingStatus"
    When the request "getRoamingStatus" is sent
    Then Response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @device_roaming_status_04_expired_access_token
   Scenario: Expired access token
    Given a valid devicestatus request body and header "Authorization" is expired
    When the  request "getRoamingStatus" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text
	
  @device_roaming_status_05_no_authorization_header
   Scenario: No Authorization header
    Given a valid devicestatus request body and header "Authorization" is not available
    When the  request "getRoamingStatus" is sent 
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text
	
  @device_roaming_status_06_invalid_access_token
   Scenario: Invalid access token
    Given a valid devicestatus request body and header "Authorization" set to an invalid access token
    When the  request "getRoamingStatus" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text
	
  @device_roaming_status_07_deviceStatus_inconsistent_access_token
   Scenario: Inconsistent access token context for the device
    # To test this, a token has to be obtained for a different device
    Given a valid subscription request body with "$.phoneNumber" and token from different device
    When the request "getRoamingStatus" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text
	
  @device_roaming_status_08_deviceStatusWithIdentifiersMismatch
    Scenario: Device identifiers mismatch
    # To test this, at least 2 types of identifiers have to be provided, e.g. a phoneNumber and the IP address of a device associated to a different phoneNumber
    Given a valid devicestatus request body with the request body property "$.device" includes several identifiers, each of them identifying a valid but different device
    When the request "getRoamingStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "DEVICE_IDENTIFIERS_MISMATCH"
    And the response property "$.message" contains a user friendly text
