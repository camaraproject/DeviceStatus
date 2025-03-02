# Changelog DeviceStatus
## Table of Contents
- [r2.2](#r22)
- [r2.1](#r21)
- [r1.3](#r13)
- [r1.2](#r12)
- [r1.1](#r11)
- [r0.6](#r06)
- [v0.5.1](#v051)
- [v0.5.0](#v050)
- [v0.5.0-rc](#v050-rc)
- [v0.4.1](#v041)
- [v0.2.0](#v020)

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

  - for an alpha release, the delta with respect to the previous release
  - for the first release-candidate, all changes since the last public release
  - for subsequent release-candidate(s), only the delta to the previous release-candidate
  - for a public release, the consolidated changes since the previous public release
# r2.2
## Release Notes

This pre-release contains the definition and documentation of
* device-roaming-status v1.0.0
* device-roaming-status-subscriptions v0.7.0
* device-reachability-status v1.0.0
* device-reachability-status-subscriptions v0.7.0
* connected-network-type 0.1.0
* connected-network-type-subscriptions 0.1.0

The API definition(s) are based on
* Commonalities v0.5.0
* Identity and Consent Management v0.3.0

## device-roaming-status v1.0.0

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-roaming-status.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-roaming-status.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r2.1/code/API_definitions/device-roaming-status.yaml)

### Added

### Changed
* Update documentation with handling of access token and multi-SIM scenarios by @eric-murray in https://github.com/camaraproject/DeviceStatus/pull/228
* Update device error model by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/232

### Fixed

### Removed

## device-roaming-status-subscriptions v0.7.0

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-roaming-status-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-roaming-status-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r2.1/code/API_definitions/device-roaming-status-subscriptions.yaml)

### Added

### Changed
* Update documentation with handling of access token and multi-SIM scenarios by @eric-murray in https://github.com/camaraproject/DeviceStatus/pull/228
* Update documentation with clarification for initialEvent by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/237
* Alignment with Commonalities Subscription Model - APIs Subscription by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/250

### Fixed
* Fix example for SUBSCRIPTION_ACTIVE by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/231
* Fix dateTime literals by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/240

### Removed
* remove `allOf` in `sinkCredential` by @dfischer-tech in https://github.com/camaraproject/DeviceStatus/pull/226

## device-reachability-status v1.0.0

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-reachability-status.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-reachability-status.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r2.1/code/API_definitions/device-reachability-status.yaml)

### Added

### Changed
* rework reachability-status to support reachability with multiple connectivity-types by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/221
* Update documentation with handling of access token and multi-SIM scenarios by @eric-murray in https://github.com/camaraproject/DeviceStatus/pull/228
* Update device error model by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/232

### Fixed

### Removed

## device-reachability-status-subscriptions v0.7.0

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-reachability-status-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-reachability-status-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r2.1/code/API_definitions/device-reachability-status-subscriptions.yaml)

### Added

### Changed
* Update documentation with handling of access token and multi-SIM scenarios by @eric-murray in https://github.com/camaraproject/DeviceStatus/pull/228
* Update documentation with clarification for initialEvent by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/237
* Alignment with Commonalities Subscription Model - APIs Subscription by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/250

### Fixed
* Fix example for SUBSCRIPTION_ACTIVE by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/231
* Fix dateTime literals by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/240

### Removed
* remove `allOf` in `sinkCredential` by @dfischer-tech in https://github.com/camaraproject/DeviceStatus/pull/226

## connected-network-type v0.1.0

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/connected-network-type.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/connected-network-type.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r2.1/code/API_definitions/connected-network-type.yaml)

### Added
* Create connected-network-type.yaml by @gmuratk in https://github.com/camaraproject/DeviceStatus/pull/158

### Changed
* Update documentation with handling of access token and multi-SIM scenarios by @eric-murray in https://github.com/camaraproject/DeviceStatus/pull/228
* Update device error model by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/232
 
### Fixed 

### Removed

## connected-network-type-subscriptions v0.1.0

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/connected-network-type-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/connected-network-type-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r2.1/code/API_definitions/connected-network-type-subscriptions.yaml)

### Added
* Create connected-network-type-subscriptions.yaml by @VijayKesharwani in https://github.com/camaraproject/DeviceStatus/pull/171
  
### Changed
* Update documentation with handling of access token and multi-SIM scenarios by @eric-murray in https://github.com/camaraproject/DeviceStatus/pull/228
* Update documentation with clarification for initialEvent by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/247
* Alignment with Commonalities Subscription Model - APIs Subscription by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/250

### Fixed
* Fix dateTime literals by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/240

### Removed

**Full Changelog**: https://github.com/camaraproject/DeviceStatus/compare/r1.3...r2.2

# r2.1
## Release Notes

This pre-release contains the definition and documentation of
* device-roaming-status v1.0.0-rc.1
* device-roaming-status-subscriptions v0.7.0-rc.1
* device-reachability-status v1.0.0-rc.1
* device-reachability-status-subscriptions v0.7.0-rc.1
* connected-network-type 0.1.0-rc.1
* connected-network-type-subscriptions 0.1.0-rc.1

The API definition(s) are based on
* Commonalities v0.5.0-rc.1
* Identity and Consent Management v0.3.0-rc.1

## device-roaming-status v1.0.0-rc.1

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-roaming-status.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-roaming-status.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r2.1/code/API_definitions/device-roaming-status.yaml)

### Added

### Changed
* Update documentation with handling of access token and multi-SIM scenarios by @eric-murray in https://github.com/camaraproject/DeviceStatus/pull/228
* Update device error model by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/232

### Fixed

### Removed

## device-roaming-status-subscriptions v0.7.0-rc.1

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-roaming-status-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-roaming-status-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r2.1/code/API_definitions/device-roaming-status-subscriptions.yaml)

### Added

### Changed
* Update documentation with handling of access token and multi-SIM scenarios by @eric-murray in https://github.com/camaraproject/DeviceStatus/pull/228
* Update documentation with clarification for initialEvent by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/237
* Alignment with Commonalities Subscription Model - APIs Subscription by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/250

### Fixed
* Fix example for SUBSCRIPTION_ACTIVE by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/231
* Fix dateTime literals by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/240

### Removed
* remove `allOf` in `sinkCredential` by @dfischer-tech in https://github.com/camaraproject/DeviceStatus/pull/226

## device-reachability-status v1.0.0-rc.1

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-reachability-status.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-reachability-status.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r2.1/code/API_definitions/device-reachability-status.yaml)

### Added

### Changed
* rework reachability-status to support reachability with multiple connectivity-types by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/221
* Update documentation with handling of access token and multi-SIM scenarios by @eric-murray in https://github.com/camaraproject/DeviceStatus/pull/228
* Update device error model by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/232

### Fixed

### Removed

## device-reachability-status-subscriptions v0.7.0-rc.1

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-reachability-status-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/device-reachability-status-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r2.1/code/API_definitions/device-reachability-status-subscriptions.yaml)

### Added

### Changed
* Update documentation with handling of access token and multi-SIM scenarios by @eric-murray in https://github.com/camaraproject/DeviceStatus/pull/228
* Update documentation with clarification for initialEvent by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/237
* Alignment with Commonalities Subscription Model - APIs Subscription by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/250

### Fixed
* Fix example for SUBSCRIPTION_ACTIVE by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/231
* Fix dateTime literals by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/240

### Removed
* remove `allOf` in `sinkCredential` by @dfischer-tech in https://github.com/camaraproject/DeviceStatus/pull/226

## connected-network-type v0.1.0-rc.1

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/connected-network-type.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/connected-network-type.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r2.1/code/API_definitions/connected-network-type.yaml)

### Added
* Create connected-network-type.yaml by @gmuratk in https://github.com/camaraproject/DeviceStatus/pull/158

### Changed
* Update documentation with handling of access token and multi-SIM scenarios by @eric-murray in https://github.com/camaraproject/DeviceStatus/pull/228
* Update device error model by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/232
 
### Fixed 

### Removed

## connected-network-type-subscriptions v0.1.0-rc.1

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/connected-network-type-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r2.1/code/API_definitions/connected-network-type-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r2.1/code/API_definitions/connected-network-type-subscriptions.yaml)

### Added
* Create connected-network-type-subscriptions.yaml by @VijayKesharwani in https://github.com/camaraproject/DeviceStatus/pull/171
  
### Changed
* Update documentation with handling of access token and multi-SIM scenarios by @eric-murray in https://github.com/camaraproject/DeviceStatus/pull/228
* Update documentation with clarification for initialEvent by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/247
* Alignment with Commonalities Subscription Model - APIs Subscription by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/250

### Fixed
* Fix dateTime literals by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/240

### Removed

**Full Changelog**: https://github.com/camaraproject/DeviceStatus/compare/r1.3...r2.1


# r1.3
## Release Notes

This patch release contains the definition and documentation of
* device-roaming-status v0.6.1
* device-roaming-status-subscriptions v0.6.1
* device-reachability-status v0.6.1
* device-reachability-status-subscriptions v0.6.1

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.1

Note: these patch release notes are listing only the change compared to the [r1.2](https://github.com/camaraproject/DeviceStatus/releases/tag/r1.2) release. For the full list of changes of the 0.6.0 API versions compared to 0.5.x see [r1.2](#r12).

## device-roaming-status v0.6.1

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.3/code/API_definitions/device-roaming-status.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.3/code/API_definitions/device-roaming-status.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r1.3/code/API_definitions/device-roaming-status.yaml)

### Added

### Changed

### Fixed
* Minor corrections in info.description by @akoshunyadi in https://github.com/camaraproject/DeviceStatus/pull/216

### Removed

## device-roaming-status-subscriptions v0.6.1

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.3/code/API_definitions/device-roaming-status-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.3/code/API_definitions/device-roaming-status-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r1.3/code/API_definitions/device-roaming-status-subscriptions.yaml)

### Added

### Changed

### Fixed
* Add missing `protocol`-components for device-roaming-status-subscriptions by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/208
* Correct the examples for sub - initialEvent and error MULTIEVENT_SUBSCRIPTION_NOT_SUPPORTED by @dfischer-tech in https://github.com/camaraproject/DeviceStatus/pull/210
* Minor corrections in info.description by @akoshunyadi in https://github.com/camaraproject/DeviceStatus/pull/216

### Removed


## device-reachability-status v0.6.1

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.3/code/API_definitions/device-reachability-status.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.3/code/API_definitions/device-reachability-status.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r1.3/code/API_definitions/device-reachability-status.yaml)

### Added

### Changed
* Update description of the reachability types by @akoshunyadi in https://github.com/camaraproject/DeviceStatus/pull/215

### Fixed
* Minor corrections in info.description by @akoshunyadi in https://github.com/camaraproject/DeviceStatus/pull/216

### Removed

## device-reachability-status-subscriptions v0.6.1

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.3/code/API_definitions/device-reachability-status-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.3/code/API_definitions/device-reachability-status-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r1.3/code/API_definitions/device-reachability-status-subscriptions.yaml)

### Added

### Changed
* Update description of the reachability types by @akoshunyadi in https://github.com/camaraproject/DeviceStatus/pull/215

### Fixed
* Correct the examples for sub - initialEvent and error MULTIEVENT_SUBSCRIPTION_NOT_SUPPORTED by @dfischer-tech in https://github.com/camaraproject/DeviceStatus/pull/210
* Minor corrections in info.description by @akoshunyadi in https://github.com/camaraproject/DeviceStatus/pull/216

### Removed

**Full Changelog**: https://github.com/camaraproject/DeviceStatus/compare/r1.2...r1.3

# r1.2
## Release Notes

This release contains the definition and documentation of
* device-roaming-status v0.6.0
* device-roaming-status-subscriptions v0.6.0
* device-reachability-status v0.6.0
* device-reachability-status-subscriptions v0.6.0

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0

Note: the previous device-status API with roaming and connectivity endpoints has been split into 4 specific APIs

## device-roaming-status v0.6.0

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.2/code/API_definitions/device-roaming-status.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.2/code/API_definitions/device-roaming-status.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r1.2/code/API_definitions/device-roaming-status.yaml)

### Added
* Addition of "lastStatusTime" Field by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/146
* include x-correlator by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/112
* Create Gherkin tests for device-status-reachability and device-status-roaming by @mdomale in https://github.com/camaraproject/DeviceStatus/pull/186

### Changed
* Change endpoint names to comply with guideline by @gmuratk in https://github.com/camaraproject/DeviceStatus/pull/131
* Make '+' mandatory for phoneNumber by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/144
* Separate endpoint yamls proposal for direct API by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/152
* Switch device structure to optional by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/179
* `device-reachability-status` & `device-roaming-status`: Alignment of errors with Commonalities by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/183
* Removing note that the API-scope is limited to 4G and 5G by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/195

### Fixed
* Renamed RequestRoamingStatus to RoamingStatusRequest by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/194

### Removed
* Remove `terms of service` and `contact` by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/185
* Remove response code 405 by bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/198

## device-roaming-status-subscriptions v0.6.0

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.2/code/API_definitions/device-roaming-status-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.2/code/API_definitions/device-roaming-status-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r1.2/code/API_definitions/device-roaming-status-subscriptions.yaml)

### Added
* Add termination reason `SUBSCRIPTION_DELETED` when subscription deleted by the user by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/121
* include x-correlator by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/112
* Create Gherkin tests for device-reachability-status-subscriptions & device-roaming-status-subscriptions by @mdomale in https://github.com/camaraproject/DeviceStatus/pull/187

### Changed
* Make '+' mandatory for phoneNumber by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/144
* split `/subscription`-endpoints into seperate APIs by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/161
* renaming "EventType"-components to be more clear & update component descriptions by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/141
* Update the subscription models to align on CAMARA commonalities by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/170
* Removing note that the API-scope is limited to 4G and 5G by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/195
* Subscription-APIs: Alignment of errors with Commonalities by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/193

### Fixed

### Removed
* Remove `terms of service` and `contact` by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/185

## device-reachability-status v0.6.0

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.2/code/API_definitions/device-reachability-status.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.2/code/API_definitions/device-reachability-status.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r1.2/code/API_definitions/device-reachability-status.yaml)

### Added
* Addition of "lastStatusTime" Field by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/146
* include x-correlator by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/112
* Create Gherkin tests for device-status-reachability and device-status-roaming by @mdomale in https://github.com/camaraproject/DeviceStatus/pull/186

### Changed
* Change endpoint names to comply with guideline by @gmuratk in https://github.com/camaraproject/DeviceStatus/pull/131
* Make '+' mandatory for phoneNumber by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/144
* Separate endpoint yamls proposal for direct API by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/152
* Switch device structure to optional by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/179
* `device-reachability-status` & `device-roaming-status`: Alignment of errors with Commonalities by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/183
* Removing note that the API-scope is limited to 4G and 5G by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/195

### Fixed

### Removed
* Remove `terms of service` and `contact` by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/185
* Remove response code 405 by bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/198

## device-reachability-status-subscriptions v0.6.0

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.2/code/API_definitions/device-reachability-status-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.2/code/API_definitions/device-reachability-status-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r1.2/code/API_definitions/device-reachability-status-subscriptions.yaml)

### Added
* Add termination reason `SUBSCRIPTION_DELETED` when subscription deleted by the user by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/121
* include x-correlator by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/112
* Create Gherkin tests for device-reachability-status-subscriptions & device-roaming-status-subscriptions by @mdomale in https://github.com/camaraproject/DeviceStatus/pull/187

### Changed
* renaming "EventType"-components to be more clear & update component descriptions by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/141
* Make '+' mandatory for phoneNumber by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/144
* split `/subscription`-endpoints into seperate APIs by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/161
* Update the subscription models to align on CAMARA commonalities by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/170
* Removing note that the API-scope is limited to 4G and 5G by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/195
* Subscription-APIs: Alignment of errors with Commonalities by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/193

### Fixed

### Removed
* Remove `terms of service` and `contact` by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/185

**Full Changelog**: https://github.com/camaraproject/DeviceStatus/compare/v0.5.1...r1.2

# r1.1
## Release Notes

This release contains the definition and documentation of
* device-roaming-status v0.6.0-rc.1
* device-roaming-status-subscriptions v0.6.0-rc.1
* device-reachability-status v0.6.0-rc.1
* device-reachability-status-subscriptions v0.6.0-rc.1

The API definition(s) are based on
* Commonalities v0.4.0-rc.1
* Identity and Consent Management v0.2.0-rc.1

Note: the previous device-status API with roaming and connectivity endpoints has been split into 4 specific APIs

## device-roaming-status v0.6.0-rc.1

**device-roaming-status v0.6.0-rc.1 is the 1st release candidate of the version 0.6**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.1/code/API_definitions/device-roaming-status.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.1/code/API_definitions/device-roaming-status.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r1.1/code/API_definitions/device-roaming-status.yaml)

### Added
* Addition of "lastStatusTime" Field by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/146
* include x-correlator by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/112

### Changed
* Change endpoint names to comply with guideline by @gmuratk in https://github.com/camaraproject/DeviceStatus/pull/131
* Make '+' mandatory for phoneNumber by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/144
* Separate endpoint yamls proposal for direct API by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/152
* Switch device structure to optional by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/179
* `device-reachability-status` & `device-roaming-status`: Alignment of errors with Commonalities by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/183
* Removing note that the API-scope is limited to 4G and 5G by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/195

### Fixed
* Renamed RequestRoamingStatus to RoamingStatusRequest by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/194

### Removed
* Remove `terms of service` and `contact` by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/185

## device-roaming-status-subscriptions v0.6.0-rc.1

**device-roaming-status-subscriptions v0.6.0-rc.1 is the 1st release candidate of the version 0.6**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.1/code/API_definitions/device-roaming-status-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.1/code/API_definitions/device-roaming-status-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r1.1/code/API_definitions/device-roaming-status-subscriptions.yaml)

### Added
* Add termination reason `SUBSCRIPTION_DELETED` when subscription deleted by the user by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/121
* include x-correlator by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/112

### Changed
* Make '+' mandatory for phoneNumber by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/144
* split `/subscription`-endpoints into seperate APIs by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/161
* renaming "EventType"-components to be more clear & update component descriptions by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/141
* Update the subscription models to align on CAMARA commonalities by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/170
* Removing note that the API-scope is limited to 4G and 5G by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/195
* Subscription-APIs: Alignment of errors with Commonalities by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/193

### Fixed

### Removed
* Remove `terms of service` and `contact` by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/185

## device-reachability-status v0.6.0-rc.1

**device-reachability-status v0.6.0-rc.1 is the 1st release candidate of the version 0.6**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.1/code/API_definitions/device-reachability-status.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.1/code/API_definitions/device-reachability-status.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r1.1/code/API_definitions/device-reachability-status.yaml)

### Added
* Addition of "lastStatusTime" Field by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/146
* include x-correlator by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/112

### Changed
* Change endpoint names to comply with guideline by @gmuratk in https://github.com/camaraproject/DeviceStatus/pull/131
* Make '+' mandatory for phoneNumber by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/144
* Separate endpoint yamls proposal for direct API by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/152
* Switch device structure to optional by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/179
* `device-reachability-status` & `device-roaming-status`: Alignment of errors with Commonalities by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/183
* Removing note that the API-scope is limited to 4G and 5G by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/195

### Fixed

### Removed
* Remove `terms of service` and `contact` by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/185

## device-reachability-status-subscriptions v0.6.0-rc.1

**device-reachability-status-subscriptions v0.6.0-rc.1 is the 1st release candidate of the version 0.6**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.1/code/API_definitions/device-reachability-status-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/r1.1/code/API_definitions/device-reachability-status-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/r1.1/code/API_definitions/device-reachability-status-subscriptions.yaml)

### Added
* Add termination reason `SUBSCRIPTION_DELETED` when subscription deleted by the user by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/121
* include x-correlator by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/112

### Changed
* renaming "EventType"-components to be more clear & update component descriptions by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/141
* Make '+' mandatory for phoneNumber by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/144
* split `/subscription`-endpoints into seperate APIs by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/161
* Update the subscription models to align on CAMARA commonalities by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/170
* Removing note that the API-scope is limited to 4G and 5G by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/195
* Subscription-APIs: Alignment of errors with Commonalities by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/193

### Fixed

### Removed
* Remove `terms of service` and `contact` by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/185

**Full Changelog**: https://github.com/camaraproject/DeviceStatus/compare/v0.5.1...r1.1

# r0.6  
## Please note:
- This release contains an alpha version of the API, it should be considered as a draft.
- There are bug fixes to be expected and incompatible changes in upcoming versions.

## Device Status - v0.6.0-alpha.1
- API definition **with inline documentation**: 
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/release-0.6/code/API_definitions/device-status.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/release-0.6/code/API_definitions/device-status.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/release-0.6/code/API_definitions/device-status.yaml)
### Main Changes
* Endpoints renamed 
* New response parameter lastStatusTime

### Added
* Addition of "lastStatusTime" Field by @sachinvodafone in https://github.com/camaraproject/DeviceStatus/pull/146
* include x-correlator by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/112

### Changed
* Change endpoint names to comply with guideline by @gmuratk in https://github.com/camaraproject/DeviceStatus/pull/131
* renaming "EventType"-components to be more clear & update component descriptions by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/141
* Make '+' mandatory for phoneNumber by @bigludo7 in https://github.com/camaraproject/DeviceStatus/pull/144

### Fixed
* NA

### Removed
* NA
  
## New Contributors
* NA

**Full Changelog**: https://github.com/camaraproject/DeviceStatus/compare/v0.5.1...r0.6


# v0.5.1
**This is a bugfix release for the third initial version of the CAMARA DeviceStatus API**
- API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/release-0.5.1/code/API_definitions/device-status.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/release-0.5.1/code/API_definitions/device-status.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/release-0.5.1/code/API_definitions/device-status.yaml)

## Please note:
- This is an initial version, it should be considered as a draft.
- There are bug fixes to be expected and incompatible changes in upcoming versions.
- The release is suitable for implementors, but it is not recommended to use the API with customers in productive environments.

### Main Changes
* Minor bugfixes
* Changes in the inline documentation

### Added
* NA

### Changed
* Change description that subscriptionExpireTime is optional by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/120
* Updated in-line documentation for Roaming to clarify that country information can optionally be returned in the response. by @trehman-gsma in https://github.com/camaraproject/DeviceStatus/pull/127

### Fixed
* fix: move "countryCode" out of "device" in ROAMING_CHANGE_COUNTRY-example by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/106
* fix: add missing "subscriptionId" in "RoamingStatus"-data for CloudEvent by @maxl2287 in https://github.com/camaraproject/DeviceStatus/pull/109
* fix: change INVALID_INPUT for INVALID_ARGUMENT according to guidelines by @fernandopradocabrillo in https://github.com/camaraproject/DeviceStatus/pull/129

### Removed
* NA
  
## New Contributors
* @trehman-gsma made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/127
* @fernandopradocabrillo made their first contribution in https://github.com/camaraproject/DeviceStatus/pull/129

**Full Changelog**: https://github.com/camaraproject/DeviceStatus/compare/v0.5.0...v0.5.1


# v0.5.0
**This is the third initial version of the CAMARA DeviceStatus API**
- API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceStatus/blob/release-0.5.0/code/API_definitions/device-status.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/release-0.5.0/code/API_definitions/device-status.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/DeviceStatus/release-0.5.0/code/API_definitions/device-status.yaml)

## Please note:
- **This release contains significant changes compared to v0.4.1, and it is not backward compatible**
- This is an initial version, it should be considered as a draft.
- There are bug fixes to be expected and incompatible changes in upcoming versions.
- The release is suitable for implementors, but it is not recommended to use the API with customers in productive environments.

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
* Corrections resolving linting errors by @rartych in https://github.com/camaraproject/DeviceStatus/pull/95

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


# v0.5.0-rc
**This is the release candidate of v0.5.0 - containing the upcoming 3rd initial version of the DeviceStatus API**
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
