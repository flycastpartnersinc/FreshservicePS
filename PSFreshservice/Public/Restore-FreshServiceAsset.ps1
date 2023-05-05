<#
.SYNOPSIS
    Restore a Freshservice Asset.

.DESCRIPTION
    Restore a Freshservice Asset via REST API.

    https://api.freshservice.com/#restore_an_asset

.PARAMETER display_id
    Unique display_id of the Asset.

.EXAMPLE
    Restore-FreshServiceAsset -display_id 8

    id status
    -- ------
    8 success 204

    Restore a Freshservice Asset. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Restore-FreshServiceAsset {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique display_id of the Asset.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$display_id
    )
    begin {
        $PrivateData = $MyInvocation.MyCommand.Module.PrivateData
    }
    process {

        $uri = [System.UriBuilder]('{0}/assets' -f $PrivateData['FreshserviceBaseUri'])

        if ($display_id) {
            $uri.Path = "{0}/{1}/restore" -f $uri.Path, $display_id
        }

        try {
            if ($PSCmdlet.ShouldProcess($display_id)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'PUT'
                    ErrorAction = 'Stop'
                }

                $results = Invoke-FreshworksRestMethod @params

                [PSCustomObject]@{
                    id     = $display_id
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
