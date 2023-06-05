# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [0.1.1]

### Fixed

- Invoke-FreshServiceRestMethod updates to handle 429 retry and automatically sleep when rate limit is reached.
- Updated incomplete examples help in New-FreshServiceOnboardingRequest and Set-FreshServiceOnboardingRequest

### Added

- Invoke-FreshserviceRestMethod updated to have artificial throttling to ensure module commands do not consume all api credits.  Progressively adds a Sleep after calls from 5 seconds @ 70% consumed to 15 seconds @ 80% consumed to 30 seconds at 90% consumed to avoid 429.
- Connect-Freshservice added a -NoThrottle to override the artificial throttling.

## [0.1.0] 5/24/2023

- Initial release
