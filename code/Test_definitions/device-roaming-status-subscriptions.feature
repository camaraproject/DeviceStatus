 
 @DeviceStatusRoamingSubscriptionSanity
  Feature: CAMARA Device Roaming Status Subscriptions API, v0.6.0 - Operation DeviceStatus
  
  
  # Input to be provided by the implementation to the tests
  # References to OAS spec schemas refer to schemas specifies in device-roaming-status-subscriptions.yaml, version v0.6.0

  Background: Common roaming status subscriptions setup
    Given the resource "/device-roaming-status-subscriptions/v0/subscriptions" as BaseURL                                                           |
    And the header "Content-Type" is set to "application/json"
	And the header "x-correlator" is set to a UUID value
    And the header "Authorization" is set to a valid access token
    And the request body is set by default to a request body compliant with the schema
	
	
  
  @Device_Roaming_Status_Subscription_01_InRoamingEvent
  Scenario: Check roaming event if the device roaming state changed to 'true'
    Given use BaseURL
    When create device status subscription for "$.msisdn1" and roaming-status event
    Then response code is 201
	And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
	And the response property "$.status" is 201
    And the response property "$.code" is "CREATED"
    Then get device status subscription
    Then response code is 200
    When wait 10 seconds
    Then the callback notification application receives roaming-status event
    Then the roaming status is true
    Then the country name is
      | DG |
      | GU |
      | US |
    Then the country code is 310
    When delete device status subscription
    Then response code is 204

  @Device_Roaming_Status_Subscription_02_NotInRoamingEvent
  Scenario: Check roaming event if the device roaming state changed to 'false'
    Given use BaseURL
    When create device status subscription for "$.msisdn2" and roaming-status event
    Then response code is 201
    Then get device status subscription
    Then response code is 200
    When wait 10 seconds
    Then the callback notification application receives roaming-status event
    Then the roaming status is false
    Then the country name is
      | DG |
      | GU |
      | US |
    Then the country code is 310
    When delete device status subscription
    Then response code is 204

  @Device_Roaming_Status_Subscription_03_CountryChangeEvent
  Scenario: Check the country code event if the device in roaming changes a country
    Given use BaseURL
    When create device status subscription for "$.msisdn3" and change-country event
    Then response code is 201
    Then get device status subscription
    Then response code is 200
    When wait 10 seconds
    Then the callback notification application receives change-country event
    Then the country name is
      | DE |
    Then the country code is 262
    When delete device status subscription
    Then response code is 204

  @Device_Roaming_Status_Subscription_04_SubscriptionEndsEvent
  Scenario: Check device status subscription ends event
    Given use BaseURL
    When create device status subscription for duration of 2 seconds
    Then response code is 201
    Then get device status subscription
    Then response code is 200
    When wait 10 seconds
    Then the callback notification application receives subscription-ends event
    Then get device status subscription
    Then response code is 404


  @Device_Roaming_Status_Subscription_05_getSubscriptions
  Scenario: get all device status event subscriptions
    Given use BaseURL
    When create device status subscription for a valid access token with client-id-1, "$.msisdn1" and change-country event
    Then response code is 201
    When create device status subscription for a valid access token with client-id-1, "$.msisdn2" and roaming-status event
    Then response code is 201
    When create device status subscription for a valid access token with client-id-2, "$.msisdn3" and connectivity-sms event
    Then response code is 201
    When get all device status subscriptions for client-id-1
    Then response code is 200
    Then Number of subscriptions of client-id-1 is 2
    When get all device status subscriptions for client-id-2
    Then response code is 200
    Then Number of subscriptions of client-id-2 is 1
    Then delete subscriptions

  @Device_Roaming_Status_Subscription_06_getSubscriptionsForNotExistingSubscription
  Scenario: get all device status subscriptions for a client that does not have any subscriptions
    Given use BaseURL
    When create device status subscription for a valid access token with client-id-1, "$.msisdn1" and connectivity-data event
    Then response code is 201
    When get all device status subscriptions for client-id-2
    Then response code is 404
    Then Number of subscriptions of client-id-2 is 0
    Then delete subscriptions
	And Respone code is 204

  @Device_Roaming_Status_Subscription_07_getSubscriptionsForInvalidToken
  Scenario: get all device status subscriptions for an invalid access token
    Given use BaseURL
    When create device status subscription for a valid access token with client-id-1, "$.msisdn2" and change-country event
    Then response code is 201
    When get all device status subscriptions for an invalid access token
    Then response code is 403
    Then delete subscriptions
	And Respone code is 204

  @Device_Roaming_Status_Subscription_08_DeviceIncorrectMsisdn
  Scenario: Device status request for an incorrect msisdn
    Given use BaseURL
    When Request device status with incorrect msisdn in json payload
    Then response code is 400
	And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @Device_Roaming_Status_Subscription_09_DeviceForPastSubscriptionExpirationTime
  Scenario: Device status request for past subscriptionExpireTime
    Given use BaseURL
    When Request create device status subscription for subscriptionExpireTime in th past
    Then response code is 400
	And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @Device_Roaming_Status_Subscription_10_DeviceWithNoMsisdn
  Scenario: Device status request without MSISDN
    Given use BaseURL
    When Request create device status subscription without MSISDN
    Then response code is 400
	And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text
 
