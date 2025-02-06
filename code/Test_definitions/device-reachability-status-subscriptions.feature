
@DeviceReachabilityStatusSubscription
Feature: Device Reachability Status Subscriptions API, v0.6.0 - Operations Reachability Status Subscription

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specified in device-reachability-status-subscriptions.yaml, version v0.6.0

  Background: Common Device Reachability Status Subscriptions setup
    Given the resource "{apiroot}/device-reachability-status-subscriptions/v0.6" as base-url
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value

######### Happy Path Scenarios #################################

  @reachability_status_subscriptions_01_create_reachability_status_subscription_synchronously
  Scenario: Create reachability status subscription synchronously
    Given that subscriptions are created synchronously
    And a valid subscription request body 
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Subscription"

  @reachability_status_subscriptions_02_create_reachability_status_subscription_asynchronously
  Scenario: Create reachability status subscription asynchronously
    Given that subscriptions are created asynchronously
    And a valid subscription request body 
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/SubscriptionAsync"
	
  @reachability_status_subscriptions_03_Operation_to_retrieve_list_of_subscriptions_when_no_records
  Scenario: Get a list of subscriptions when no subscriptions available
    Given a client without subscriptions created
    When the request "retrieveDeviceReachabilityStatusSubscriptionList" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an empty array

  @reachability_status_subscriptions_04_Operation_to_retrieve_list_of_subscriptions
  Scenario: Get a list of subscriptions
    Given a client with subscriptions created
    When the request "retrieveDeviceReachabilityStatusSubscriptionList" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body has an array of items and each item complies with the OAS schema at "/components/schemas/Subscription"

  @reachability_status_subscriptions_05_Operation_to_retrieve_subscription_based_on_an_existing_subscription-id
  Scenario: Get a subscription based on existing subscription-id.
    Given the path parameter "subscriptionId" is set to the identifier of an existing subscription
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Subscription"

  @reachability_status_subscriptions_06_Operation_to_delete_subscription_based_on_an_existing_subscription-id
  Scenario: Delete a subscription based on existing subscription-id.
    Given the path parameter "subscriptionId" is set to the identifier of an existing subscription
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
    Then the response code is 202 or 204
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And if the response property $.status is 204 then response body is not available
    And if the response property $.status is 202 then response body complies with the OAS schema at "/components/schemas/SubscriptionAsync"

  @reachability_status_subscriptions_07_Receive_notification_when_device_reachability_changed_to_data_usage
  Scenario: Receive notification for reachability-data event
    Given that subscriptions are created synchronously
    And a valid subscription request body 
    And the request body property "$.type" is "reachability-data"	
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response code is 201
    And if the device reachability is changed to data usage
    Then event notification "reachability-data" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "##/components/schemas/EventReachabilityData"
    And type="org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data"

  @reachability_status_subscriptions_08_Receive_notification_when_device_reachability_changed_to_sms_usage
  Scenario: Receive notification for reachability-sms event
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.type" is "reachability-sms"	
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response code is 201
    And if the device reachability is changed to sms usage
    Then event notification "reachability-sms" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "##/components/schemas/EventReachabilitySms"
    And type="org.camaraproject.device-reachability-status-subscriptions.v0.reachability-sms"

  @reachability_status_subscriptions_09_Receive_notification_when_device_reachability_changed_to_disconnected
  Scenario: Receive notification for reachability-disconnected event
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.type" is "reachability-disconnected"	
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response code is 201
    And if the device reachability is changed to disconnected
    Then event notification "reachability-disconnected" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "##/components/schemas/EventReachabilityDisconnected"
    And type="org.camaraproject.device-reachability-status-subscriptions.v0.reachability-disconnected"

  @reachability_status_subscriptions_10_subscription_expiry
  Scenario: Receive notification for subscription-ends event on expiry
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.subscriptionExpireTime" is set to a value in the near future
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response code is 201 
    Then the subscription is expired
    Then event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "##/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.device-reachability-status-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "SUBSCRIPTION_EXPIRED"

  @reachability_status_subscriptions_11_subscription_end_when_max_events
  Scenario: Receive notification for subscription-ends event on max events reached
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.type" is "reachability-data"
    And the request body property "$.subscriptionMaxEvents" is set to 1 
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response code is 201 
    Then event notification "reachability-data" is received on callback-url
    Then event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "##/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.device-reachability-status-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "MAX_EVENTS_REACHED"

  @reachability_status_subscriptions_12_subscription_delete_event_validation
  Scenario: Receive notification for subscription-ends event on deletion
    Given that subscriptions are created synchronously
    And a valid subscription request body
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response code is 201 
    When the request "deleteSubscription" is sent
    Then the response code is 202 or 204	
    Then event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "##/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.device-reachability-status-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "SUBSCRIPTION_DELETED"

############### Error response scenarios ###########################

  @reachability_status_subscriptions_13_Create_reachability_status_subscription_with_invalid_parameter
  Scenario: Create subscription with invalid parameter
    Given the request body is not compliant with the schema "/components/schemas/SubscriptionRequest"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_14_creation_of_subscription_with_expiry_time_in_past
  Scenario: Expiry time in past
    Given a valid subscription request body 
    And request body property "$.subscriptionexpiretime" in past
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscription_15_invalid_protocol
  Scenario: subscription creation with invalid protocol
    Given a valid subscription request body 
    And the request property "$.protocol" is not set to "HTTP"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_PROTOCOL"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscription_16_invalid_credential_type
  Scenario: subscription creation with invalid credential type
    Given a valid subscription request body 
    And the request property "$.credentialType" is not "ACCESSTOKEN"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_CREDENTIAL"
    And the response property "$.message" contains a user friendly text
	
  @reachability_status_subscription_17_invalid_access_token_type
  Scenario: subscription creation with invalid access token type
    Given a valid subscription request body 
    And the request property "$.accessTokenType" is not "bearer"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_TOKEN" or "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscription_18_invalid_credentials
  Scenario: subscription creation with invalid credentials
    Given a valid subscription request body 
    And header "Authorization" token is set to invalid credentials
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscription_19_permission_denied
  Scenario: subscription creation with inconsistent access token for requested events subscription
    # To test this, a token does not have the required scope
    Given a valid subscription request body 
    And the request body property "$.device" is set to a valid testing device supported by the service
    And header "Authorization" set to access token referring different scope
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscription_20_invalid_token_context
  Scenario: subscription creation with invalid access token context for requested events subscription
    # To test this, a token does not have the required device identifier
    Given a valid subscription request body
    And the request body property "$.device" is set to a valid testing device supported by the service
    And header "Authorization" set to access token referring different device
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscription_21_inconsistent_access_token_for_requested_events_subscription
  Scenario: subscription creation with invalid access token for requested events subscription
    # To test this, a token contains an unsupported event type for this API
    Given a valid subscription request body
    And the request body property "$.device" is set to a valid testing device supported by the service
    And the request body property "$.types" contains the supported event type in this API
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "SUBSCRIPTION_MISMATCH"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscription_22_unknown_subscription_id
  Scenario: Get subscription when subscription-id is unknown to the system
    Given the path parameter property "$.subscriptionId" is unknown to the system
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text
