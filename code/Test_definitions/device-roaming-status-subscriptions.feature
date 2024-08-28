 
@DeviceStatusRoamingSubscription
Feature: Device Roaming Status Subscriptions API, v0.6.0 - Operations RoamingStatus 

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specified in device-roaming-status-subscriptions.yaml, version v0.6.0

  Background: Common Device Roaming Status setup
    Given the resource "{apiroot}/device-roaming-status-subscriptions/v0.6" as base-url                                                           
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value

######### Happy Path Scenarios #################################

@roaming_status_subscriptions_01_create_roaming_status_subscription_synchronously
  Scenario:  Create roaming status subscription synchronously
    Given that subscriptions are created synchronously
    And a valid subscription request body 
    When the  request "createSubscription" is sent 
    Then the response code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Subscription"

@roaming_status_subscriptions_02_create_roaming_status_subscription_asynchronously
  Scenario:  Create roaming status subscription asynchronously
    Given that subscriptions are created asynchronously
    And a valid subscription request body 
    When the  request "createSubscription" is sent 
    Then the response code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/SubscriptionAsync"
	
@roaming_status_subscriptions_03_Operation_to_retrieve_list_of_subscriptions
  Scenario: Get a list of subscriptions.
    Given the request body is not available
    When the request "retrieveSubscriptionList" is sent 
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And each item in the response body, if any, complies with the OAS schema at "/components/schemas/Subscription"

 @roaming_status_subscriptions_04_Operation_to_retrieve_subscription_based_on_an_existing_subscription-id
  Scenario: Get a subscription based on existing subscription-id.
    Given the request body is not available and path parameter "subscriptionId" is set to the identifier of an existing subscription
    When the request "retrieveRoamingStatusSubscription" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Subscription"

 @roaming_status_subscriptions_05_Operation_to_delete_subscription_based_on_an_existing_subscription-id
  Scenario: Delete a subscription based on existing subscription-id.
    Given the request body is not available and path parameter "subscriptionId" is set to the identifier of an existing subscription
    When the request "deleteRoamingStatusSubscription" is sent
    Then the response code is 202 or 204
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And if the response property $.status is 204 then response body is not available
    And if the response property $.status is 202 then response body complies with the OAS schema at "/components/schemas/SubscriptionAsync"

@roaming_status_subscriptions_06_Receive_notification_when_roaming_status_changed_to_on
  Scenario: Receive notification for roaming-on event
    Given that subscriptions are created synchronously
    And a valid subscription request body 
    And the request body property "$.type" is "roaming-on"	
    When the request "createSubscription" is sent
    Then the response code is 201
    And if the device switch from roaming "OFF" to roaming "ON"
    Then event notification "roaming-on" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "##/components/schemas/EventRoamingOn"
    And type="org.camaraproject.roaming-status-subscriptions.v0.roaming-on"

@roaming_status_subscriptions_07_Receive_notification_when_roaming_status_changed_to_off
  Scenario: Receive notification for roaming-off event
    Given that subscriptions are created synchronously
    And a valid subscription request body  
    And the request body property "$.type" is "roaming-off"	
    When the request "createSubscription" is sent
    Then the response code is 201
    And if the device switch from roaming "ON" to roaming "OFF"
    Then event notification "roaming-off" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "##/components/schemas/EventRoamingOff"
    And type="org.camaraproject.roaming-status-subscriptions.v0.roaming-off"

@roaming_status_subscriptions_08_Receive_notification_when_roaming_status_changed
  Scenario: Receive notification for roaming-status changes
    Given that subscriptions are created synchronously
    And a valid subscription request body  
    And the request body property "$.type" is "roaming-status"	
    When the request "createSubscription" is sent
    Then the response code is 201
    And if the device roaming-status changes
    Then event notification "roaming-status" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "##/components/schemas/EventRoamingStatus"
    And type="org.camaraproject.roaming-status-subscriptions.v0.roaming-status"


@roaming_status_subscriptions_09_Receive_notification_when_roaming_change_country
  Scenario: Receive notification for roaming-change-country
    Given that subscriptions are created synchronously
    And a valid subscription request body  
    And the request body property "$.type" is "roaming-change-country"	
    When the request "createSubscription" is sent
    Then the response code is 201
    And if the device roaming country changes
    Then event notification "roaming-change-country" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "##/components/schemas/RoamingChangeCountry"
    And type="org.camaraproject.roaming-status-subscriptions.v0.roaming-change-country"

@roaming_status_subscriptions_10_subscriptionExpireTime
  Scenario: Receive notification for subscription-ends event on expiry  
    Given that subscriptions are created synchronously
    And a valid subscription request body  
    And the request body property "$.type" is "roaming-status"
    And the request body property "$.subscriptionExpireTime" set to smaller value
    When the request "createSubscription" is sent
    Then the response code is 201 
    And the subscription is expired
    And event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "##/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.geofencing-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "SUBSCRIPTION_EXPIRED"

@roaming_status_subscriptions_11_subscriptionMaxEvents
   Scenario: Receive notification for subscription-ends event on max events reached 
    Given that subscriptions are created synchronously
    And a valid subscription request body  
    And the request body property "$.type" is "roaming-status"
    And the request body property "$.subscriptionMaxEvents" is set to 1 
    When the request "createSubscription" is sent
    Then the response code is 201 
    Then event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "##/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.geofencing-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "MAX_EVENTS_REACHED"

  @roaming_status_subscriptions_12_subscription_delete_event_validation
   Scenario: Receive notification for subscription-ends event on deletion 
    Given that subscriptions are created synchronously
    And a valid subscription request body  
    When the request "createSubscription" is sent
    Then the response code is 201 
    When the request "deleteRoamingStatusSubscription" is sent
    Then the response code is 202 or 204	
    Then event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "##/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.geofencing-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "SUBSCRIPTION_DELETED"


############### Error response scenarios ###########################

  @roaming_status_subscriptions_13_Create_roaming_status_subscription_for_a_device_with_invalid_parameter
  Scenario:  Create subscription with invalid parameter
    Given a valid subscription request body with invalid parameter
    When the  request "createSubscription" is sent 
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

@roaming_status_subscriptions_14_creation_of_subscription_with_expiry_time_in_past
  Scenario: Expiry time in past
    Given a valid subscription request body with expiry time in past
    When the  request "createSubscription" is sent 
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

 @roaming_status_subscription_15_invalid_protocol
   Scenario: subscription creation with invalid protocol
    Given a valid subscription request body 
    And "$.protocol" is not "HTTP"
    When the request "createSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_PROTOCOL"
    And the response property "$.message" contains a user friendly text

@roaming_status_subscription_16_invalid_credential_type
   Scenario: subscription creation with invalid credential type
    Given a valid subscription request body 
    And "$.credentialType" is not "ACCESSTOKEN"
    When the request "createSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_CREDENTIAL"
    And the response property "$.message" contains a user friendly text
	
@roaming_status_subscription_17_invalid_access_token_type
   Scenario: subscription creation with invalid access token type 
    Given a valid subscription request body 
    And "$.accessTokenType" is not "bearer"
    When the request "createSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_TOKEN"
    And the response property "$.message" contains a user friendly text

@roaming_status_subscription_18_invalid_credentials
   Scenario: subscription creation with invalid credentials
    Given a valid subscription request body with invalid credentials
    When the request "createSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

@roaming_status_subscription_19_invalid_inconsistent_access_token
   Scenario: subscription creation with inconsistent access token for requested events subscription
  # To test this, a token have to be obtained for a different device
    Given a valid subscription request body with inconsistent access token from different device
    When the request "createSubscription" is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "SUBSCRIPTION_MISMATCH"
    And the response property "$.message" contains a user friendly text

@roaming_status_subscription_20_invalid_resource_path
   Scenario: subscription creation with invalid resource path
    Given a valid subscription request body with invalid resource path
    When the request "createSubscription" is sent
    Then the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text
