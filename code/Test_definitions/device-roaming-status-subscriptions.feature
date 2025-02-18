Feature: Device Roaming Status Subscriptions API, v0.7.0-rc.1 - - Operation to manage roaming subscriptions

  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * List of device identifier types which are not supported, among: phoneNumber, networkAccessIdentifier, ipv4Address, ipv6Address
  #
  # Testing assets:
  # * A device object which roaming status is known by the network when connected.
  # * The known roaming status of the testing device
  # * A sink-url identified as "callbackUrl", which receives notifications
  #
  # References to OAS spec schemas refer to schemas specified in device-roaming-status-subscriptions.yaml, version vwip

  Background: Common Device Roaming Status Subscriptions setup
    Given the resource "{apiroot}/device-roaming-status-subscriptions/v0.7rc1/subscriptions" as base-url
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value

##########################
# Happy path scenarios
##########################

  @roaming_status_subscriptions_01_sync_creation
  Scenario Outline: Check sync subscription creation - This scenario could be bypass if async creation is provided (following scenario)
    Given use BaseURL
    When the request "createDeviceReachabilityStatusSubscription" is sent
    And "$.types" is one of the allowed values "<subscription-creation-types>"
    And "$.protocol"="HTTP"
    And a valid phone number identified by the token or provided in the request body
    And "$.sink" is set to provided callbackUrl
    Then the response code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And types, protocol, sink and config.subscriptionDetail.phoneNumber are present with provided value
    And startsAt is valued with a datetime corresponding to the date time of the response

    Examples:
      | subscription-creation-types                                                             |
      | org.camaraproject.device-roaming-status-subscriptions.v0.roaming-status                 |
      | org.camaraproject.device-roaming-status-subscriptions.v0.roaming-on                     |
      | org.camaraproject.device-roaming-status-subscriptions.v0.roaming-off                    |
      | org.camaraproject.device-roaming-status-subscriptions.v0.roaming-change-country         |

  @roaming_status_subscriptions_02_async_creation
  Scenario Outline: Check async subscription creation - This scenario could be bypass if previous scenario is provided
    Given use BaseURL
    When the request "createDeviceReachabilityStatusSubscription" is sent
    And "$.types" is one of the allowed values "<subscription-creation-types>"
    And "$.protocol"="HTTP"
    And a valid phone number identified by the token or provided in the request body
    And "$.sink" is set to provided callbackUrl
    Then the response code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionAsync"

    Examples:
      | subscription-creation-types                                                             |
      | org.camaraproject.device-roaming-status-subscriptions.v0.roaming-status                 |
      | org.camaraproject.device-roaming-status-subscriptions.v0.roaming-on                     |
      | org.camaraproject.device-roaming-status-subscriptions.v0.roaming-off                    |
      | org.camaraproject.device-roaming-status-subscriptions.v0.roaming-change-country         |

  @roaming_status_subscriptions_03_retrieve_by_id
  Scenario: Check existing subscription is retrieved by id
    Given a subscription is existing and identified by an "id"
    And use BaseURL
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent with subscriptionId="id"
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"

  @roaming_status_subscriptions_04_retrieve_list_2legs
  Scenario: Check existing subscription(s) is/are retrieved in list
    Given at least one subscription is existing for the API client making this request
    And use BaseURL
    When the request "retrieveDeviceReachabilityStatusSubscriptionList" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with an array of OAS schema defined at "#/components/schemas/Subscription"
    And subscription(s) is/are listed

  @roaming_status_subscriptions_05_retrieve_list_3legs
  Scenario: Check existing subscription(s) is/are retrieved in list
    Given a subscription is existing for the device
    And this device is identified by the token
    And use BaseURL
    When the request "retrieveDeviceReachabilityStatusSubscriptionList" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with an array of OAS schema defined at "#/components/schemas/Subscription"
    And the subscriptions for this device are listed

  @roaming_status_subscriptions_06_retrieve_empty_list_3legs
  Scenario: Check no existing subscription is retrieved in list
    Given no subscription is existing for the device
    And this device is identified by the token
    And use BaseURL
    When the request "retrieveDeviceReachabilityStatusSubscriptionList" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an empty list

  @roaming_status_subscriptions_07_delete_subscription_based_on_an_existing_subscription-id
  Scenario: Delete a subscription based on existing subscription-id.
    Given the path parameter "subscriptionId" is set to the identifier of an existing subscription
    When the request "deleteDeviceReachabilityStatusSubscription" is sent with subscriptionId="id"
    Then the response code is 202 or 204
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And if the response property $.status is 204 then response body is not available
    And if the response property $.status is 202 then response body complies with the OAS schema at "#/components/schemas/SubscriptionAsync"

  @roaming_status_subscriptions_08_receive_notification_when_roaming_status_changed_to_on
  Scenario: Receive notification for roaming-on event
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.types" contains the element "org.camaraproject.device-roaming-status-subscriptions.v0.roaming-on"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response code is 201
    And if the device switch from roaming "OFF" to roaming "ON"
    And event notification "org.camaraproject.device-roaming-status-subscriptions.v0.roaming-on" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "#/components/schemas/EventRoamingOn"
    And type="org.camaraproject.roaming-status-subscriptions.v0.roaming-on"

  @roaming_status_subscriptions_09_receive_notification_when_roaming_status_changed_to_off
  Scenario: Receive notification for roaming-off event
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.types" contains the element "org.camaraproject.device-roaming-status-subscriptions.v0.roaming-off"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response code is 201
    And if the device switch from roaming "ON" to roaming "OFF"
    Then event notification "org.camaraproject.device-roaming-status-subscriptions.v0.roaming-off" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "#/components/schemas/EventRoamingOff"
    And type="org.camaraproject.roaming-status-subscriptions.v0.roaming-off"

  @roaming_status_subscriptions_10_receive_notification_when_roaming_status_changed
  Scenario: Receive notification for roaming-status changes
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.types" contains the element "org.camaraproject.device-roaming-status-subscriptions.v0.roaming-status"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response code is 201
    And if the device roaming-status changes
    Then event notification "roaming-status" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "#/components/schemas/EventRoamingStatus"
    And type="org.camaraproject.roaming-status-subscriptions.v0.roaming-status"

  @roaming_status_subscriptions_11_receive_notification_when_roaming_change_country
  Scenario: Receive notification for roaming-change-country
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.types" contains the element "org.camaraproject.device-roaming-status-subscriptions.v0.roaming-change-country"
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response code is 201
    And if the device roaming country changes
    Then event notification "org.camaraproject.device-roaming-status-subscriptions.v0.roaming-change-country" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "#/components/schemas/RoamingChangeCountry"
    And type="org.camaraproject.roaming-status-subscriptions.v0.roaming-change-country"

  @roaming_status_subscriptions_12_subscription_expiry
  Scenario: Receive notification for subscription-ends event on expiry
    Given that subscriptions are created synchronously
    When the request "createDeviceReachabilityStatusSubscription" is sent
    And a valid subscription request body
    And the request body property "$.subscriptionExpireTime" is set to a value in the near future
    Then the response code is 201
    And the subscription is expired
    And event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "#/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.device-roaming-status-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "SUBSCRIPTION_EXPIRED"

  @roaming_status_subscriptions_13_subscription_end_when_max_events
  Scenario: Receive notification for subscription-ends event on max events reached
    Given that subscriptions are created synchronously
    When the request "createDeviceReachabilityStatusSubscription" is sent
    And a valid subscription request body
    And the request body property "$.types" contains the element "org.camaraproject.device-roaming-status-subscriptions.v0.roaming-status"
    And the request body property "$.subscriptionMaxEvents" is set to 1
    Then the response code is 201
    And event notification " org.camaraproject.device-roaming-status-subscriptions.v0.roaming-status" is received on callback-url
    And event notification "org.camaraproject.device-roaming-status-subscriptions.v0.subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "#/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.device-roaming-status-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "MAX_EVENTS_REACHED"

  @roaming_status_subscriptions_14_subscription_delete_event_validation
  Scenario: Receive notification for subscription-ends event on deletion
    Given that subscriptions are created synchronously
    When the request "createDeviceReachabilityStatusSubscription" is sent
    And a valid subscription request body
    Then the response code is 201
    When the request "deleteDeviceReachabilityStatusSubscription" is sent with subscriptionId="id"
    Then the response code is 202 or 204
    And event notification "org.camaraproject.device-roaming-status-subscriptions.v0.subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "#/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.device-roaming-status-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "SUBSCRIPTION_DELETED"

################
# Error scenarios for management of input parameter device
##################

  @roaming_status_subscriptions_C01.01_device_empty
  Scenario: The device value is an empty object
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" is set to: {}
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_C01.02_device_identifiers_not_schema_compliant
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
  @roaming_status_subscriptions_C01.03_device_not_found
  Scenario: Some identifier cannot be matched to a device
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" is compliant with the schema but does not identify a valid device
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_C01.04_unnecessary_device
  Scenario: Device not to be included when it can be deduced from the access token
    Given the header "Authorization" is set to a valid access token identifying a device
    And the request body property "$.device" is set to a valid device
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
    And the response property "$.message" contains a user-friendly text

  @roaming_status_subscriptions_C01.05_missing_device
  Scenario: Device not included and cannot be deduced from the access token
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" is not included
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "MISSING_IDENTIFIER"
    And the response property "$.message" contains a user-friendly text

  @roaming_status_subscriptions_C01.06_unsupported_device
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
  @roaming_status_subscriptions_C01.07_device_not_supported
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
  @roaming_status_subscriptions_C01.08_device_identifiers_mismatch
  Scenario: Device identifiers mismatch
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And at least 2 types of device identifiers are supported by the implementation
    And the request body property "$.device" includes several identifiers, each of them identifying a valid but different device
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "IDENTIFIER_MISMATCH"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_C01.08_multi_event_not_supported
  Scenario: Device identifiers mismatch
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And "$.types" includes more than one subscription-type
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "MULTIEVENT_SUBSCRIPTION_NOT_SUPPORTED"
    And the response property "$.message" contains a user friendly text

##################
# Error code 400
##################

  @roaming_status_subscriptions_400.1_create_subscription_with_invalid_parameter
  Scenario: Create subscription with invalid parameter
    Given use BaseURL
    When the request body is not compliant with the schema "#/components/schemas/SubscriptionRequest"
    And the HTTP "POST" request is sent
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_400.2_create_subscription_with_invalid_subscription_expire_time
  Scenario: Expiry time in past
    Given use BaseURL
    When a valid subscription request body
    And the HTTP "POST" request is sent
    And "$.config.subscriptionExpireTime" is set in the past
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_400.3_invalid_eventType
  Scenario: Subscription creation with invalid event type
    Given use BaseURL
    When a valid subscription request body
    And the HTTP "POST" request is sent
    And the request body property "$.types" is set to invalid value
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_400.4_invalid_protocol
  Scenario: subscription creation with invalid protocol
    Given use BaseURL
    When the request "createDeviceReachabilityStatusSubscription" is sent
    And a valid subscription request body
    And "$.protocol" <> "HTTP"
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_PROTOCOL"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_400.5_create_subscription_with_invalid_credential_type
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

  @roaming_status_subscriptions_400.6_create_subscription_with_invalid_access_token_type
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

  @roaming_status_subscriptions_creation_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And use BaseUrL
    And the request body is set to a valid request body
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_creation_401.2_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And use BaseUrL
    And the request body is set to a valid request body
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_creation_401.3_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And use BaseUrL
    And the request body is set to a valid request body
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_retrieve_401.4_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And use BaseUrL
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_retrieve_401.5_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And use BaseUrL
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_retrieve_401.6_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And use BaseUrL
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent
    Then the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_delete_401.7_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And use BaseUrL
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_delete_401.8_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And use BaseUrL
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_delete_401.9_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And use BaseUrL
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
    Then the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text


##################
# Error code 403
##################

  @roaming_status_subscriptions_create_403.1_permission_denied
  Scenario: subscription creation without having the required scope
    # To test this, a token does not have the required scope
    Given header "Authorization" set to access token referring different scope
    And use BaseUrL
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_create_403.2_invalid_token_context
  Scenario: subscription creation with invalid access token context for requested events subscription
    # To test this, a token does not have the required device identifier
    Given a valid subscription request body
    And use BaseUrL
    And the request body property "$.device" is set to a valid testing device supported by the service
    And header "Authorization" set to access token referring different device
    When the request "createDeviceReachabilityStatusSubscription" is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_create_403.3_subscription_mismatch_for_requested_events_subscription
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

  @roaming_status_subscriptions_404.1_retrieve_unknown_subscription_id
  Scenario: Get subscription when subscription-id is unknown to the system
    Given the path parameter property "$.subscriptionId" is unknown to the system
    And use BaseUrL
    When the request "retrieveDeviceReachabilityStatusSubscription" is sent with subscriptionId="id"
    Then the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @roaming_status_subscriptions_404.2_delete_unknown_subscription_id
  Scenario: Delete subscription with subscription-id unknown to the system
    Given the path parameter "subscriptionId" is set to the value unknown to system
    When the request "deleteDeviceReachabilityStatusSubscription" is sent
    Then the response code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text
