
@DeviceReachabilityStatusSubscriptionSanity
 Feature: CAMARA Device Reachability Status Subscriptions API, v0.6.0 - Operations Device Status
 
 
  # Input to be provided by the implementation to the tests
  # References to OAS spec schemas refer to schemas specifies in device-reachability-status-subscriptions.yaml, version v0.6.0

  Background: Common Device Reachability Status Subscriptions setup
    Given the resource "/device-reachbility-status-subscriptions/v0/subscriptions"  as BASEURL                                                            |
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is set by default to a request body compliant with the schema
	
  @Device_Reachability_Status_Subscriptions_01_DataEvent
  Scenario: Check reachability  event if the device reachability  is changed to Data usage
    Given Use BaseURL
    When Create device status subscription for "$msisdn1" and connectivity-data event
    Then Response code is 201
    Then Get device status subscription
    Then Response code is 200
    When Wait 10 seconds
    Then The callback notification application receives connectivity-data event
    When Delete device status subscription
    Then Response code is 204
	And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"

  @Device_Reachability_Status_Subscriptions_02_ConnectivitySmsEvent
  Scenario: Check reachability  event if the device reachability  is changed to SMS usage
    Given Use BaseURL
    When Create device status subscription for MSISDN "$msisdn2" and connectivity-sms event
    Then Response code is 201
    Then Get device status subscription
    Then Response code is 200
    When Wait 10 seconds
    Then The callback notification application receives connectivity-sms event
    When Delete device status subscription
    Then Response code is 204
	And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"

  @Device_Reachability_Status_Subscriptions_03_ConnectivityDisconnectedEvent
  Scenario: Check reachability  event if the device reachability  is changed to disconnected
    Given Use BaseURL
    When Create device status subscription for MSISDN "$msisdn3" and connectivity-disconnected event
    Then Response code is 201
    Then Get device status subscription
    Then Response code is 200
    When Wait 10 seconds
    Then The callback notification application receives connectivity-disconnected event
    When Delete device status subscription
    Then Response code is 204
	And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
	
	
  @Device_Reachability_Status_Subscriptions_04_Retrieve_Subscriptions_for_SMS
  Scenario: Get all device status event subscriptions
    Given Use BaseURL
    When Create device status subscription for a valid access token with client-id-2,"$msisdn2" and connectivity-sms event
    Then Response code is 201
	And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"

  @Device_Reachability_Status_Subscriptions_05_SMS_DisconnectEvent
  Scenario: Receive SMS disconnect event 
    Given Use BaseURL
    When Create device status subscription for a valid access token with client-id-2, "$msisdn3" and connectivity-disconnected event
    Then Response code is 201
	And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
	
 @Device_Reachability_Status_Subscriptions_06_GetSubscriptionsForNotExistingSubscription
  Scenario: Get all device status subscriptions for a client that does not have any subscriptions
    Given Use BaseURL
    When Create device status subscription for a valid access token with client-id-1,  "$msisdn1" and connectivity-data event
    Then Response code is 201
    When Get all device status subscriptions for client-id-2
    Then Response code is 404
    Then Number of subscriptions of client-id-2 is 0
    Then Delete subscriptions

  @Device_Reachability_Status_Subscriptions_07_GetSubscriptionsForInvalidToken
  Scenario: Get all device status subscriptions for an invalid access token
    Given Use BaseURL
    When Create device status subscription for a valid access token with client-id-1, "$msisdn2" and change-country event
    Then Response code is 201
    When Get all device status subscriptions for an invalid access token
    Then Response code is 401
	And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text
    Then Delete subscriptions

  @Device_Reachability_Status_Subscriptions_08_DeviceIncorrectMsisdn
  Scenario: Device status request for an incorrect msisdn
    Given Use BaseURL
    When Request device status with incorrect msisdn in json payload
    Then Response code is 400
	And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @Device_Reachability_Status_Subscriptions_09_DeviceForPastSubscriptionExpirationTime
  Scenario: Device status request for past subscriptionExpireTime
    Given Use BaseURL
    When Request create device status subscription for subscriptionExpireTime in th past
    Then Response code is 400
	And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @Device_Reachability_Status_Subscriptions_10_DeviceWithNoMsisdn
  Scenario: Device status request without MSISDN
    Given Use BaseURL
    When Request create device status subscription without MSISDN
    Then Response code is 400
	And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text
