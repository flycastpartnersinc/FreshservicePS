---
layout: module
permalink: /module/FreshservicePS/
---
# [FreshservicePS](https://www.flycastpartners.com/FreshservicePS)

<!-- [![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/FreshservicePS.svg?style=for-the-badge)](https://www.powershellgallery.com/packages/FreshservicePS) -->
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## About
From our continued success as a Platinum-level partner, [Flycast Partners] is considered Freshworks’ preferred partner for complex Freshservice ITSM implementations/integrations as well as a leading source of Freshservice knowledge and services. As part of our commitment to delivering high-quality services, our team of ITIL- and Freshworks-certified ITSM Consultants has created FreshservicePS, a comprehensive Freshservice PowerShell API Library, for diverse operational needs.  

Built by the team who garnered Freshworks Global ITSM Strategic Partner of the Year, Flycast Partners believes in contributing to the Freshworks community. Our PowerShell Modules provide organizations with a versatile solution to administer, build, and streamline their Freshservice environment. By offering our expertise and experience to fellow users, we hope to foster a culture of collaboration and knowledge-sharing that empowers this community to succeed and thrive!

With our FreshservicePS PowerShell Modules, Freshservice Admins have the ability to:

- Make the Freshservice API simple to use with a command-line interface
- Manage Freshservice Ticket, Problems, Changes, Releases, Requesters, and more using simple commands
- Provide additional reporting and filtering capabilities
- Automate re-occurring tasks in Freshservice tenants
- Move data between Freshservice tenants
- Support DevOps and build, test, and deploy solutions in CI/CD operations

The FreshservicePS module aligns closely with the [Freshservice API] documentation, so be sure to reference notes, throttling and other import aspects of the Freshservice API.

## Status - Work in progress

> This project is a **work in progress** and may change significantly before reaching stability based on feedback from the community.
> **Please do not base critical processes on this project** until it has been further refined.  Links to other content may not be working
just yet as we are building content to support this project.

Join the conversation on [FreshservicePS.slack.com](https://join.slack.com/t/freshserviceps/shared_invite/zt-2514m3vky-Azc3DAqh9RhpjJ0ibPwqsQ) -->

---

## Instructions

### Installation

Install FreshservicePS from the [PowerShell Gallery]! `Install-Module` requires PowerShellGet.

```powershell
# One time only install:
Install-Module -Name FreshservicePS -Scope CurrentUser

# Check for updates occasionally:
Update-Module -Name FreshservicePS
```

### Usage

Create a connection profile for FreshservicePS.

```powershell
# To create a configuration to Freshservice:

# Import the module
Import-Module -Name FreshservicePS

# Create a configuration to connect to the Production instance (i.e. https://acme-corp.freshservice.com)
# API and set as the Default connection (automatically connect when importing the module):

New-FreshServiceConnection -Name acme_prod -ApiKey 'gsfdgjkhdfs73jdsbd' -Tenant 'acme-corp' -Environment Production -Default $true

# Create a configuration to connect to the Sandbox (i.e. https://its-fine-fs-sandbox.freshservice.com) 
# API to switch connections using Connect-Freshservice:

New-FreshServiceConnection -Name acme_sbx -ApiKey 'gsfdgjkhdfs73jdsbd' -Tenant 'acme-corp' -Environment Sandbox -Default $false
```

Connect to an environment and execute commands:

```powershell
# When importing the module, it will automatically connect to the default instance 
# (defined with the -Default switch with 'acme_prod'):
Import-Module FreshservicePS

# To switch to another connection, use the Connect-Freshservice cmdlet:
Connect-Freshservice -Name acme_sbx 
```

You can find the full documentation [here](https://flycastpartners.com/FreshservicePS) and in the console.

```powershell
#Review the help at any time!
Get-Help about_FreshservicePS
Get-Command -Module FreshservicePS
Get-Help Get-FreshServiceTicket -Full # or any other command
```

### Rate Limit (Throttling)

Highly recommend reviewing the [rate limit](https://api.freshservice.com/#rate_limit) documentation for Freshservice.  The rate limit applies at the **account level** (not per API Key\account), so all accounts leveraging the API consume calls.  This module performs pagination automatically and pipeline operations that can make many API calls very quickly, so throttling at the module level is default behavior to reduce the probability of a 429 Retry-After which makes the API inaccessible for the entire account for time period (usually 30-40 seconds).  If bulk operations are being performed and no throttling should occur, use the NoThrottling switch:

```powershell
Connect-Freshservice -Name my_instance -NoThrottling
```

For more information on how to use FreshservicePS, tips, blogs and more, check out (COMING SOON!!).

<!-- ### Contribute

Want to contribute to FreshservicePS? Great!
We appreciate who invests their time to make our modules the best they can be. -->

<!-- Check out our guidelines on [Contributing] to our modules and documentation. -->

## Useful links

- [Flycast Partners]
- [Freshservice API]
- [Source Code]
- [Latest Release]
- [Submit an Issue]

- How you can help us: [List of Issues](https://github.com/flycastpartnersinc/FreshservicePS/issues?q=is%3Aissue+is%3Aopen+label%3Aup-for-grabs)

## Disclaimer

Hopefully this is obvious, but:

> This is an open source project (under the [MIT license]), and all contributors are volunteers. All commands are executed at your own risk. **Please ensure have good backups before you start, because you can delete a lot of stuff if you're not careful.**

<!-- reference-style links -->
  [Flycast Partners]: https://www.flycastpartners.com/
  [Freshservice API]: https://api.freshservice.com/
  [PowerShell Gallery]: https://www.powershellgallery.com/
  [Source Code]: https://github.com/flycastpartnersinc/FreshservicePS
  [Latest Release]: https://github.com/flycastpartnersinc/FreshservicePS/releases/latest
  [Submit an Issue]: https://github.com/flycastpartnersinc/FreshservicePS/issues/new
  [MIT license]: https://github.com/flycastpartnersinc/FreshservicePS/blob/main/LICENSE
