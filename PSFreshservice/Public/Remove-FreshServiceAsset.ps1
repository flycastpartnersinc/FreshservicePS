<#
.SYNOPSIS
    Delete a Freshservice Asset.

.DESCRIPTION
    Delete a Freshservice Asset via REST API.

    https://api.freshservice.com/#delete_an_asset
    https://api.freshservice.com/#delete_forever_an_asset

.PARAMETER display_id
    Unique display_id of the Freshservice Asset.

.PARAMETER delete_forever
    Permanently delete an asset which cannot be restored later.

.EXAMPLE
    Remove-FreshServiceAsset -display_id 30

    id status
    -- ------
    30 success 204

    Delete a Freshservice Asset. Default API has no response, artificial response with id and status containing
    status code is returned for tracking.

.EXAMPLE
    Remove-FreshServiceAsset -display_id 30 -delete_forever

    id status
    -- ------
    30 success 204

    Permanently delete an Freshservice Asset which cannot be restored later. Default API has no response, artificial response with id and status containing
    status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceAsset {
         [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique display_id of the Asset.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('id')]
        [long]$display_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Permanently delete an asset which cannot be restored later.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('Permanent')]
        [switch]$delete_forever
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/assets' -f $PrivateData['FreshserviceBaseUri'])

        try {
                if ($PSCmdlet.ShouldProcess($id)) {

                    $Method = 'DELETE'

                    if ($display_id) {
                        $uri.Path = "{0}/{1}" -f $uri.Path, $display_id
                    }

                    if ( $PSBoundParameters.ContainsKey('delete_forever') ) {
                        $uri.Path = '{0}/delete_forever' -f $uri.Path
                        $Method = 'PUT'
                    }

                    $params = @{
                        Uri         = $uri.Uri.AbsoluteUri
                        Method      = $Method
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
