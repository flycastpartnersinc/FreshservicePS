<#
.SYNOPSIS
    Returns a Freshservice information.

.DESCRIPTION
    Returns a Freshservice information via REST API.

    This is a test\helper command to see what tenant is currently connected and show the consumption of API throttle limits. Ideally,
    there would be an endpoint to GET basic tenant information like owners, licensing details, etc. that could be used.  There is
    and alias 'whofs' to validate connection quickly and cmdlets support -WhatIf and will show impacted url.

.EXAMPLE
    Get-FreshServiceInfo

    Returns a Freshservice connection information.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceInfo {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/business_hours' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        try {

            $uri.Query = $qry.ToString()
            $uri = $uri.Uri.AbsoluteUri

            $params = @{
                Uri         = $uri
                Method      = 'GET'
                ErrorAction = 'Stop'
            }

            $result = Invoke-FreshworksRestMethod @params

        }
        catch {
            Throw $_
        }

    }
    end {

        [PSCustomObject]@{
            Connection = $PrivateData.FreshserviceConnection
            BaseUri    = $PrivateData.FreshserviceBaseUri
            Tenant     = $PrivateData.FreshserviceTenant
            'Api-Version'          = $result.Headers['X-Freshservice-Api-Version'][0]
            'Ratelimiting-Managed' = $result.Headers['X-Fw-Ratelimiting-Managed'][0]
            'Ratelimit-Total'      = $result.Headers['X-Ratelimit-Total'][0]
            'Ratelimit-Remaining'  = $result.Headers['X-Ratelimit-Remaining'][0]
        }
    }
}
