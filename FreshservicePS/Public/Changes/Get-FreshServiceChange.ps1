<#
.SYNOPSIS
    Returns a Freshservice Change.

.DESCRIPTION
    Returns a Freshservice Change via REST API.

    By default only changes that have been created within the past 30 days will be returned.
    For older changes, use the updated_since filter.

    https://api.freshservice.com/#view_a_change

.PARAMETER Id
    Unique Id of the Change.

.PARAMETER workspace_id
    Workspace id filter is applicable only for accounts with Workspaces feature enabled. Providing a Workspace_id will return tickets from a specific workspace.

    If the workspace_id(s) parameter is NOT provided, data will only be returned for the Default\Primary Workspace.
    If the workspace_id(s) parameter is provided, data will be returned from the specified Workspaces.
    If the workspace_id value is 0, data will be returned from all workspaces (the user has access to), with only global level fields.

.PARAMETER updated_since
    Filter to return changes updated since a provided date and time.

.PARAMETER include
    By default, stats field will not be included in the response. They can be retrieved via the embedding functionality.

    Each include will consume an additional 2 credits. For example if you embed the stats information you will be charged a total of 3 API credits (1 credit for the API call, and 2 credits for the additional stats embedding).

.PARAMETER predefined_filter
    Predefined filters. The filters available are new_and_my_open, watching, spam, deleted.

.PARAMETER fields
    Allows you to view all the built-in and custom fields for Change in your Freshservice account.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceChange

    agent_id           :
    group_id           :
    priority           : 1
    impact             : 1
    status             : 1
    risk               : 1
    change_type        : 1
    planned_start_date : 3/25/2023 7:37:58 AM
    planned_end_date   : 3/25/2023 9:37:58 AM
    subject            : Fix Zero-day Vulnerability
    department_id      : 21000351606
    category           :
    sub_category       :
    item_category      :
    description        : <div>We need to get critical patch on KB123456 installed ASAP.</div>
    description_text   : We need to get critical patch on KB123456 installed ASAP.
    id                 : 17
    requester_id       : 21000418005
    approval_status    : 4
    change_window_id   :
    created_at         : 3/25/2023 7:38:00 PM
    updated_at         : 3/25/2023 7:38:00 PM
    maintenance_window :
    blackout_window    :
    assets             : {}
    impacted_services  : {}

    agent_id           : 21000418005
    group_id           : 21000188395
    priority           : 1
    impact             : 1
    status             : 2
    risk               : 1
    change_type        : 1
    planned_start_date : 2/28/2023 5:42:29 AM
    planned_end_date   : 2/28/2023 7:42:29 AM
    subject            : Test change from Pester
    department_id      :
    category           : Hardware
    sub_category       : Computer
    item_category      :
    description        : <div>Test change from Pester: 82556a0b-60eb-49a9-8ce5-a4a7fb185d31</div>
    description_text   : Test change from Pester: 82556a0b-60eb-49a9-8ce5-a4a7fb185d31
    id                 : 10
    requester_id       : 21000418005
    approval_status    : 4
    change_window_id   :
    created_at         : 2/28/2023 5:42:30 PM
    updated_at         : 2/28/2023 5:51:25 PM
    maintenance_window :
    blackout_window    :
    assets             : {}
    impacted_services  : {}

    Return all Freshservice Changes.
.EXAMPLE
    Get-FreshServiceChange -id 10

    agent_id           : 21000418005
    group_id           : 21000188395
    priority           : 1
    impact             : 1
    status             : 2
    risk               : 1
    change_type        : 1
    planned_start_date : 2/28/2023 5:42:29 AM
    planned_end_date   : 2/28/2023 7:42:29 AM
    subject            : Test change from Pester
    department_id      :
    category           : Hardware
    sub_category       : Computer
    item_category      :
    description        : <div>Test change from Pester: 82556a0b-60eb-49a9-8ce5-a4a7fb185d31</div>
    description_text   : Test change from Pester: 82556a0b-60eb-49a9-8ce5-a4a7fb185d31
    id                 : 10
    requester_id       : 21000418005
    approval_status    : 4
    change_window_id   :
    created_at         : 2/28/2023 5:42:30 PM
    updated_at         : 2/28/2023 5:51:25 PM
    maintenance_window :
    blackout_window    :
    assets             : {}
    impacted_services  : {}
    custom_fields      :
    planning_fields    : @{custom_fields=}

    Return Freshservice Change by Id.
.EXAMPLE
    Get-FreshServiceChange -id 3 -include stats

    agent_id           :
    group_id           :
    priority           : 1
    impact             : 1
    status             : 1
    risk               : 1
    change_type        : 1
    planned_start_date : 1/11/2023 7:07:09 PM
    planned_end_date   : 1/12/2023 7:07:09 PM
    subject            : Fix Zero-day Vulnerability
    department_id      :
    category           :
    sub_category       :
    item_category      :
    description        : <div>We need to get critical patch on KB123456 installed ASAP.</div>
    description_text   : We need to get critical patch on KB123456 installed ASAP.
    id                 : 3
    requester_id       : 21000418005
    approval_status    : 4
    change_window_id   :
    created_at         : 1/11/2023 7:07:08 PM
    updated_at         : 1/11/2023 7:07:08 PM
    maintenance_window :
    blackout_window    :
    assets             : {}
    impacted_services  : {}
    custom_fields      :
    planning_fields    : @{custom_fields=}
    stats              : @{closed_at=; planning_at=; assigned_at=; approval_at=; pending_release_at=;
                        pending_review_at=; resolution_time_by_bhrs=}

    Return Freshservice Change by Id and include stats.

.EXAMPLE
    Get-FreshServiceChange -predefined_filter my_open

    agent_id           :
    group_id           :
    priority           : 1
    impact             : 1
    status             : 1
    risk               : 1
    change_type        : 1
    planned_start_date : 3/25/2023 7:37:58 AM
    planned_end_date   : 3/25/2023 9:37:58 AM
    subject            : Fix Zero-day Vulnerability
    department_id      : 21000351606
    category           :
    sub_category       :
    item_category      :
    description        : <div>We need to get critical patch on KB123456 installed ASAP.</div>
    description_text   : We need to get critical patch on KB123456 installed ASAP.
    id                 : 17
    requester_id       : 21000418005
    approval_status    : 4
    change_window_id   :
    created_at         : 3/25/2023 7:38:00 PM
    updated_at         : 3/25/2023 7:38:00 PM
    maintenance_window :
    blackout_window    :
    assets             : {}
    impacted_services  : {}

    agent_id           : 21000418005
    group_id           : 21000188395
    priority           : 1
    impact             : 1
    status             : 2
    risk               : 1
    change_type        : 1
    planned_start_date : 2/28/2023 5:42:29 AM
    planned_end_date   : 2/28/2023 7:42:29 AM
    subject            : Test change from Pester
    department_id      :
    category           : Hardware
    sub_category       : Computer
    item_category      :
    description        : <div>Test change from Pester: 82556a0b-60eb-49a9-8ce5-a4a7fb185d31</div>
    description_text   : Test change from Pester: 82556a0b-60eb-49a9-8ce5-a4a7fb185d31
    id                 : 10
    requester_id       : 21000418005
    approval_status    : 4
    change_window_id   :
    created_at         : 2/28/2023 5:42:30 PM
    updated_at         : 2/28/2023 5:51:25 PM
    maintenance_window :
    blackout_window    :
    assets             : {}
    impacted_services  : {}

    Return Freshservice Change by predefined filter my_open.

.EXAMPLE
    Get-FreshServiceChange -updated_since (Get-Date).AddDays(-10)

    agent_id           :
    group_id           :
    priority           : 1
    impact             : 1
    status             : 1
    risk               : 1
    change_type        : 1
    planned_start_date : 3/25/2023 7:37:58 AM
    planned_end_date   : 3/25/2023 9:37:58 AM
    subject            : Fix Zero-day Vulnerability
    department_id      : 21000351606
    category           :
    sub_category       :
    item_category      :
    description        : <div>We need to get critical patch on KB123456 installed ASAP.</div>
    description_text   : We need to get critical patch on KB123456 installed ASAP.
    id                 : 17
    requester_id       : 21000418005
    approval_status    : 4
    change_window_id   :
    created_at         : 3/25/2023 7:38:00 PM
    updated_at         : 3/25/2023 7:38:00 PM
    maintenance_window :
    blackout_window    :
    assets             : {}
    impacted_services  : {}

    Return Freshservice Changes updated since the last 10 days.

.EXAMPLE
    Get-FreshServiceChange -Fields

    id                   : 21000472434
    created_at           : 8/29/2022 2:17:30 PM
    updated_at           : 8/29/2022 2:17:30 PM
    name                 : requester
    label                : Requester
    description          : Change requester
    field_type           : default_requester
    required             : True
    required_for_closure : False
    position             : 1
    default_field        : True
    choices              : {}
    nested_fields        : {}

    id                   : 21000472435
    created_at           : 8/29/2022 2:17:30 PM
    updated_at           : 8/29/2022 2:17:30 PM
    name                 : subject
    label                : Subject
    description          : Change subject
    field_type           : default_subject
    required             : True
    required_for_closure : False
    position             : 2
    default_field        : True
    choices              : {}
    nested_fields        : {}

    id                   : 21000472436
    created_at           : 8/29/2022 2:17:30 PM
    updated_at           : 8/29/2022 2:17:30 PM
    name                 : change_type
    label                : Type
    description          : Change Type
    field_type           : default_change_type
    required             : True
    required_for_closure : False
    position             : 3
    default_field        : True
    choices              : {@{id=1; value=Minor}, @{id=2; value=Standard}, @{id=3; value=Major}, @{id=4;
                        value=Emergency}}
    nested_fields        : {}

    id                   : 21000472437
    created_at           : 8/29/2022 2:17:30 PM
    updated_at           : 8/29/2022 2:17:30 PM
    name                 : status
    label                : Status
    description          : Change status
    field_type           : default_status
    required             : True
    required_for_closure : False
    position             : 4
    default_field        : True
    choices              : {@{id=1; value=Open}, @{id=2; value=Planning}, @{id=3; value=Awaiting Approval},
                        @{id=4; value=Pending Release}...}
    nested_fields        : {}

    Retrieve all the Fields that constitute the Change Object.

.NOTES
    This module was developed and tested with Freshservice REST API v2.

#>
function Get-FreshServiceChange {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the change',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Workspace ID of the Change. The attribute is applicable only for accounts with the Workspaces feature enabled. The default value is the ID of the primary workspace of the account.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 0
        )]
        [int]$workspace_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Filter results for Change',
            ParameterSetName = 'default',
            Position = 1
        )]
        [Alias('UpdateSince')]
        [datetime]$updated_since,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Filter results for Change',
            ParameterSetName = 'default',
            Position = 2
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Filter results for Change',
            ParameterSetName = 'predefined_filter',
            Position = 0
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Filter results for Change',
            ParameterSetName = 'id',
            Position = 1
        )]
        [ValidateSet('stats')]
        [string[]]$include,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Predefined filters for Change',
            ParameterSetName = 'predefined_filter',
            Position = 1
        )]
        [ValidateSet('my_open', 'unassigned', 'closed', 'release_requested', 'requester_id')]
        [string]$predefined_filter,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allows you to view all the built-in and custom fields for Change in your Freshservice account.',
            ParameterSetName = 'Form',
            Position = 0
        )]
        [Alias('Form')]
        [switch]$fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 3
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Predefined filters for Change',
            ParameterSetName = 'predefined_filter',
            Position = 3
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 4
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Predefined filters for Change.',
            ParameterSetName = 'predefined_filter',
            Position = 4
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
            $uri = [System.UriBuilder]('{0}/change_form_fields' -f $PrivateData['FreshserviceBaseUri'])
        }
        else {
            $uri = [System.UriBuilder]('{0}/changes' -f $PrivateData['FreshserviceBaseUri'])
        }
        $enablePagination = $true

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }

        if ($PSBoundParameters.ContainsKey('workspace_id')) {
            $qry.Add('workspace_id', $workspace_id -join ',')
        }

        if ($predefined_filter) {
            $qry.Add('type', '{0}' -f $predefined_filter.ToLower() )
        }

        If ($updated_since) {
            $qry.Add("updated_since", (Get-Date -Date $updated_since -Format "o"))
        }

        if ($include) {
            Write-Verbose -Message ('Adding include as data type' -f $include.GetType().FullName)
            $qry.Add('include', $include.ToLower() -join ',')
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
                    #When using Filter, the API also returns a Total property, so we are filtering here to only return change or changes property
                    $objProperty = $content[0].PSObject.Properties |
                                        Where-Object -FilterScript {$_.Name -ne 'total'} |
                                            Select-Object -ExpandProperty Name

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
