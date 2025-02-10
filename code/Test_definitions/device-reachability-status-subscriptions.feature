Feature: CAMARA Device Reachability Status API, vwip - Operation to manage reachability subscriptions

  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * List of device identifier types which are not supported, among: phoneNumber, networkAccessIdentifier, ipv4Address, ipv6Address
  #
  # Testing assets:
  # * A device object which reachability status is known by the network when connected.
  # * A device object where you can turn on/off the SMS or data usage reachability.
  # * The known reachability status of the testing device
  # * A sink-url identified as "callbackUrl", which receives notifications
  #
  # References to OAS spec schemas refer to schemas specifies in device-reachability-status-subscriptions.yaml

  Background: Common Device Reachability Status Subscriptions setup
    Given the resource "{apiroot}/device-reachability-status-subscriptions/vwip/subscriptions" as base-url
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value

##########################
# Happy path scenarios
##########################

  @reachability_status_subscriptions_01_sync_creation
  Scenario Outline: Check sync subscription creation - This scenario could be bypass if async creation is provided (following scenario)
    Given use BaseURL
    When the HTTP "POST" request is sent
    And "$.types" is one of the allowed values "<subscription-creation-types>"
    And "$.protocol"="HTTP"
    And a valid phone number identified by the token or provided in the request body
    And "$.sink" is set to provided callbackUrl
    Then the response code is is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And types, protocol, sink and config.subscriptionDetail.phoneNumber are present with provided value
    And startsAt is valued with a datetime corresponding to the date time of the response

    Examples:
      | subscription-creation-types                                                             |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data         |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-sms          |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-disconnected |

  @reachability_status_subscriptions_02_async_creation
  Scenario Outline: Check async subscription creation - This scenario could be bypass if previous scenario is provided
    Given use BaseURL
    When the HTTP "POST" request is sent
    And "$.types" is one of the allowed values "<subscription-creation-types>"
    And "$.protocol"="HTTP"
    And a valid phone number identified by the token or provided in the request body
    And "$.sink" is set to provided callbackUrl
    Then the response code is is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionAsync"

    Examples:
      | subscription-creation-types                                                             |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data         |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-sms          |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-disconnected |

  @reachability_status_subscriptions_03_retrieve_by_id
  Scenario: Check existing subscription is retrieved by id
    Given a subscription is existing and identified by an "id"
    And use BaseURL
    When the HTTP "GET" request is sent with subscriptionId="id"
    Then the response code is is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"

  @reachability_status_subscriptions_04_retrieve_list_2legs
  Scenario: Check existing subscription(s) is/are retrieved in list
    Given at least one subscription is existing for the API client making this request
    And use BaseURL
    When the HTTP "GET" request is sent
    Then the response code is is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with an array of OAS schema defined at "#/components/schemas/Subscription"
    And subscription(s) is/are listed

  @reachability_status_subscriptions_05_retrieve_list_3legs
  Scenario: Check existing subscription(s) is/are retrieved in list
    Given a subscription is existing for the device
    And this device is identified by the token
    And use BaseURL
    When the HTTP "GET" request is sent
    Then the response code is is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with an array of OAS schema defined at "#/components/schemas/Subscription"
    And the subscriptions for this device are listed

  @reachability_status_subscriptions_06_retrieve_empty_list_3legs
  Scenario: Check no existing subscription is retrieved in list
    Given no subscription is existing for the device
    And this device is identified by the token
    And use BaseURL
    When the HTTP "GET" request is sent
    Then the response code is is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an empty list

  @reachability_status_subscriptions_07_delete_subscription_based_on_an_existing_subscription-id
  Scenario: Delete a subscription based on existing subscription-id.
    Given the path parameter "subscriptionId" is set to the identifier of an existing subscription
    When the HTTP "DELETE" request is sent with subscriptionId="id"
    Then the response code is 202 or 204
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And if the response property $.status is 204 then response body is not available
    And if the response property $.status is 202 then response body complies with the OAS schema at "/components/schemas/SubscriptionAsync"

  @reachability_status_subscriptions_08_receive_notification_when_device_reachability_changed_to_data_usage
  Scenario: Receive notification for reachability-data event
    Given that subscriptions are created synchronously
    When the HTTP "POST" request is sent
    And a valid subscription request body
    And the request body property "$.type" is "org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data"
    Then the response code is 201
    And if the device reachability is changed to data usage
    And event notification "org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "#/components/schemas/EventReachabilityData"
    And type="org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data"

  @reachability_status_subscriptions_09_receive_notification_when_device_reachability_changed_to_sms_usage
  Scenario: Receive notification for reachability-sms event
    Given that subscriptions are created synchronously
    When the HTTP "POST" request is sent
    And a valid subscription request body
    And the request body property "$.type" is "org.camaraproject.device-reachability-status-subscriptions.v0.reachability-sms"
    Then the response code is 201
    And if the device reachability is changed to sms usage
    And event notification "org.camaraproject.device-reachability-status-subscriptions.v0.reachability-sms" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "#/components/schemas/EventReachabilitySms"
    And type="org.camaraproject.device-reachability-status-subscriptions.v0.reachability-sms"

  @reachability_status_subscriptions_10_receive_notification_when_device_reachability_changed_to_disconnected
  Scenario: Receive notification for reachability-disconnected event
    Given that subscriptions are created synchronously
    When the HTTP "POST" request is sent
    And a valid subscription request body
    And the request body property "$.type" is "org.camaraproject.device-reachability-status-subscriptions.v0.reachability-disconnected"
    Then the response code is 201
    And if the device reachability is changed to disconnected
    And event notification "org.camaraproject.device-reachability-status-subscriptions.v0.reachability-disconnected" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "#/components/schemas/EventReachabilityDisconnected"
    And type="org.camaraproject.device-reachability-status-subscriptions.v0.reachability-disconnected"

  @reachability_status_subscriptions_11_subscription_expiry
  Scenario: Receive notification for subscription-ends event on expiry
    Given that subscriptions are created synchronously
    When the HTTP "POST" request is sent
    And a valid subscription request body
    And the request body property "$.subscriptionExpireTime" is set to a value in the near future
    Then the response code is 201
    And the subscription is expired
    And event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "#/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.device-reachability-status-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "SUBSCRIPTION_EXPIRED"

  @reachability_status_subscriptions_12_subscription_end_when_max_events
  Scenario: Receive notification for subscription-ends event on max events reached
    Given that subscriptions are created synchronously
    When the HTTP "POST" request is sent
    And a valid subscription request body
    And the request body property "$.type" is "org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data"
    And the request body property "$.subscriptionMaxEvents" is set to 1 
    Then the response code is 201
    And event notification "org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data" is received on callback-url
    And event notification "org.camaraproject.device-reachability-status-subscriptions.v0.subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "#/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.device-reachability-status-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "MAX_EVENTS_REACHED"

  @reachability_status_subscriptions_13_subscription_delete_event_validation
  Scenario: Receive notification for subscription-ends event on deletion
    Given that subscriptions are created synchronously
    When the HTTP "POST" request is sent
    And a valid subscription request body
    Then the response code is 201
    When the HTTP "DELETE" request is sent with subscriptionId="id"
    Then the response code is 202 or 204
    And event notification "org.camaraproject.device-reachability-status-subscriptions.v0.subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "#/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.device-reachability-status-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "SUBSCRIPTION_DELETED"

##################
# Error code 400
##################

  @reachability_status_subscriptions_400.1_create_subscription_with_invalid_parameter
  Scenario: Create subscription with invalid parameter
    Given use BaseURL
    When the request body is not compliant with the schema "#/components/schemas/SubscriptionRequest"
    And the HTTP "POST" request is sent
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_400.2_create_subscription_with_invalid_subscription_expire_time
  Scenario: Expiry time in past
    Given use BaseURL
    When a valid subscription request body
    And the HTTP "POST" request is sent
    And "$.config.subscriptionExpireTime" is set in the past
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_400.3_invalid_eventType
  Scenario: Subscription creation with invalid event type
    Given use BaseURL
    When a valid subscription request body
    And the HTTP "POST" request is sent
    And the request body property "$.types" is set to invalid value
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_400.4_invalid_protocol
  Scenario: subscription creation with invalid protocol
    Given use BaseURL
    When the HTTP "POST" request is sent
    And a valid subscription request body
    And "$.protocol" <> "HTTP"
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_PROTOCOL"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_400.5_create_subscription_with_invalid_credential_type
  Scenario: subscription creation with invalid credential type
    Given use BaseURL
    When the HTTP "POST" request is sent
    And a valid subscription request body
    And "$.sink" is set to provided callbackUrl
    And "$.sinkCredential.credentialType" <> "ACCESSTOKEN"
    And "$.sinkCredential.accessTokenType" = "bearer"
    And "$.sinkCredential.accessToken" is valued with a valid value
    And "$.sinkCredential.accessTokenExpiresUtc" is valued with a valid value
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_CREDENTIAL"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_400.6_create_subscription_with_invalid_access_token_type
  Scenario: subscription creation with invalid token
    Given use BaseURL
    When the HTTP "POST" request is sent
    And a valid subscription request body
    And "$.sink" is set to provided callbackUrl
    And "$.sinkCredential.credentialType" = "ACCESSTOKEN"
    And "$.sinkCredential.accessTokenType" <> "bearer"
    And "$.sinkCredential.accessToken" is valued with a valid value
    And "$.sinkCredential.accessTokenExpiresUtc" is valued with a valid value
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_TOKEN"
    And the response property "$.message" contains a user friendly text

##################
# Error code 401
##################

  @reachability_status_subscriptions_creation_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And use BaseUrL
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_creation_401.2_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And use BaseUrL
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_creation_401.3_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And use BaseUrL
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_retrieve_401.4_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And use BaseUrL
    When the HTTP "GET" request is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_retrieve_401.5_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And use BaseUrL
    When the HTTP "GET" request is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_retrieve_401.6_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And use BaseUrL
    When the HTTP "GET" request is sent
    Then the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_delete_401.7_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And use BaseUrL
    When the HTTP "DELETE" request is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_delete_401.8_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And use BaseUrL
    When the HTTP "DELETE" request is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_delete_401.9_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And use BaseUrL
    When the HTTP "DELETE" request is sent
    Then the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  
##################
# Error code 403
##################

  @reachability_status_subscriptions_create_403.1_permission_denied
  Scenario: subscription creation without having the required scope
    # To test this, a token does not have the required scope
    Given header "Authorization" set to access token referring different scope
    And use BaseUrL
    When the HTTP "POST" request is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_create_403.2_invalid_token_context
  Scenario: subscription creation with invalid access token context for requested events subscription
    # To test this, a token does not have the required device identifier
    Given a valid subscription request body
    And use BaseUrL
    And the request body property "$.device" is set to a valid testing device supported by the service
    And header "Authorization" set to access token referring different device
    When the HTTP "POST" request is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_create_403.3_subscription_mismatch_for_requested_events_subscription
  Scenario: subscription creation with invalid access token for requested events subscription
    # To test this, a token contains an unsupported event type for this API
    Given a valid subscription request body
    And use BaseUrL
    And the request body property "$.device" is set to a valid testing device supported by the service
    And the request body property "$.types" contains the supported event type in this API
    When the HTTP "POST" request is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "SUBSCRIPTION_MISMATCH"
    And the response property "$.message" contains a user friendly text

##################
# Error code 404
##################

  @reachability_status_subscriptions_404.1_retrieve_unknown_subscription_id
  Scenario: Get subscription when subscription-id is unknown to the system
    Given the path parameter property "$.subscriptionId" is unknown to the system
    And use BaseUrL
    When the HTTP "GET" request is sent with subscriptionId="id"
    Then the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_404.2_delete_unknown_subscription_id
  Scenario: Delete subscription with subscription-id unknown to the system
    Given the path parameter "subscriptionId" is set to the value unknown to system
    When the HTTP "DELETE" request is sent
    Then the response code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text
