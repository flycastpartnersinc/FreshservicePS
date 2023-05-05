<#
.SYNOPSIS
    Updates a Freshservice Vendor.

.DESCRIPTION
    Updates a Freshservice Vendor via REST API.

    https://api.freshservice.com/#update_a_vendor

.PARAMETER id
    Unique ID of the vendor.

.PARAMETER name
    Name of the vendor.

.PARAMETER description
    Description of the vendor.

.PARAMETER primary_contact_id
    User ID of the primary contact (must be a user in Freshservice).

.PARAMETER address
    Key-value pair containing the names and values of the address fields with line1, city, state, country and zip code properties.

.PARAMETER custom_fields
    Key-value pair containing the names and values of the (custom) vendor fields.

.EXAMPLE
    Set-FreshServiceVendor -id 21000085371 -description 'Apple Inc.'

    address            : @{line1=1 Infinite Loop; city=Cupertino; state=California; country=United States;
                        zipcode=95014}
    id                 : 21000085371
    name               : Apple
    description        : Apple Inc.
    contact_name       :
    email              :
    mobile             :
    phone              :
    primary_contact_id :
    custom_fields      :
    created_at         : 8/29/2022 2:17:31 PM
    updated_at         : 3/31/2023 2:26:24 AM

    Updates a description on a Freshservice Vendor.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceVendor {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique ID of the vendor.'
        )]
        [string]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the vendor.'
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the vendor.'
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User ID of the primary contact (must be a user in Freshservice)'
        )]
        [long]$primary_contact_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key-value pair containing the names and values of the address fields with line1, city, state, country and zip code properties'
        )]
        [hashtable]$address,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key-value pair containing the names and values of the (custom) vendor fields.'
        )]
        [hashtable]$custom_fields
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/vendors' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            [void]$PSBoundParameters.Remove('id')
        }

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
        }

        try {
            if ($PSCmdlet.ShouldProcess($id)) {

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
