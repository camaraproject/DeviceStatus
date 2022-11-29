# Overview
This API makes possible to query the connectivity status of user equipment.

## 1\. Introduction
<img src="resources/DeviceStatus_Connectivity_diagram.png">

## 2\. Quick Start
DeviceStatus API v0.2.0 exposes only one endpoint, which can be used to check connectivity status for user equipment. To do so user has to pass following parameters in request body:
1. **ueId** - an object with four fields, each of them make possible to pass ueId in different format: externalId [1], msisdn, ipv4Addr and ipv6Add
2. **eventType** - string value which determines the connectivity event to check its status, for now only "UE_ROAMING_STATUS" is supported.

Sample API invocation is presented in Section 4.4.

## 3\. Authentication and Authorization
The Device Status API makes use of the client credentials grant which is applicable for server to server use cases involving trusted partners or clients without any protected user data involved. In this method the API invoker client is registered as a confidential client with an authorization grant type of client_credentials [2].

## 4\. API Documentation
The API user wants to execute a check of connectivity status for a user equipment. The current API version make possible to check only the roaming status of device with given identifier. It can be extended in the future with other event types.


### 4.1 Endpoint Definitions

<span class="colour" style="color:rgb(23, 43, 77)"><span class="colour" style="color:rgb(36, 41, 47)">Following table
defines API endpoints of exposed REST based for QoD throughput management operations. </span></span>

| **Endpoint**                            | **Operation**             | **Description**               |
|-----------------------------------------|---------------------------|-------------------------------|
| POST<br>  \<base-url>/connectivity/v0/status | **Device Connectivity Status** | Get the current connectivity status |

#### **Check device connectivity status**

| **Execute check of device connectivity status**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **HTTP Request**<br> POST \<base-url>/connectivity/v0/status<br>**QueryParameters**<br> No query parameters are defined.<br>**Path Parameters**<br> No path parameters are defined.<br>**Request Body Parameters**<br> **ueId**: UE identifier object, contains 4 different identifiers, at least 1 has to be set<br> **uePort (optional):** User equipment port. Device port may be required along with IP address to identify the target device <br> **eventType:** enum type value, for now only one is supported: UE_ROAMING_STATUS<br><br>**Response**<br> **200: Connectivity status checked**<br>  Response body:<br> **ueId**: UE identifier object, contains 4 different identifiers, at least 1 has to be set<br> **uePort (optional):** User equipment port. Device port may be required along with IP address to identify the target device <br> **eventType:** enum type value, contains UE_ROAMING_STATUS <br> **eventStatus:** enum type value, contains one of the following: ROAMING_ON, ROAMING_OFF <br><br> **400:** **Invalid input.**<br> **401:** **Un-authorized, missing or incorrect authentication.**<br> **403:** **Forbidden access.**<br> **404:** **Resource not found.**<br>  **500:** **Server error.**<br> **503:** **Service temporarily unavailable.** |
<br>

### 4.2 Errors

Since CAMARA Device Status API is based on REST design principles and blueprints, well defined HTTP status
codes and families specified by community are followed [3].

Details of HTTP based error/exception codes for the Device Status API are described in Section 4.2 of each API REST based method.
Following table provides an overview of common error names, codes and messages applicable to Device Status API.

| No  | Error Name            | Error Code | Error Message                                                 |
|-----|-----------------------|------------|---------------------------------------------------------------|
| 1   | Invalid port(s)       | 400        | "Ports specification not valid"                               |
| 2   | Invalid ueId          | 400        | "Validation failed for parameter: ueId"                       |
| 3   | Invalid port          | 400        | "Validation failed for parameter: port"                       |
| 4   | Invalid eventType     | 400        | "Validation failed for parameter: eventType"                  |
| 7   | Unauthorized          | 401        | "Un-authorized to invoke operation"                           |
| 8   | Forbidden             | 403        | "Forbidden to invoke operation"                               |
| 9   | Not found             | 404        | "The specified resource is not found"                         |
| 10  | Internal server error | 500        | "Internal server error"                                       |
| 11  | Service unavailable   | 503        | “Internal error due to required telco service unavailability" |

### 4.3 Policies

N/A

### 4.4 Code Snippets

| Snippet 1. Execute location verification                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| curl -X 'POST' `https://sample-base-url/connectivity/v0/status`   <br>    -H 'accept: application/json' <br>    -H 'Content-Type: application/json'<br>    -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbG...."<br>    -d '{<br>     "ueId": {<br>"externalId": "exampleExternalId@domain.com",<br>"msisdn": "41793834315",<br>"ipv4Addr": "192.0. 2.146",<br>"ipv6Addr": "2001:db8:3333:4444:5555:6666:7777:8888"<br>},<br> "port": 5060, <br> "eventType": "UE_ROAMING_STATUS"<br>   } |

<br>

### 4.5 FAQ's

(FAQs will be added in a later version of the documentation)

### 4.6 Terms

N/A

### 4.7 Release Notes

N/A

## References

[1] External Identifier format of the GPSI https://github.com/camaraproject/WorkingGroups/blob/main/Commonalities/documentation/UE-Identification.md#external-identifier-format-of-the-gpsi <br>
[2] Camara Commonalities : Authentication and Authorization Concept for Service
APIs https://github.com/camaraproject/WorkingGroups/blob/main/Commonalities/documentation/Working/CAMARA-AuthN-AuthZ-Concept.md <br>
[3] HTTP Status codes spec https://restfulapi.net/http-status-codes
