@Connected_network_type_subscription
Feature: CAMARA Device reachability status API, vwip - Operations on subscriptions

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specifies in connected-network-type-subscriptions.yaml, version vwip

  Background: Connected Network Type Subscriptions setup
    Given the resource "{apiroot}/connected-network-type-subscriptions/vwip" as base-url
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value

######### Happy Path Scenarios #################################

  @connected_network_type_subscriptions_01_create_connected_network_type_subscription_sync
  Scenario:  Create connected network type subscription synchronously
    Given that subscriptions are created synchronously
    And a valid subscription request body
    When the request "createSubscription" is sent
    Then the response code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Subscription"

  @connected_network_type_subscriptions_02_create_connected_network_type_subscription_async
  Scenario:  Create connected network type subscription asynchronously
    Given that subscriptions are created asynchronously
    And a valid subscription request body
    When the  request "createSubscription" is sent
    Then the response code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/SubscriptionAsync"

  @connected_network_type_subscriptions_03_operation_to_retrieve_list_of_subscriptions_when_no_records
  Scenario: Get a list of subscriptions when no subscriptions available
    Given a client without subscriptions created
    When the request "retrieveSubscriptionList" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an empty array

  @connected_network_type_subscriptions_04_operation_to_retrieve_list_of_subscriptions
  Scenario: Get a list of subscriptions
    Given a client with subscriptions created
    When the request "retrieveSubscriptionList" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body has an array of items and each item complies with the OAS schema at "/components/schemas/Subscription"

  @connected_network_type_subscriptions_05_operation_to_retrieve_subscription_based_on_an_existing_subscription-id
  Scenario: Get a subscription based on existing subscription-id.
    Given the path parameter "subscriptionId" is set to the identifier of an existing subscription
    When the request "retrieveSubscription" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Subscription"

  @connected_network_type_subscriptions_06_operation_to_delete_subscription_based_on_an_existing_subscription-id
  Scenario: Delete a subscription based on existing subscription-id.
    Given the path parameter "subscriptionId" is set to the identifier of an existing subscription
    When the request "deleteSubscription" is sent
    Then the response code is 202 or 204
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And if the response property $.status is 204 then response body is not available
    And if the response property $.status is 202 then response body complies with the OAS schema at "/components/schemas/SubscriptionAsync"

  connected_network_type_subscriptions_07_receive_notification_when_network_type_changed
  Scenario: Receive notification for network-type-changed event
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.types" contains the element "network-type-changed"
    When the request "createSubscription" is sent
    Then the response code is 201
    And if the device network type changed
    Then event notification "network-type-changed" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "#/components/schemas/EventNetworkTypeChange"
    And type="org.camaraproject.connected-network-type-subscriptions.v0.network-type-changed"

  @connected_network_type_subscriptions_08_subscription_ends_on_expiry
  Scenario: Receive notification for subscription-ends event on expiry
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.subscriptionExpireTime" is set to a value in the near future
    When the request "createSubscription" is sent
    Then the response code is 201
    Then the subscription is expired
    Then event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "#/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.connected-network-type-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "SUBSCRIPTION_EXPIRED"

  @connected_network_type_subscriptions_09_subscription_end_when_max_events
  Scenario: Receive notification for subscription-ends event on max events reached
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.types" contains the element "network-type-changed"
    And the request body property "$.subscriptionMaxEvents" is set to 1
    When the request "createSubscription" is sent
    Then the response code is 201
    Then event notification "network-type-changed" is received on callback-url
    Then event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "##/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.connected-network-type-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "MAX_EVENTS_REACHED"

  @connected_network_type_subscriptions_10_subscription_delete_event_validation
  Scenario: Receive notification for subscription-ends event on deletion
    Given that subscriptions are created synchronously
    And a valid subscription request body
    When the request "createSubscription" is sent
    Then the response code is 201
    When the request "deleteSubscription" is sent
    Then the response code is 202 or 204
    Then event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "##/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.connected-network-type-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "SUBSCRIPTION_DELETED"

############### Error response scenarios ###########################

  @connected_network_type_subscriptions_11_create_network_type_subscription_with_invalid_parameter
  Scenario:  Create subscription with invalid parameter
    Given the request body is not compliant with the schema "/components/schemas/SubscriptionRequest"
    When the  request "createSubscription" is sent
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_subscriptions_12_creation_of_subscription_with_expiry_time_in_past
  Scenario: Expiry time in past
    Given a valid subscription request body
    And request body property "$.subscriptionexpiretime" in past
    When the  request "createSubscription" is sent
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_subscriptions_13_invalid_eventType
  Scenario: Subscription creation with invalid event type
    Given a valid subscription request body
    And the request body property "$.types" is set to invalid value
    When the request "createSubscription" is sent
    Then the response code is 400
    and the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_subscriptions_14_invalid_protocol
  Scenario: subscription creation with invalid protocol
    Given a valid subscription request body
    And  the request property "$.protocol" is not set to "HTTP"
    When the request "createSubscription" is sent
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_PROTOCOL"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_subscriptions_15_invalid_credential
  Scenario: subscription creation with invalid credential type
    Given a valid subscription request body
    And the request property "$.credentialType" is not "ACCESSTOKEN"
    When the request "createSubscription" is sent
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_CREDENTIAL"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_subscriptions_16_invalid_access_token_type
  Scenario: subscription creation with invalid access token type
    Given a valid subscription request body
    And the request property "$.accessTokenType" is not "bearer"
    When the request "createSubscription" is sent
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_TOKEN" or "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_subscriptions_17_no_authorization_header_for_create_subscription
  Scenario: subscription creation with invalid credentials
    Given a valid subscription request body
    And header "Authorization" token is set to invalid credentials
    When the request "createSubscription" is sent
    Then the response code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_subscriptions_18_expired_access_token_for_create_subscription
  Scenario: Expired access token for create subscription
    Given a valid subscription request body and header "Authorization" is expired
    When the request "createSubscription" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_subscriptions_19_invalid_inconsistent_access_token
  Scenario: subscription creation with inconsistent access token for requested events subscription
   # To test this, a token have to be obtained for a different device
    Given a valid subscription request body
    And the request body property "$.device" is set to a valid testing device supported by the service
    And header "Authorization" set to access token referring different device
    When the request "createSubscription" is sent
    Then the response code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "SUBSCRIPTION_MISMATCH"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_subscriptions_20_unknown_subscription_id
  Scenario: Get subscription when subscription-id is unknown to the system
    Given the path parameter property "$.subscriptionId" is unknown to the system
    When the request "retrieveSubscription" is sent
    Then the response code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_subscriptions_21_delete_unknown_subscription_id
  Scenario:  Delete subscription with subscription-id unknown to the system
    Given the path parameter "subscriptionId" is set to the value unknown to system
    When the request "deleteSubscription" is sent
    Then the response code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text
