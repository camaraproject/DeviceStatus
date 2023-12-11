# Changelog DeviceStatus
## Table of Contents
- [v0.5.0-rc](#v050-rc)
- [v0.4.1](#v041)
- [v0.2.0](#v020)

# v0.5.0-rc
**This is the release candidate of v0.5.0 - containing the upcoming 3rd alpha version of the DeviceStatus API**
- API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/release-0.5.0-rc/code/API_definitions/device-status.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/release-0.5.0-rc/code/API_definitions/device-status.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/release-0.5.0-rc/code/API_definitions/device-status.yaml)

## Please note:
- **This release will contain significant changes compared to v0.4.1, and it is not backward compatible**
- **This is only the pre-release, it should be considered as a draft of the upcoming release v0.5.0**
  - The pre-release is meant for implementors, but it is not recommended to use the API with customers in productive environments.

### Main Changes
* Added a new endpoint (/connectivity) to query the connectivity status of a device.
* Added the support for event notifications, based on CloudEvents, for both roaming and connectivity events.
* Reworked API security, now only Open-ID connect is allowed.

### Added
* Added new endpoints to manage event-notifications for roaming events by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/31
* Aligned event notification management with CloudEvents spec and added Open-Id connect as security method by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/75
* Added a new endpoint and events to query the connectivity status of a device by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/69

### Changed
* Aligned error definition with guidelines by @monamok in https://github.com/camaraproject/DeviceStatus/pull/35

### Fixed
* Aligned with common usage of allOf by @patrice-conil in https://github.com/camaraproject/DeviceStatus/pull/60
* Replaced subscriptionId with eventSubscriptionId by @patrice-conil in https://github.com/camaraproject/DeviceStatus/pull/64

### Removed
* NA

## New Contributors
* @bigludo7 made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/50
* @sachinvodafone made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/51
* @patrice-conil made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/59
* @SyeddR made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/63
* @Sachinsiso made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/68
* @rartych made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/79
* @maxl2287 made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/69

**Full Changelog**: https://github.com/camaraproject/DeviceStatus/compare/v0.4.1...v0.5.0

# v0.4.1
### This is the second pre-release of the CAMARA Device Status API
- API [definition](https://github.com/camaraproject/DeviceStatus/blob/release-0.4.1/code/API_definitions/device-status.yaml)
- API [documentation](https://github.com/camaraproject/DeviceStatus/blob/release-0.4.1/documentation/API_documentation/Connectivity_API.md)

### Please note:
- This is a pre-release version, and should be considered as a draft for further development
- There are bug fixes and breaking changes to be expected in later versions
- The release is suitable for test implementations, but it is not recommended for use in production environments

### Added
* Add new return parameters MCC (Mobile Country Code) and ISO 3166-1 alpha-2 Country Code by @ravindrapalaskar17 in https://github.com/camaraproject/DeviceStatus/pull/21

### Changed
* API simplified by @monamok in https://github.com/camaraproject/DeviceStatus/pull/23
  - base path renamed to `device-status`
  - `/status` path renamed to `/roaming` 
  - required status type is now implicit from path name, and does not need to be passed by parameter `eventType`

### Fixed
* Fix typo in filename and in CountryName response field by @ravindrapalaskar17 in https://github.com/camaraproject/DeviceStatus/pull/30

### Removed
- Objects `ConnectivityEventType` and `EventStatusType`

## New Contributors
* @ravindrapalaskar17 made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/21

**Full Changelog**: https://github.com/camaraproject/DeviceStatus/compare/v0.2.0...v0.4.1

# v0.2.0
### This is the first pre-release of the CAMARA Device Status API
- API [definition](https://github.com/camaraproject/DeviceStatus/blob/release-0.2.0/code/API_definitions/check-device-connectivity.yaml)
- API [documentation](https://github.com/camaraproject/DeviceStatus/blob/release-0.2.0/documentation/API_documentation/Connectivity_API.md)

### Please note:
- This is a pre-release version, and should be considered as a draft for further development
- There are bug fixes and breaking changes to be expected in later versions
- The release is suitable for test implementations, but it is not recommended for use in production environments

### Added
* Initial contribution of API spec check-device-connectivity v0.2.0 by @akoshunyadi in https://github.com/camaraproject/DeviceStatus/pull/5
* Upload Roaming API Proposal - Vodafone.md by @eric-murray in https://github.com/camaraproject/DeviceStatus/pull/12
* Add documentation by @paweltalar in https://github.com/camaraproject/DeviceStatus/pull/8

### Changed
* This is the first pre-release

### Fixed
* This is the first pre-release

### Removed
* This is the first pre-release

## New Contributors
* @eric-murray made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/1
* @JoachimDahlgren made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/3
* @akoshunyadi made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/5
* @paweltalar made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/8
* @shilpa-padgaonkar made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/13
* @NoelWirzius made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/16

**Full Changelog**: https://github.com/camaraproject/DeviceStatus/commits/v0.2.0
