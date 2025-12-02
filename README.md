<a href="https://github.com/camaraproject/DeviceStatus/commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus/issues" title="Open Issues"><img src="https://img.shields.io/github/issues/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus/pulls" title="Open Pull Requests"><img src="https://img.shields.io/github/issues-pr/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus/graphs/contributors" title="Contributors"><img src="https://img.shields.io/github/contributors/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus" title="Repo Size"><img src="https://img.shields.io/github/repo-size/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=plastic"></a>
<a href="https://github.com/camaraproject/DeviceStatus/releases/latest" title="Latest Release"><img src="https://img.shields.io/github/release/camaraproject/DeviceStatus?style=plastic"></a>
<a href="https://github.com/camaraproject/Governance/blob/main/ProjectStructureAndRoles.md" title="Incubating API Repository"><img src="https://img.shields.io/badge/Incubating%20API%20Repository-green?style=plastic"></a>

# DeviceStatus

Incubating API Repository to evolve and maintain the definitions and documentation of DeviceStatus Service API(s) within the Sub Project [Device Status](https://lf-camaraproject.atlassian.net/wiki/x/6wApBQ)

* API Repository [wiki page](https://lf-camaraproject.atlassian.net/wiki/x/fzLe)

> [!WARNING]  
> After the Camara Spring25 meta release this repository has been separated into 3 individual repositories:
> - [Device Roaming Status](https://github.com/camaraproject/DeviceRoamingStatus)
> - [Device Reachability Status](https://github.com/camaraproject/DeviceReachabilityStatus)
> - [Connected Network Type](https://github.com/camaraproject/ConnectedNetworkType)
> 
> This repository should be only used for maintenance of previous releases. For contributions to the API development please use exclusively the new repositories. Thanks!

## Scope
* Service APIs for “Device Status” (see [APIBacklog.md](https://github.com/camaraproject/APIBacklog/blob/main/documentation/APIbacklog.md))  
* It provides the API consumer with the ability to:  
  - check if a device is reachable or is not connected to the network
  - check if a device is roaming, and in which country
  - receive notifications if the connectivity or roaming status of the device changes
* Describe, develop, document and test the APIs (with 1-2 Telcos)
* Started: July 2022
* Incubating stage since: February 2025 

<!-- CAMARA:RELEASE-INFO:START -->
<!-- The following section is automatically maintained by the CAMARA project-administration tooling: https://github.com/camaraproject/project-administration -->

## Release Information

> [!NOTE]
> Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until a new release is created. For example, changes may be reverted before a release is created. **For best results, use the latest available release**.

* **NEW**: The latest public release is [r2.2](https://github.com/camaraproject/DeviceStatus/releases/tag/r2.2) (Spring25), with the following API versions:
  * **connected-network-type-subscriptions v0.1.0**
  [[YAML]](https://github.com/camaraproject/DeviceStatus/blob/r2.2/code/API_definitions/connected-network-type-subscriptions.yaml)
  [[ReDoc]](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.2/code/API_definitions/connected-network-type-subscriptions.yaml&nocors)
  [[Swagger]](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.2/code/API_definitions/connected-network-type-subscriptions.yaml)
  * **connected-network-type v0.1.0**
  [[YAML]](https://github.com/camaraproject/DeviceStatus/blob/r2.2/code/API_definitions/connected-network-type.yaml)
  [[ReDoc]](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.2/code/API_definitions/connected-network-type.yaml&nocors)
  [[Swagger]](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.2/code/API_definitions/connected-network-type.yaml)
  * **device-reachability-status-subscriptions v0.7.0**
  [[YAML]](https://github.com/camaraproject/DeviceStatus/blob/r2.2/code/API_definitions/device-reachability-status-subscriptions.yaml)
  [[ReDoc]](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.2/code/API_definitions/device-reachability-status-subscriptions.yaml&nocors)
  [[Swagger]](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.2/code/API_definitions/device-reachability-status-subscriptions.yaml)
  * **device-reachability-status v1.0.0**
  [[YAML]](https://github.com/camaraproject/DeviceStatus/blob/r2.2/code/API_definitions/device-reachability-status.yaml)
  [[ReDoc]](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.2/code/API_definitions/device-reachability-status.yaml&nocors)
  [[Swagger]](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.2/code/API_definitions/device-reachability-status.yaml)
  * **device-roaming-status-subscriptions v0.7.0**
  [[YAML]](https://github.com/camaraproject/DeviceStatus/blob/r2.2/code/API_definitions/device-roaming-status-subscriptions.yaml)
  [[ReDoc]](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.2/code/API_definitions/device-roaming-status-subscriptions.yaml&nocors)
  [[Swagger]](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.2/code/API_definitions/device-roaming-status-subscriptions.yaml)
  * **device-roaming-status v1.0.0**
  [[YAML]](https://github.com/camaraproject/DeviceStatus/blob/r2.2/code/API_definitions/device-roaming-status.yaml)
  [[ReDoc]](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.2/code/API_definitions/device-roaming-status.yaml&nocors)
  [[Swagger]](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.2/code/API_definitions/device-roaming-status.yaml)
* The latest public release is always available here: https://github.com/camaraproject/DeviceStatus/releases/latest
* Other releases of this repository are available in https://github.com/camaraproject/DeviceStatus/releases
* For changes see [CHANGELOG.md](https://github.com/camaraproject/DeviceStatus/blob/main/CHANGELOG.md)

---
_This section is automatically synchronized by CAMARA project-administration from [data/releases-master.yaml](https://github.com/camaraproject/project-administration/blob/main/data/releases-master.yaml)._
<!-- CAMARA:RELEASE-INFO:END -->

## Contributing
* Meetings
  * Bi-weekly on Wednesday, 09:00 UTC
  * [Registration / Join](https://zoom-lfx.platform.linuxfoundation.org/meeting/93413850406?password=3aeb0f1b-d9f9-42c5-91d8-3d2b20421ef1)
  * Access [meeting minutes](https://lf-camaraproject.atlassian.net/wiki/x/fzLe) 
* Mailing List
  * Subscribe / Unsubscribe to the mailing list of this Sub Project https://lists.camaraproject.org/g/sp-dst.
  * A message to the community of this Sub Project can be sent using <sp-dst@lists.camaraproject.org>.
  
