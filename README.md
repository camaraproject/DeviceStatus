<a href="https://github.com/camaraproject/DeviceStatus/commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus/issues" title="Open Issues"><img src="https://img.shields.io/github/issues/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus/pulls" title="Open Pull Requests"><img src="https://img.shields.io/github/issues-pr/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus/graphs/contributors" title="Contributors"><img src="https://img.shields.io/github/contributors/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus" title="Repo Size"><img src="https://img.shields.io/github/repo-size/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus/releases/latest" title="Latest Release"><img src="https://img.shields.io/github/release/camaraproject/DeviceStatus?style=plastic"></a>

# DeviceStatus
Repository to describe, develop, document and test the DeviceStatus API family

## Scope
* Service APIs for “Device Status” (see APIBacklog.md)  
* It provides the customer with the ability to:  
  * check if a device is losing connection to the network or gets reachable again, and the roaming status.
  * NOTE: The scope of this API family should be limited (at least at a first stage) to 4G and 5G.  
* Describe, develop, document and test the APIs (with 1-2 Telcos)  
* Started: July 2022 

## Contributing
* Meetings
  * Bi-weekly on Wednesday, 11:00 CET/CEST (08:00 UTC, 09:00 UTC during European DST)
  * [Registration / Join](https://zoom-lfx.platform.linuxfoundation.org/meeting/94783050047?password=c43ff9fd-4c79-468a-9d98-45222dd6343d)
* Maling List
  * Subscribe <sp-dst+subscribe@lists.camaraproject.org>
  * <https://lists.camaraproject.org/g/sp-dst>
* Lifecycle Status
  * [Latest Release](https://github.com/camaraproject/DeviceStatus/releases/latest)
  * Release Information: Link to wiki
   * Note: Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until a new release is created. For example, changes may be reverted before a release is created. **For best results, use the latest available release**.
   * The latest available and released version 0.5.1 of the API is available within the [release-0.5.1 branch](https://github.com/camaraproject/DeviceStatus/tree/release-0.5.1)
  - API definition with inline documentation:
    - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/release-0.5.1/code/API_definitions/device-status.yaml)
    - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/release-0.5.1/code/API_definitions/device-status.yaml&nocors)
    - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/release-0.5.1/code/API_definitions/device-status.yaml) 
