<a href="https://github.com/camaraproject/DeviceStatus/commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus/issues" title="Open Issues"><img src="https://img.shields.io/github/issues/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus/pulls" title="Open Pull Requests"><img src="https://img.shields.io/github/issues-pr/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus/graphs/contributors" title="Contributors"><img src="https://img.shields.io/github/contributors/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus" title="Repo Size"><img src="https://img.shields.io/github/repo-size/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=plastic"></a>

# DeviceStatus
Repository to describe, develop, document and test the DeviceStatus API family

## Scope
* Service APIs for “Device Status” (see APIBacklog.md)  
* It provides the customer with the ability to:  
  * check if a device is losing connection to the network or gets reachable again, and the roaming status.
  * NOTE: The scope of this API family should be limited (at least at a first stage) to 4G and 5G.  
* Describe, develop, document and test the APIs (with 1-2 Telcos)  
* Started: July 2022
* Location: virtually  

## Meetings
* Meetings are held virtually
* Schedule: bi-weekly (odd weeks), Wednesday, 11 AM CET
* Meeting link: <a href="https://teams.microsoft.com/l/meetup-join/19%3ameeting_NDQwYTlkZjYtOTc0NS00MjA5LWE2YjItMWFjYTczZTM4NTEx%40thread.v2/0?context=%7b%22Tid%22%3a%22bde4dffc-4b60-4cf6-8b04-a5eeb25f5c4f%22%2c%22Oid%22%3a%22389ab01b-6fbd-4e02-8f1a-1be1e09c95e8%22%7d">Microsoft Teams Meeting</a>

## Status and released versions
* Note: Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until a new release is created. For example, changes may be reverted before a release is created. **For best results, use the latest available release**.

* **The Release Candidate for v0.5.0 of the Device Status is available. The upcoming release will contain the 3rd alpha version of the DeviceStatus API**<br>Until the release there are bug fixes to be expected. The release candidate is suitable for implementors, but it is not recommended to use the API with customers in productive environments.
* The release candidate for v0.5.0 is available in the [release-0.5.0-rc branch](https://github.com/camaraproject/DeviceStatus/tree/release-0.5.0-rc)
  - API definition with inline documentation:
    - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/release-0.5.0-rc/code/API_definitions/device-status.yaml)
    - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/release-0.5.0-rc/code/API_definitions/device-status.yaml&nocors)
    - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/release-0.5.0-rc/code/API_definitions/device-status.yaml)
  - For changes between v0.5.0-rc and v0.4.1 see the [CHANGELOG.md](https://github.com/camaraproject/DeviceStatus/blob/release-0.5.0-rc/CHANGELOG.md)

* The latest available and released version 0.4.1 of the API is available within the [release-0.4.1 branch](https://github.com/camaraproject/DeviceStatus/tree/release-0.4.1)
  - API definition with inline documentation:
    - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/release-0.4.1/code/API_definitions/device-status.yaml)
    - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/release-0.4.1/code/API_definitions/device-status.yaml&nocors)
    - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/release-0.4.1/code/API_definitions/device-status.yaml) 

## Contributorship and mailing list
* To subscribe / unsubscribe to the mailing list of this Sub Project and thus be / resign as Contributor please visit <https://lists.camaraproject.org/g/sp-dst>.
* A message to all Contributors of this Sub Project can be sent using <sp-dst@lists.camaraproject.org>.
