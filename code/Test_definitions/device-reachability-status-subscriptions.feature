@Device_Reachability_Status_Subscription
Feature: Device Reachability Status Subscriptions API, vwip - Operations createDeviceReachabilityStatusSubscription, retrieveDeviceReachabilityStatusSubscriptionList, retrieveDeviceReachabilityStatusSubscription and deleteDeviceReachabilityStatusSubscription

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
    Given the resource "{apiroot}/device-reachability-status-subscriptions/vwip" as base-url
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value

##########################
# Happy path scenarios
##########################

  @reachability_status_subscriptions_01.1_sync_creation_2legs
  Scenario Outline: Synchronous subscription creation with 2-legged-access-token
    # Some implementations may only support asynchronous subscription creation
    Given the header "Authorization" is set to a valid access token which does not identify any device
    And the request body is compliant with the OAS schema at "#/component/schemas/SubscriptionRequest"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    And request property "$.types" is one of the allowed values "<subscription-creation-types>"
    And request property "$.protocol" is equal to "HTTP"
    And a valid phone number identified by "$.config.subscriptionDetail.device.phoneNumber"
    And request property "$.sink" is set to a valid callbackUrl
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And the response properties "$.types", "$.protocol", "$.sink" and "$.config.subscriptionDetail.device.phoneNumber" are present with the values provided in the request
    And the response property "$.id" is present
    And the response property "$.startsAt", if present, has a valid value with date-time format
    And the response property "$.expiresAt", if present, has a valid value with date-time format
    And the response property "$.status", if present, has the value "ACTIVATION_REQUESTED", "ACTIVE" or "INACTIVE"

    Examples:
      | subscription-creation-types                                                             |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data         |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-sms          |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-disconnected |

  @reachability_status_subscriptions_01.2_sync_creation_3legs
  Scenario Outline: Synchronous subscription creation with 3-legged-access-token
    # Some implementations may only support asynchronous subscription creation
    Given the header "Authorization" is set to a valid access token which identifies a valid device
    And the request body is compliant with the OAS schema at "#/component/schemas/SubscriptionRequest"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    And request property "$.types" is one of the allowed values "<subscription-creation-types>"
    And request property "$.protocol" is equal to "HTTP"
    And request property "$.sink" is set to a valid callbackUrl
    And request property "$.config.subscriptionDetail.device.phoneNumber" is not present
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And the response properties "$.types", "$.protocol" and "$.sink" are present with the values provided in the request
    And the response property "$.id" is present
    And the response property "$.startsAt", if present, has a valid value with date-time format
    And the response property "$.expiresAt", if present, has a valid value with date-time format
    And the response property "$.status", if present, has the value "ACTIVATION_REQUESTED", "ACTIVE" or "INACTIVE"
    And the response property "$.config.subscriptionDetail.device" is not present

    Examples:
      | subscription-creation-types                                                             |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data         |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-sms          |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-disconnected |

  @reachability_status_subscriptions_02_async_creation
  Scenario Outline: Asynchronous subscription creation with 2- or 3-legged access token
    # Some implementations may only support synchronous subscription creation
    Given a valid target device, identified by either the access token or in the request body
    And the request body is compliant with the OAS schema at "#/component/schemas/SubscriptionRequest"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    And request property "$.types" is one of the allowed values "<subscription-creation-types>"
    And request property "$.protocol" is equal to "HTTP"
    And request property "$.sink" is set to a valid callbackUrl
    Then the response status code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionAsync"
    And the response property "$.id" is present

    Examples:
      | subscription-creation-types                                                             |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data         |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-sms          |
      | org.camaraproject.device-reachability-status-subscriptions.v0.reachability-disconnected |

  @reachability_status_subscriptions_03.1_retrieve_by_id_2legs
  Scenario: Check existing subscription is retrieved by id with a 2-legged access token
    Given a subscription exists and has a subscriptionId equal to "id"
    And the header "Authorization" is set to a valid access token which does not identify any device 
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent
    And the path parameter "subscriptionId" is set to "id"
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And the response property "$.id" is equal to "id"
    And the response property "$.config.subscriptionDetail.device" is present

  @reachability_status_subscriptions_03.2_retrieve_by_id_3legs
  Scenario: Check existing subscription is retrieved by id with a 3-legged access token
    Given a subscription exists and has a subscriptionId equal to "id"
    And the header "Authorization" is set to a valid access token which identifies the device associated with the subscription
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent
    And the path parameter "subscriptionId" is set to "id"
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And the response property "$.id" is equal to "id"
    And the response property "$.config.subscriptionDetail.device" is not present

  @reachability_status_subscriptions_04_retrieve_list_2legs
  Scenario: Check existing subscription(s) is/are retrieved in list
    Given at least one subscription is existing for the API consumer making this request
    And the header "Authorization" is set to a valid access token which does not identify any device 
    When the request "retrieveDeviceReachabilityStatusSubscriptionList" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with an array of OAS schema defined at "#/components/schemas/Subscription"
    And the response body lists all subscriptions belonging to the API consumer

  @reachability_status_subscriptions_05_retrieve_list_3legs
  Scenario: Check existing subscription(s) is/are retrieved in list
    Given the API consumer has at least one active subscription for the device
    And the header "Authorization" is set to a valid access token which identifies a valid device associated with one or more subscriptions
    When the request "retrieveDeviceReachabilityStatusSubscriptionList" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with an array of OAS schema defined at "#/components/schemas/Subscription"
    And the response body lists all subscriptions belonging to the API consumer for the identified device
    And the response property "$.config.subscriptionDetail.device" is not present in any of the subscription records

  @reachability_status_subscriptions_06_retrieve_empty_list_3legs
  Scenario: Check no existing subscription is retrieved in list
    Given the API consumer has no active subscriptions for the device
    And the header "Authorization" is set to a valid access token which identifies a valid device
    When the request "retrieveDeviceReachabilityStatusSubscriptionList" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an empty array

  @reachability_status_subscriptions_07_delete_subscription_based_on_an_existing_subscription-id
  Scenario: Delete the subscription with subscriptionId equal to "id"
    Given the API consumer has an active subscription with "subscriptionId" equal to "id"
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
    And the path parameter "subscriptionId" is set to "id"
    Then the response status code is 202 or 204
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And if the response property "$.status" is 204 then response body is not present
    And if the response property "$.status" is 202 then response body complies with the OAS schema at "#/components/schemas/SubscriptionAsync" and the response property "$.id" is equal to "id"

  @reachability_status_subscriptions_08_receive_notification_when_device_reachability_changed_to_data_usage
  Scenario: Receive notification for reachability-data event
    Given a valid subscription for that device exists with "subscriptionId" equal to "id"
    And the subscription property "$.types" contains the element "org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data"
    And the subscription property "$.sink" is a valid callback URL
    And the device does not have data connectivity with the API provider's network
    When the device's data connectivity status changes (e.g. data connectivity is enabled)
    Then event notification "reachability-data" is sent to the specified callback URL
    And the sink credentials specified when the subscription was created are included
    And notification body complies with the OAS schema at "#/components/schemas/EventReachabilityData"
    And the notification property "$.type" is equal to "org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data"
    And the notification property "$.data.subscriptionId" is equal to "id"

  @reachability_status_subscriptions_09_receive_notification_when_device_reachability_changed_to_sms_usage
  Scenario: Receive notification for reachability-sms event
    Given a valid subscription for that device exists with "subscriptionId" equal to "id"
    And the subscription property "$.types" contains the element "org.camaraproject.device-reachability-status-subscriptions.v0.reachability-sms"
    And the subscription property "$.sink" is a valid callback URL
    And the device does not have sms connectivity with the API provider's network
    When the device's sms connectivity status changes (e.g. sms connectivity is enabled)
    Then event notification "reachability-sms" is sent to the specified callback URL
    And the sink credentials specified when the subscription was created are included
    And notification body complies with the OAS schema at "#/components/schemas/EventReachabilitySms"
    And the notification property "$.type" is equal to "org.camaraproject.device-reachability-status-subscriptions.v0.reachability-sms"
    And the notification property "$.data.subscriptionId" is equal to "id"

  @reachability_status_subscriptions_10_receive_notification_when_device_reachability_changed_to_disconnected
  Scenario: Receive notification for reachability-disconnected event
    Given a valid subscription for that device exists with "subscriptionId" equal to "id"
    And the subscription property "$.types" contains the element "org.camaraproject.device-reachability-status-subscriptions.v0.reachability-disconnected"
    And the subscription property "$.sink" is a valid callback URL
    And the device has data and/or sms connectivity with the API provider's network
    When the device loses all connectivity with the API provider's network (e.g. the device is switched off)
    Then event notification "reachability-disconnected" is sent to the specified callback URL
    And the sink credentials specified when the subscription was created are included
    And notification body complies with the OAS schema at "#/components/schemas/EventReachabilityDisconnected"
    And the notification property "$.type" is equal to "org.camaraproject.device-reachability-status-subscriptions.v0.reachability-disconnected"
    And the notification property "$.data.subscriptionId" is equal to "id"

  @reachability_status_subscriptions_11_subscription_expiry
  Scenario: Receive notification for subscription-ends event on expiry
    Given a valid subscription for a device exists with "subscriptionId" equal to "id"
    And the subscription property "$.subscriptionExpireTime" is set to a value in the near future
    And the subscription property "$.sink" is a valid callback URL
    When the subscriptionExpireTime is reached
    Then a subscription termination event notification is sent to the callback URL
    And the notification body complies with the OAS schema at "#/components/schemas/EventSubscriptionEnds"
    And the notification property "$.type" is "org.camaraproject.device-reachability-status-subscriptions.v0.subscription-ends"
    And the notification property "$.data.subscriptionId" is equal to "id"
    And the notification property "$.data.terminationReason" is equal to "SUBSCRIPTION_EXPIRED"

  @reachability_status_subscriptions_12_subscription_end_when_max_events
  Scenario: Receive notification for subscription-ends event on max events reached
    Given a valid subscription for a device exists with "subscriptionId" equal to "id"
    And the subscription property "$.subscriptionMaxEvents" is set to 1
    And the subscription property "$.sink" is a valid callback URL
    When a single notification corresponding to subscription property "$.type" has been sent to the callback URL
    Then a subscription termination event notification is sent to the callback URL
    And the notification body complies with the OAS schema at "#/components/schemas/EventSubscriptionEnds"
    And the notification property "$.type" is equal to "org.camaraproject.device-reachability-status-subscriptions.v0.subscription-ends"
    And the notification property "$.data.subscriptionId" is equal to "id"
    And the notification request property "$.data.terminationReason" is equal to "MAX_EVENTS_REACHED"

  @reachability_status_subscriptions_13_subscription_delete_event_validation
  Scenario: Receive notification for subscription-ends event on deletion
    Given a valid subscription for a device exists with "subscriptionId" equal to "id"
    And the subscription property "$.sink" is a valid callback URL
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
    And the path parameter "subscriptionId" is set to "id"
    And the response status code is 202 or 204
    Then a subscription termination event notification is sent to the callback URL
    And the notification body complies with the OAS schema at "#/components/schemas/EventSubscriptionEnds"
    And the notification property "$.type" is equal to "org.camaraproject.device-reachability-status-subscriptions.v0.subscription-ends"
    And the notification property "$.data.subscriptionId" is equal to "id"
    And the notification request property "$.data.terminationReason" is equal to "SUBSCRIPTION_DELETED"

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
    When the request "createDeviceReachabilityStatusSubscription" is sent
    And a valid subscription request body
    And "$.protocol" <> "HTTP"
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_PROTOCOL"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_400.5_create_subscription_with_invalid_credential_type
  Scenario: subscription creation with invalid credential type
    Given use BaseURL
    When the request "createDeviceReachabilityStatusSubscription" is sent
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
    When the request "createDeviceReachabilityStatusSubscription" is sent
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
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_creation_401.2_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And use BaseUrL
    And the request body is set to a valid request body
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_creation_401.3_malformed_access_token
  Scenario: Malformed access token
    Given the header "Authorization" is set to a malformed token
    And use BaseUrL
    And the request body is set to a valid request body
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_retrieve_401.4_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And use BaseUrL
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_retrieve_401.5_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And use BaseUrL
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_retrieve_401.6_malformed_access_token
  Scenario: Malformed access token
    Given the header "Authorization" is set to a malformed token
    And use BaseUrL
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent
    Then the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_delete_401.7_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And use BaseUrL
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_delete_401.8_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And use BaseUrL
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_delete_401.9_malformed_access_token
  Scenario: Malformed access token
    Given the header "Authorization" is set to a malformed token
    And use BaseUrL
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
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
    Given header "Authorization" set to an access token not including scope "device-reachability-status-subscriptions:org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data:create"
    And use BaseUrL
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_create_403.2_subscription_mismatch_for_requested_events_subscription
  Scenario: subscription creation with invalid access token for requested events subscription
    # To test this, a token contains an unsupported event type for this API
    Given a valid subscription request body
    And use BaseUrL
    And the request body property "$.device" is set to a valid testing device supported by the service
    And the request body property "$.types" contains the supported event type in this API
    When the request "createDeviceReachabilityStatusSubscription" is sent
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
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent with subscriptionId="id"
    Then the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_404.2_delete_unknown_subscription_id
  Scenario: Delete subscription with subscription-id unknown to the system
    Given the path parameter "subscriptionId" is set to the value unknown to system
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
    Then the response code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text
