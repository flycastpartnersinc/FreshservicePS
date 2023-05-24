<#
.SYNOPSIS
    Returns a Freshservice Solution Article.

.DESCRIPTION
    Returns a Freshservice Solution Article via REST API.

    https://api.freshservice.com/#view_solution_article

.PARAMETER id
    Unique id of the Freshservice Solution Article.

.PARAMETER folder_id
    The id of the folder to return Freshservice Solution Articles.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceSolutionArticle -id 18000063600

    description                      : <p>This is how you fix stuff</p>
    group_folder_group_ids           : {}
    folder_department_ids            : {}
    group_folder_requester_group_ids : {}
    group_folder_department_ids      : {}
    attachments                      : {}
    folder_visibility                : 1
    id                               : 18000063600
    created_at                       : 9/30/2022 3:13:24 AM
    updated_at                       : 9/30/2022 3:13:24 AM
    title                            : My New Solution Article
    status                           : 2
    user_id                          : 18012453181
    approval_status                  :
    position                         : 1
    folder_id                        : 18000066002
    category_id                      : 18000018546
    thumbs_up                        : 0
    thumbs_down                      : 0
    modified_by                      :
    modified_at                      : 9/30/2022 3:13:24 AM
    inserted_into_tickets            : 0
    url                              :
    article_type                     : 1
    views                            : 0
    description_text                 :  This is how you fix stuff
    keywords                         : {}
    review_date                      :
    tags                             : {}
    approvals                        : {}
    cloud_files                      : {}

    Get Freshservice Solution Article by id.
.EXAMPLE
    Get-FreshServiceSolutionArticle -folder_id 18000066002

    description                      : <p>This is how you fix stuff</p>
    group_folder_group_ids           : {}
    folder_department_ids            : {}
    group_folder_requester_group_ids : {}
    group_folder_department_ids      : {}
    attachments                      : {}
    folder_visibility                : 1
    id                               : 18000063600
    created_at                       : 9/30/2022 3:13:24 AM
    updated_at                       : 9/30/2022 3:13:24 AM
    title                            : My New Solution Article
    status                           : 2
    user_id                          : 18012453181
    approval_status                  :
    position                         : 1
    folder_id                        : 18000066002
    category_id                      : 18000018546
    thumbs_up                        : 0
    thumbs_down                      : 0
    modified_by                      :
    modified_at                      : 9/30/2022 3:13:24 AM
    inserted_into_tickets            : 0
    url                              :
    article_type                     : 1
    views                            : 0
    description_text                 :  This is how you fix stuff
    keywords                         : {}
    review_date                      :

    description                      : <p>Updated description on how to fix stuff.</p>
    group_folder_group_ids           : {}
    folder_department_ids            : {}
    group_folder_requester_group_ids : {}
    group_folder_department_ids      : {}
    attachments                      : {}
    folder_visibility                : 1
    id                               : 18000063601
    created_at                       : 9/30/2022 3:16:48 AM
    updated_at                       : 9/30/2022 12:59:16 PM
    title                            : My Other New Solution Article
    status                           : 1
    user_id                          : 18012453181
    approval_status                  :
    position                         : 2
    folder_id                        : 18000066002
    category_id                      : 18000018546
    thumbs_up                        : 0
    thumbs_down                      : 0
    modified_by                      : 18012453181
    modified_at                      : 10/10/2022 8:23:59 PM
    inserted_into_tickets            : 0
    url                              :
    article_type                     : 1
    views                            : 0
    description_text                 :  Updated description on how to fix stuff.
    keywords                         : {}
    review_date                      :

    Get solution articles by folder.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceSolutionArticle {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the solution article',
            ParameterSetName = 'Id',
            Position = 1
        )]
        [long]$id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Folder Id of the solution article',
            ParameterSetName = 'Id',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Folder Id of the solution article',
            ParameterSetName = 'default',
            Position = 0
        )]
        [long]$folder_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
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
        $uri = [System.UriBuilder]('{0}/solutions/articles' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

    }
    process {

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }
        elseif ($folder_id) {
            $qry.Add('folder_id', $folder_id )
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
