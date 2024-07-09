
@DeviceStatusSanity
Feature: CAMARA DeviceStatus API, v0.5.1 - Operation DeviceStatus

  @DeviceStatus_01_RoamingStatusTrue
  Scenario: Check the roaming state and the country information synchronously if the device is in the roaming mode
    Given Use BaseURL
    When Request roaming status for msisdn +49160444444
    Then Response code is 200
    Then The roaming status is true

  @DeviceStatus_02_RoamingStatusFalse
  Scenario: Check the roaming state synchronously if the device is not in the roaming mode
    Given Use BaseURL
    When Request roaming status for msisdn +49160444449
    Then Response code is 200
    Then The roaming status is false

  @DeviceStatus_03_ConnectivityStatusConnectedSMS
  Scenario: Check device connectivity synchronously if the device is connected for SMS usage
    Given Use BaseURL
    When Request connectivity status for msisdn +491604444444
    Then Response code is 200
    Then The connectivity status is CONNECTED_SMS

  @DeviceStatus_04_ConnectivityStatusConnectedData
  Scenario: Check device connectivity synchronously if the device is connected for Data usage
    Given Use BaseURL
    When Request connectivity status for msisdn +491605555555
    Then Response code is 200
    Then The connectivity status is CONNECTED_DATA

  @DeviceStatus_05_DeviceConnectivityStatusNotConnected
  Scenario: Check device connectivity synchronously if the device is not connected to network
    Given Use BaseURL
    When Request connectivity status for msisdn +49160666666
    Then Response code is 200
    Then The connectivity status is NOT_CONNECTED

  @DeviceStatus_06_DeviceStatusWithoutDoubleQuoteInMsisdn
  Scenario: Device status request with missing double quote in json request body
    Given Use BaseURL
    When Request device status with missing double quote in json payload
    Then Response code is 400

  @DeviceStatus_07_DeviceStatusWithMissingBracket
  Scenario: Device status request with missing bracket in json request
    Given Use BaseURL
    When Request device status with missing bracket in json payload
    Then Response code is 400

  @DeviceStatus_08_DeviceStatusWithIncorrectEventType
  Scenario: Device status request with incorrect EventType
    Given Use BaseURL
    When Request device status with with incorrect EventType
    Then Response code is 400

  @DeviceStatus_09_DeviceStatusWithIncorrectIpAddress
  Scenario: Device status request with incorrect ipaddress
    Given Use BaseURL
    When Request device status with incorrect ipaddress in json payload
    Then Response code is 400

  @DeviceStatus_10_DeviceStatusWithIncorrectHTTPMethod
  Scenario: Device status request with incorrect HTTP request method
    Given Use BaseURL
    When Put request for DeviceStatus Status
    Then Response code is 405

 @DeviceStatus_11_DeviceStatusServiceUnavailable
  Scenario: Server not available
	  Given Use the BaseURL
      Test for Create when service unavailable
      When Verify DeviceStatus with valid msisdn when service is not available
      Then Response code equal to 503
