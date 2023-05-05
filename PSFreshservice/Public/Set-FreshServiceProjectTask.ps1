<#
.SYNOPSIS
    Updates a Freshservice Project Task.

.DESCRIPTION
    Updates a Freshservice Project Task via REST API.

    https://api.freshservice.com/#update_a_project_task_newgen

    Only users with "View or Manage Projects" privilege can access this API endpoint.

.PARAMETER id
    Unique identifier of the task.

.PARAMETER project_id
    Unique identifier of the project

.PARAMETER title
    Name of the task.

.PARAMETER description
    Description of the task in plain text or HTML format.

.PARAMETER type_id
    The type of task to be created . Examples of task types are epic, user story, etc. The id can be obtained from here.

.PARAMETER reporter_id
    User ID of the person who reported the task. The default value is of the person creating the task.

.PARAMETER assignee_id
    User ID of the person to whom the task is to be assigned.

.PARAMETER planned_start_date
    Planned start date of the task. The acceptable format is yyyy-mm-ddThh:mm:ssZ.

.PARAMETER planned_end_date
    Planned end date of the task. The acceptable format is yyyy-mm-ddThh:mm:ssZ.

.PARAMETER planned_effort
    Planned effort of the task. The acceptable format is '1w 2d 3h 4m'.

.PARAMETER planned_duration
    Planned effort of the task. The acceptable format is 1w 2d 3h 4m.

.PARAMETER status_id
    Status of the task. The id can be obtained from here. The default status is "Open".

.PARAMETER priority_id
    Priority of the task. The id can be obtained from here.

.PARAMETER parent_id
    Unique id of the parent task (if this field is applicable).
    In the case of subtasks, it is the ID of the parent task it is a part of.
    In the case of standard tasks, it is the ID of the Epic/Task_List it is a part of.

.PARAMETER story_points
    Story Points of the task (if this field is applicable).

.PARAMETER sprint_id
    Unique id of the sprint this task should be a part of (if this field is applicable). It can be obtained from here.

.PARAMETER version_id
    Unique id of the version this task is a part of (if this field is applicable). It can be obtained from here.

.PARAMETER custom_fields
    Key value pairs containing the names and values of custom fields. Read more here.

.EXAMPLE
    Set-FreshServiceProjectTask -project_id 1000320954 -Id 1004523576 -status_id 1000304165

    id                 : 1004523576
    title              : Test task 1e49df30-7850-4a5b-a9b0-aefafdac192b
    project_id         : 1000320954
    description        : <p>Test task 1e49df30-7850-4a5b-a9b0-aefafdac192b</p>
    status_id          : 1000304165
    priority_id        : 1000384012
    created_at         : 4/24/2023 3:47:21 PM
    updated_at         : 4/24/2023 4:22:41 PM
    display_key        : P667977-1
    planned_start_date : 4/24/2023 3:47:20 AM
    type_id            : 1000602500
    planned_end_date   : 5/4/2023 3:47:20 AM
    reporter_id        : 21000418005
    assignee_id        : 21000418005
    planned_effort     :
    planned_duration   : 1w 3d
    custom_fields      :
    version_id         :
    parent_id          :
    story_points       :
    sprint_id          :

    Updates Freshservice Project Task with new status.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceProjectTask {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique identifier of the project',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 0
        )]
        [long]$project_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the Project Task.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 1
        )]
        [Alias('task_id')]
        [long]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the task.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 2
        )]
        [string]$title,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the task in plain text or HTML format.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 3
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The type of task to be created . Examples of task types are epic, user story, etc. The id can be obtained from here.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 4
        )]
        [long]$type_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User ID of the person who reported the task. The default value is of the person creating the task.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 5
        )]
        [long]$reporter_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User ID of the person to whom the task is to be assigned.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 6
        )]
        [long]$assignee_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Planned start date of the task. The acceptable format is yyyy-mm-ddThh:mm:ssZ.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 7
        )]
        [datetime]$planned_start_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Planned end date of the task. The acceptable format is yyyy-mm-ddThh:mm:ssZ.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 8
        )]
        [datetime]$planned_end_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Planned effort of the task. The acceptable format is 1w 2d 3h 4m.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 9
        )]
        [string]$planned_effort,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Planned effort of the task. The acceptable format is 1w 2d 3h 4m.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 10
        )]
        [string]$planned_duration,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Status of the task. The id can be obtained from here. The default status is "Open".',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 11
        )]
        [long]$status_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Priority of the task. The id can be obtained from here.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 12
        )]
        [long]$priority_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the parent task (if this field is applicable). In the case of subtasks, it is the ID of the parent task it is a part of. In the case of standard tasks, it is the ID of the Epic/Task_List it is a part of.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 13
        )]
        [long]$parent_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Story Points of the task (if this field is applicable).',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 14
        )]
        [long]$story_points,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the sprint this task should be a part of (if this field is applicable). It can be obtained from here.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 15
        )]
        [long]$sprint_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the version this task is a part of (if this field is applicable). It can be obtained from here.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 16
        )]
        [long]$version_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of custom fields. Read more here.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 17
        )]
        [hashtable]$custom_fields
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/pm/projects' -f $PrivateData['FreshserviceBaseUri'])

        if ($PSBoundParameters.ContainsKey('project_id')) {
            $uri.Path = "{0}/{1}/tasks" -f $uri.Path, $project_id
            [void]$PSBoundParameters.Remove('Project_id')
        }

        if ($PSBoundParameters.ContainsKey('id')) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $id
            [void]$PSBoundParameters.Remove('Id')
        }

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            if ($PSBoundParameters[$PSItem] -is [datetime]) {
                $jsonBody[$PSItem.ToLower()] = (Get-Date -Date $PSBoundParameters[$PSItem]).ToUniversalTime().ToString("yyyy-MM-ddThh:mm:ssZ")
            }
            else {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            }
        }

        try {
            if ($PSCmdlet.ShouldProcess($id)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'PUT'
                    Body        = $jsonBody | ConvertTo-Json
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

            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
