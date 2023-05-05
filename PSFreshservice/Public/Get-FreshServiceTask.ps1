<#
.SYNOPSIS
    Returns a Freshservice Task for a Ticket, Problem, Change or Release.

.DESCRIPTION
    Returns a Freshservice Task for a Ticket, Problem, Change or Release via REST API.

    https://api.freshservice.com/#view_a_ticket_task
    https://api.freshservice.com/#view_a_problem_task
    https://api.freshservice.com/#view_a_change_task
    https://api.freshservice.com/#view_a_release_task

.PARAMETER parent_id
    Unique id of the Ticket, Problem, Change or Release.

.PARAMETER type
    Type of container (Tickets, Problems, Changes or Releases)

.PARAMETER id
    Unique id of the Task.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceTask -ParentId 4 -Type Ticket

    id            : 20
    agent_id      :
    status        : 1
    due_date      : 11/15/2022 10:00:00 PM
    notify_before : 0
    title         : My ticket task
    description   :
    created_at    : 11/14/2022 6:34:04 PM
    updated_at    : 11/14/2022 6:34:04 PM
    closed_at     :
    group_id      : 21000188395
    deleted       : False

    Get all Freshservice Tasks of a Ticket.

.EXAMPLE
    Get-FreshServiceTask -parent_id 4 -type Ticket -id 20

    id            : 20
    agent_id      :
    status        : 1
    due_date      : 11/15/2022 10:00:00 PM
    notify_before : 0
    title         : My ticket task
    description   :
    created_at    : 11/14/2022 6:34:04 PM
    updated_at    : 11/14/2022 6:34:04 PM
    closed_at     :
    group_id      : 21000188395
    deleted       : False

    Get a specific Freshservice Task on a Ticket.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceTask {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the parent Ticket, Problem, Change or Release.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [Alias('ParentId')]
        [long]$parent_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Type of task (Tickets, Problems, Changes or Releases)',
            ParameterSetName = 'default',
            Position = 1
        )]
        [ValidateSet('Ticket','Problem','Change','Release')]
        [string]$type,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the the Task on the Ticket',
            ParameterSetName = 'default',
            Position = 2
        )]
        [Alias('TaskId','ChildId')]
        [string]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 3
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 4
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/{1}s/{2}/tasks' -f $PrivateData['FreshserviceBaseUri'], $type.ToLower(),$parent_id)
        $enablePagination = $true

    }
    process {

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
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
