<#
.SYNOPSIS
    Returns a Freshservice SLA Policy.

.DESCRIPTION
    Returns a Freshservice SLA Policy via REST API.

    https://api.freshservice.com/#list_all_sla

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceSLAPolicy

    id            : 21000057781
    name          : Default SLA Policy
    position      : 1
    is_default    : True
    active        : True
    deleted       : False
    description   : default policy
    sla_targets   : {@{priority=4; escalation_enabled=True; respond_within=3600; resolve_within=14400;
                    business_hours=True}, @{priority=3; escalation_enabled=True; respond_within=14400;
                    resolve_within=43200; business_hours=True}, @{priority=2; escalation_enabled=True;
                    respond_within=28800; resolve_within=86400; business_hours=True}, @{priority=1;
                    escalation_enabled=True; respond_within=86400; resolve_within=259200; business_hours=True}}
    applicable_to :
    escalation    :
    created_at    : 8/29/2022 2:17:01 PM
    updated_at    : 8/29/2022 2:17:01 PM

    Returns all Freshservice SLA Policies.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceSLAPolicy {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
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
        $uri = [System.UriBuilder]('{0}/sla_policies' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

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
    end {

        $results

    }
}
