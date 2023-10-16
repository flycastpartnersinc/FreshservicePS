# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [0.1.4]

### Added

- Additional support for Workspaces.
- Get-FreshServiceWorkspace cmdlet to list Workspaces.
- Filtering for workspace_id:

  - Get-FreshServiceAgent
  - Get-FreshServiceAsset
  - Get-FreshServiceTicket
  - Get-FreshServiceChange
  - Get-FreshServiceProblem
  - Get-FreshServiceRelease
  - Get-FreshServiceBusinessHour
  - Get-FreshServiceSolutionCategory
  - Get-FreshServiceCatalogCategory
  - Get-FreshServiceCatalogItem
  - Get-FreshServiceCustomObject

- Move methods and options for Workspaces:

  - Set-FreshserviceTicket
  - Set-FreshserviceProblem
  - Set-FreshserviceChange
  - Set-FreshserviceRelease
  - Set-FreshServiceAsset

- Create items in Workspaces:

  - New-FreshServiceAsset
  - New-FreshServiceTicket
  - New-FreshServiceChange
  - New-FreshServiceProblem
  - New-FreshServiceRelease

- Agent licensing for Workspace assignment and License Type:

  - New-FreshServiceAgent
  - Set-FreshServiceAgent

- Updated the New-FreshserviceConnection to only require tenant and apikey.  If a friendly name is not provided, it will use the tenant name.  The first connection will be set to the default.  These settings are to make connection simple for new users.  Converted the Default parameter from Boolean to Switch.

- Originally Freshservice did not support custom statuses and there was a validation done in the cmdlet (e.g. ValidateSet).  Removed the validation to allow custom statuses for tickets.  Current valid values can be viewed with Get-FSTicket -Fields.

- Updated Invoke-FreshserviceRestMethod to append UTF-8 header and set 'application/json; charset=utf-8' and default ContentType.

- Updated Invoke-FreshserviceRestMethod to include -UseBasicParsing for Invoke-WebRequest for all calls to support backwards compatibility for Server Core and older PS versions.

### Fixed

- Filter pagination loop logic.  There is no relative link to perform pagination, updated logic to manually increment page until there is no content returned.

  - Get-FreshServiceAgent
  - Get-FreshServiceAsset
  - Get-FreshserviceTicket
  - Get-FreshServiceProjectTask
  - Get-FreshServiceRequester

## [0.1.3]

### Added

- Removed mandatory parameter for Environment in New-FreshserviceConnection and defaulted to Production

### Fixed

- Moved the if statement for should process to ensure the entire url is built for WhatIf for Remove-FreshserviceAsset

## [0.1.2]

### Fixed

- Updated cmdlets custom_fields with data type object[] to object

## [0.1.1]

### Fixed

- Invoke-FreshServiceRestMethod updates to handle 429 retry and automatically sleep when rate limit is reached.
- Updated incomplete examples help in New-FreshServiceOnboardingRequest and Set-FreshServiceOnboardingRequest

### Added

- Invoke-FreshserviceRestMethod updated to have artificial throttling to ensure module commands do not consume all api credits.  Progressively adds a Sleep after calls from 5 seconds @ 70% consumed to 15 seconds @ 80% consumed to 30 seconds at 90% consumed to avoid 429.
- Connect-Freshservice added a -NoThrottle to override the artificial throttling.

## [0.1.0] 5/24/2023

- Initial release
