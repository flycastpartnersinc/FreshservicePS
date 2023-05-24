<#
.SYNOPSIS
    Returns a Freshservice Project.

.DESCRIPTION
    Returns a Freshservice Project via REST API.

    https://api.freshservice.com/#projects-newgen

.PARAMETER Id
    Unique id of the Project.

.PARAMETER Fields
    View all the built-in and custom fields for Projects.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceProject

    id              : 1000240162
    name            : Test Api Project
    key             : TAP
    description     : test project from API
    status_id       : 2
    priority_id     : 1
    sprint_duration : 14
    project_type    : 1
    start_date      : 2022-09-20
    end_date        : 2022-09-30
    archived        : False
    visibility      : 1
    manager_id      : 21000418005
    created_at      : 9/22/2022 2:36:00 AM
    updated_at      : 9/22/2022 2:36:03 AM
    custom_fields   :

    id              : 1000233530
    name            : New application rollout (sample project)
    key             : NARSP
    description     :
    status_id       : 1
    priority_id     : 2
    sprint_duration : 14
    project_type    : 1
    start_date      : 2022-08-28
    end_date        : 2022-09-29
    archived        : False
    visibility      : 1
    manager_id      : 21000418005
    created_at      : 8/29/2022 2:17:05 PM
    updated_at      : 8/29/2022 2:17:11 PM
    custom_fields   :

    Return all Freshservice Projects.

.EXAMPLE
    Get-FreshServiceProject -id 1000240162

    id              : 1000240162
    name            : Test Api Project
    key             : TAP
    description     : test project from API
    status_id       : 2
    priority_id     : 1
    sprint_duration : 14
    project_type    : 1
    start_date      : 2022-09-20
    end_date        : 2022-09-30
    archived        : False
    visibility      : 1
    manager_id      : 21000418005
    created_at      : 9/22/2022 2:36:00 AM
    updated_at      : 9/22/2022 2:36:03 AM
    custom_fields   :

    Return Freshservice Project by Id.

.EXAMPLE
    Get-FreshServiceProject -Fields

    label      : Name
    name       : name
    type       : default_name
    default    : True
    choices    : {}
    mandatory  : True
    created_at : 2022-08-29 14:17:04
    updated_at : 2022-08-29 14:17:04

    label      : Description
    name       : description
    type       : default_description
    default    : True
    choices    : {}
    mandatory  : False
    created_at : 2022-08-29 14:17:04
    updated_at : 2022-08-29 14:17:04

    label      : Project Manager
    name       : manager_id
    type       : default_manager_id
    default    : True
    choices    : {}
    mandatory  : False
    created_at : 2022-08-29 14:17:04
    updated_at : 2022-08-29 14:17:04

    label      : Project Key
    name       : key
    type       : default_key
    default    : True
    choices    : {}
    mandatory  : True
    created_at : 2022-08-29 14:17:04
    updated_at : 2022-08-29 14:17:04

    Return all the built-in and custom fields for Projects.
.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceProject {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Project.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allows you to view all the built-in and custom fields for Projects in your Freshservice account.',
            ParameterSetName = 'Form',
            Position = 0
        )]
        [Alias('Form')]
        [switch]$fields,
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

        if ($fields){
            $uri = [System.UriBuilder]('{0}/pm/project-fields' -f $PrivateData['FreshserviceBaseUri'])
        }
        else {
            $uri = [System.UriBuilder]('{0}/pm/projects' -f $PrivateData['FreshserviceBaseUri'])
        }

        $enablePagination = $true

    }
    process {

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $id
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
