<#
.SYNOPSIS
    Delete a Freshservice Software User.

.DESCRIPTION
    Delete a Freshservice Software User via REST API.

    https://api.freshservice.com/#bulk_delete_users

.PARAMETER user_id
    Unique id of the Software User.

.PARAMETER software_id
    Unique id of the Software.

.EXAMPLE
    Remove-FreshServiceSoftwareUser -software_id 21000240239 -user_id 21000418006

    software_id user_ids      status
    ----------- --------      ------
    21000240239 {21000418006} success 204

    Delete a Freshservice Software User. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceSoftwareUser {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Software.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$software_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Software User.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('id')]
        [long[]]$user_id
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/applications' -f $PrivateData['FreshserviceBaseUri'])

        if ($software_id) {
            $uri.Path = "{0}/{1}/users" -f $uri.Path, $software_id
        }

        try {
                if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                if ($user_id.Count -gt 1) {
                    $qry.Add('user_ids', ($user_id -join ',') )
                }
                else {
                    $qry.Add('user_ids', $user_id )
                }

                $uri.Query = [uri]::EscapeUriString([System.Web.HttpUtility]::UrlDecode($qry.ToString()));

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'DELETE'
                    ErrorAction = 'Stop'
                }

                $results = Invoke-FreshworksRestMethod @params

                [PSCustomObject]@{
                    software_id = $software_id
                    user_id     = $user_id
                    status      = "success {0}" -f $results.StatusCode
                }

            }
        }
        catch {
            Throw $_
        }
    }
    end {}
}
