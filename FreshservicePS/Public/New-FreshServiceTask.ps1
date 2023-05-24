<#
.SYNOPSIS
    Creates Freshservice Task.

.DESCRIPTION
    Creates Freshservice Task via REST API for Tickets, Problems, Changes and Releases.

    https://api.freshservice.com/#create_ticket_task
    https://api.freshservice.com/#create_problem_task
    https://api.freshservice.com/#create_change_task
    https://api.freshservice.com/#create_release_task

.PARAMETER parent_Id
    Parent Id of the ticket, problem, change or release to create the task.

.PARAMETER agent_id
    Unique id of the agent to whom the task is assigned.

.PARAMETER status
    Status of the task:

    1 = Open
    2 = In Progress
    3 = Completed

.PARAMETER due_date
    Due date of the task.

.PARAMETER notify_before
    Time in seconds before which notification is sent prior to due date.

.PARAMETER title
    Title of the task

.PARAMETER description
    Description of the task

.PARAMETER group_id
    Unique ID of the group to which the task is assigned

.PARAMETER Type
    Parent object type to create task.  Tasks can be created on Ticket, Problem, Change, or Release.

.EXAMPLE
    New-FreshServiceTask -ParentId 8 -Type Ticket -status 1 -due_date (Get-Date).AddDays(3) -title 'My Ticket Task' -description 'Do some stuff'

    id            : 22
    agent_id      :
    status        : 1
    due_date      : 1/2/2023 2:44:19 PM
    notify_before : 0
    title         : My Ticket Task
    description   : Do some stuff
    created_at    : 12/30/2022 2:44:19 PM
    updated_at    : 12/30/2022 2:44:19 PM
    closed_at     :
    group_id      :
    deleted       : False

    Creates a Freshservice ticket task.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceTask {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the parent Ticket, Problem, Change or Release.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('ParentId')]
        [long]$parent_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the agent to whom the task is assigned.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$agent_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Status of the task, 1-Open, 2-In Progress, 3-Completed',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,3)]
        [int]$status,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Due date of the task',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$due_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Time in seconds before which notification is sent prior to due date',
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$notify_before,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Title of the task',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$title,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the task',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique ID of the group to which the task is assigned',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$group_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Parent object type to create task (e.g. Ticket, Problem, Change, Release)',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet('Ticket','Problem','Change','Release')]
        [string]$type
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/{1}s/{2}/tasks' -f $PrivateData['FreshserviceBaseUri'], $Type.ToLower(),$parent_id)

        [void]$PSBoundParameters.Remove('type')
        [void]$PSBoundParameters.Remove('parent_id')

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            #if ($PSBoundParameters[$PSItem] -is [boolean]) {
            #    $jsonBody[$PSItem.ToLower()] = [int]$PSBoundParameters[$PSItem]
            #}
            #else {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            #}
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
