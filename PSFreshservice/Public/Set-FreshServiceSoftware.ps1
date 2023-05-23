<#
.SYNOPSIS
    Updates a Freshservice Software.

.DESCRIPTION
    Updates a Freshservice Software via REST API.

    https://api.freshservice.com/#update_a_software

.PARAMETER id
    Unique Id of the software.

.PARAMETER name
    Name of the software.

.PARAMETER description
    Description of the software

.PARAMETER application_type
    Type of the software. Default is desktop, possible values:

    desktop
    saas
    mobile

.PARAMETER status
    Status of the software, possible values:

    blacklisted
    ignored
    managed

.PARAMETER publisher_id
    Unique id of the Vendor

.PARAMETER managed_by_id
    Unique id of the user managing the software (must be a user in Freshservice)

.PARAMETER notes
    Notes about the software

.PARAMETER category
    Category of the software

.PARAMETER source
    Name of the source from where the software details are updated (API, Okta, Google...etc).

.EXAMPLE
    Set-FreshServiceSoftware -id 21001415197 -description 'Microsoft Visual Studio 2023.XX'

    additional_data    : @{overview=; graph_data=; last_sync_date=}
    user_count         : 2
    installation_count : 2
    id                 : 21001415197
    name               : Microsoft Visual Studio Code
    description        : Microsoft Visual Studio 2023.XX
    notes              : VS Code runs on macOS, Linux, and Windows. VS Code is free for private or commercial use.
    publisher_id       : 21000085375
    created_at         : 3/20/2023 2:49:35 PM
    updated_at         : 3/31/2023 1:41:20 AM
    application_type   : desktop
    status             : managed
    managed_by_id      : 21000418005
    category           : Internal
    sources            : {API}

    Updates the description on a Freshservice Software.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceSoftware {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique Id of the Software.'
        )]
        [string]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the software'
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the software'
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Type of the software. Default is desktop. '
        )]
        [ValidateSet('desktop', 'saas', 'mobile')]
        [string]$application_type,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Status of the software'
        )]
        [ValidateSet('blacklisted', 'ignored', 'managed')]
        [string]$status,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the Vendor'
        )]
        [long]$publisher_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the user managing the software (must be a user in Freshservice)'
        )]
        [long]$managed_by_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Notes about the software'
        )]
        [string]$notes,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Category of the software'
        )]
        [string]$category,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the source from where the software details are updated (API, Okta, Google...etc).'
        )]
        [string]$source
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/applications' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            [void]$PSBoundParameters.Remove('id')
        }

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            if ( 'application_type','status' -contains $PSItem ) {
                $jsonBody[$PSItem.ToLower()] = ($PSBoundParameters[$PSItem]).ToLower()
            }
            else {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            }
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'PUT'
                    Body        = $jsonBody | ConvertTo-Json
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                $content = $result.Content |
                                ConvertFrom-Json

                if ($content) {
                    #API returns singluar or plural property based on the number of records, parse to get property returned.
                    $objProperty = $content[0].PSObject.Properties.Name
                    Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                    $content."$($objProperty)"
                }

            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
