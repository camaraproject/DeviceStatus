@Device_Roaming_Status
Feature: CAMARA Device Roaming Status API, vwip - Operation getRoamingStatus
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * List of device identifier types which are not supported, among: phoneNumber, networkAccessIdentifier, ipv4Address, ipv6Address
  #
  # Testing assets:
  # * A device object which roaming status is known by the network when connected.
  # * The known roaming status of the testing device
  #
  # References to OAS spec schemas refer to schemas specifies in device-roaming-status.yaml

  Background: Common getRoamingStatus setup
    Given the resource "{api-root}/device-roaming-status/vwip/retrieve" set as base-url
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is set by default to a request body compliant with the schema

##########################
# Happy path scenarios
##########################

  @device_roaming_status_01_roaming_status_true_with_country_code
  Scenario: Check the roaming status when device is in the roaming mode
    Given a valid testing device supported by the service, identified by the token or provided in the request body
    And the request body is set to a valid request body
    And the device which is in roaming inside Germany and supported by the service
    When the request "getRoamingStatus" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/RoamingStatusResponse"
    And the response property "$.roaming" is "true"
    And the response property "$.countryCode" has the value "262" as the Mobile Country Code (MCC) for Germany
    And the response property "$.countryName" is a non-empty array containing the ISO 3166 ALPHA-2 country-code ["DE"]
    And if the response property "$.lastStatusTime" is present, then the value has a valid date-time format

  @device_roaming_status_02_roaming_status_false
  Scenario: Check the roaming state synchronously if the device is not in the roaming mode
    Given a valid testing device supported by the service, identified by the token or provided in the request body
    And the request body is set to a valid request body
    And the device which is not in roaming and supported by the service
    When the request "getRoamingStatus" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/RoamingStatusResponse"
    And the response property "$.roaming" is "false"
    And the response property "$.countryCode" is not present
    And the response property "$.countryName" is not present
    And if the response property "$.lastStatusTime" is present, then the value is a valid date-time format

#################
# Error scenarios for management of input parameter device
##################

  @device_roaming_status_C01.01_device_empty
  Scenario: The device value is an empty object
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" is set to: {}
    When the request "getRoamingStatus" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @device_roaming_status_C01.02_device_identifiers_not_schema_compliant
  Scenario Outline: Some device identifier value does not comply with the schema
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "<device_identifier>" does not comply with the OAS schema at "<oas_spec_schema>"
    When the request "getRoamingStatus" is sent
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
  @device_roaming_status_C01.03_device_not_found
  Scenario: Some identifier cannot be matched to a device
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" is compliant with the schema, but does not identify a device whose connectivity is managed by the API provider
    When the request "getRoamingStatus" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @device_roaming_status_C01.04_unnecessary_device
  Scenario: Device not to be included when it can be deduced from the access token
    Given the header "Authorization" is set to a valid access token identifying a device
    And the request body property "$.device" is set to a valid device, which may or may not be the same device that is identified by the access token
    When the request "getRoamingStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
    And the response property "$.message" contains a user-friendly text

  @device_roaming_status_C01.05_missing_device
  Scenario: Device not included and cannot be deduced from the access token
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" is not included
    When the request "getRoamingStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "MISSING_IDENTIFIER"
    And the response property "$.message" contains a user-friendly text

  @device_roaming_status_C01.06_unsupported_device
  Scenario: None of the provided device identifiers is supported by the implementation
    Given that some types of device identifiers are not supported by the implementation
    And the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" only includes device identifiers not supported by the implementation
    When the request "getRoamingStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNSUPPORTED_IDENTIFIER"
    And the response property "$.message" contains a user-friendly text

  # When the service is only offered to certain types of devices or subscriptions, e.g. IoT, B2C, etc.
  @device_roaming_status_C01.07_device_not_supported
  Scenario: Service not available for the device
    Given that the service is not available for all devices commercialized by the operator
    And a valid device, identified by the token or provided in the request body, for which the service is not applicable
    When the request "getRoamingStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
    And the response property "$.message" contains a user-friendly text

  # Several identifiers provided but they do not identify the same device
  # This scenario may happen with 2-legged access tokens, which do not identify a device
  @device_roaming_status_C01.08_device_identifiers_mismatch
  Scenario: Device identifiers mismatch
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And at least 2 types of device identifiers are supported by the implementation
    And the request body property "$.device" includes several identifiers, each of them identifying a valid but different device
    When the request "getRoamingStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "IDENTIFIER_MISMATCH"
    And the response property "$.message" contains a user friendly text

#################
# Error code 401
#################

  @device_roaming_status_401.1_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the request body is set to a valid request body
    When the request "getRoamingStatus" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @device_roaming_status_401.2_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is set to a valid request body
    When the request "getRoamingStatus" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @device_roaming_status_401.3_malformed_access_token
  Scenario: Malformed access token
    Given the header "Authorization" is set to a malformed token
    And the request body is set to a valid request body
    When the request "getRoamingStatus" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
    And the response property "$.message" contains a user friendly text

#################
# Error code 403
#################

  @device_roaming_status_403_permission_denied
   Scenario: OAuth2 token access does not have the required scope
    Given header "Authorization" set to an access token not including scope "device-roaming-status:read"
    And the request body is set to a valid request body
    When the request "getRoamingStatus" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

#################
# Error code 503
#################

  @device_roaming_status_503_network_error
   Scenario: Network error temporarily prevents the device roaming status from being retrieved
    # This test is for use by the API provider only
    Given a valid testing device supported by the service, identified by the token or provided in the request body
    And the request body is set to a valid request body
    And the device is supported by the service, and may be roaming or not roaming
    When the request "getRoamingStatus" is sent
    And a network error prevents the device roaming status from being retrieved
    Then the response status code is 503
    And the response property "$.status" is 503
    And the response property "$.code" is "UNAVAILABLE"
    And the response property "$.message" contains a user friendly text indicating a temporary network error
