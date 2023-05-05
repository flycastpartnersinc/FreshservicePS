<#
.SYNOPSIS
    Restore a Freshservice Ticket.

.DESCRIPTION
    Restore a Freshservice Ticket via REST API.

    https://api.freshservice.com/#restore_a_Ticket

.PARAMETER id
    Unique Id of the Ticket.

.EXAMPLE
    Restore-FreshServiceTicket -id 16

    id status
    -- ------
    16 success 204

    Restore a Freshservice Ticket. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Restore-FreshServiceTicket {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Ticket.',
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

        $uri = [System.UriBuilder]('{0}/tickets' -f $PrivateData['FreshserviceBaseUri'])

        if ($id) {
            $uri.Path = "{0}/{1}/restore" -f $uri.Path, $id
        }

        try {
            if ($PSCmdlet.ShouldProcess($id)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'PUT'
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
