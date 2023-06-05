<#
.SYNOPSIS
    Returns a Freshservice Solution Category.

.DESCRIPTION
    Returns a Freshservice Solution Category via REST API.

    https://api.freshservice.com/#view_solution_category

.PARAMETER Id
    Unique Id of the Solution Category.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceSolutionCategory

    id                 : 18000018545
    created_at         : 3/16/2021 9:24:31 PM
    updated_at         : 3/16/2021 9:31:04 PM
    name               : Default Category
    description        : All emails sent to kbase@company.com will be stored here as drafts
    default_category   : True
    position           : 1
    translations       :
    visible_in_portals : {18000009042}

    id                 : 18000018546
    created_at         : 3/16/2021 9:24:31 PM
    updated_at         : 3/16/2021 9:24:31 PM
    name               : General
    description        : Default solution category, feel free to edit or delete it.
    default_category   : False
    position           : 2
    translations       :
    visible_in_portals : {18000009042, 18000010161}

    id                 : 18000040164
    created_at         : 9/29/2022 1:24:27 PM
    updated_at         : 9/29/2022 1:32:41 PM
    name               : CategoryFromApi
    description        : My category description
    default_category   : False
    position           : 3
    translations       :
    visible_in_portals : {18000009042}

    id                 : 18000040165
    created_at         : 9/29/2022 1:29:35 PM
    updated_at         : 9/29/2022 1:29:35 PM
    name               : MyCategory
    description        :
    default_category   : False
    position           : 4
    translations       :
    visible_in_portals : {18000009042}

    Get all Freshservice Solution Categories.
.EXAMPLE
    Get-FreshServiceSolutionCategory -id 18000040164

    id                 : 18000040164
    created_at         : 9/29/2022 1:24:27 PM
    updated_at         : 9/29/2022 1:32:41 PM
    name               : CategoryFromApi
    description        : My category description
    default_category   : False
    position           : 3
    translations       :
    visible_in_portals : {18000009042}

    Get a Freshservice Solution Category with id 18000040164.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceSolutionCategory {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the Solution Category.'
        )]
        [string]$Id,
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
        $uri = [System.UriBuilder]('{0}/solutions/categories' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $false

    }
    process {

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }

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
