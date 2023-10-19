<#
.SYNOPSIS
    Returns a Freshservice Agent.

.DESCRIPTION
    Returns a Freshservice Agent via REST API.

    https://api.freshservice.com/#view_an_agent

.PARAMETER id
    Unique id of the agent.

.PARAMETER Filter
    Use Agent attributes to filter results. See https://api.freshservice.com/#filter_agents.

.PARAMETER State
    State of the agent. Fulltime or Occasional.

.PARAMETER Fields
    Allows you to view all the built-in and custom fields for agents in your Freshservice account.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshserviceAgent

    active                                          : False
    address                                         :
    auto_assign_status_changed_at                   :
    auto_assign_tickets                             : True
    background_information                          :
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 8/29/2022 2:17:02 PM
    custom_fields                                   :
    department_ids                                  : {}
    department_names                                :
    email                                           : rachel@freshservice.com
    external_id                                     :
    first_name                                      : Rachel
    has_logged_in                                   : False
    id                                              : 21000418008
    job_title                                       :
    language                                        : en
    last_active_at                                  :
    last_login_at                                   :
    last_name                                       :
    location_id                                     :
    location_name                                   :
    mobile_phone_number                             :
    occasional                                      : False
    reporting_manager_id                            :
    role_ids                                        : {21000150295}
    roles                                           : {@{role_id=21000150295; assignment_scope=entire_helpdesk;
                                                    groups=System.Object[]}}
    scopes                                          : @{ticket=; problem=; change=; asset=; solution=; contract=}
    scoreboard_level_id                             :
    scoreboard_points                               :
    signature                                       :
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 8/29/2022 2:17:02 PM
    vip_user                                        : False
    work_phone_number                               :
    group_ids                                       : {}
    member_of                                       : {}
    observer_of                                     : {}
    member_of_pending_approval                      : {}
    observer_of_pending_approval                    : {}

    active                                          : True
    address                                         :
    auto_assign_status_changed_at                   : 10/31/2022 3:20:53 PM
    auto_assign_tickets                             : True
    background_information                          :
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 8/29/2022 2:17:01 PM
    custom_fields                                   :
    department_ids                                  : {}
    department_names                                :
    email                                           : alex@example.com
    external_id                                     :
    first_name                                      : Alex
    has_logged_in                                   : True
    id                                              : 21000418005
    job_title                                       :
    language                                        : en
    last_active_at                                  : 11/2/2022 1:40:09 AM
    last_login_at                                   : 9/29/2022 12:49:59 PM
    last_name                                       : Smith
    location_id                                     :
    location_name                                   :
    mobile_phone_number                             :
    occasional                                      : False
    reporting_manager_id                            :
    role_ids                                        : {21000150292}
    roles                                           : {@{role_id=21000150292; assignment_scope=entire_helpdesk;
                                                    groups=System.Object[]}}
    scopes                                          : @{ticket=; problem=; change=; release=; asset=; solution=; contract=}
    scoreboard_level_id                             :
    scoreboard_points                               :
    signature                                       :
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 8/29/2022 2:17:01 PM
    vip_user                                        : False
    work_phone_number                               :
    group_ids                                       : {}
    member_of                                       : {}
    observer_of                                     : {}
    member_of_pending_approval                      : {}
    observer_of_pending_approval                    : {}

    Returns all Freshservice Agents.
.EXAMPLE
    Get-FreshserviceAgent -Id 21000418005

    active                                          : True
    address                                         :
    auto_assign_status_changed_at                   : 10/31/2022 3:20:53 PM
    auto_assign_tickets                             : True
    background_information                          :
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 8/29/2022 2:17:01 PM
    custom_fields                                   :
    department_ids                                  : {}
    department_names                                :
    email                                           : alex@example.com
    external_id                                     :
    first_name                                      : Alex
    has_logged_in                                   : True
    id                                              : 21000418005
    job_title                                       :
    language                                        : en
    last_active_at                                  : 11/2/2022 1:40:09 AM
    last_login_at                                   : 9/29/2022 12:49:59 PM
    last_name                                       : Smith
    location_id                                     :
    location_name                                   :
    mobile_phone_number                             :
    occasional                                      : False
    reporting_manager_id                            :
    role_ids                                        : {21000150292}
    roles                                           : {@{role_id=21000150292; assignment_scope=entire_helpdesk;
                                                    groups=System.Object[]}}
    scopes                                          : @{ticket=; problem=; change=; release=; asset=; solution=; contract=}
    scoreboard_level_id                             :
    scoreboard_points                               :
    signature                                       :
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 8/29/2022 2:17:01 PM
    vip_user                                        : False
    work_phone_number                               :
    group_ids                                       : {}
    member_of                                       : {}
    observer_of                                     : {}
    member_of_pending_approval                      : {}
    observer_of_pending_approval                    : {}

    Returns a Freshservice Agent by Id.

.EXAMPLE
    Get-FreshserviceAgent -Filter "email:'alex@example.com'"

    active                                          : True
    address                                         :
    auto_assign_status_changed_at                   : 10/31/2022 3:20:53 PM
    auto_assign_tickets                             : True
    background_information                          :
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 8/29/2022 2:17:01 PM
    custom_fields                                   :
    department_ids                                  : {}
    department_names                                :
    email                                           : alex@example.com
    external_id                                     :
    first_name                                      : Alex
    has_logged_in                                   : True
    id                                              : 21000418005
    job_title                                       :
    language                                        : en
    last_active_at                                  : 11/2/2022 1:40:09 AM
    last_login_at                                   : 9/29/2022 12:49:59 PM
    last_name                                       : Smith
    location_id                                     :
    location_name                                   :
    mobile_phone_number                             :
    occasional                                      : False
    reporting_manager_id                            :
    role_ids                                        : {21000150292}
    roles                                           : {@{role_id=21000150292; assignment_scope=entire_helpdesk;
                                                    groups=System.Object[]}}
    scopes                                          : @{ticket=; problem=; change=; release=; asset=; solution=; contract=}
    scoreboard_level_id                             :
    scoreboard_points                               :
    signature                                       :
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 8/29/2022 2:17:01 PM
    vip_user                                        : False
    work_phone_number                               :
    group_ids                                       : {}
    member_of                                       : {}
    observer_of                                     : {}
    member_of_pending_approval                      : {}
    observer_of_pending_approval                    : {}

    Returns a Freshservice Agent based on Filter for Email Address.  For filter options see:

    https://api.freshservice.com/#filter_agents
.EXAMPLE
    Get-FreshserviceAgent -State Fulltime

    active                                          : False
    address                                         :
    auto_assign_status_changed_at                   :
    auto_assign_tickets                             : True
    background_information                          :
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 8/29/2022 2:17:02 PM
    custom_fields                                   :
    department_ids                                  : {}
    department_names                                :
    email                                           : rachel@freshservice.com
    external_id                                     :
    first_name                                      : Rachel
    has_logged_in                                   : False
    id                                              : 21000418008
    job_title                                       :
    language                                        : en
    last_active_at                                  :
    last_login_at                                   :
    last_name                                       :
    location_id                                     :
    location_name                                   :
    mobile_phone_number                             :
    occasional                                      : False
    reporting_manager_id                            :
    role_ids                                        : {21000150295}
    roles                                           : {@{role_id=21000150295; assignment_scope=entire_helpdesk;
                                                    groups=System.Object[]}}
    scopes                                          : @{ticket=; problem=; change=; asset=; solution=; contract=}
    scoreboard_level_id                             :
    scoreboard_points                               :
    signature                                       :
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 8/29/2022 2:17:02 PM
    vip_user                                        : False
    work_phone_number                               :
    group_ids                                       : {}
    member_of                                       : {}
    observer_of                                     : {}
    member_of_pending_approval                      : {}
    observer_of_pending_approval                    : {}

    active                                          : True
    address                                         :
    auto_assign_status_changed_at                   : 10/31/2022 3:20:53 PM
    auto_assign_tickets                             : True
    background_information                          :
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 8/29/2022 2:17:01 PM
    custom_fields                                   :
    department_ids                                  : {}
    department_names                                :
    email                                           : alex@example.com
    external_id                                     :
    first_name                                      : Alex
    has_logged_in                                   : True
    id                                              : 21000418005
    job_title                                       :
    language                                        : en
    last_active_at                                  : 11/2/2022 1:40:09 AM
    last_login_at                                   : 9/29/2022 12:49:59 PM
    last_name                                       : Smith
    location_id                                     :
    location_name                                   :
    mobile_phone_number                             :
    occasional                                      : False
    reporting_manager_id                            :
    role_ids                                        : {21000150292}
    roles                                           : {@{role_id=21000150292; assignment_scope=entire_helpdesk;
                                                    groups=System.Object[]}}
    scopes                                          : @{ticket=; problem=; change=; release=; asset=; solution=; contract=}
    scoreboard_level_id                             :
    scoreboard_points                               :
    signature                                       :
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 8/29/2022 2:17:01 PM
    vip_user                                        : False
    work_phone_number                               :
    group_ids                                       : {}
    member_of                                       : {}
    observer_of                                     : {}
    member_of_pending_approval                      : {}
    observer_of_pending_approval                    : {}

    Returns all Freshservice agents by State (e.g. FullTime).

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceAgent {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the ticket',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Use Agent attributes to filter results.',
            ParameterSetName = 'Filter',
            Position = 0
        )]
        [string]$Filter,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'State of the agent. Fulltime or Occasional.',
            ParameterSetName = 'State',
            Position = 0
        )]
        [ValidateSet('Fulltime','Occasional')]
        [string]$State,
        [Parameter(
            Mandatory = $false,
            HelpMessage = ' Allows you to view all the built-in and custom fields for agents in your Freshservice account.',
            ParameterSetName = 'Form',
            Position = 0
        )]
        [Alias('Form')]
        [switch]$fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'Filter',
            Position = 1
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'State',
            Position = 1
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 2
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'Filter',
            Position = 2
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'State',
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
        if ($Fields) {
            $uri = [System.UriBuilder]('{0}/agent_fields' -f $PrivateData['FreshserviceBaseUri'])
        }
        else {
            $uri = [System.UriBuilder]('{0}/agents' -f $PrivateData['FreshserviceBaseUri'])
        }
        $enablePagination = $true

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }
        elseif ($Filter) {
            $qry.Add('query', '"{0}"' -f $filter )
        }
        elseif ($State) {
            $qry.Add('state', $state.ToLower() )
        }

    }
    process {

        try {

            if ($enablePagination) {
                $qry['page'] = $page
                $qry['per_page'] = $per_page
            }

            $uri.Query = $qry.ToString()

            $uriFinal = $uri.Uri.AbsoluteUri

            $results = do {

                $params = @{
                    Uri         = $uriFinal
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

                #Default loop condition - link exists indicates another page for pagination
                $loopCondition = !$result.Headers.Link

                if ($PSBoundParameters.ContainsKey('filter')) {
                    #Pagination is manual for results returned from filter
                    Write-Verbose ('Using filter pagination for page {0}' -f $page)
                    #Manually increment page
                    $page++
                    #Update query
                    $qry['page'] = $page
                    $uri.Query = $qry.ToString()
                    $uriFinal = $uri.Uri.AbsoluteUri
                    #Update loop condition based on return results
                    $loopCondition = $content."$($objProperty)".Count -eq 0
                }
                elseif ($result.Headers.Link) {
                    $uriFinal = [regex]::Matches($result.Headers.Link,'<(?<Uri>.*)>')[0].Groups['Uri'].Value
                    Write-Verbose ('Automatic pagination enabled with next link {0}' -f $uri)
                }
            }
            until ($loopCondition)

        }
        catch {
            Throw $_
        }

    }
    end {

        $results

    }
}
