<#
.SYNOPSIS
    Delete a Freshservice Time Entry for a Ticket, Problem, Change, or Release.

.DESCRIPTION
    Delete a Freshservice Time Entry for a Ticket, Problem, Change, or Release via REST API.

    https://api.freshservice.com/#delete_ticket_time_entry
    https://api.freshservice.com/#delete_a_problem_time_entry
    https://api.freshservice.com/#delete_a_time_entry
    https://api.freshservice.com/#delete_a_release_time_entry

.PARAMETER id
    Unique id of the Freshservice Time Entry.

.PARAMETER parent_id
    Parent Id of the ticket, problem, change or release to delete the Time Entry.

.PARAMETER type
    Parent object type to delete Time Entry.  Time Entries can be deleted on Ticket, Problem, Change, or Release.

.EXAMPLE
    Remove-FreshServiceTimeEntry -parent_id 8 -id 23 -Type Ticket

    id parent_id type   status
    -- --------- ----   ------
    23         8 Ticket success 204

    Delete a Freshservice Time Entry on a Ticket. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceTimeEntry {
         [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Time Entry.',
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
            Mandatory = $true,
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

        try {
            if ($PSCmdlet.ShouldProcess($id)) {

                $uri = [System.UriBuilder]('{0}/{1}s/{2}/time_entries/{3}' -f $PrivateData['FreshserviceBaseUri'], $type.ToLower(),$parent_id,$id)

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'DELETE'
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                [PSCustomObject]@{
                    id        = $id
                    parent_id = $parent_id
                    type      = $type
                    status    = "success {0}" -f $result.StatusCode
                }

            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
