<#
.SYNOPSIS
    Returns a Freshservice Relationship.

.DESCRIPTION
    Returns a Freshservice Relationship via REST API.

    https://api.freshservice.com/#list_relationships_of_an_asset

.PARAMETER Id
    Unique id of the Relationship.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceRelationship

    id                   : 21000035237
    relationship_type_id : 21000356921
    primary_id           : 37
    primary_type         : asset
    secondary_id         : 36
    secondary_type       : asset
    created_at           : 3/17/2023 1:05:06 PM
    updated_at           : 3/17/2023 1:05:06 PM

    id                   : 21000035236
    relationship_type_id : 21000356921
    primary_id           : 35
    primary_type         : asset
    secondary_id         : 34
    secondary_type       : asset
    created_at           : 3/17/2023 1:03:15 PM
    updated_at           : 3/17/2023 1:03:15 PM

    id                   : 21000035235
    relationship_type_id : 21000356921
    primary_id           : 33
    primary_type         : asset
    secondary_id         : 32
    secondary_type       : asset
    created_at           : 3/17/2023 1:00:41 PM
    updated_at           : 3/17/2023 1:00:41 PM

    id                   : 21000035205
    relationship_type_id : 21000356921
    primary_id           : 31
    primary_type         : asset
    secondary_id         : 30
    secondary_type       : asset
    created_at           : 3/16/2023 9:22:45 PM
    updated_at           : 3/16/2023 9:22:45 PM

    Lists all relationships on the Freshservice tenant.

.EXAMPLE
    Get-FreshServiceRelationship -id 21000035237

    id                   : 21000035237
    relationship_type_id : 21000356921
    primary_id           : 37
    primary_type         : asset
    secondary_id         : 36
    secondary_type       : asset
    created_at           : 3/17/2023 1:05:06 PM
    updated_at           : 3/17/2023 1:05:06 PM

    Get a Freshservice Relationship by id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceRelationship {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Relationship.',
            ParameterSetName = 'ByAsset',
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
        $uri = [System.UriBuilder]('{0}/relationships' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

        if ($id) {
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
