 @Device_Reachability_Status_Sanity
 Feature: CAMARA Device Reachability Status API, v0.6.0 - Operations Device Status Check
 
  # Input to be provided by the implementation to the tests
  # References to OAS spec schemas refer to schemas specifies in device-reachability-status.yaml, version v0.6.0

  Background: Common Device Reachability status setup
    Given the resource "/device-reachability-status/v0/retrive"                                                              |
    And the header "Content-Type" is set to "application/json"
	And the header "x-correlator" is set to a UUID value
    And the header "Authorization" is set to a valid access token
    And the requestbody is set by default to a requestbody compliant with the schema
	
	
 @Device_Reachability_Status_01_ReachabilityStatusConnectedSMS
  Scenario: Check device reachability synchronously if the device is connected for SMS usage
    Given Use BaseURL
    When request reachability status for "$.phonenumber" is set to a valid testing device supported by the service
	Then response code is 200
	And the response property "$.status" is 200
    And the response property "$.code" is "OK"
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ReachabilityStatusResponse"
	And the reachability status is CONNECTED_SMS

  @Device_Reachability_Status_02_Status_ConnectedData
  Scenario: Check device reachability synchronously if the device is connected for Data usage
    Given Use BaseURL
    When request reachability status for "$.phonenumber" is set to a valid testing device supported by the service
    Then response code is 200
    And the response property "$.status" is 200
    And the response property "$.code" is "OK"
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ReachabilityStatusResponse"
	Then the reachability status is CONNECTED_DATA

  @Device_Reachability_Status_03_Status_NotConnected
  Scenario: Check device reachability synchronously if the device is not connected to network
    Given Use BaseURL
    When request reachability status for "$.phonenumber" is set to a valid testing device supported by the service
    Then response code is 200
	And the response property "$.status" is 200
    And the response property "$.code" is "OK"
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ReachabilityStatusResponse"
	And the reachability status is NOT_CONNECTED
	
 @Device_Reachability_Status_04_Status_ConnectedSMS_Service_unavailable
  Scenario: Check device reachability synchronously if the device is connected for SMS usage & Service_unavailable
    Given Use BaseURL
    When request reachability status for "$.phonenumber" is set to a valid testing device supported by the service 
    Then response code is 503
	And the response property "$.status" is 503
    And the response property "$.code" is "UNAVAILABLE"
    And the response property "$.message" contains a user friendly text
	
 @Device_Reachability_Status_05_Status_ConnectedSMS_Service_bad_request
  Scenario: Check device reachability synchronously if the device is connected for SMS usage & device parameter values not present/invalid values
    Given Use BaseURL
    When request reachability status for "$.phonenumber" is set to a invalid testing device not supported by the service 
    Then response code is 400
	And the response property "$.status" is 400
    And the response property "$.code" is "BAD_REQUEST"
    And the response property "$.message" contains a user friendly text
	
 @Device_Reachability_Status_06_Status_ConnectedSMS_Token_expired
  Scenario: Check device reachability synchronously if the device is connected for SMS usage & device parameter values not present/invalid values
    Given Use BaseURL
    When request reachability status for "$.phonenumber" is set to a valid testing device supported by the service
    Then response code is 401
	And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHORIZED"
    And the response property "$.message" contains a user friendly text
	
 @Device_Reachability_Status_07_ConnectedSMS_phonenumber_Not_available
  Scenario: Check device reachability synchronously if the device is connected for SMS usage & phonenumber not available
    Given Use BaseURL
    When request reachability status for "$.phonenumber" is set to a invalid testing device not available by the service
    Then response code is 404
	And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text
	
 @Device_Reachability_Status_07_ConnectedSMS_Get_Method_call
   Scenario: Check device reachability synchronously if the device is connected for SMS usage & invalid method 
    Given Use BaseURL
    When get method request reachability status for "$.phonenumber"
    Then response code is 405
	And the response property "$.status" is 405
    And the response property "$.code" is "METHOD_NOT_ALLOWED"
    And the response property "$.message" contains a user friendly text
