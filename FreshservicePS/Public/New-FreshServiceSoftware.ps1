<#
.SYNOPSIS
    Creates a new Freshservice Software.

.DESCRIPTION
    Creates a new Freshservice Software via REST API.

    https://api.freshservice.com/#create_a_software

.PARAMETER name
    Name of the software

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

.PARAMETER custom_field
    Key-value pair containing the names and values of the (custom) requester fields.

.EXAMPLE
    New-FreshserviceSoftware -name 'Software X1000 Platinum' -description 'Awesome software, all the time.' -application_type desktop -status ignored  -publisher_id 21000085375 -notes 'Some Notes on the Sofware' -category Internal -source 'API'

    additional_data    : @{overview=; graph_data=; last_sync_date=}
    user_count         : 0
    installation_count : 0
    id                 : 21001446583
    name               : Software X1000 Platinum
    description        : Awesome software, all the time.
    notes              : Some Notes on the Sofware
    publisher_id       : 21000085375
    created_at         : 3/28/2023 6:40:32 PM
    updated_at         : 3/28/2023 6:40:32 PM
    application_type   : desktop
    status             : ignored
    managed_by_id      :
    category           : Internal
    sources            : {API}

    Creates a new Freshservice Application.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceSoftware {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the software'
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the software'
        )]
        [string]$description,
        [Parameter(
            Mandatory = $true,
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
        [string]$source,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key-value pair containing the names and values of the (custom) requester fields.'
        )]
        [object[]]$custom_field
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/applications' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

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
                    Method      = 'POST'
                    Body        = $jsonBody | ConvertTo-Json
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                $content = $result.Content |
                                ConvertFrom-Json -Depth 5

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
