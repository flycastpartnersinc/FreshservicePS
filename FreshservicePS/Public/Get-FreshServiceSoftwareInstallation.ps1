<#
.SYNOPSIS
    Returns a Freshservice Software installation.

.DESCRIPTION
    Returns a Freshservice Software installation via REST API.

    https://api.freshservice.com/#list_installations

.PARAMETER software_id
    Unique id of the Software to get installations.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceSoftwareinstallation -software_id 21000240240

    id                      : 21002218412
    created_at              : 8/29/2022 2:17:55 PM
    updated_at              : 8/29/2022 2:17:55 PM
    installation_path       :
    version                 :
    installation_machine_id : 1
    user_id                 : 21000418006
    department_id           :
    installation_date       :

    Returns all Freshservice Sofware installations.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceSoftwareInstallation {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the software to get installation information from.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [Alias('id')]
        [long]$software_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 2
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/applications' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

    }
    process {

        if ($software_id) {
            $uri.Path = "{0}/{1}/installations" -f $uri.Path, $software_id
        }

        try {

            if ($enablePagination) {
                $qry['page'] = $page
                $qry['per_page'] = $per_page
            }

            $uri.Query = $qry.ToString()

            $uri = $uri.Uri.AbsoluteUri

            do {

                $params = @{
                    Uri         = $uri
                    Method      = 'GET'
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                if ($result.Content) {
                    $content = $result.Content |
                                    ConvertFrom-Json

                    #API returns singluar or plural property based on the number of records, parse to get property returned.
                    $objProperty = $content[0].PSObject.Properties.Name
                    Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                    $content."$($objProperty)"
                }

                if ($result.Headers.Link) {
                    $uri = [regex]::Matches($result.Headers.Link,'<(?<Uri>.*)>')[0].Groups['Uri'].Value
                }

            }
            until (!$result.Headers.Link)

        }
        catch {
            Throw $_
        }

    }
    end {}
}
