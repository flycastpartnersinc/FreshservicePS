<#
.SYNOPSIS
    Delete a Freshservice Requester Group Member.

.DESCRIPTION
    Delete a Freshservice Requester Group Member via REST API.

    https://api.freshservice.com/#delete_member_from_requester_group

.PARAMETER id
    Unique id of the requester group.

.PARAMETER requester_id
    Unique id of the requester.

.EXAMPLE
    Remove-FreshServiceRequesterGroupMember -id 21000137988 -requester_id 21001799737

    id          status
    --          ------
    21000137988 success 204

    Delete a Freshservice Requester Group Member. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceRequesterGroupMember {
         [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the group.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('requester_group_id')]
        [string]$id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$requester_id
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/requester_groups' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $uri.Path = "{0}/{1}/members" -f $uri.Path, $Id
            [void]$PSBoundParameters.Remove('id')
        }

        if ($requester_id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $requester_id
            [void]$PSBoundParameters.Remove('requester_id')
        }

        try {
            if ($PSCmdlet.ShouldProcess($id)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'DELETE'
                    ErrorAction = 'Stop'
                }

                $results = Invoke-FreshworksRestMethod @params

                [PSCustomObject]@{
                    id     = $id
                    status = "success {0}" -f $results.StatusCode
                }

            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
