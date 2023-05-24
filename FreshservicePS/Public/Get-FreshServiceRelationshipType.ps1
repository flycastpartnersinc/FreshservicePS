<#
.SYNOPSIS
    Returns a Freshservice Asset Relationship Types.

.DESCRIPTION
    Returns a Freshservice Asset via REST API.

    https://api.freshservice.com/#view_an_asset

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceRelationshipType

    id                  : 21000356894
    is_default          : True
    description         :
    created_at          : 8/29/2022 2:17:32 PM
    updated_at          : 8/29/2022 2:17:32 PM
    downstream_relation : Depends On
    upstream_relation   : Used By

    id                  : 21000356895
    is_default          : True
    description         :
    created_at          : 8/29/2022 2:17:32 PM
    updated_at          : 8/29/2022 2:17:32 PM
    downstream_relation : Uses
    upstream_relation   : Used By

    id                  : 21000356896
    is_default          : True
    description         :
    created_at          : 8/29/2022 2:17:32 PM
    updated_at          : 8/29/2022 2:17:32 PM
    downstream_relation : Sends Data To
    upstream_relation   : Receives Data From

    id                  : 21000356897
    is_default          : True
    description         :
    created_at          : 8/29/2022 2:17:32 PM
    updated_at          : 8/29/2022 2:17:32 PM
    downstream_relation : Runs on
    upstream_relation   : Runs

    Returns a Freshservice Asset Relationship Types.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceRelationshipType {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.'
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.'
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/relationship_types' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

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

                $content = $result.Content |
                                ConvertFrom-Json

                if ($content) {
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
