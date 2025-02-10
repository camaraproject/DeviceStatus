
@Device_Roaming_Status
Feature: CAMARA Device Roaming Status API, v1.0.0-rc.1 - Operations for Roaming Status

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specifies in device-roaming-status.yaml, version vwip

  Background: Common Device Roaming status setup
    Given the resource "{api-root}/device-roaming-status/vwip/retrieve" set as base-url
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
	
#############Happy Path Scenarios##################	

  @device_roaming_status_01_roaming_status_true
  Scenario: Check the roaming status when device is in the roaming mode
    Given a valid devicestatus request body 
    And the request body property "$.device" is set to a valid testing device which is in roaming and supported by the service
    When the request "getRoamingStatus" is sent
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
    Given a valid devicestatus request body 
    And the request body property "$.device" is set to a valid testing device which is not in roaming and supported by the service
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

  @device_roaming_status_04_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is set to a valid request body
    When the HTTP "getRoamingStatus" request is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @device_roaming_status_05_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the request body is set to a valid request body
    When the HTTP "getRoamingStatus" request is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @device_roaming_status_06_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the request body is set to a valid request body
    When the HTTP "getRoamingStatus" request is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text
	
  @device_roaming_status_07_permissions_denied
  Scenario: Client does not have sufficient permissions to perform this action
    # To test this, a token has to be obtained for a different device
    Given the header "Authorization" is set to an invalid access token
    And the request body is set to a valid request body
    When the request "getRoamingStatus" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text
	
  @device_roaming_status_08_deviceStatusWithIdentifiersMismatch
  Scenario: Device identifiers mismatch
    # To test this, at least 2 types of identifiers have to be provided, e.g. a phoneNumber and the IP address of a device associated to a different phoneNumber
    Given a valid devicestatus request body 
    And the request body property "$.device" includes several identifiers, each of them identifying a valid but different device
    When the request "getRoamingStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "DEVICE_IDENTIFIERS_MISMATCH"
    And the response property "$.message" contains a user friendly text

  @device_roaming_status_09_device_not_supported
  Scenario: Service not available for the device
    Given that the service is not available for all devices commercialized by the operator
    And a valid device, identified by the token or provided in the request body, for which the service is not applicable
    When the request "getRoamingStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
    And the response property "$.message" contains a user friendly text

  @device_roaming_status_10_unnecessary_device
  Scenario: Device not to be included when it can be deduced from the access token
    # This test applies whether the device associated with the access token matches the explicit device identifier or not
    # For 3-legged access tokens, an explicit device identifier MUST NOT be provided
    Given the header "Authorization" is set to a valid access token identifying a device
    And the request body property "$.device" is set to a valid device (which may or may not be the same device)
    When the request "getRoamingStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  @device_roaming_status_11_unable_to_provide_roaming_status
  Scenario: Unable to provide roaming status for a device
    Given a valid devicestatus request body
    And the request body property "$.device" refers to a device having network issue
    When the request "getRoamingStatus" is sent
    Then the response status code is 503
    And the response property "$.status" is 503
    And the response property "$.code" is "UNAVAILABLE"
    And the response property "$.message" contains a user friendly text
