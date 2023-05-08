---
layout: module
permalink: /module/PSFreshservice/
---
# [PSFreshservice](https://www.flycastpartners.com/PSFreshservice)

<!-- [![GitHub release](https://img.shields.io/github/release/flycastpartnersinc/PSFreshservice.svg?style=for-the-badge)](https://github.com/flycastpartnersinc/PSFreshservice/releases/latest)
[![Build Status](https://img.shields.io/vso/build/flycastpartnersinc/PSFreshservice/11/master.svg?style=for-the-badge)](https://dev.azure.com/flycastpartnersinc/PSFreshservice/_build/latest?definitionId=11)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/PSFreshService.svg?style=for-the-badge)](https://www.powershellgallery.com/packages/PSFreshService)
![License](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge) -->

PSFreshservice is a Windows PowerShell module to interact with Freshworks Freshservice via a REST API, while maintaining a consistent PowerShell look, feel, and aligns closely with Freshservice API documentation.

<!-- Join the conversation on [![SlackLogo][] AtlassianPS.Slack.com](https://atlassianps.org/slack) -->

<!-- [SlackLogo]: https://atlassianps.org/assets/img/Slack_Mark_Web_28x28.png -->
<!--more-->

---

## Instructions

### Installation

Install PSFreshService from the [PowerShell Gallery]! `Install-Module` requires PowerShellGet (included in PS v5, or download for v3/v4 via the gallery link)

```powershell
# One time only install:
Install-Module PSFreshService -Scope CurrentUser

# Check for updates occasionally:
Update-Module PSFreshService
```

### Usage

```powershell
# To create a configuration to Freshservice, this would :
Import-Module PSFreshService
#Configuration to connect to https://acme-corp.freshservice.com API and use as the default connection (automatically connect when importing the module):
New-FreshServiceConnection -Name acme_prod -ApiKey 'gsfdgjkhdfs73jdsbd' -Tenant 'acme-corp' -Environment Production -Default $true
#Configuration to connect to https://its-fine-fs-sandbox.freshservice.com API and use as the default connection (automatically connect when importing the module):
New-FreshServiceConnection -Name acme_sbx -ApiKey 'gsfdgjkhdfs73jdsbd' -Tenant 'acme-corp' -Environment Sandbox -Default $false
```


```powershell
# To connect each session, automatically connects to 'acme_prod' as default:
Import-Module PSFreshService
# To connect to another environment (e.g. Sandbox) or set the connection parameters:
Connect-Freshservice -Name acme_sbx 
```

You can find the full documentation [here](https://flycastpartners.com/PSFreshService) and in the console.

```powershell
# Review the help at any time!
Get-Help about_PSFreshService
Get-Command -Module PSFreshService
Get-Help Get-JiraIssue -Full # or any other command
```

For more information on how to use PSFreshService, tips, blogs and more, check out the [Documentation](https://flycastpartners.com/PSFreshService).

### Contribute

Want to contribute to PSFreshservice? Great!
We appreciate who invests their time to make our modules the best they can be.

<!-- Check out our guidelines on [Contributing] to our modules and documentation. -->

<!-- ## Tested on

|Configuration|Status|
|-------------|------|
|Windows Powershell v3||
|Windows Powershell v4||
|Windows Powershell v5.1|[![Build Status](https://img.shields.io/vso/build/flycastpartnersinc/PSFreshservice/11/master.svg?style=for-the-badge)](https://dev.azure.com/flycastpartnersinc/PSFreshservice/_build/latest?definitionId=11)|
|Powershell Core (latest) on Windows|[![Build Status](https://img.shields.io/vso/build/flycastpartnersinc/PSFreshservice/11/master.svg?style=for-the-badge)](https://dev.azure.com/flycastpartnersinc/PSFreshservice/_build/latest?definitionId=11)|
|Powershell Core (latest) on Ubuntu|[![Build Status](https://img.shields.io/vso/build/flycastpartnersinc/PSFreshservice/11/master.svg?style=for-the-badge)](https://dev.azure.com/flycastpartnersinc/PSFreshservice/_build/latest?definitionId=11)|
|Powershell Core (latest) on MacOS|[![Build Status](https://img.shields.io/vso/build/flycastpartnersinc/PSFreshservice/11/master.svg?style=for-the-badge)](https://dev.azure.com/flycastpartnersinc/PSFreshservice/_build/latest?definitionId=11)| -->

<!-- ## Acknowledgements

* Thanks to [replicaJunction] for getting this module on it's feet
* Thanks to everyone ([Our Contributors](https://atlassianps.org/#people)) that helped with this module -->

## Useful links

* [Source Code]
* [Latest Release]
* [Submit an Issue]
* [Contributing]
* How you can help us: [List of Issues](https://github.com/flycastpartnersinc/PSFreshservice/issues?q=is%3Aissue+is%3Aopen+label%3Aup-for-grabs)

## Disclaimer

Hopefully this is obvious, but:

> This is an open source project (under the [MIT license]), and all contributors are volunteers. All commands are executed at your own risk. Please have good backups before you start, because you can delete a lot of stuff if you're not careful.

<!-- reference-style links -->
  <!-- [JIRA]: https://www.atlassian.com/software/jira -->
  [PowerShell Gallery]: https://www.powershellgallery.com/
  [Source Code]: https://github.com/flycastpartnersinc/PSFreshservice
  [Latest Release]: https://github.com/flycastpartnersinc/PSFreshservice/releases/latest
  [Submit an Issue]: https://github.com/flycastpartnersinc/PSFreshservice/issues/new
  <!-- [replicaJunction]: https://github.com/replicaJunction -->
  [MIT license]: https://github.com/flycastpartnersinc/PSFreshservice/blob/main/LICENSE
  <!-- [Contributing]: http://atlassianps.org/docs/Contributing -->
