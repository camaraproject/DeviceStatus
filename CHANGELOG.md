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
