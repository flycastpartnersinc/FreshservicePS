<#
.SYNOPSIS
    Returns a Freshservice Workspace.

.DESCRIPTION
    Returns a Freshservice Workspace via REST API.

    https://api.freshservice.com/#view_a_workspace

.PARAMETER id
    Unique id of the FreshService Workspace.

.PARAMETER associated_assets
    View information about all the associated assets of a Workspace.

.PARAMETER attachments
    View information about all the associated attachments of a Workspace.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceWorkspace

    created_at    : 7/25/2023 1:25:30 PM
    description   :
    id            : 2
    logo          :
    name          : My Team
    primary       : True
    restricted    : False
    state         : 1
    template_name : it
    updated_at    : 7/25/2023 1:25:30 PM

    created_at    : 8/25/2023 8:58:25 PM
    description   :
    id            : 3
    logo          : https://tenant.attachments.freshservice.com/data/helpdesk/attachments/production/21019153239/original/it.png?Expires=1697659317&Signature=gEfmrtaiQWqSCQFvyPGRezeoz9z~rrtZQ5yoNb3ssaCiFlFLJKGAzqXhftFD8v4vk-WQn6gZXVNtbuj
                    a0kVOof0p0D2p3ojHX7xNqzVmtWrIqozOcwmohDKz8ZFqZ3oD0pGclO4Qy9KxPGmMW4nJ09aI7eUG7QH76gmxN-C4biqwE2w1QVkg1cjrNXT-3iMPs18ZEb3e1OsfKhHg7fnX2oSlYsZnR0oTLpSFvOUndKdklRMpMq7xQeL4X-VbV~9thZrJ8CEkwyBomhdUxz0jiN4Lpo6~2gR0kqmMvh999Q
                    H0RFlXb25UOWilCK6VAxHKUpwO29H0qsKLe5GFa5Gz~Q__&Key-Pair-Id=APKAIPHBXWY2KT5RCMPQ
    name          : IT Custom
    primary       : False
    restricted    : False
    state         : 1
    template_name : it
    updated_at    : 8/25/2023 8:59:09 PM

    Returns all Freshservice Workspaces.

.EXAMPLE
    Get-FreshServiceWorkspace -id 2

    created_at    : 7/25/2023 1:25:30 PM
    description   :
    id            : 2
    logo          :
    name          : My Team
    primary       : True
    restricted    : False
    state         : 1
    template_name : it
    updated_at    : 7/25/2023 1:25:30 PM

    Return a Freshservice Workspace by Id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceWorkspace {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Workspace',
            ParameterSetName = 'id',
            Position = 0
        )]
        [int]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default'
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default'
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/workspaces' -f $PrivateData['FreshserviceBaseUri'])
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
