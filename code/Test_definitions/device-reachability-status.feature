
@Device_reachability_status
Feature: CAMARA Device reachability status API, v0.6.0 - Operations for reachability status

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specifies in device-reachability-status.yaml, version vwip

  Background: Common Device reachability status setup
    Given the resource "{api-root}/device-reachability-status/vwip/retrieve" set as base-url
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
	
############# Happy Path Scenarios ##################	

  @device_reachability_status_01_reachableAndConnectedSms
  Scenario: Check the reachability status if device is connected with SMS
    Given a valid device reachability status request body 
    And the request body property "$.device" is set to a valid testing device which is connected with sms and supported by the service
    When the request "getReachabilityStatus" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ReachabilityStatusResponse"
    And the response property "$.reachable" is true
    And the response property "$.connectivity" includes "SMS"

  @device_reachability_status_02_reachableAndConnectedData
  Scenario: Check the reachability status if device is connected with DATA
    Given a valid device reachability status request body
    And the request body property "$.device" is set to a valid testing device which is connected with data and supported by the service
    When the request "getReachabilityStatus" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ReachabilityStatusResponse"
    And the response property "$.reachable" is true
    And the response property "$.connectivity" includes "DATA"

  @device_reachability_status_03_reachableAndConnectedDataAndSms
  Scenario: Check the reachability status if device is connected with DATA and SMS
    Given a valid device reachability status request body
    And the request body property "$.device" is set to a valid testing device which is connected with both data and sms, and supported by the service
    When the request "getReachabilityStatus" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ReachabilityStatusResponse"
    And the response property "$.reachable" is true
    And the response property "$.connectivity" includes both "DATA" and "SMS"
	
  @device_reachability_status_04_notReachable
  Scenario: Check the reachability status for an unreachable device
    Given a valid device reachability status request body 
    And the request body property "$.device" is set to a valid testing device which is not connected and supported by the service
    When the request "getReachabilityStatus" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ReachabilityStatusResponse"
    And the response property "$.reachable" is false
    And the response property "$.connectivity" is not returned
	
#############Error Response Scenarios##################
	
  @device_reachability_status_05_deviceStatus_with_invalid_parameter
  Scenario: Device reachability status request with invalid parameter 
    Given the request body is not compliant with the schema "/components/schemas/RequestReachabilityStatus"
    When the request "getReachabilityStatus" is sent
    Then Response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @device_reachability_status_06_expired_access_token
  Scenario: Expired access token
    Given a valid device reachability status request body 
    And header "Authorization" is set to expired token
    When the request "getReachabilityStatus" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text
	
  @device_reachability_status_07_no_authorization_header
  Scenario: No Authorization header
    Given a valid device reachability status request body 
    And header "Authorization" is not available
    When the request "getReachabilityStatus" is sent 
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text
	
  @device_reachability_status_08_invalid_access_token
  Scenario: Invalid access token
    Given a valid device reachability status request body 
    And header "Authorization" set to an invalid access token
    When the request "getReachabilityStatus" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text
	
  @device_reachability_status_09_deviceStatus_inconsistent_access_token
  Scenario: Inconsistent access token context for the device
    # To test this, a token has to be obtained for a different device
    Given a valid device reachability status request body
    And the request body property "$.device" is set to a valid testing device supported by the service
    And header "Authorization" set to access token referring different device
    When the request "getReachabilityStatus" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text
	
  @device_reachability_status_10_deviceStatusWithIdentifiersMismatch
  Scenario: Device reachabilityidentifiers mismatch
    # To test this, at least 2 types of identifiers have to be provided, e.g. a phoneNumber and the IP address of a Device reachability associated to a different phoneNumber
    Given a valid device reachability status request body 
    And the request body property "$.device" includes several identifiers, each of them identifying a valid but different device
    When the request "getReachabilityStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "DEVICE_IDENTIFIERS_MISMATCH"
    And the response property "$.message" contains a user friendly text

  @device_reachability_status_11_deviceStatus_NotApplicable
  Scenario: Device reachability not applicable
    Given a valid device reachability status request body 
    And the request body property "$.device" refers to an unknown device
    When the request "getReachabilityStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "DEVICE_NOT_APPLICABLE"
    And the response property "$.message" contains a user friendly text

  @device_reachability_status_12_unable_to_provide_reachability_status
  Scenario: Unable to provide reachability status for a device
    Given a valid device reachability status request body 
    And the request body property "$.device" refers to a device having network issue
    When the request "getReachabilityStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNABLE_TO_PROVIDE_REACHABILITY_STATUS"
    And the response property "$.message" contains a user friendly text

  @device_reachability_status_13_unsupported_device_identifiers
  Scenario: Unsupported device identifiers
    Given a valid device reachability status request body
    And the request body property "$.device" set to unsupported identifiers value for the service
    When the request "getReachabilityStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNSUPPORTED_DEVICE_IDENTIFIERS"
    And the response property "$.message" contains a user friendly text
