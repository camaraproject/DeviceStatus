 
@DeviceStatusRoamingSubscription
Feature: Device Roaming Status Subscriptions API, v0.7.0-rc.1 - Operations RoamingStatus

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specified in device-roaming-status-subscriptions.yaml, version vwip

  Background: Common Device Roaming Status setup
    Given the resource "{apiroot}/device-roaming-status-subscriptions/v0.7rc1" as base-url
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value

######### Happy Path Scenarios #################################

  @roaming_status_subscriptions_01_create_roaming_status_subscription_synchronously
  Scenario: Create roaming status subscription synchronously
    Given that subscriptions are created synchronously
    And a valid subscription request body 
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Subscription"

  @roaming_status_subscriptions_02_create_roaming_status_subscription_asynchronously
  Scenario: Create roaming status subscription asynchronously
    Given that subscriptions are created asynchronously
    And a valid subscription request body 
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/SubscriptionAsync"
	
  @roaming_status_subscriptions_03_Operation_to_retrieve_list_of_subscriptions_when_no_records
  Scenario: Get a list of subscriptions when no subscriptions 
    Given a client without subscriptions created
    When the request "retrieveDeviceRoamingStatusSubscriptionList" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an empty array

  @roaming_status_subscriptions_04_Operation_to_retrieve_list_of_subscriptions
  Scenario: Get a list of subscriptions.
    Given a client with subscriptions created
    When the request "retrieveDeviceRoamingStatusSubscriptionList" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body has an array of items and each item complies with the OAS schema at "/components/schemas/Subscription"

  @roaming_status_subscriptions_05_Operation_to_retrieve_subscription_based_on_an_existing_subscription-id
  Scenario: Get a subscription based on existing subscription-id.
    Given the path parameter "subscriptionId" is set to the identifier of an existing subscription
    When the request "retrieveDeviceRoamingStatusSubscription" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Subscription"

  @roaming_status_subscriptions_06_Operation_to_delete_subscription_based_on_an_existing_subscription-id
  Scenario: Delete a subscription based on existing subscription-id.
    Given the path parameter "subscriptionId" is set to the identifier of an existing subscription
    When the request "deleteDeviceRoamingStatusSubscription" is sent
    Then the response code is 202 or 204
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And if the response property $.status is 204 then response body is not available
    And if the response property $.status is 202 then response body complies with the OAS schema at "/components/schemas/SubscriptionAsync"

  @roaming_status_subscriptions_07_Receive_notification_when_roaming_status_changed_to_on
  Scenario: Receive notification for roaming-on event
    Given that subscriptions are created synchronously
    And a valid subscription request body 
    And the request body property "$.type" is "roaming-on"	
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response code is 201
    And if the device switch from roaming "OFF" to roaming "ON"
    Then event notification "roaming-on" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "##/components/schemas/EventRoamingOn"
    And type="org.camaraproject.roaming-status-subscriptions.v0.roaming-on"

  @roaming_status_subscriptions_08_Receive_notification_when_roaming_status_changed_to_off
  Scenario: Receive notification for roaming-off event
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.type" is "roaming-off"	
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response code is 201
    And if the device switch from roaming "ON" to roaming "OFF"
    Then event notification "roaming-off" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "##/components/schemas/EventRoamingOff"
    And type="org.camaraproject.roaming-status-subscriptions.v0.roaming-off"

  @roaming_status_subscriptions_09_Receive_notification_when_roaming_status_changed
  Scenario: Receive notification for roaming-status changes
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.type" is "roaming-status"	
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response code is 201
    And if the device roaming-status changes
    Then event notification "roaming-status" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "##/components/schemas/EventRoamingStatus"
    And type="org.camaraproject.roaming-status-subscriptions.v0.roaming-status"

  @roaming_status_subscriptions_10_Receive_notification_when_roaming_change_country
  Scenario: Receive notification for roaming-change-country
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.type" is "roaming-change-country"	
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response code is 201
    And if the device roaming country changes
    Then event notification "roaming-change-country" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "##/components/schemas/RoamingChangeCountry"
    And type="org.camaraproject.roaming-status-subscriptions.v0.roaming-change-country"

  @roaming_status_subscriptions_11_subscription_expiry
  Scenario: Receive notification for subscription-ends event on expiry
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.subscriptionExpireTime" is set to a value in the near future
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response code is 201 
    And the subscription is expired
    And event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "##/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.roaming-status-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "SUBSCRIPTION_EXPIRED"

  @roaming_status_subscriptions_12_subscription_ends_when_max_events_reached
  Scenario: Receive notification for subscription-ends event on max events reached
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.type" is "roaming_on"
    And the request body property "$.subscriptionMaxEvents" is set to 1 
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response code is 201 
    Then event notification "roaming_on" is received on callback-url
    Then event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "##/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.roaming-status-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "MAX_EVENTS_REACHED"

  @roaming_status_subscriptions_13_subscription_delete_event_validation
  Scenario: Receive notification for subscription-ends event on deletion
    Given that subscriptions are created synchronously
    And a valid subscription request body
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response code is 201 
    When the request "deleteSubscription" is sent
    Then the response code is 202 or 204	
    Then event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "##/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.roaming-status-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "SUBSCRIPTION_DELETED"

############### Error response scenarios ###########################

  @roaming_status_subscriptions_14_Create_roaming_status_subscription_with_invalid_parameter
  Scenario: Create subscription with invalid parameter
    Given the request body is not compliant with the schema "/components/schemas/SubscriptionRequest"
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_15_creation_of_subscription_with_expiry_time_in_past
  Scenario: Expiry time in past
    Given a valid subscription request body
    And request body property "$.subscriptionExpireTime" in past
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscription_16_invalid_protocol
  Scenario: subscription creation with invalid protocol
    Given a valid subscription request body 
    And the request property "$.protocol" is not "HTTP"
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_PROTOCOL"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscription_17_invalid_credential_type
  Scenario: subscription creation with invalid credential type
    Given a valid subscription request body 
    And the request property "$.credentialType" is not "ACCESSTOKEN"
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_CREDENTIAL"
    And the response property "$.message" contains a user friendly text
	
  @roaming_status_subscription_18_invalid_access_token_type
  Scenario: subscription creation with invalid access token type
    Given a valid subscription request body 
    And the request property "$.accessTokenType" is not "bearer"
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_TOKEN" or "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscription_19_invalid_credentials
  Scenario: subscription creation with invalid credentials
    Given a valid subscription request body 
    And header "Authorization" token is set to invalid credentials
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscription_20_permission_denied
  Scenario: subscription creation with inconsistent access token for requested events subscription
    # To test this, a token does not have the required scope
    Given a valid subscription request body
    And the request body property "$.device" is set to a valid testing device supported by the service
    And header "Authorization" set to access token referring different scope
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscription_21_unnecessary_identifier
  Scenario: subscription creation with both a 3-legged token and explicit device identifier
    # This test applies whether the device associated with the access token matches the explicit device identifier or not
    # For 3-legged access tokens, an explicit device identifier MUST NOT be provided
    Given a valid subscription request body
    And the request body property "$.device" is set to a valid testing device supported by the service
    And header "Authorization" set to access token also referring to a device (which may or may not be the same device)
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response property "$.status" is 422
    And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscription_22_inconsistent_access_token_for_requested_events_subscription
  Scenario: subscription creation with invalid access token for requested events subscription
    # To test this, a token contains an unsupported event type for this API
    Given a valid subscription request body
    And the request body property "$.device" is set to a valid testing device supported by the service
    And the request body property "$.types" contains the supported event type in this API
    When the request "createDeviceRoamingStatusSubscription" is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "SUBSCRIPTION_MISMATCH"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscription_23_unknown_subscription_id
  Scenario: Get subscription when subscription-id is unknown to the system
    Given the path parameter property "$.subscriptionId" is unknown to the system
    When the request "retrieveDeviceRoamingStatusSubscription" is sent
    Then the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text
