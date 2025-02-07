Feature: CAMARA Device Reachability Status API, vwip - Operation getReachabilityStatus
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * List of device identifier types which are not supported, among: phoneNumber, networkAccessIdentifier, ipv4Address, ipv6Address
  #
  # Testing assets:
  # * A device object which reachability status is known by the network when connected.
  # * The known reachability status of the testing device
  #
  # References to OAS spec schemas refer to schemas specifies in device-reachability-status.yaml

  Background: Common Device reachability status setup
    Given the resource "{api-root}/device-reachability-status/vwip/retrieve" set as base-url

    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is set by default to a request body compliant with the schema

  ############# Happy Path Scenarios ##################

  @device_reachability_status_01_reachable_and_connected_sms
  Scenario: Check the reachability status if device is connected with SMS
    Given a valid device reachability status request body
    And the request body is set to a valid request body
    And the device is connected with sms and supported by the service
    When the HTTP "POST" request is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ReachabilityStatusResponse"
    And the response property "$.reachable" is true
    And the response property "$.connectivity" includes "SMS"

  @device_reachability_status_02_reachable_and_connected_data
  Scenario: Check the reachability status if device is connected with DATA
    Given a valid device reachability status request body
    And the request body is set to a valid request body
    And the device is connected with data and supported by the service
    When the HTTP "POST" request is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ReachabilityStatusResponse"
    And the response property "$.reachable" is true
    And the response property "$.connectivity" includes "DATA"

  @device_reachability_status_03_reachable_and_connected_data_and_sms
  Scenario: Check the reachability status if device is connected with DATA and SMS
    Given a valid device reachability status request body
    And the request body is set to a valid request body
    And the device is connected with data and sms and supported by the service
    When the HTTP "POST" request is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ReachabilityStatusResponse"
    And the response property "$.reachable" is true
    And the response property "$.connectivity" includes both "DATA" and "SMS"

  @device_reachability_status_04_not_reachable
  Scenario: Check the reachability status for an unreachable device
    Given a valid device reachability status request body
    And the request body is set to a valid request body
    And the device is not connected and supported by the service
    When the HTTP "POST" request is sent
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ReachabilityStatusResponse"
    And the response property "$.reachable" is false
    And the response property "$.connectivity" is not returned

  #############Error Response Scenarios##################

  # Generic 400 errors

  @device_reachability_status_400.1_device_identifiers_not_schema_compliant
  Scenario Outline: Some device identifier value does not comply with the schema
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "<device_identifier>" does not comply with the OAS schema at "<oas_spec_schema>"
    When the HTTP "POST" request is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

    Examples:
      | device_identifier          | oas_spec_schema                             |
      | $.device.phoneNumber       | /components/schemas/PhoneNumber             |
      | $.device.ipv4Address       | /components/schemas/NetworkAccessIdentifier |
      | $.device.ipv6Address       | /components/schemas/DeviceIpv4Addr          |
      | $.device.networkIdentifier | /components/schemas/DeviceIpv6Address       |

  @device_reachability_status_400.2_device_phoneNumber_schema_compliant
  # Example of the scenario above with a higher level of specification
  # TBD if test plan has to provide specific testing values to provoke an error
  Scenario Outline: Device identifier phoneNumber value does not comply with the schema
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device.phoneNumber" is set to: <phone_number_value>
    When the HTTP "POST" request is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

    Examples:
      | phone_number_value |
      | string_value       |
      | 1234567890         |
      | +12334foo22222     |
      | +00012230304913849 |
      | 123                |
      | ++49565456787      |

  # Generic 401 errors

  @device_reachability_status_401.1_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @device_reachability_status_401.2_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @device_reachability_status_401.3_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Generic 403 errors

  @device_reachability_status_403_permission_denied
  Scenario: OAuth2 token access does not have the required scope
    # To test this, a token has to be obtained for a different device
    Given the header "Authorization" is set to a valid access token, but without the required scope
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  # Generic 422 errors

  @device_reachability_status_422.1_device_identifiers_mismatch
  Scenario: Device identifiers mismatch
    # To test this, at least 2 types of identifiers have to be provided, e.g. a phoneNumber and the IP address of a device associated to a different phoneNumber
    Given that config_var "identifier_types_unsupported" contains at least 2 items
    And the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" includes several identifiers, each of them identifying a valid but different device
    When the HTTP "POST" request is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "IDENTIFIER_MISMATCH"
    And the response property "$.message" contains a user friendly text

  @device_reachability_status_422.2_service_not_applicable
  Scenario: Service not applicable
    Given the request body includes a device identifier not applicable for this service
    When the HTTP "POST" request is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
    And the response property "$.message" contains "Service is not available for the provided device identifier."

  @device_reachability_status_422.3_unsupported_device_identifier
  Scenario: Unsupported device identifier
    Given a valid devicestatus request body
    And the request body property "$.device" set to unsupported identifier value for the service
    When the HTTP "POST" request is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNSUPPORTED_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  @device_reachability_status_422.4_unnecessary_device
  Scenario: Device not to be included when it can be deduced from the access token
    Given the header "Authorization" is set to a valid access token identifying a device
    And the request body property "$.device" is set to a valid device
    When the HTTP "POST" request is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
    And the response property "$.message" contains a user friendly text