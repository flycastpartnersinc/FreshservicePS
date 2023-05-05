<#
.SYNOPSIS
    Deactivate or Forget Freshservice Agent.

.DESCRIPTION
    Deactivate or Forget Freshservice Agent via REST API. Default action is Deactivation (soft delete) of agent.

    https://api.freshservice.com/#delete_an_agent
    https://api.freshservice.com/#forget_an_agent

.PARAMETER id
    Unique id of the Agent.

.PARAMETER Forget
    Permanently delete a Agent and the tickets that they requested.

.EXAMPLE
    Deactivate an Agent. Default API has no response, artificial response with id and status containing
    status code is returned for tracking.

Remove-FreshServiceAgent -id 21001941406

    id status
    -- ------
    21001941406 success 200

.EXAMPLE
    Remove-FreshServiceAgent -id 21001941406 -forget

    id status
    -- ------
    21001941406 success 204

    Permanently delete a Agent and the tickets that they requested. Default API has no response, artificial response with id and status containing
    status code is returned for tracking.
.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceAgent {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Agent.',
            ValueFromPipelineByPropertyName=$true
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'This operation allows you to permanently delete a agent and the tickets that they requested.'
        )]
        [switch]$Forget
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/agents' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path,$Id
        }

        if ($Forget) {
            $uri.Path = "{0}/forget" -f $uri.Path
        }

        try {

            if ($PSCmdlet.ShouldProcess($id)) {

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
