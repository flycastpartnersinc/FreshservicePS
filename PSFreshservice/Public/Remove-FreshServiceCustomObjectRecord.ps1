<#
.SYNOPSIS
    Delete a Freshservice Custom Object Record.

.DESCRIPTION
    Delete a Freshservice Custom Object Record via REST API.

    https://api.freshservice.com/#delete_custom_object_record

.PARAMETER custom_object_id
    Unique ID of the Custom Object.

.PARAMETER id
    Unique id of the Freshservice Custom Object Record.

.EXAMPLE
    Remove-FreshServiceCustomObjectRecord -custom_object_id 21000011818 -id 6

    id status
    -- ------
    6 success 202

    Delete a Freshservice Custom Object Record (i.e. 6) from a Custom Object (i.e. 21000011818). Default API
    has no response, artificial response with id and status containing status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceCustomObjectRecord {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique ID of the Custom Object.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$custom_object_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique ID of the Custom Object Record',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('record_id')]
        [long]$id
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/objects' -f $PrivateData['FreshserviceBaseUri'])

        if ($PSBoundParameters.ContainsKey('custom_object_id')) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $custom_object_id
            [void]$PSBoundParameters.Remove('custom_object_id')
        }

        if ($PSBoundParameters.ContainsKey('id')) {
            $uri.Path = "{0}/records/{1}" -f $uri.Path, $id
            [void]$PSBoundParameters.Remove('Id')
        }

        try {
            if ($PSCmdlet.ShouldProcess($id)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'DELETE'
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
