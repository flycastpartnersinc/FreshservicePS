<#
.SYNOPSIS
    Delete a Freshservice Software Installation.

.DESCRIPTION
    Delete a Freshservice Software Installation via REST API.

    https://api.freshservice.com/#bulk_delete_installations

.PARAMETER software_id
    Unique id of the software installation.

.PARAMETER installation_machine_id
    Unique id of the machine using the Software.

.EXAMPLE
    Remove-FreshServiceSoftwareInstallation -software_id 21000240239 -installation_machine_id 1

    software_id installation_machine_id status
    ----------- ----------------------- ------
    21000240239                       1 success 204

    Delete a Freshservice Software Installation. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceSoftwareInstallation {
         [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the software installation.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 0
        )]
        [Alias('softwareid','id')]
        [long]$software_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the machine using the Software.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('machine_id','device_id')]
        [long]$installation_machine_id
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
            $uri.Path = "{0}/{1}/installations" -f $uri.Path, $software_id
        }

        try {
            if ($PSCmdlet.ShouldProcess($id)) {

                if ($installation_id.Count -gt 1) {
                    $qry.Add('device_ids', ($installation_machine_id -join ',') )
                }
                else {
                    $qry.Add('device_ids', $installation_machine_id )
                }

                $uri.Query = [uri]::EscapeUriString([System.Web.HttpUtility]::UrlDecode($qry.ToString()));

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'DELETE'
                    ErrorAction = 'Stop'
                }

                $results = Invoke-FreshworksRestMethod @params

                [PSCustomObject]@{
                    software_id             = $software_id
                    installation_machine_id = $installation_machine_id
                    status                  = "success {0}" -f $results.StatusCode
                }
            }
        }
        catch {
            Throw $_
        }
    }
    end {}
}
