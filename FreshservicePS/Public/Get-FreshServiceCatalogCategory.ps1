<#
.SYNOPSIS
    Returns a Freshservice Service Catalog Category.

.DESCRIPTION
    Returns a Freshservice Service Catalog Category via REST API.

    https://api.freshservice.com/#list_all_service_categories

.PARAMETER id
    Unique id of the Service Catalog Category.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceCatalogCategory

    description :
    id          : 21000104299
    created_at  : 8/29/2022 2:17:48 PM
    updated_at  : 8/29/2022 2:17:48 PM
    name        : Hardware Provisioning
    position    : 1

    description :
    id          : 21000104300
    created_at  : 8/29/2022 2:17:48 PM
    updated_at  : 8/29/2022 2:17:48 PM
    name        : Software Installation
    position    : 2

    description :
    id          : 21000104301
    created_at  : 8/29/2022 2:17:48 PM
    updated_at  : 8/29/2022 2:17:48 PM
    name        : HR Management
    position    : 3

    description :
    id          : 21000104302
    created_at  : 8/29/2022 2:17:48 PM
    updated_at  : 8/29/2022 2:17:48 PM
    name        : Data Services
    position    : 4

    Returns all Freshservice Catalog Categories.

.EXAMPLE
    Get-FreshServiceCatalogCategory -id 21000104303

    description :
    id          : 21000104303
    created_at  : 8/29/2022 2:17:48 PM
    updated_at  : 8/29/2022 2:17:48 PM
    name        : Application Access
    position    : 5

    Returns a Freshservice Catalog Category by Id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceCatalogCategory {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of Service Catalog Category.',
            ParameterSetName = 'Id',
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
        $uri = [System.UriBuilder]('{0}/service_catalog/categories' -f $PrivateData['FreshserviceBaseUri'])
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
