<#
.SYNOPSIS
    Returns a Freshservice Time Entry for a Ticket, Problem, Change or Release.

.DESCRIPTION
    Returns a Freshservice Time Entry for a Ticket, Problem, Change or Release via REST API.

    https://api.freshservice.com/#view_ticket_time_entry
    https://api.freshservice.com/#view_a_problem_time_entry
    https://api.freshservice.com/#view_a_time_entry
    https://api.freshservice.com/#view_a_release_time_entry

.PARAMETER Id
    Unique id of the Time Entry.

.PARAMETER parent_id
    Parent Id of the ticket, problem, change or release to create the time entry.

.PARAMETER Type
    Parent object type to create time entry. Time Entrys can be created on Ticket, Problem, Change, or Release.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceTimeEntry -parent_id 185 -type Ticket

    id            : 21000167654
    created_at    : 3/27/2023 3:09:37 PM
    updated_at    : 3/27/2023 3:09:37 PM
    start_time    : 3/27/2023 3:09:37 PM
    timer_running : False
    billable      : True
    time_spent    : 02:00
    executed_at   : 3/27/2023 3:09:12 PM
    task_id       :
    note          : Worked on stuff
    agent_id      : 21001931878
    custom_fields :

    Returns all Freshservice Time Entries on Ticket 185.

.EXAMPLE
    Get-FreshServiceTimeEntry -parent_id 12 -type Problem

    id            : 21000167668
    created_at    : 3/27/2023 3:12:54 PM
    updated_at    : 3/27/2023 3:12:54 PM
    start_time    : 3/27/2023 3:12:54 PM
    timer_running : False
    billable      : True
    time_spent    : 05:00
    executed_at   : 3/27/2023 3:12:00 PM
    task_id       :
    note          : Trying to find the bug in the software
    agent_id      : 21001931878
    custom_fields :

    Returns all Freshservice Time Entries on Problem 12.

.EXAMPLE
    Get-FreshServiceTimeEntry -parent_id 185 -type Ticket -id 21000167654

    id            : 21000167654
    created_at    : 3/27/2023 3:09:37 PM
    updated_at    : 3/27/2023 3:09:37 PM
    start_time    : 3/27/2023 3:09:37 PM
    timer_running : False
    billable      : True
    time_spent    : 02:00
    executed_at   : 3/27/2023 3:09:12 PM
    task_id       :
    note          : Worked on stuff
    agent_id      : 21001931878
    custom_fields :

    Returns a specific Freshservice Time Entry on a Ticket by Id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceTimeEntry {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Time Entry.',
            ParameterSetName = 'id',
            Position = 2
        )]
        [long]$id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the parent Ticket, Problem, Change or Release.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the parent Ticket, Problem, Change or Release.',
            ParameterSetName = 'id',
            Position = 1
        )]
        [Alias('ParentId')]
        [long]$parent_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Parent object type to create time entry (e.g. Ticket, Problem, Change, Release)',
            ParameterSetName = 'default',
            Position = 0
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Parent object type to create time entry (e.g. Ticket, Problem, Change, Release)',
            ParameterSetName = 'id',
            Position = 0
        )]
        [ValidateSet('Ticket','Problem','Change','Release')]
        [string]$type,
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
        $uri = [System.UriBuilder]('{0}/{1}s/{2}/time_entries' -f $PrivateData['FreshserviceBaseUri'], $type.ToLower(),$parent_id)

        $enablePagination = $true

    }
    process {

        if ($id) {
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
