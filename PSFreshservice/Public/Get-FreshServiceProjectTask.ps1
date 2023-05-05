<#
.SYNOPSIS
    Returns a Freshservice Project Task.

.DESCRIPTION
    Returns a Freshservice Project Task via REST API.

    https://api.freshservice.com/#view_a_project_task_newgen

.PARAMETER Id
    Unique id of the Task.

.PARAMETER project_id
    Unique id of the Project.

.PARAMETER filter
    Filter Project Tasks.  See documentation for filterable properties:

    https://api.freshservice.com/#filter_all_project_tasks_newgen

.PARAMETER task_types
    Lists all the task types that are present in a project.

.PARAMETER task_priorities
    Lists all priority levels that have been created in a project.

.PARAMETER task_statuses
    Lists all the task statuses that have been defined in a project.

.PARAMETER versions
    Lists all the versions that have been created in a project.

.PARAMETER sprints
    Lists all the sprints that have been created in a project.

.PARAMETER memberships
    Lists all the members that are present in a project.

.PARAMETER fields
    List the fields of a specifc task type from your project. The ID of the task type can be obtained from this API.

.PARAMETER task_type_id
    Unique id of the task type to return fields. The task type id listed using the -task_types switch.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE

    Get-FreshServiceProjectTask -project_id 1000251723

    id                 : 1003442491
    title              : Onboarding Kickoff Call
    project_id         : 1000251723
    description        :
    status_id          : 1000304164
    priority_id        :
    created_at         : 10/31/2022 3:36:08 PM
    updated_at         : 10/31/2022 3:36:08 PM
    display_key        : FSD-1
    planned_start_date :
    type_id            : 1000602500
    planned_end_date   :
    reporter_id        : 21000418005
    assignee_id        :
    planned_effort     :
    planned_duration   :
    custom_fields      :
    version_id         :
    parent_id          :
    story_points       :
    sprint_id          :

    Return all Freshservice Project Tasks.

.EXAMPLE
    Get-FreshServiceProjectTask -project_id 1000251723 -Id 1003442491

    id                 : 1003442491
    title              : Onboarding Kickoff Call
    project_id         : 1000251723
    description        :
    status_id          : 1000304164
    priority_id        :
    created_at         : 10/31/2022 3:36:08 PM
    updated_at         : 10/31/2022 3:36:08 PM
    display_key        : FSD-1
    planned_start_date :
    type_id            : 1000602500
    planned_end_date   :
    reporter_id        : 21000418005
    assignee_id        :
    planned_effort     :
    planned_duration   :
    custom_fields      :
    version_id         :
    parent_id          :
    story_points       :
    sprint_id          :

    Return a specific Freshservice Project Task by Id.

.EXAMPLE
    Get-FSProjectTask -project_id 1000251723 -task_types

    id          : 1000602501
    created_at  : 8/29/2022 2:17:04 PM
    updated_at  : 8/29/2022 2:17:04 PM
    name        : sub_task
    description : This is the description for sub_task
    project_id  : 1000251723

    id          : 1000602500
    created_at  : 8/29/2022 2:17:04 PM
    updated_at  : 8/29/2022 2:17:04 PM
    name        : task
    description : This is the description for task
    project_id  : 1000251723

    id          : 1000602497
    created_at  : 8/29/2022 2:17:04 PM
    updated_at  : 8/29/2022 2:17:04 PM
    name        : task_list
    description : This is the description for task_list
    project_id  : 1000251723

    Return all Task Types on a Freshservice Project.


.EXAMPLE
    Get-FreshServiceProjectTask -project_id 1000251723 -Filter "type_id:1000602500"

    id                 : 1003442491
    title              : Onboarding Kickoff Call
    project_id         : 1000251723
    description        :
    status_id          : 1000304164
    priority_id        :
    created_at         : 10/31/2022 3:36:08 PM
    updated_at         : 10/31/2022 3:36:08 PM
    display_key        : FSD-1
    planned_start_date :
    type_id            : 1000602500
    planned_end_date   :
    reporter_id        : 21000418005
    assignee_id        :
    planned_effort     :
    planned_duration   :
    custom_fields      :
    version_id         :
    parent_id          :
    story_points       :
    sprint_id          :

    Return all Project Tasks on a Freshservice Project with a filtered type id of '1000602500'.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceProjectTask {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Project.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Project.',
            ParameterSetName = 'filter',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Project.',
            ParameterSetName = 'fields',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Project.',
            ParameterSetName = 'task_types',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Project.',
            ParameterSetName = 'task_priorities',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Project.',
            ParameterSetName = 'task_statuses',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Project.',
            ParameterSetName = 'versions',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Project.',
            ParameterSetName = 'sprints',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Project.',
            ParameterSetName = 'memberships',
            Position = 0
        )]
        [long]$project_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the Project Task.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [Alias('task_id')]
        [long]$Id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Filter Project Tasks.',
            ParameterSetName = 'filter',
            Position = 1
        )]
        [string]$filter,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Lists all the task types that are present in a project.',
            ParameterSetName = 'task_types',
            Position = 1
        )]
        [switch]$task_types,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Lists all priority levels that have been created in a project.',
            ParameterSetName = 'task_priorities',
            Position = 1
        )]
        [switch]$task_priorities,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Lists all the task statuses that have been defined in a project.',
            ParameterSetName = 'task_statuses',
            Position = 1
        )]
        [switch]$task_statuses,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Lists all the versions that have been created in a project.',
            ParameterSetName = 'versions',
            Position = 1
        )]
        [switch]$versions,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Lists all the sprints that have been created in a project.',
            ParameterSetName = 'sprints',
            Position = 1
        )]
        [switch]$sprints,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Lists all the members that are present in a project.',
            ParameterSetName = 'memberships',
            Position = 1
        )]
        [switch]$memberships,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'List the fields of a specifc task type from your project. The ID of the task type can be obtained from this API.',
            ParameterSetName = 'fields',
            Position = 1
        )]
        [Alias('task_fields')]
        [switch]$fields,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'The task type id listed using the -task_types switch.',
            ParameterSetName = 'fields',
            Position = 2
        )]
        [long]$task_type_id,
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
        $uri = [System.UriBuilder]('{0}/pm/projects' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

    }
    process {

        if ($project_id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $project_id
            $enablePagination = $false
        }

        if ($fields) {
            $uri.Path = "{0}/task-types/{1}/fields" -f $uri.Path,$task_type_id
            $enablePagination = $false
        }
        elseif ($task_types) {
            $uri.Path = "{0}/task-types" -f $uri.Path
            $enablePagination = $false
        }
        elseif ($task_priorities) {
            $uri.Path = "{0}/task-priorities" -f $uri.Path
            $enablePagination = $false
        }
        elseif ($task_statuses) {
            $uri.Path = "{0}/task-statuses" -f $uri.Path
            $enablePagination = $false
        }
        elseif ($versions) {
            $uri.Path = "{0}/versions" -f $uri.Path
            $enablePagination = $false
        }
        elseif ($sprints) {
            $uri.Path = "{0}/sprints" -f $uri.Path
            $enablePagination = $false
        }
        elseif ($memberships) {
            $uri.Path = "{0}/memberships" -f $uri.Path
            $enablePagination = $false
        }
        else {
            $uri.Path = "{0}/tasks" -f $uri.Path
        }

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $id
            $enablePagination = $false
        }
        elseif ($filter) {
            $uri.Path = "{0}/filter" -f $uri.Path
            $qry.Add('query', '"{0}"' -f $filter )
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
                    Write-Verbose ('Properties: {0}' -f ($content[0].PSObject.Properties.Name -join ','))
                    $objProperty = $content[0].PSObject.Properties.Name |
                                        Where-Object -FilterScript {$_ -notlike 'total*'}

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
