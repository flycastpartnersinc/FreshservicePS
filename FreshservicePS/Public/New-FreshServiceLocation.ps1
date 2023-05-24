<#
.SYNOPSIS
    Creates Freshservice location.

.DESCRIPTION
    Creates Freshservice location via REST API.

    https://api.freshservice.com/#create_a_location

.PARAMETER name
    Name of the location.

.PARAMETER contact_name
    Name of the Contact.

.PARAMETER email
    Email of the Contact.

.PARAMETER phone
    Phone of the Contact.

.PARAMETER parent_location_id
    Unique id of the parent location.

.PARAMETER primary_contact_id
    User ID of the primary contact (must be a user in Freshservice)

.PARAMETER address
    Address with line1, line2, city, state, country and zip code properties'

.EXAMPLE
    $locParams = @{
        name = MyNewLocation
        address = @{
            line1 = "123 Corporate Avenue"
            line2 = "Suite 100"
            city = "Jacksonville"
            state = "Florida"
            country = "USA"
            zipcode = "32217"
        }
    }

    New-FreshServiceLocation @locParams

    Creates a new Freshservice Location.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceLocation {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the location. ',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the Contact.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$contact_name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Email of the Contact.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$email,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Phone of the Contact.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$phone,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the parent location.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$parent_location_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User ID of the primary contact (must be a user in Freshservice)',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$primary_contact_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Address with line1, line2, city, state, country and zip code properties',
            ValueFromPipelineByPropertyName = $true
        )]
        [hashtable]$address
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/locations' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            #if ($PSBoundParameters[$PSItem] -is [boolean]) {
            #    $jsonBody[$PSItem.ToLower()] = [int]$PSBoundParameters[$PSItem]
            #}
            #else {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            #}
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
