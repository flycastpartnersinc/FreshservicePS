<#
.SYNOPSIS
    Returns a Freshservice Background Job Status.

.DESCRIPTION
    Returns a Freshservice Background Job Status created by New-FreshServiceRelationship via REST API.

    https://api.freshservice.com/#create_relationships

.PARAMETER Id
    Unique id of the Job.

.EXAMPLE
    Get-FreshServiceBackgroundJob -id bce1461a-617d-938a-bb73-87d46525e2fc

    relationships                    status
    -------------                    ------
    {@{success=True; relationship=}} success

    Return a background job status by guid created by New-FreshServiceRelationship.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceBackgroundJob {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Job.',
            Position = 0
        )]
        [guid]$Id
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/jobs' -f $PrivateData['FreshserviceBaseUri'])
    }
    process {

        try {

            if ($id) {
                $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            }

            $params = @{
                Uri         = $uri.Uri.AbsoluteUri
                Method      = 'GET'
                ErrorAction = 'Stop'
            }

            $result = Invoke-FreshworksRestMethod @params

            $content = $result.Content |
                            ConvertFrom-Json

        }
        catch {
            Throw $_
        }
    }
    end {
        $content
    }
}
