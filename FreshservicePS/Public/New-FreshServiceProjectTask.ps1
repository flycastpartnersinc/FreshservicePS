<#
.SYNOPSIS
    Creates Freshservice Project Task.

.DESCRIPTION
    Creates Freshservice Project Task via REST API.

    https://api.freshservice.com/#create_a_project_task_newgen

.PARAMETER project_id
    Unique identifier of the project.

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
    Planned duration of the task. It is the difference between the planned end and start dates. The acceptable format is '1w 2d 3h 4m'.

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
    New-FreshServiceProjectTask -title "My New Task" -description "Stuff to do" -type_id 1000602500 -project_id 1000320954 -planned_start_date (Get-Date).AddDays(1)

    id                 : 1004523593
    title              : My New Task
    project_id         : 1000320954
    description        : <p>Stuff to do</p>
    status_id          : 1000304164
    priority_id        :
    created_at         : 4/24/2023 3:50:02 PM
    updated_at         : 4/24/2023 3:50:02 PM
    display_key        : P667977-2
    planned_start_date : 4/25/2023 3:50:02 AM
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

    Create a new Freshservice Project Task.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceProjectTask {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique identifier of the Release',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 0
        )]
        [long]$project_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the task.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 1
        )]
        [string]$title,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the task in plain text or HTML format.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 2
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The type of task to be created . Examples of task types are epic, user story, etc. The id can be obtained from here.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 3
        )]
        [long]$type_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User ID of the person who reported the task. The default value is of the person creating the task.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 4
        )]
        [long]$reporter_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User ID of the person to whom the task is to be assigned.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 5
        )]
        [long]$assignee_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Planned start date of the task. The acceptable format is yyyy-mm-ddThh:mm:ssZ.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 6
        )]
        [datetime]$planned_start_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Planned end date of the task. The acceptable format is yyyy-mm-ddThh:mm:ssZ.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 7
        )]
        [datetime]$planned_end_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Planned effort of the task. The acceptable format is "1w 2d 3h 4m".',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 8
        )]
        [string]$planned_effort,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Planned duration of the task. It is the difference between the planned end and start dates. The acceptable format is "1w 2d 3h 4m".',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 9
        )]
        [string]$planned_duration,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Status of the task. The id can be obtained from here. The default status is "Open".',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 10
        )]
        [long]$status_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Priority of the task. The id can be obtained from here.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 11
        )]
        [long]$priority_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the parent task (if this field is applicable). In the case of subtasks, it is the ID of the parent task it is a part of. In the case of standard tasks, it is the ID of the Epic/Task_List it is a part of.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 12
        )]
        [long]$parent_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Story Points of the task (if this field is applicable).',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 13
        )]
        [long]$story_points,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the sprint this task should be a part of (if this field is applicable). It can be obtained from here.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 14
        )]
        [long]$sprint_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the version this task is a part of (if this field is applicable). It can be obtained from here.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 15
        )]
        [long]$version_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of custom fields. Read more here.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 16
        )]
        [hashtable]$custom_fields
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/pm/projects' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        if ($PSBoundParameters.ContainsKey('project_id')) {
            $uri.Path = "{0}/{1}/tasks" -f $uri.Path, $project_id
            [void]$PSBoundParameters.Remove('Project_id')
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
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'POST'
                    Body        = $jsonBody | ConvertTo-Json
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

            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
