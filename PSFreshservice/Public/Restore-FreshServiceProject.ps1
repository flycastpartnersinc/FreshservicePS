<#
.SYNOPSIS
    Restores a Freshservice Project.

.DESCRIPTION
    Restores a 'Archived' Freshservice Project via REST API.  Deleted projects cannot be restored.

    https://api.freshservice.com/#restore_a_project


.PARAMETER id
    Unique Id of the archived Project.

.EXAMPLE
    Restore-FreshServiceProject -id 1000319865

    id status
    -- ------
    16 success 200

    Restore an archived Freshservice Project. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Restore-FreshServiceProject {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Project.',
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

        $uri = [System.UriBuilder]('{0}//pm/projects' -f $PrivateData['FreshserviceBaseUri'])

        if ($id) {
            $uri.Path = "{0}/{1}/restore" -f $uri.Path, $id
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'POST'
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
