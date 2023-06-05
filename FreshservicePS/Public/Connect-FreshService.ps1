<#
.SYNOPSIS
    Sets the required variables for the Freshservice tenant with named connection created with
    New-FreshServiceConnection. This is required to be run at the start of a new session to establish
    the tenant that will be used for cmdlet execution.

.DESCRIPTION
    Imports the saved configuration and sets the required variables for the Freshservice tenant with named
    connection created with New-FreshServiceConnection. This is required to be run at the start of a new session to establish
    the tenant that will be used for cmdlet execution.

.PARAMETER Name
    Friendly name of the connection created with New-FreshServiceConnection (e.g. acme_prod).  See existing connections, seeh Get-FreshServiceConnection.

.PARAMETER PassThru
    Return session data.

.PARAMETER NoBanner
    No banner for the hard working team building the module. ;)

.PARAMETER NoThrottle
    Disable artificial throttling.

    **WARNING** The API rate limit is applied on an account wide basis irrespective of factors such as
    the number of agents or IP addresses used to make the calls.  There are numerous API calls that can consume multiple API calls
    for single get operations (e.g. Get-FSAsset -IncludeTypeFields = 3 API credits for each call). Throttling will slow
    the API calls down ggadually the closer the query gets to consuming all calls forcing a 429 Retry-After which affects all API
    calls to the account.  Here is the breakdown:

    Consumed calls greater than 70% = 5 seconds
    Consumed calls greater than 80% = 15 seconds
    Consumed calls greater than 90% = 30 seconds

.EXAMPLE
    Connect-Freshservice -Name acme_prod

    Use a stored connection created with New-FreshServiceConnection to establish variables for FreshservicePS cmdlets.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Connect-Freshservice {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Friendly name of the environment'
        )]
        [string]$Name,
        [Parameter(
            Mandatory = $False,
            HelpMessage = 'Return session data.')]
        [switch]$PassThru,
        [Parameter(
            Mandatory = $False,
            HelpMessage = 'No banner for the hard working team building the module. ;) ')]
        [Alias('LeaveMeAlone')]
        [switch]$NoBanner,
        [Parameter(
            Mandatory = $False,
            HelpMessage = 'Disable artificial throttling.')]
        [switch]$NoThrottle
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if ($PSBoundParameters.ContainsKey('Path')) {[void]$PSBoundParameters.Remove('Path')}
    }
    process {
        try {

            $environment = Get-FreshServiceConnection -Name $Name
            Write-Verbose -Message ('Using configuration {0} to set module variables for {1} with api key {2}' -f $Name, $environment.Tenant, $plainPass)

            $ApiKey = [Net.NetworkCredential]::new('',$($environment.ApiKey | ConvertTo-SecureString)).password

            $PrivateData.FreshserviceTenant     = $environment.Tenant;
            $PrivateData.FreshserviceApiToken   = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $ApiKey,'X')))
            $PrivateData.FreshserviceBaseUri    = $environment.BaseUri
            $PrivateData.FreshserviceConnection = $Name

            if ($NoThrottle) {
                $PrivateData.FreshserviceThrottling = $false
            }

        }
        catch [System.IO.FileNotFoundException] {
            Throw 'Configuration file {0} does not exist. Use New-FreshServiceConnection to create and save a configuration.' -f $FreshServiceConfigPath
        }
        catch {
            Throw $_
        }
    }
    end {
        if ($PassThru) {
            [PSCustomObject]@{
                Tenant  = $PrivateData.FreshserviceTenant
                ApiKey  = $ApiKey
                BaseUri = $PrivateData.FreshserviceBaseUri
            }
        }

        if (!$NoBanner) {

$aboutFlyCast = @"
This free Powershell module is provided by Flycast Partners to the Freshworks Freshservice Community.  Flycast Partners specializes in ITSM solutions and is a Freshworks Platinum Partner. Need assistance
with your Freshservice instance(s) or initiative, contact us or check out our website for current offerings:

Website:  www.flycastpartners.com
Email: info@FlycastPartners.com
Linkedin: https://www.linkedin.com/company/2025923/
Twitter: https://twitter.com/Flycast_

Thank you to everyone for your support! Happy coding!
"@

            Write-Warning -Message $aboutFlyCast
        }
    }
}
