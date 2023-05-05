<#
.SYNOPSIS
    Returns a Freshservice information.

.DESCRIPTION
    Returns a Freshservice information via REST API.

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
        # $enablePagination = $true

    }
    process {

        try {

            # if ($enablePagination) {
            #     $qry['page'] = $page
            #     $qry['per_page'] = $per_page
            # }

            $uri.Query = $qry.ToString()

            $uri = $uri.Uri.AbsoluteUri

            # $results = do {

                $params = @{
                    Uri         = $uri
                    Method      = 'GET'
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                # $content = $result.Content |
                #                 ConvertFrom-Json

                # if ($content) {
                #     #API returns singluar or plural property based on the number of records, parse to get property returned.
                #     $objProperty = $content[0].PSObject.Properties.Name
                #     Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                #     $content."$($objProperty)"
                # }

                # if ($result.Headers.Link) {
                #     $uri = [regex]::Matches($result.Headers.Link,'<(?<Uri>.*)>')[0].Groups['Uri'].Value
                # }

            # }
            # until (!$result.Headers.Link)

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
