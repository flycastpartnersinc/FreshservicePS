<#
.SYNOPSIS
    Returns a Freshservice Product.

.DESCRIPTION
    Returns a Freshservice Product via REST API.

    https://api.freshservice.com/#view_a_product

.PARAMETER Id
    Unique id of the Product.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceProduct

    id                   : 21000056898
    name                 : Apple MacBook Air 13
    asset_type_id        : 21000855304
    manufacturer         : Apple
    status               : In Production
    mode_of_procurement  : Both
    depreciation_type_id :
    description          : <div>Not given.</div>
    description_text     : Not given.
    created_at           : 8/29/2022 2:17:47 PM
    updated_at           : 8/29/2022 2:17:47 PM

    id                   : 21000056899
    name                 : Dell 22-inch Monitor
    asset_type_id        : 21000855276
    manufacturer         : Dell
    status               : In Production
    mode_of_procurement  : Both
    depreciation_type_id :
    description          : <div>Not given.</div>
    description_text     : Not given.
    created_at           : 8/29/2022 2:17:47 PM
    updated_at           : 8/29/2022 2:17:47 PM

    id                   : 21000056900
    name                 : Logitech M705 Wireless Mouse
    asset_type_id        : 21000855268
    manufacturer         : Logitech
    status               : In Production
    mode_of_procurement  : Both
    depreciation_type_id :
    description          : <div>Not given.</div>
    description_text     : Not given.
    created_at           : 8/29/2022 2:17:47 PM
    updated_at           : 8/29/2022 2:17:47 PM

    Returns all Freshservice Products.

.EXAMPLE
    Get-FreshServiceProduct -Id 21000056899

    id                   : 21000056899
    name                 : Dell 22-inch Monitor
    asset_type_id        : 21000855276
    manufacturer         : Dell
    status               : In Production
    mode_of_procurement  : Both
    depreciation_type_id :
    description          : <div>Not given.</div>
    description_text     : Not given.
    created_at           : 8/29/2022 2:17:47 PM
    updated_at           : 8/29/2022 2:17:47 PM

    Returns a Freshservice Product by Id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceProduct {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Product.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 2
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 3
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/products' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }

    }
    process {

        try {

            if ($enablePagination) {
                $qry['page'] = $page
                $qry['per_page'] = $per_page
            }

            $uri.Query = $qry.ToString()

            $uri = $uri.Uri.AbsoluteUri

            $results = do {

                $params = @{
                    Uri         = $uri
                    Method      = 'GET'
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

                if ($result.Headers.Link) {
                    $uri = [regex]::Matches($result.Headers.Link,'<(?<Uri>.*)>')[0].Groups['Uri'].Value
                }

            }
            until (!$result.Headers.Link)

        }
        catch {
            Throw $_
        }

    }
    end {

        $results

    }
}
