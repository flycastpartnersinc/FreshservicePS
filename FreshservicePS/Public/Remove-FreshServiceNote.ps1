<#
.SYNOPSIS
    Delete a Freshservice Note on Problem, Change, or Release.

.DESCRIPTION
    Delete a Freshservice Note on Problem, Change, or Release via REST API.

    https://api.freshservice.com/#delete_a_problem_note
    https://api.freshservice.com/#delete_a_change_note
    https://api.freshservice.com/#delete_a_release_note

    For Ticket Note deletion, see Remove-FreshServiceConversation.

.PARAMETER id
    Unique id of the Freshservice Note.

.PARAMETER parent_id
    Parent Id of the problem, change or release to delete the task.

.PARAMETER type
    Parent object type to delete task. Tasks can be deleted on Problem, Change, or Release.

.EXAMPLE
    Remove-FreshServiceNote -parent_id 2 -type Problem -id 21000071787

    id status
    -- ------
    21000071787 success 204

    Delete a Freshservice Note (i.e. 21000071787) on a Problem (i.e. id = 2). Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceNote {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the note.',
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
            HelpMessage = 'Parent object type to create note (e.g. Problem, Change, Release)',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet('Problem','Change','Release')]
        [string]$type
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/{1}s/{2}/notes/{3}' -f $PrivateData['FreshserviceBaseUri'], $type.ToLower(),$parent_id,$id)

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'DELETE'
                    ErrorAction = 'Stop'
                }

                $results = Invoke-FreshworksRestMethod @params

                [PSCustomObject]@{
                    id        = $id
                    parent_id = $parent_id
                    type      = $type
                    status    = "success {0}" -f $results.StatusCode
                }

            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
