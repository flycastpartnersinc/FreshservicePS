<#
.SYNOPSIS
    Creates Freshservice Ticket Source.

.DESCRIPTION
    Creates Freshservice Ticket Source via REST API.

    https://api.freshservice.com/#create_custom_ticket_source

.PARAMETER name
    Name of the ticket source.

.EXAMPLE
    New-FreshServiceTicketSource -name 'Magic'

    id         : 21000466443
    created_at : 1/5/2023 6:08:44 PM
    updated_at : 1/5/2023 6:08:44 PM
    choice_id  : 1001
    value      : Magic
    position   : 16
    visible    : True
    default    : False

    Creates a Freshservice Ticket Source.

.NOTES
    This module was developed and tested with Freshservice REST API v2.

    There are no GET, SET (PUT) or REMOVE (DELETE) methods currently available for this API endpoint.
#>
function New-FreshServiceTicketSource {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the ticket source.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$name
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/ticket_fields/sources' -f $PrivateData['FreshserviceBaseUri'])

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'POST'
                    Body        = $jsonBody | ConvertTo-Json
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                if ($result.Content) {
                    $content = $result.Content |
                                    ConvertFrom-Json

                    #API returns singluar or plural property based on the number of records, parse to get property returned.
                    $objProperty = $content[0].PSObject.Properties.Name
                    Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                    $content."$($objProperty)"
                }

            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
