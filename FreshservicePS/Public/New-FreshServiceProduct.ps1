<#
.SYNOPSIS
    Creates Freshservice Product.

.DESCRIPTION
    Creates Freshservice Product via REST API.

    https://api.freshservice.com/#products

.PARAMETER name
    Name of the Product.

.PARAMETER asset_type_id
    Unique id of the asset type(must be a type in Freshservice).

.PARAMETER manufacturer
    Manufacturer of the product

.PARAMETER status
    Status of the product.

.PARAMETER mode_of_procurement
    Mode of procurement of the product.

.PARAMETER depreciation_type_id
    Unique id of the depreciation type.

.PARAMETER description
    HTML Content of the product.

.PARAMETER description_text
    Description of the product in plain text.

.EXAMPLE
    New-FreshServiceProduct -name ProductFromAPI -description 'A product from the API' -asset_type_id 21000855284 -manufacturer 'Other' -status 'In Production' -mode_of_procurement Buy

    id                   : 21000194694
    created_at           : 4/12/2023 3:09:14 AM
    updated_at           : 4/12/2023 3:09:14 AM
    name                 : ProductFromAPI
    manufacturer         : Other
    asset_type_id        : 21000855284
    description          : <div>A product from the API</div>
    description_text     : A product from the API
    depreciation_type_id :
    status               : In Production
    mode_of_procurement  : Buy

    Creates a new Freshservice Product.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceProduct {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the Product.'
        )]
        [string]$name,
        [Parameter(
            Mandatory = $true,
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

        $uri = [System.UriBuilder]('{0}/products' -f $PrivateData['FreshserviceBaseUri'])

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

                if ($result.Content) {
                    $content = $result.Content |
                                    ConvertFrom-Json

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
