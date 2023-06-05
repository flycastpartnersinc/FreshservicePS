<#
.SYNOPSIS
    Returns a Freshservice Agent Group.

.DESCRIPTION
    Returns a Freshservice Agent Group via REST API.

    https://api.freshservice.com/#view_a_group

.PARAMETER id
    Unique id of the agent group.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceAgentGroup

    id                         : 21000188396
    name                       : Capacity Management Team
    description                : Capacity Management Team
    escalate_to                :
    unassigned_for             :
    business_hours_id          :
    created_at                 : 8/29/2022 2:17:01 PM
    updated_at                 : 8/29/2022 2:17:01 PM
    auto_ticket_assign         : False
    restricted                 : False
    approval_required          : False
    ocs_schedule_id            :
    agent_ids                  : {}
    members                    : {}
    observers                  : {}
    leaders                    : {}
    members_pending_approval   : {}
    leaders_pending_approval   : {}
    observers_pending_approval : {}

    id                         : 21000188392
    name                       : Change Team
    description                : Change Management Team
    escalate_to                :
    unassigned_for             :
    business_hours_id          :
    created_at                 : 8/29/2022 2:17:01 PM
    updated_at                 : 8/29/2022 2:17:01 PM
    auto_ticket_assign         : False
    restricted                 : False
    approval_required          : False
    ocs_schedule_id            :
    agent_ids                  : {}
    members                    : {}
    observers                  : {}
    leaders                    : {}
    members_pending_approval   : {}
    leaders_pending_approval   : {}
    observers_pending_approval : {}

    Returns all FreshService Agent Groups.
.EXAMPLE
    Get-FreshServiceAgentGroup -id 21000188392

    id                         : 21000188392
    name                       : Change Team
    description                : Change Management Team
    escalate_to                :
    unassigned_for             :
    business_hours_id          :
    created_at                 : 8/29/2022 2:17:01 PM
    updated_at                 : 8/29/2022 2:17:01 PM
    auto_ticket_assign         : False
    restricted                 : False
    approval_required          : False
    ocs_schedule_id            :
    agent_ids                  : {}
    members                    : {}
    observers                  : {}
    leaders                    : {}
    members_pending_approval   : {}
    leaders_pending_approval   : {}
    observers_pending_approval : {}

    Returns a Freshservice Agent Group by Id.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceAgentGroup {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of Agent Group.',
            ParameterSetName = 'Id',
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
        $uri = [System.UriBuilder]('{0}/groups' -f $PrivateData['FreshserviceBaseUri'])
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
