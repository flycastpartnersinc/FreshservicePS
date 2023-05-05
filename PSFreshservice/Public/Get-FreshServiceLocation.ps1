<#
.SYNOPSIS
    Returns a Freshservice Location.

.DESCRIPTION
    Returns a Freshservice Location via REST API.

    https://api.freshservice.com/#view_a_location

.PARAMETER Id
    Unique id of the Location.

.PARAMETER Name
    Return by Location Name.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceLocation

    address            : @{line1=; line2=; city=; state=; country=; zipcode=}
    contact_name       :
    created_at         : 8/29/2022 2:17:48 PM
    email              :
    id                 : 21000159902
    name               : Japan
    parent_location_id : 21000159892
    phone              :
    primary_contact_id :
    updated_at         : 8/29/2022 2:17:48 PM

    address            : @{line1=; line2=; city=; state=; country=; zipcode=}
    contact_name       :
    created_at         : 8/29/2022 2:17:48 PM
    email              :
    id                 : 21000159901
    name               : China
    parent_location_id : 21000159892
    phone              :
    primary_contact_id :
    updated_at         : 8/29/2022 2:17:48 PM

    address            : @{line1=; line2=; city=; state=; country=; zipcode=}
    contact_name       :
    created_at         : 8/29/2022 2:17:48 PM
    email              :
    id                 : 21000159900
    name               : India
    parent_location_id : 21000159892
    phone              :
    primary_contact_id :
    updated_at         : 8/29/2022 2:17:48 PM

    Returns all Freshservice Locations

.EXAMPLE
    Get-FreshServiceLocation -Id 21000159902

    address            : @{line1=; line2=; city=; state=; country=; zipcode=}
    contact_name       :
    created_at         : 8/29/2022 2:17:48 PM
    email              :
    id                 : 21000159902
    name               : Japan
    parent_location_id : 21000159892
    phone              :
    primary_contact_id :
    updated_at         : 8/29/2022 2:17:48 PM

    Returns a Freshservice Location by Id.

.EXAMPLE
    Get-FreshServiceLocation -Name Japan

    address            : @{line1=; line2=; city=; state=; country=; zipcode=}
    contact_name       :
    created_at         : 8/29/2022 2:17:48 PM
    email              :
    id                 : 21000159902
    name               : Japan
    parent_location_id : 21000159892
    phone              :
    primary_contact_id :
    updated_at         : 8/29/2022 2:17:48 PM

    Returns a Freshservice Location By Name.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceLocation {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the Location.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the Location',
            ParameterSetName = 'ByName',
            Position = 0
        )]
        [string]$Name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'ByName',
            Position = 1
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'ByName',
            Position = 2
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/locations' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }
        elseif ($Name) {
            $qry.Add('query', '"name:''{0}''"' -f $Name )
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
