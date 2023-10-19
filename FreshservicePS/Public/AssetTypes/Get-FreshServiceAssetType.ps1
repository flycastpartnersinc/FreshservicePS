<#
.SYNOPSIS
    Returns a Freshservice Asset Type.

.DESCRIPTION
    Returns a Freshservice Asset Type via REST API.

    https://api.freshservice.com/#view_an_asset_type

.PARAMETER id
    Unique id of the Asset Type.

.PARAMETER Fields
    Retrieve Fields for Asset Type for a spefic asset type id.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceAssetType

    id                   : 21000855265
    name                 : Services
    description          :
    parent_asset_type_id :
    visible              : True
    created_at           : 8/29/2022 2:17:36 PM
    updated_at           : 8/29/2022 2:17:36 PM

    id                   : 21000855285
    name                 : Business Service
    description          :
    parent_asset_type_id : 21000855265
    visible              : True
    created_at           : 8/29/2022 2:17:37 PM
    updated_at           : 8/29/2022 2:17:37 PM

    id                   : 21000855311
    name                 : Sales Service
    description          :
    parent_asset_type_id : 21000855285
    visible              : True
    created_at           : 8/29/2022 2:17:39 PM
    updated_at           : 8/29/2022 2:17:39 PM

    Return Freshservice Asset Types.

.EXAMPLE
    Get-FreshServiceAssetType -Id 21000855285

    id                   : 21000855285
    name                 : Business Service
    description          :
    parent_asset_type_id : 21000855265
    visible              : True
    created_at           : 8/29/2022 2:17:37 PM
    updated_at           : 8/29/2022 2:17:37 PM

    Return Freshservice Asset Type by Id.

.EXAMPLE
    Get-FreshServiceAssetType -Id 21000855285 -Fields

    field_header     fields
    ------------     ------
    General          {@{id=; created_at=; updated_at=; asset_type_id=; name=name; label=Display Name; required=True; is_uni...
    Assignment       {@{id=; created_at=; updated_at=; asset_type_id=; name=location_id; label=Location; required=False; is...
    Services         {}
    Business Service {@{id=21003895909; created_at=8/29/2022 2:17:42 PM; updated_at=8/29/2022 2:17:42 PM; asset_type_id=210...

    Return Freshservice Asset Type Fields by Id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
    function Get-FreshServiceAssetType {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Asset Type.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Retrieve Fields for Asset Type',
            ParameterSetName = 'id',
            Position = 1
        )]
        [switch]$fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/asset_types' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }

        if ($Fields) {
            $uri.Path = "{0}/fields" -f $uri.Path, $Id
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
