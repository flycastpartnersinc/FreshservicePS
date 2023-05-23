<#
.SYNOPSIS
    Delete a Freshservice Relationship.

.DESCRIPTION
    Delete a Freshservice Relationship via REST API.

    https://api.freshservice.com/#delete_relationships

.PARAMETER id
    Unique id of the Freshservice Relationship.

.EXAMPLE
    Remove-FreshServiceRelationship -id 21000035235

    id            status
    --            ------
    {21000035235} success 204

    Delete a Freshservice Relationship. Default API has no response, artificial response with id and
    status containing status code is returned for tracking.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceRelationship {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Relationship.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long[]]$id
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/relationships' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $qry.Add('ids', ($id -join ','))
        }

        $uri.Query = $qry.ToString()

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
