<#
.SYNOPSIS
    Delete a Freshservice Ticket.

.DESCRIPTION
    Delete a Freshservice Ticket via REST API.

    Note: Deleted tickets are not permanently lost. You can retrieve them using the Restore Ticket API, see Restore-FreshServiceTicket.

    https://api.freshservice.com/#delete_a_ticket

.PARAMETER id
    Unique id of the Ticket.

.EXAMPLE
    Remove-FreshServiceTicket -id 7

    id status
    -- ------
    7 success 204

    Delete a Freshservice Ticket. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceTicket {
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

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

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
