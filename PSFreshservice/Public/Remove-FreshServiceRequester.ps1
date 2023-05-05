<#
.SYNOPSIS
    Deactivate or Forget Freshservice Requester.

.DESCRIPTION
    Deactivate or Forget Freshservice Requester. Default action is Deactivation of requester via REST API.

    https://api.freshservice.com/#deactivate_a_requester
    https://api.freshservice.com/#forget_a_requester

.PARAMETER id
    Unique id of the Requester.

.PARAMETER Forget
    Permanently delete a Requester and the tickets that they requested

.EXAMPLE
    Remove-FreshServiceRequester -id 21001841985

    id status
    -- ------
    21001841985 success 204

    Deactivate a new Requester. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.EXAMPLE
    Remove-FreshServiceRequester -id 21001841985 -forget

    id status
    -- ------
    21001841985 success 204

    Permanently delete a Requester and the tickets that they requested. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceRequester {
         [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the group.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'This operation allows you to permanently delete a requester and the tickets that they requested.',
            ValueFromPipelineByPropertyName = $true
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

        $uri = [System.UriBuilder]('{0}/requesters' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
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
