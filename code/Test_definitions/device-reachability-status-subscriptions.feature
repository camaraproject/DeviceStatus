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

################
# Error scenarios for management of input parameter device
##################

  @reachability_status_subscriptions_C01.01_device_empty
  Scenario: The device value is an empty object
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" is set to: {}
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_C01.02_device_identifiers_not_schema_compliant
  Scenario Outline: Some device identifier value does not comply with the schema
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "<device_identifier>" does not comply with the OAS schema at "<oas_spec_schema>"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

    Examples:
      | device_identifier          | oas_spec_schema                             |
      | $.device.phoneNumber       | /components/schemas/PhoneNumber             |
      | $.device.ipv4Address       | /components/schemas/DeviceIpv4Addr          |
      | $.device.ipv6Address       | /components/schemas/DeviceIpv6Address       |
      | $.device.networkIdentifier | /components/schemas/NetworkAccessIdentifier |

  # This scenario may happen e.g. with 2-legged access tokens, which do not identify a single device.
  @reachability_status_subscriptions_C01.03_device_not_found
  Scenario: Some identifier cannot be matched to a device
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" is compliant with the schema but does not identify a device whose connectivity is managed by the API provider
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_C01.04_unnecessary_device
  Scenario: Device not to be included when it can be deduced from the access token
    Given the header "Authorization" is set to a valid access token identifying a device
    And the request body property "$.device" is also set to a valid device, which may or may not be the same device
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
    And the response property "$.message" contains a user-friendly text

  @reachability_status_subscriptions_C01.05_missing_device
  Scenario: Device not included and cannot be deduced from the access token
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" is not included
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "MISSING_IDENTIFIER"
    And the response property "$.message" contains a user-friendly text

  @reachability_status_subscriptions_C01.06_unsupported_device
  Scenario: None of the provided device identifiers is supported by the implementation
    Given that some types of device identifiers are not supported by the implementation
    And the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" only includes device identifiers not supported by the implementation
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNSUPPORTED_IDENTIFIER"
    And the response property "$.message" contains a user-friendly text

  # When the service is only offered to certain types of devices or subscriptions, e.g. IoT, B2C, etc.
  @reachability_status_subscriptions_C01.07_device_not_supported
  Scenario: Service not available for the device
    Given that the service is not available for all devices commercialized by the operator
    And a valid device, identified by the token or provided in the request body, for which the service is not applicable
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
    And the response property "$.message" contains a user-friendly text

  # Several identifiers provided but they do not identify the same device
  # This scenario may happen with 2-legged access tokens, which do not identify a device
  @reachability_status_subscriptions_C01.08_device_identifiers_mismatch
  Scenario: Device identifiers mismatch
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And at least 2 types of device identifiers are supported by the implementation
    And the request body property "$.device" includes several identifiers, each of them identifying a valid but different device
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "IDENTIFIER_MISMATCH"
    And the response property "$.message" contains a user friendly text

##################
# Error code 400
##################

  @reachability_status_subscriptions_400.1_create_subscription_with_invalid_parameter
  Scenario: Create subscription with invalid parameter
    Given the request body is not compliant with the schema "#/components/schemas/SubscriptionRequest"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_400.2_create_subscription_with_invalid_subscription_expire_time
  Scenario: Expiry time in past
    Given the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    And the request property "$.config.subscriptionExpireTime" is set to a time in the past
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_400.3_invalid_eventType
  Scenario: Subscription creation with invalid event type
    Given the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    And the request body property "$.types" is set to an invalid value
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_400.4_invalid_protocol
  Scenario: subscription creation with invalid protocol
    Given the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    And the request property "$.protocol" is not equal to "HTTP"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_PROTOCOL"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_400.5_create_subscription_with_invalid_credential_type
  Scenario: subscription creation with invalid credential type
    Given the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    And the request property "$.sinkCredential.accessTokenType" is equal to "bearer"
    And the request property "$.sinkCredential.credentialType" is not equal to "ACCESSTOKEN"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_CREDENTIAL"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_400.6_create_subscription_with_invalid_access_token_type
  Scenario: subscription creation with invalid token
    Given the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    And the request property "$.sinkCredential.credentialType" is equal to "ACCESSTOKEN"
    And the request property "$.sinkCredential.accessTokenType" is not equal to "bearer"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_TOKEN"
    And the response property "$.message" contains a user friendly text

##################
# Error code 401
##################

  @reachability_status_subscriptions_creation_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_creation_401.2_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to a previously valid but now expired access token
    And the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_creation_401.3_malformed_access_token
  Scenario: Malformed access token
    Given the header "Authorization" is set to a malformed token
    And the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_retrieve_401.4_no_authorization_header
  Scenario: No Authorization header
    Given the request header "Authorization" is removed
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_retrieve_401.5_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to a previously valid but now expired access token
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_retrieve_401.6_malformed_access_token
  Scenario: Malformed access token
    Given the header "Authorization" is set to a malformed token
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_delete_401.7_no_authorization_header
  Scenario: No Authorization header
    Given the request header "Authorization" is removed
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_delete_401.8_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to a previously valid but now expired access token
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_delete_401.9_malformed_access_token
  Scenario: Malformed access token
    Given the header "Authorization" is set to a malformed token
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_retrieve__list_401.10_no_authorization_header
  Scenario: No Authorization header
    Given the request header "Authorization" is removed
    When the request "retrieveDeviceReachabilityStatusSubscriptionList" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_retrieve_list_401.11_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to a previously valid but now expired access token
    When the request "retrieveDeviceReachabilityStatusSubscriptionList" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_retrieve_list_401.12_malformed_access_token
  Scenario: Malformed access token
    Given the header "Authorization" is set to a malformed token
    When the request "retrieveDeviceReachabilityStatusSubscriptionList" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

##################
# Error code 403
##################

  @reachability_status_subscriptions_create_403.1_permission_denied
  Scenario: Subscription creation without having the required scope
    # To test this, a token must not have the required scope
    Given the header "Authorization" set to an access token not including scope "device-reachability-status-subscriptions:org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data:create"
    And the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    And the request body property "$.types" is equal to "device-reachability-status-subscriptions:org.camaraproject.device-reachability-status-subscriptions.v0.reachability-data"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_create_403.2_permission_denied
  Scenario: Subscription creation without having the required scope
    # To test this, a token must not have the required scope
    Given the header "Authorization" set to an access token not including scope "device-reachability-status-subscriptions:org.camaraproject.device-reachability-status-subscriptions.v0.reachability-sms:create"
    And the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    And the request body property "$.types" is equal to "device-reachability-status-subscriptions:org.camaraproject.device-reachability-status-subscriptions.v0.reachability-sms"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_create_403.3_permission_denied
  Scenario: Subscription creation without having the required scope
    # To test this, a token must not have the required scope
    Given the header "Authorization" set to an access token not including scope "device-reachability-status-subscriptions:org.camaraproject.device-reachability-status-subscriptions.v0.reachability-disconnected:create"
    And the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    And the request body property "$.types" is equal to "device-reachability-status-subscriptions:org.camaraproject.device-reachability-status-subscriptions.v0.reachability-disconnected"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_create_403.4_subscription_mismatch_for_requested_events_subscription
  Scenario: Subscription creation with invalid access token for requested events subscription
    Given the header "Authorization" set to an access token that includes only a single subscription scope
    And the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    And the request body property "$.types" is equal to a valid type other than the event corresponding to the access token scope
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "SUBSCRIPTION_MISMATCH"
    And the response property "$.message" contains a user friendly text

##################
# Error code 404
##################

  @reachability_status_subscriptions_404.1_retrieve_unknown_subscription_id
  Scenario: Get subscription when subscriptionId is unknown to the system
    Given that there is no valid subscription with "subscriptionId" equal to "id"
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent
    And the path parameter "subscriptionId" is equal to "id"
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @reachability_status_subscriptions_404.2_delete_unknown_subscription_id
  Scenario: Delete subscription with subscriptionId unknown to the system
    Given that there is no valid subscription with "subscriptionId" equal to "id"
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
    And the path parameter "subscriptionId" is equal to "id"
    Then the response code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

##################
# Error code 422
##################

  @reachability_status_subscriptions_422.1_multi_event_not_supported
  Scenario: Multi-event subscriptions are not supported
    Given a valid 2- or 3-legged access token
    And a request body that is compliant with the OAS schema at "#/component/schemas/SubscriptionRequest"
    And request property "$.types" includes more than one subscription-type
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "MULTIEVENT_SUBSCRIPTION_NOT_SUPPORTED"
    And the response property "$.message" contains a user friendly text
