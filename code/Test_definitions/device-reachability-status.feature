
@Device_reachability_status
Feature: CAMARA Device reachability status API, v0.6.0 - Operations for reachability status

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specifies in device-reachability-status.yaml, version v0.6.0

  Background: Common Device reachability status setup
    Given the resource "{api-root}/device-reachability-status/v0.6/retrieve" set as base-url                                                             |
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
	
#############Happy Path Scenarios##################	

  @device_reachability_status_01_reachabilityStatusConnectedSms
  Scenario: Check the reachability status if device is connected with SMS
    Given a valid devicestatus request body with "$.phoneNumber"
    When the request "getReachabilityStatus" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ReachabilityStatusResponse"
    And the response property "$.status" is 200
    And the response property "$.code" is "OK"
    And the response property "$.message" contains a user friendly text
    And the response property "$.reachabilityStatus" is "CONNECTED_SMS"

  @device_reachability_status_02_reachabilityStatusConnectedData
  Scenario: Check the reachability status if device is connected with DATA  
    Given a valid devicestatus request body with "$.phoneNumber"
    When the request "getReachabilityStatus" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ReachabilityStatusResponse"
    And the response property "$.status" is 200
    And the response property "$.code" is "OK"
    And the response property "$.reachabilityStatus" is  "CONNECTED_DATA"
	
  @device_reachability_status_03_reachabilityStatusDeviceNotConnected
  Scenario: Check the reachability status for  DeviceNotConnected
    Given a valid devicestatus request body with "$.phoneNumber"
    When the request "getReachabilityStatus" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ReachabilityStatusResponse"
    And the response property "$.status" is 200
    And the response property "$.code" is "OK"
    And the response property "$.reachabilityStatus" is  "NOT_CONNECTED"
	
	
#############Error Response Scenarios##################
	
  @device_reachability_status_04_deviceStatus_with_invalid_parameter
  Scenario: Device reachability status request with invalid parameter 
    Given a valid devicestatus request body with invalid parameter
    When the request "getReachabilityStatus" is sent
    Then Response code is 400
   And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @device_reachability_status_05_expired_access_token
  Scenario: Expired access token
    Given a valid devicestatus request body and header "Authorization" is expired
    When the  request "getReachabilityStatus" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text
	
  @device_reachability_status_06_no_authorization_header
  Scenario: No Authorization header
    Given a valid devicestatus request body and header "Authorization" is not available
    When the  request "getReachabilityStatus" is sent 
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text
	
  @device_reachability_status_07_invalid_access_token
  Scenario: Invalid access token
    Given a valid devicestatus request body and header "Authorization" set to an invalid access token
    When the request "getReachabilityStatus" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text
	
  @device_reachability_status_08_deviceStatus_inconsistent_access_token
   Scenario: Inconsistent access token context for the device
    # To test this, a token have to be obtained for a different device
    Given a valid subscription request body with "$.phoneNumber" and token from different device
    When the request "getReachabilityStatus" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text

  @device_reachability_status_09_deviceStatusWithIncorrectHTTPMethod
   Scenario: Device reachabilitystatus request with incorrect HTTP request method
    Given a valid devicestatus request body with "$.phoneNumber"
    When the "PUT" request "getReachabilityStatus" is sent
    Then Response code is 405
    And the response property "$.status" is 405
    And the response property "$.code" is "Method_Not_Allowed"
    And the response property "$.message" contains a user friendly text
	
  @device_reachability_status_10_deviceStatusWithIdentifiersMismatch
    Scenario: Device reachabilityidentifiers mismatch
    # To test this, at least 2 types of identifiers have to be provided, e.g. a phoneNumber and the IP address of a Device reachability associated to a different phoneNumber
    Given a valid devicestatus request body with "$.phoneNumber" and config_var "identifier_types_unsupported" contains at least 2 items
    And the request body property "$.device" includes several identifiers, each of them identifying a valid but different device
    When the request "getReachabilityStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "DEVICE_IDENTIFIERS_MISMATCH"
    And the response property "$.message" contains a user friendly text
