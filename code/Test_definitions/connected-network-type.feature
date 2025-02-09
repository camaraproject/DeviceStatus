@Connected_network_type
Feature: CAMARA Connected Network Type API, vwip - Operations for retrieve network type

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specifies in connected-network-type.yaml, version vwip

  Background: Common Connected Network Type setup
    Given the resource "{api-root}/connected-network-type/vwip/retrieve" set as base-url
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
	
############# Happy Path Scenarios ##################	

  @connected_network_type_01_generic_success_scenario
  Scenario: Check the connected network type to which the user device is connected
    Given a valid testing device supported by the service, identified by the token or provided in the request body
    And the testing device is connected to a mobile network
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ConnectedNetworkTypeResponse"
    And the response property "$.connectedNetworkType" is "2G" or "3G" or "4G" or "5G"

  @connected_network_type_02_retrieval_undetermined_network
  Scenario: The connected network type of the user device can not be determined
    Given a valid testing device supported by the service, identified by the token or provided in the request body
    And the testing device is not connected to a mobile network (e.g. connected only to WiFi, or not connected to any network)
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/ConnectedNetworkTypeResponse"
    And the response property "$.connectedNetworkType" is "UNKNOWN"

############# Error Response Scenarios ##################
	
  @connected_network_type_3_device_empty
  Scenario: The device value is an empty object
    Given the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" is set to: {}
    When the HTTP "POST" request is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_4_device_identifiers_not_schema_compliant
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

  @connected_network_type_5_device_phoneNumber_schema_compliant
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

  @connected_network_type_6_device_not_found
  Scenario: Some identifier cannot be matched to a device
    Given the request body property "$.device" is set to a value compliant to the OAS schema at "/components/schemas/Device" but does not identify a device managed by the API provider
    And the header "Authorization" is set to a valid access token which does not identify a single device
    When the HTTP "POST" request is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_7_device_identifiers_unsupported
  Scenario: None of the provided device identifiers is supported by the implementation
    Given that some type of device identifiers are not supported by the implementation
    And the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" only includes device identifiers not supported by the implementation
    When the HTTP "POST" request is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNSUPPORTED_IDENTIFIERS"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_8_device_identifiers_mismatch
  Scenario: Device identifiers mismatch
    # To test this, at least 2 types of identifiers have to be provided, e.g. a phoneNumber and the IP address of a device associated to a different phoneNumber
    Given that the implementation supports multiple device identifiers
    And the header "Authorization" is set to a valid access token which does not identify a single device
    And the request body property "$.device" includes several identifiers, each of them identifying a valid but different device
    When the HTTP "POST" request is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "IDENTIFIER_MISMATCH"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_9_unnecessary_device
  Scenario: Device not to be included when it can be deduced from the access token
    # This test applies whether the device associated with the access token matches the explicit device identifier or not
    # For 3-legged access tokens, an explicit device identifier MUST NOT be provided
    Given the header "Authorization" is set to a valid access token identifying a device
    And the request body property "$.device" is set to a valid device (which may or may not be the same device)
    When the HTTP "POST" request is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_10_device_not_supported
  Scenario: Service not available for the device
    Given that the service is not available for all devices commercialized by the operator
    And a valid device, identified by the token or provided in the request body, for which the service is not applicable
    When the HTTP "POST" request is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_11_device_missing_identifier
  Scenario: Cannot be identified from the access token and the optional device object
    Given the request body property "$.device" is optional and not set
    And the header "Authorization" is set to a valid access token without a device identifier
    When the HTTP "POST" request is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "MISSING_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  # Generic 400 errors

  @connected_network_type_12_no_request_body
  Scenario: Missing request body
    Given the request body is not included
    When the HTTP "POST" request is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  # Other specific 400 errors

  @connected_network_type_13_max_age_schema_compliant
  Scenario: Input property values doe not comply with the schema
    Given a valid testing device supported by the service, identified by the token or provided in the request body
    And the "maxAge" is set to 6a0
    When the HTTP "POST" request is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  # Generic 401 errors

  @connected_network_type_15_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_16_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @connected_network_type_17_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Generic 403 error

  @connected_network_type_18_permissions_denied
  Scenario: Client does not have sufficient permissions to perform this action
    Given the header "Authorization" is set to an invalid access token
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response status code is 403
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text