<#
.SYNOPSIS
    Delete Freshservice Agent group.

.DESCRIPTION
    Delete Freshservice Agent Group via REST API.

    1. Deleting a Group will only disband the group and not delete its members.
    2. Deleted groups cannot be restored.
    3. When deleting a group, agents who have their only role in this group being deleted will be rescoped
        to the "assigned_items" scope from "specified_groups" for this role.

    https://api.freshservice.com/#delete_a_group

.PARAMETER id
    Unique id of the Agent Group.

.EXAMPLE
    Remove-FreshServiceAgentGroup -id 21000546879

    id status
    -- ------
    21000546879 success 204

    Delete and Agent Group. Default API has no response, artificial response with id and status containing
    status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceAgentGroup {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique Id of the Agent Group.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$id
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/groups' -f $PrivateData['FreshserviceBaseUri'])

        if ($PSBoundParameters.ContainsKey('id')) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $id
            [void]$PSBoundParameters.Remove('Id')
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'DELETE'
                    ErrorAction = 'Stop'
                }

                $results = Invoke-FreshworksRestMethod @params

                [pscustomobject]@{
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
