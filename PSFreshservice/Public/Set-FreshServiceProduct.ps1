<#
.SYNOPSIS
    Updates a Freshservice Product.

.DESCRIPTION
    Updates a Freshservice Product via REST API.

    https://api.freshservice.com/#update_a_product

.PARAMETER id
    Unique ID of the product.

.PARAMETER name
    Name of the Product.

.PARAMETER asset_type_id
    Unique id of the asset type (must be a type in Freshservice).

.PARAMETER manufacturer
    Manufacturer of the product

.PARAMETER status
    Status of the product (In Production, In Pipeline, or Retired).

.PARAMETER mode_of_procurement
    Mode of procurement of the product.

.PARAMETER depreciation_type_id
    Unique id of the depreciation type.

.PARAMETER description
    HTML Content of the product.

.PARAMETER description_text
    Description of the product in plain text.

.EXAMPLE
    Set-FreshServiceProduct -id 21000188679 -description '[RETIRED] Exploded in Flames' -status Retired

    id                   : 21000188679
    created_at           : 3/15/2023 9:29:01 PM
    updated_at           : 3/31/2023 12:13:44 AM
    name                 : Dell PowerConnect 2808 c328350a-2ead-4600-889e-d91f43bd5c77
    manufacturer         : 21000085372
    asset_type_id        : 21000855304
    description          : [RETIRED] Exploded in Flames
    description_text     : [RETIRED] Exploded in Flames
    depreciation_type_id :
    status               : Retired
    mode_of_procurement  : Buy

    Updates the description and status of a Freshservice Product.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceProduct {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique ID of the product.'
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the Product.'
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the asset type(must be a type in Freshservice).'
        )]
        [long]$asset_type_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Manufacturer of the product.'
        )]
        [string]$manufacturer,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Status of the product..'
        )]
        [ValidateSet('In Production', 'In Pipeline', 'Retired')]
        [string]$status,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Mode of procurement of the product.'
        )]
        [ValidateSet('Buy', 'Lease', 'Both')]
        [string]$mode_of_procurement,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the depreciation type.'
        )]
        [long]$depreciation_type_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'HTML Content of the product..'
        )]
        [string]$description
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/products' -f $PrivateData['FreshserviceBaseUri'])

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
