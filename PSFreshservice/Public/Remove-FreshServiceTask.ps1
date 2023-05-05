<#
.SYNOPSIS
    Delete a Freshservice Task for a Ticket, Problem, Change, or Release.

.DESCRIPTION
    Delete a Freshservice Task for a Ticket, Problem, Change, or Release via REST API.

    https://api.freshservice.com/#delete_a_ticket_task
    https://api.freshservice.com/#delete_a_problem_task
    https://api.freshservice.com/#delete_a_change_task
    https://api.freshservice.com/#delete_a_release_task

.PARAMETER id
    Unique id of the Freshservice Task.

.PARAMETER parent_id
    Parent Id of the ticket, problem, change or release to delete the task.

.PARAMETER type
    Parent object type to delete task. Tasks can be created on Ticket, Problem, Change, or Release.

.EXAMPLE
    Remove-FreshServiceTask -parent_id 8 -id 23 -Type Ticket

    id parent_id type   status
    -- --------- ----   ------
    23         8 Ticket success 204

    Delete a Freshservice Task. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceTask {
         [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the task.',
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

                $uri = [System.UriBuilder]('{0}/{1}s/{2}/tasks/{3}' -f $PrivateData['FreshserviceBaseUri'], $type.ToLower(),$parent_id,$id)

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
