<#
.SYNOPSIS
    Returns a Freshservice Solution Folder..

.DESCRIPTION
    Returns a Freshservice Solution Folder via REST API.

    https://api.freshservice.com/#view_solution_folder

.PARAMETER Id
    Unique Id of the Solution Folder.

.PARAMETER category_id
    Unique category of the Solution Folder to return.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceSolutionFolder -category_id 18000018546

    description         : Default solution folder, feel free to edit or delete it.
    id                  : 18000028049
    created_at          : 3/16/2021 9:24:31 PM
    updated_at          : 3/16/2021 9:24:31 PM
    name                : FAQ
    category_id         : 18000018546
    position            : 1
    visibility          : 1
    approval_settings   :
    default_folder      : False
    manage_by_group_ids : {}

    description         : Default solution folder, feel free to edit or delete it.
    id                  : 18000028050
    created_at          : 3/16/2021 9:24:31 PM
    updated_at          : 3/16/2021 9:24:31 PM
    name                : Getting Started
    category_id         : 18000018546
    position            : 2
    visibility          : 1
    approval_settings   :
    default_folder      : False
    manage_by_group_ids : {}

    description         : Folder desc from API
    id                  : 18000066001
    created_at          : 9/30/2022 1:42:30 AM
    updated_at          : 9/30/2022 2:05:15 AM
    name                : FolderFromAPI
    category_id         : 18000018546
    position            : 3
    visibility          : 1
    approval_settings   :
    default_folder      : False
    manage_by_group_ids : {}

    description         : Folder desc from API
    id                  : 18000066002
    created_at          : 9/30/2022 2:16:32 AM
    updated_at          : 9/30/2022 2:19:18 AM
    name                : MyNewSolutionFolder
    category_id         : 18000018546
    position            : 4
    visibility          : 1
    approval_settings   :
    default_folder      : False
    manage_by_group_ids : {}

    Get all Freshservice Solution Folders by Category.

.EXAMPLE
    Get-FreshServiceSolutionFolder -id 18000066002

    description         : Folder desc from API
    id                  : 18000066002
    created_at          : 9/30/2022 2:16:32 AM
    updated_at          : 9/30/2022 2:19:18 AM
    name                : MyNewSolutionFolder
    category_id         : 18000018546
    position            : 4
    visibility          : 1
    approval_settings   :
    default_folder      : False
    manage_by_group_ids : {}

    Get a Freshservice Solution Folder with id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceSolutionFolder {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Solution Folder.',
            ParameterSetName = 'Id',
            Position = 1
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Category to get Solution Folders.',
            ParameterSetName = 'Id',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Category to get Solution Folders.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [long]$category_id,
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
        $uri = [System.UriBuilder]('{0}/solutions/folders' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $false

    }
    process {

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }

        if ($category_id) {
            $qry.Add('category_id', $category_id)
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
