<#
.SYNOPSIS
    Updates a Freshservice Time Entry on a Ticket, Problem, Change or Release.

.DESCRIPTION
    Updates a Freshservice Time Entry on a Ticket, Problem, Change or Release via REST API.

    https://api.freshservice.com/#update_ticket_time_entry
    https://api.freshservice.com/#update_problem_time_entry
    https://api.freshservice.com/#update_time_entry
    https://api.freshservice.com/#update_release_time_entry

.PARAMETER Id
    Unique id of the Time Entry.

.PARAMETER parent_id
    Parent Id of the ticket, problem, change or release to create the time entry.

.PARAMETER start_time
    The time at which the time-entry is added. If a timer, which is in stopped state, is started again, this holds date_time at which the timer is started again.

.PARAMETER timer_running
    Set to true if timer is currently running. Default value is false. At a time, only one timer can be running for an agent across the account.

.PARAMETER billable
    Set as true if the time-entry is billable. Default value is true.

.PARAMETER time_spent
    The total amount of time spent by the timer in hh::mm format. This field cannot be set if timer_running is true. Mandatory if timer_running is false.

.PARAMETER executed_at
    Time at which the timer is executed. Default value (unless given in request) is the time at which timer is added. Should be less than or equal to current date_time.

.PARAMETER task_id
    Unique id of the task assigned to the time-entry. Task should be valid on the given ticket and assigned to agent_id.

.PARAMETER note
    Description of the time-entry.

.PARAMETER agent_id
    The user/agent to whom this time-entry is assigned.

.PARAMETER Type
    Parent object type to create time entry.  Time Entrys can be created on Ticket, Problem, Change, or Release.

.EXAMPLE
    Set-FreshServiceTimeEntry -parent_id 9 -type Ticket -id 21000056011 -note "Detailed Notes"

    id            : 21000056011
    created_at    : 1/4/2023 1:53:41 PM
    updated_at    : 1/5/2023 5:51:01 PM
    start_time    : 1/4/2023 1:53:41 PM
    timer_running : False
    billable      : True
    time_spent    : 01:00
    executed_at   : 1/4/2023 1:53:41 PM
    time entry_id       :
    note          : Detailed Notes
    agent_id      : 21000418005
    custom_fields :

    Update a description on a Time Entry on a Freshservice Ticket.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceTimeEntry {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the time entry.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the parent Ticket, Problem, Change or Release.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('ParentId')]
        [long]$parent_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set to true if timer is currently running. Default value is false. At a time, only one timer can be running for an agent across the account',
            ValueFromPipelineByPropertyName = $true
        )]
        [boolean]$timer_running,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set as true if the time-entry is billable. Default value is true',
            ValueFromPipelineByPropertyName = $true
        )]
        [boolean]$billable,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The total amount of time spent by the timer in hh::mm format. This field cannot be set if timer_running is true. Mandatory if timer_running is false',
            ValueFromPipelineByPropertyName = $true
        )]
        [timespan]$time_spent,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Time at which the timer is executed. Default value (unless given in request) is the time at which timer is added. Should be less than or equal to current date_time',
            ValueFromPipelineByPropertyName = $true
        )]
        [datetime]$executed_at,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the task assigned to the time-entry. Task should be valid on the given ticket and assigned to agent_id',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$task_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the time-entry',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$note,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The user/agent to whom this time-entry is assigned',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$agent_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Parent object type to create time entry (e.g. Ticket, Problem, Change, Release)',
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

        $uri = [System.UriBuilder]('{0}/{1}s/{2}/time_entries/{3}' -f $PrivateData['FreshserviceBaseUri'], $type.ToLower(),$parent_id,$id)

        [void]$PSBoundParameters.Remove('type')
        [void]$PSBoundParameters.Remove('parent_id')
        [void]$PSBoundParameters.Remove('id')

        if ($PSBoundParameters.ContainsKey('time_spent')) {
            $PSBoundParameters['time_spent'] = $time_spent.ToString("hh\:mm")
        }

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

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
