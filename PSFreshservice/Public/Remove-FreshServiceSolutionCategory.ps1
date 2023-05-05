<#
.SYNOPSIS
    Delete a Freshservice Solution Category.

.DESCRIPTION
    Delete a Freshservice Solution Category via REST API.

    https://api.freshservice.com/#delete_solution_category

.PARAMETER id
    Unique Id of the Solution Category.

.EXAMPLE
    Delete a Freshservice Solution Category. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

    PS C:\PSFreshservice>Remove-FreshServiceSolutionCategory -id 18000040164

    id status
    -- ------
    18000040164 success

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceSolutionCategory {
         [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique Id of the Solution Category.',
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

        $uri = [System.UriBuilder]('{0}/solutions/categories' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
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
