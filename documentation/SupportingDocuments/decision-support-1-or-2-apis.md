# Decision supporting document for the discussion 1 or 2(n) APIs

## Current situation  
The device-status API has 1 endpoint: /roaming.  
There is a need to add new functionalities. At first 2 new endpoints: to get the connectivity status and to subscribe for status-events.
Later other functionalities will follow.

### Option 1
Logically related endpoints are generally within 1 API, with 1 basepath. In special cases (e.g. compliance) splitting is possible.  
Example:    
{apiRoot}/device-status/v0/roaming  
{apiRoot}/device-status/v0/connectivity  
{apiRoot}/device-status/v0/subscriptions  

### Option 2
Each device status subtype is handled in a separate API with different basepaths building an API-family.  
Example:   
API #1  
{apiRoot}/device-roaming-status/v0/roaming  
{apiRoot}/device-roaming-status/v0/subscriptions  

API #2  
{apiRoot}/device-connectivity-status/v0/connectivity  
{apiRoot}/device-connectivity-status/v0/subscriptions  


## Criterias

### 1. API usage - client view

Aspects of finding and using the API(s) for a specific use case of a client.

**Separate basepath**

Pros:
- For a use case with a single area of interest (e.g. only roaming status is needed) a specific small API might be easier to be found and used

Cons:
- For more complex use cases many device status-APIs are needed (find, subscribe, integrate, etc.)


**Common basepath**

Pros:
- For a use case with multiple areas of interest or the intention to extend the usage later a combined API with all device status related information is more comfortable 
- Only one API onboarding
- In this very specific context, the 2 functions are very close.

Cons:
- If only one specific status is needed, then it might take longer to find the right information


### 2. Service development and operation - provider view
Aspects of the service implementation, testing, and operation on the provider side.

**Separate basepath**

Pros:
- Independent implementation and testing of the different status functionalities
- Fine-grade billing, scaling and monitoring is possible (however more effort)

Cons:
- Extra effort is needed to prevent doubled code
- More overhead on developing and operating multiple services

**Common basepath**

Pros:
- Efficient development (especially when all status information can be gathered from the same southbound service)
- Model generation performed once

Cons:
- If different southbound services are used the service gets more complex


### 3. API maintenance & releasing - Camara view
Aspects of maintenance (add, delete, change functionality) and releasing (versioning, release planning, etc.)

**Separate basepath**

Pros:
- A simple service is easier to maintain and release

Cons:
- The overall effort (discussions, YAML work, etc.) for the API family is higher 
- Additional synchronization within the API family is necessary (using common types could help)

**Common basepath**

Pros:
- Bigger releases with higher value
- Easy to add a new endpoint to an existing API 

Cons:
- Longer release cycles (more content, more discussions)


### 4. Harmonization - technical view
Aspects of industry best practice, generic design guidelines and harmonization with other Camara APIs. 

**Some examples**
- 3GPP APIs are simple on the path level (collection and collection\\<id\>), inside the requests/responses many subtypes are used
- TM-Forum APIs contain multiple different endpoints related to the API theme
- Camara APIs don't show a clear picture (range from very simple to "monster" APIs) 

**Separate basepath**

Pros:
- Small API and microservice with very limited responsibility (however 1 microservice can implement multiple APIs also)

Cons:
- Atomic APIs with very limited scopes are not typical

**Common basepath**

Pros:
- 

Cons:
- 

## Preference

| Company | Preference |
| ------- | ---------- |
| Orange  | Slight preference for one API with 2 resources but not a 'structral' point for us for this API. |
| Vodafone  | Based on the information shared at https://github.com/camaraproject/WorkingGroups/discussions/218 against different other aspects, our preference is to have separate APIs for each status (Roaming/Connectivity).   |
| Deutsche Telekom  | We prefer the solution with a common basepath (1 API), however in specific cases a separation is conceivable |




