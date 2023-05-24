<#
.SYNOPSIS
    Returns a Freshservice Agent Role.

.DESCRIPTION
    Returns a Freshservice Agent Role via REST API.

    https://api.freshservice.com/#view_a_role

.PARAMETER id
    Unique id of the agent role.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceAgentRole

    description : Has complete control over the help desk including access to Account or Billing related information, and
                receives Invoices.
    id          : 21000150292
    name        : Account Admin
    created_at  : 8/29/2022 2:16:59 PM
    updated_at  : 9/29/2022 10:19:47 AM
    default     : True
    scopes      : @{ticket=; problem=; change=; release=; asset=; solution=; contract=}

    description : Can configure all features through the Admin tab, but is restricted from viewing Account or Billing
                related information.
    id          : 21000150293
    name        : Admin
    created_at  : 8/29/2022 2:16:59 PM
    updated_at  : 9/29/2022 10:19:47 AM
    default     : True
    scopes      : @{ticket=; problem=; change=; release=; asset=; solution=; contract=}

    Returns all Freshservice Agent Roles.

.EXAMPLE
    Get-FreshServiceAgentRole -Id 21000150293

    description : Can configure all features through the Admin tab, but is restricted from viewing Account or Billing
                related information.
    id          : 21000150293
    name        : Admin
    created_at  : 8/29/2022 2:16:59 PM
    updated_at  : 9/29/2022 10:19:47 AM
    default     : True
    scopes      : @{ticket=; problem=; change=; release=; asset=; solution=; contract=}

    Returns a Freshservice Agent Role by Id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceAgentRole {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of Agent Role.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/roles' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }

      }
    process {

        try {

            if ($enablePagination) {
                $qry['page'] = $page
                $qry['per_page'] = $per_page
            }

            $uri.Query = $qry.ToString()

            $uri = $uri.Uri.AbsoluteUri

            $results = do {

                $params = @{
                    Uri         = $uri
                    Method      = 'GET'
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                $content = $result.Content |
                                ConvertFrom-Json

                if ($content) {
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
    end {

        $results

    }
}
