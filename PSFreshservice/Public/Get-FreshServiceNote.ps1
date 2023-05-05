<#
.SYNOPSIS
    Returns a Freshservice Note on Problem, Change or Release.

.DESCRIPTION
    Returns a Freshservice Note on Problem, Change or Release via REST API. For Tickets,
    see Get-FreshServiceConversation.

    https://api.freshservice.com/#view_a_problem_note
    https://api.freshservice.com/#view_a_change_note
    https://api.freshservice.com/#view_a_release

.PARAMETER Id
    Unique id of the note.

.PARAMETER parent_id
    Unique id of the parent Ticket, Problem, Change or Release.

.PARAMETER type
    Parent object type to create time entry (e.g. Ticket, Problem, Change, Release).

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceNote -parent_id 2 -type Problem

    id            : 21000071787
    created_at    : 1/10/2023 6:24:23 PM
    updated_at    : 1/10/2023 6:24:23 PM
    body          : <div>A note added to a Problem.</div>
    body_text     : A note added to a Problem.
    user_id       : 21000418005
    notify_emails :

    Return all Freshservice Notes on Problem id 2.

.EXAMPLE
    Get-FreshServiceNote -parent_id 2 -type Problem -id 21000071797

    id            : 21000071797
    created_at    : 1/10/2023 7:52:26 PM
    updated_at    : 1/10/2023 8:01:18 PM
    body          : Updated note on a problem
    body_text     : Updated note on a problem
    user_id       : 21000418005
    notify_emails :

    Return a specific Freshservice Note on Problem id 2 by id 21000071797.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceNote {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id for Ticket to get conversations',
            ParameterSetName = 'default',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the parent Ticket, Problem, Change or Release.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('ParentId')]
        [long]$parent_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Parent object type to create time entry (e.g. Ticket, Problem, Change, Release)',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet('Ticket','Problem','Change','Release')]
        [string]$type,
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
        $uri = [System.UriBuilder]('{0}/{1}s/{2}' -f $PrivateData['FreshserviceBaseUri'], $type.ToLower(),$parent_id)
        $enablePagination = $true

    }
    process {

        if ($type -eq 'Ticket') {
            $uri.Path = "{0}/conversations" -f $uri.Path, $Id
        }
        else {
            $uri.Path = "{0}/notes" -f $uri.Path, $Id
        }

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $true
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
                    $objProperty = $content[0].PSObject.Properties.Name |
                                        Where-Object -FilterScript {$_ -like 'note*' -or $_ -like 'conversation*'}
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
