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
        [switch]$NoBanner
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
with your Freshservice instance(s) or initiative, give us a shout or check out our website for current offerings:

Website:  www.flycastpartners.com
Email:    sales@example.com
Linkedin: www.linkedin.com/flycast
Twitter:  www.twitter.com/flycast

Thank you to everyone for your support! Happy coding!
"@

            Write-Warning -Message $aboutFlyCast
        }
    }
}
