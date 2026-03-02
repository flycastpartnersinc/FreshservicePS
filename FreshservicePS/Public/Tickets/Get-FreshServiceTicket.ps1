<#
.SYNOPSIS
    Returns a Freshservice ticket.

.DESCRIPTION
    Returns a Freshservice ticket via REST API.

    https://api.freshservice.com/#view_a_ticket

.PARAMETER Id
    Unique Id of the Ticket.

.PARAMETER workspace_id
    Workspace id filter is applicable only for accounts with Workspaces feature enabled. Providing a Workspace_id will return tickets from a specific workspace.

    If the workspace_id(s) parameter is NOT provided, data will only be returned for the Default\Primary Workspace.
    If the workspace_id(s) parameter is provided, data will be returned from the specified Workspaces.
    If the workspace_id value is 0, data will be returned from all workspaces (the user has access to), with only global level fields.

.PARAMETER Filter
    Filter results for Ticket.  Documentation can be found here to get the latest capabilities and examples:

    https://api.freshservice.com/#filter_tickets

    The function will automatically encode the url query prior to the API call.

.PARAMETER updated_since
    Filter to return tickets updated since a provided date and time.

.PARAMETER include
    By default, certain fields such as conversations, tags and requester email will not be included in the response.
    They can be retrieved via the embedding functionality.

    Use 'include' to embed additional details in the response. Each include will consume an additional credit. For example,
    if you embed the requester and company information you will be charged a total of 3 API credits for the call.

    The include parameter is for getting ticket by ID and has the following options:

    tags
    conversations
    requester
    stats
    problem
    assets
    change
    related_tickets
    requested_for
    department
    feedback

.PARAMETER include_global
    By default, certain fields such as conversations, tags and requester email will not be included in the response.
    They can be retrieved via the embedding functionality.

    Use 'include' to embed additional details in the response. Each include will consume an additional credit. For example,
    if you embed the requester and company information you will be charged a total of 3 API credits for the call.

    The include parameter is for getting all tickets and has the following options:

    requester
    stats
    tags
    requested_for
    department

.PARAMETER predefined_filter
    Predefined filters. The filters available are new_and_my_open, watching, spam, deleted.

.PARAMETER requester_id
    Filter tickets based on provided requester id.

.PARAMETER email
    Filter tickets based on provided email.

.PARAMETER type
    Filter tickets based on the ticket type (i.e. Incident, Service Request or Alert)

.PARAMETER Activities
    Return ticket Activities for a specific ticket.

.PARAMETER csat_response
    Retrieve a csat response of a Ticket with the given ID from Freshservice.

.PARAMETER fields
    Allows you to view all the built-in and custom fields for Tickets in your Freshservice account.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshserviceTicket

    subject          : Where can I find more information about employee health benefits?
    group_id         :
    department_id    :
    category         :
    sub_category     :
    item_category    :
    requester_id     : 21000418007
    responder_id     :
    due_by           : 9/8/2022 2:17:57 PM
    fr_escalated     : True
    deleted          : False
    spam             : False
    email_config_id  :
    fwd_emails       : {}
    reply_cc_emails  : {}
    cc_emails        : {}
    is_escalated     : True
    fr_due_by        : 8/31/2022 8:17:57 PM
    id               : 4
    priority         : 1
    status           : 2
    source           : 2
    created_at       : 8/29/2022 2:17:57 PM
    updated_at       : 11/17/2022 8:08:21 PM
    requested_for_id : 21000418007
    to_emails        :
    type             : Incident
    description      : Testing API set
    description_text : Testing API set
    custom_fields    : @{weather_server=}

    subject          : Request for Andrea : Dell Monitor
    group_id         :
    department_id    :
    category         :
    sub_category     :
    item_category    :
    requester_id     : 21000418006
    responder_id     :
    due_by           : 8/31/2022 8:17:53 PM
    fr_escalated     : True
    deleted          : False
    spam             : False
    email_config_id  :
    fwd_emails       : {}
    reply_cc_emails  : {}
    cc_emails        : {}
    is_escalated     : True
    fr_due_by        : 8/30/2022 1:17:53 PM
    id               : 3
    priority         : 2
    status           : 2
    source           : 2
    created_at       : 8/29/2022 2:17:53 PM
    updated_at       : 8/29/2022 2:17:53 PM
    requested_for_id : 21000418006
    to_emails        :
    type             : Service Request
    description      :
    description_text :
    custom_fields    : @{weather_server=}

    subject          : Request for Andrea : Logitech Wireless Mouse
    group_id         :
    department_id    :
    category         :
    sub_category     :
    item_category    :
    requester_id     : 21000418006
    responder_id     :
    due_by           : 8/31/2022 8:17:53 PM
    fr_escalated     : True
    deleted          : False
    spam             : False
    email_config_id  :
    fwd_emails       : {}
    reply_cc_emails  : {}
    cc_emails        : {}
    is_escalated     : True
    fr_due_by        : 8/30/2022 1:17:53 PM
    id               : 2
    priority         : 2
    status           : 2
    source           : 2
    created_at       : 8/29/2022 2:17:53 PM
    updated_at       : 8/29/2022 2:17:53 PM
    requested_for_id : 21000418006
    to_emails        :
    type             : Service Request
    description      :
    description_text :
    custom_fields    : @{weather_server=}

    subject          : What's wrong with my email?
    group_id         :
    department_id    :
    category         :
    sub_category     :
    item_category    :
    requester_id     : 21000418006
    responder_id     :
    due_by           : 9/8/2022 2:17:01 PM
    fr_escalated     : True
    deleted          : False
    spam             : False
    email_config_id  :
    fwd_emails       : {}
    reply_cc_emails  : {}
    cc_emails        : {}
    is_escalated     : True
    fr_due_by        : 8/31/2022 8:17:01 PM
    id               : 1
    priority         : 1
    status           : 2
    source           : 2
    created_at       : 8/29/2022 2:17:01 PM
    updated_at       : 8/29/2022 2:17:01 PM
    requested_for_id : 21000418006
    to_emails        :
    type             : Incident
    description      : <div>Hi Team,<br/> <br/>I have been unable to send any emails since this morning. What's going
                    on?<br/><br/>Regards,<br/> Andrea </div>
    description_text : Hi Team, I have been unable to send any emails since this morning. What's going on? Regards,
                    Andrea
    custom_fields    : @{weather_server=}

    Return all Freshservice Tickets.

.EXAMPLE
    Get-FreshserviceTicket -id 2

    cc_emails                     :
    fwd_emails                    :
    reply_cc_emails               :
    bcc_emails                    :
    fr_escalated                  : True
    spam                          : False
    email_config_id               :
    group_id                      :
    priority                      : 2
    requester_id                  : 21000418006
    requested_for_id              : 21000418006
    responder_id                  :
    source                        : 2
    status                        : 2
    subject                       : Request for Andrea : Logitech Wireless Mouse
    to_emails                     :
    sla_policy_id                 : 21000057781
    applied_business_hours        : 21000011791
    department_id                 :
    id                            : 2
    type                          : Service Request
    due_by                        : 8/31/2022 8:17:53 PM
    fr_due_by                     : 8/30/2022 1:17:53 PM
    is_escalated                  : True
    description                   :
    description_text              :
    custom_fields                 : @{weather_server=}
    created_at                    : 8/29/2022 2:17:53 PM
    updated_at                    : 8/29/2022 2:17:53 PM
    urgency                       : 1
    impact                        : 1
    category                      :
    sub_category                  :
    item_category                 :
    deleted                       : False
    attachments                   : {}
    created_within_business_hours : True
    approval_status               : 4
    approval_status_name          : Not Requested

    Return Freshservice Ticket by Id.

.EXAMPLE
    Get-FreshServiceTicket -predefined_filter new_and_my_open

    Return Freshservice Tickets with pre-defined filters (new_and_my_open, watching, spam, deleted)

.EXAMPLE
    Get-FreshServiceTicket -Filter "agent_id:< 1 AND (status:2 OR status:3 OR status:5) AND group_id:21000188396 AND created_at:>'2022-01-01'"

    Return Freshservice Ticket with advanced Filter.

.EXAMPLE
    Get-FreshServiceTicket -updated_since (Get-Date).AddDays(-4)

    subject          : Attachment Test
    group_id         :
    department_id    : 21000351606
    category         :
    sub_category     :
    item_category    :
    requester_id     : 21000418005
    responder_id     :
    due_by           : 4/5/2023 9:00:00 PM
    fr_escalated     : False
    deleted          : False
    spam             : False
    email_config_id  :
    fwd_emails       : {}
    reply_cc_emails  : {}
    cc_emails        : {}
    is_escalated     : False
    fr_due_by        : 3/29/2023 6:00:00 PM
    id               : 210
    priority         : 1
    status           : 2
    source           : 2
    created_at       : 3/25/2023 7:24:41 PM
    updated_at       : 3/25/2023 7:24:41 PM
    requested_for_id : 21000418005
    to_emails        :
    type             : Incident
    description      : <div>=</div>
    description_text : =
    custom_fields    : @{weather_server=}

    subject          : Employee Onboarding Request
    group_id         : 21000188390
    department_id    : 21000351606
    category         :
    sub_category     :
    item_category    :
    requester_id     : 21000418005
    responder_id     :
    due_by           : 4/5/2023 9:00:00 PM
    fr_escalated     : False
    deleted          : False
    spam             : False
    email_config_id  :
    fwd_emails       : {}
    reply_cc_emails  : {}
    cc_emails        : {}
    is_escalated     : False
    fr_due_by        : 3/29/2023 6:00:00 PM
    id               : 208
    priority         : 1
    status           : 2
    source           : 13
    created_at       : 3/25/2023 5:32:16 PM
    updated_at       : 3/25/2023 5:32:16 PM
    requested_for_id : 21000418005
    to_emails        :
    type             : Service Request
    description      :
    description_text :
    custom_fields    : @{weather_server=}

    subject          : Create Email Address
    group_id         : 21000188390
    department_id    : 21000351606
    category         :
    sub_category     :
    item_category    :
    requester_id     : 21000418005
    responder_id     :
    due_by           : 4/5/2023 9:00:00 PM
    fr_escalated     : False
    deleted          : False
    spam             : False
    email_config_id  :
    fwd_emails       : {}
    reply_cc_emails  : {}
    cc_emails        : {}
    is_escalated     : False
    fr_due_by        : 3/29/2023 6:00:00 PM
    id               : 209
    priority         : 1
    status           : 2
    source           : 13
    created_at       : 3/25/2023 5:32:16 PM
    updated_at       : 3/25/2023 5:32:16 PM
    requested_for_id : 21000418005
    to_emails        :
    type             : Service Request
    description      :
    description_text :
    custom_fields    : @{weather_server=}

    Return Freshservice Tickets updated in the last 4 days.

.EXAMPLE
    Get-FreshServiceTicket -type 'Service Request'

    subject          : Request for Alex : Windows Laptop
    group_id         :
    department_id    :
    category         :
    sub_category     :
    item_category    :
    requester_id     : 21000418005
    responder_id     :
    due_by           : 3/1/2023 3:11:18 PM
    fr_escalated     : True
    deleted          : False
    spam             : False
    email_config_id  :
    fwd_emails       : {}
    reply_cc_emails  : {}
    cc_emails        : {}
    is_escalated     : True
    fr_due_by        : 2/27/2023 5:11:18 PM
    id               : 171
    priority         : 2
    status           : 2
    source           : 2
    created_at       : 2/24/2023 6:11:18 PM
    updated_at       : 2/24/2023 6:11:18 PM
    requested_for_id : 21000418005
    to_emails        :
    type             : Service Request
    description      :
    description_text :
    custom_fields    : @{weather_server=}

    subject          : Request for Alex : Windows Laptop
    group_id         :
    department_id    :
    category         :
    sub_category     :
    item_category    :
    requester_id     : 21000418005
    responder_id     :
    due_by           : 3/1/2023 3:09:30 PM
    fr_escalated     : True
    deleted          : False
    spam             : False
    email_config_id  :
    fwd_emails       : {}
    reply_cc_emails  : {}
    cc_emails        : {}
    is_escalated     : True
    fr_due_by        : 2/27/2023 5:09:30 PM
    id               : 168
    priority         : 2
    status           : 2
    source           : 2
    created_at       : 2/24/2023 6:09:30 PM
    updated_at       : 2/24/2023 6:09:30 PM
    requested_for_id : 21000418005
    to_emails        :
    type             : Service Request
    description      :
    description_text :
    custom_fields    : @{weather_server=}

    subject          : Request for Alex : Windows Laptop
    group_id         :
    department_id    :
    category         :
    sub_category     :
    item_category    :
    requester_id     : 21000418005
    responder_id     :
    due_by           : 3/1/2023 3:05:22 PM
    fr_escalated     : True
    deleted          : False
    spam             : False
    email_config_id  :
    fwd_emails       : {}
    reply_cc_emails  : {}
    cc_emails        : {}
    is_escalated     : True
    fr_due_by        : 2/27/2023 5:05:22 PM
    id               : 164
    priority         : 2
    status           : 2
    source           : 2
    created_at       : 2/24/2023 6:05:22 PM
    updated_at       : 2/24/2023 6:05:22 PM
    requested_for_id : 21000418005
    to_emails        :
    type             : Service Request
    description      :
    description_text :
    custom_fields    : @{weather_server=}

    Returns all Freshservice Service Requests.

.EXAMPLE
    Get-FreshServiceTicket -id 2 -activities

    actor                          content
    -----                          -------
    @{id=21000418007; name=System} added item Logitech Wireless Mouse
    @{id=21000418006; name=Andrea} created ticket for Andrea,  set Status as Open, set Urgency as Low, set Priority as M...

    Returns a Freshservice Ticket activities.

.EXAMPLE
    Get-FSTicket -id 100 -include related_tickets, stats

    cc_emails                     : {}
    fwd_emails                    : {}
    reply_cc_emails               : {}
    bcc_emails                    :
    fr_escalated                  : True
    spam                          : False
    email_config_id               :
    group_id                      :
    priority                      : 2
    requester_id                  : 21000418005
    requested_for_id              : 21000418005
    responder_id                  :
    source                        : 9
    status                        : 2
    subject                       : Pester test ticket 28a2496e-fb2e-48e0-b210-49ee9b1e67be
    to_emails                     :
    sla_policy_id                 : 21000057781
    applied_business_hours        : 21000011791
    department_id                 :
    id                            : 100
    type                          : Incident
    due_by                        : 2/28/2023 7:00:00 PM
    fr_due_by                     : 2/24/2023 9:00:00 PM
    is_escalated                  : True
    description                   : <div>Test ticket from Powershell Module with GUID
                                    28a2496e-fb2e-48e0-b210-49ee9b1e67be</div>
    description_text              : Test ticket from Powershell Module with GUID
                                    28a2496e-fb2e-48e0-b210-49ee9b1e67be
    custom_fields                 : @{weather_server=}
    created_at                    : 2/24/2023 3:30:30 AM
    updated_at                    : 3/28/2023 10:26:20 PM
    urgency                       : 2
    impact                        : 2
    category                      : Software
    sub_category                  :
    item_category                 :
    deleted                       : False
    attachments                   : {}
    created_within_business_hours : False
    stats                         : @{ticket_id=21003880128; opened_at=; pending_since=; resolved_at=;
                                    closed_at=; first_assigned_at=; assigned_at=; first_responded_at=;
                                    agent_responded_at=; created_at=2/24/2023 3:30:30 AM;
                                    updated_at=3/28/2023 10:26:20 PM; group_escalated=False; inbound_count=1;
                                    status_updated_at=2/24/2023 3:30:30 AM; outbound_count=0;
                                    first_resp_time_in_secs=; resolution_time_in_secs=745200}
    related_tickets               : @{child_ids=System.Object[]}

    Get a Freshservice Ticket and include related tickets and stats.

.EXAMPLE
    Get-FreshServiceTicket -fields

    id                     : 21000152095
    label                  : Requester
    description            : Ticket requester
    field_type             : default_requester
    created_at             : 8/29/2022 10:17:01 AM
    updated_at             : 8/29/2022 10:17:01 AM
    position               : 1
    required_for_closure   : False
    name                   : requester
    default_field          : True
    required_for_agents    : True
    customers_can_edit     : True
    label_for_customers    : Requester
    required_for_customers : True
    displayed_to_customers : True
    belongs_to_section     : False
    portal_cc              : False
    portalcc_to            : company
    choices                : {}
    nested_fields          : {}
    sections               : {}

    id                     : 21000152096
    label                  : Subject
    description            : Ticket subject
    field_type             : default_subject
    created_at             : 8/29/2022 10:17:01 AM
    updated_at             : 8/29/2022 10:17:01 AM
    position               : 2
    required_for_closure   : False
    name                   : subject
    default_field          : True
    required_for_agents    : True
    customers_can_edit     : True
    label_for_customers    : Subject
    required_for_customers : True
    displayed_to_customers : True
    belongs_to_section     : False
    choices                : {}
    nested_fields          : {}
    sections               : {}

    id                     : 21000152097
    label                  : Type
    description            : Ticket type
    field_type             : default_ticket_type
    created_at             : 8/29/2022 10:17:01 AM
    updated_at             : 8/29/2022 10:17:01 AM
    position               : 3
    required_for_closure   : False
    name                   : ticket_type
    default_field          : True
    required_for_agents    : False
    customers_can_edit     : False
    label_for_customers    : Type
    required_for_customers : False
    displayed_to_customers : False
    belongs_to_section     : False
    choices                : {@{id=21000039527; value=Incident}, @{id=21000039528; value=Service Request}}
    nested_fields          : {}
    sections               : {}

    Returns all the built-in and custom fields for Tickets.

.EXAMPLE
    Get-FSTicket -workspace_id 0

    For Workspace enabled instances, returns tickets from all workspaces where an agent has permissions.

.EXAMPLE
    Get-FSTicket -workspace_id 2,4

    For Workspace enabled instances, returns tickets from specific workspaces 2 and 4.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceTicket {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, HelpMessage = 'Unique id of the ticket', ParameterSetName = 'id', Position = 0)][long]$id,
        [Parameter(Mandatory = $false, HelpMessage = 'Workspace id is applicable only for accounts with Workspaces feature enabled. The value 0 for workspace_id will return tickets from all workspaces, with only global level fields.', ParameterSetName = 'default', Position = 0)][int[]]$workspace_id,
        [Parameter(Mandatory = $false, HelpMessage = 'Filter results for Ticket.', ParameterSetName = 'filter', Position = 0)][string]$filter,
        [Parameter(Mandatory = $false, HelpMessage = 'By default only tickets that have been created within the past 30 days will be returned. For older tickets, use the updated_since filter.', ParameterSetName = 'default', Position = 1)][Alias('UpdateSince')][datetime]$updated_since,
        [Parameter(Mandatory = $false, HelpMessage = 'Use include to embed additional details in the response. Each include will consume an additional credit. For example if you embed the requester and company information you will be charged a total of 3 API credits for the call.', ParameterSetName = 'id', Position = 1)][ValidateSet('tags', 'conversations', 'requester', 'stats', 'problem', 'assets', 'change', 'related_tickets', 'requested_for', 'department', 'feedback', 'offboarding_context', 'onboarding_context')][string[]]$include,
        [Parameter(Mandatory = $false, HelpMessage = 'Use include to embed additional details in the response. Each include will consume an additional credit. For example if you embed the requester and company information you will be charged a total of 3 API credits for the call.', ParameterSetName = 'default', Position = 2)][ValidateSet('requester', 'stats', 'tags', 'requested_for', 'department')][string[]]$include_global,
        [Parameter(Mandatory = $false, HelpMessage = 'Predefined filters for Ticket', ParameterSetName = 'default', Position = 3)][ValidateSet('new_and_my_open', 'watching', 'spam', 'deleted')][string]$predefined_filter,
        [Parameter(Mandatory = $false, HelpMessage = 'Unique id of the requester', ParameterSetName = 'default', Position = 4)][Alias('RequesterId')][long]$requester_id,
        [Parameter(Mandatory = $false, HelpMessage = 'Email of the requester', ParameterSetName = 'default', Position = 5)][string]$email,
        [Parameter(Mandatory = $false, HelpMessage = 'Type of Ticket. Service Request or Incident', ParameterSetName = 'default', Position = 6)][ValidateSet('Service Request', 'Incident', 'Alert')][string[]]$type,
        [Parameter(Mandatory = $false, HelpMessage = 'Return Ticket Activities', ParameterSetName = 'id', Position = 2)][switch]$activities,
        [Parameter(Mandatory = $false, HelpMessage = 'Allows you to view all the built-in and custom fields for Tickets in your Freshservice account.', ParameterSetName = 'fields', Position = 0)][Alias('Form')][switch]$fields,
        [Parameter(Mandatory = $false, HelpMessage = 'Retrieve a csat response of a Ticket with the given ID from Freshservice.', ParameterSetName = 'id', Position = 1)][switch]$csat_response,
        [Parameter(Mandatory = $false, HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.', ParameterSetName = 'default', Position = 7)]
        [Parameter(Mandatory = $false, HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.', ParameterSetName = 'filter', Position = 1)][int]$per_page = 100,
        [Parameter(Mandatory = $false, HelpMessage = 'Page number to begin record return.', ParameterSetName = 'default', Position = 8)]
        [Parameter(Mandatory = $false, HelpMessage = 'Page number to begin record return.', ParameterSetName = 'filter', Position = 2)][int]$page = 1
    )
    begin {

        $PrivateData = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $ticketFieldsURI = $([System.UriBuilder]('{0}/ticket_form_fields' -f $PrivateData['FreshserviceBaseUri']))
        $ticketFieldsQuery = Invoke-FreshworksRestMethod -Method Get -Uri $ticketFieldsURI.Uri.AbsoluteUri -AuthorizationToken $PrivateData['FreshserviceApiToken']
        $ticketfields = $ticketFieldsQuery.Content | ConvertFrom-Json | Select-Object -ExpandProperty ticket_fields

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)

        if ($fields) {
            $uri = [System.UriBuilder]('{0}/ticket_form_fields' -f $PrivateData['FreshserviceBaseUri'])
        } else {
            $uri = [System.UriBuilder]('{0}/tickets' -f $PrivateData['FreshserviceBaseUri'])
        }

        $enablePagination = $true

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        } elseif ($filter) {
            $uri.Path = "{0}/filter" -f $uri.Path
            $qry.Add('query', '"{0}"' -f $filter )
            # $qry.Add('query', $filter )
        }

        if ($PSBoundParameters.ContainsKey('workspace_id')) {
            $qry.Add('workspace_id', $workspace_id -join ',')
        }

        if ($predefined_filter) {
            $qry.Add('filter', '{0}' -f $predefined_filter.ToLower() )
        }

        if ($requester_id) {
            $qry.Add('requester_id', '{0}' -f $requester_id )
        }

        if ($email) {
            $qry.Add('email', '{0}' -f $email.ToLower() )
        }

        if ($Type) {
            #Type is case-sensitive, overwrite value with proper case.
            switch ($type) {
                'Incident' { $PSBoundParameters['Type'] = 'Incident' }
                'Service Request' { $PSBoundParameters['Type'] = 'Service Request' }
                'Alert' { $PSBoundParameters['Type'] = 'Alert' }
            }

            $qry.Add('type', '{0}' -f $PSBoundParameters['Type'])
        }

        If ($updated_since) {
            $qry.Add("updated_since", (Get-Date -Date $updated_since -Format "o"))
        }

        #Only one option can be passed with id. Parameterset was breaking, so parse at runtime.
        if ($include) {
            $qry.Add('include', $include.ToLower() -join ',')
        } elseif ($activities) {
            $uri.Path = "{0}/activities" -f $uri.Path
        } elseif ($csat_response) {
            $uri.Path = "{0}/csat_response" -f $uri.Path
        }

        if ($include_global) {
            $qry.Add('include', $include_global.ToLower() -join ',')
        }
    } process {
        try {

            if ($enablePagination) {
                $qry['page'] = $page
                $qry['per_page'] = $per_page
            }

            $uri.Query = $qry.ToString()
            $uriFinal = $uri.Uri.AbsoluteUri
            $results = do {

                $params = @{
                    Uri                = $uriFinal
                    Method             = 'GET'
                    ErrorAction        = 'Stop'
                    AuthorizationToken = $PrivateData.FreshserviceApiToken
                }

                $result = Invoke-FreshworksRestMethod @params

                if ($result.Content) {
                    $content = $result.Content | ConvertFrom-Json

                    #API returns singluar or plural property based on the number of records, parse to get property returned.
                    #When using Filter, the API also returns a Total property, so we are filtering here to only return ticket or tickets property
                    $objPropertyName = $content[0].PSObject.Properties | Where-Object -FilterScript { $_.Name -ne 'total' } | Select-Object -ExpandProperty Name
                    Write-Verbose -Message ("Returning {0} property with count {1}" -f $objPropertyName, $content."$($objPropertyName)".Count)
                    [array]$records = $content | Select-Object -ExpandProperty $objPropertyName

                    if ($records) {
                        $returnedproperties = $records[0].psobject.properties
                        $lookupFields = $returnedproperties | Where-Object { $_.TypeNameOfValue -Like 'System.Int*' -and $_.Name -NE 'approval_status' -and $_.Name -NE 'id' }
                        if ("onboarding_context" -in $include) {
                            $OnboardingLookupFields = $content."$($objPropertyName)".onboarding_context.lookup_values
                        }
                        if ("offboarding_context" -in $include) {
                            $OffboardingLookupFields = $content."$($objPropertyName)".offboarding_context.lookup_values
                        }
                    }
                    foreach ($record in $records) {
                        if ($lookupFields) {
                            foreach ($Property in $lookupFields.name) {
                                if (-not [string]::IsNullOrEmpty($record.$Property)) {
                                    try {
                                        #get the value from ticketfields Choices
                                        $PossibleValues = $ticketfields | Where-Object Name -EQ $($property -replace '_id', '')
                                        $PropertyValue = $PossibleValues.choices | Where-Object id -EQ $record.$Property
                                        $record.$Property = $PropertyValue
                                    } catch {
                                        # If the lookup field fails keep the property as is (Do nothing)
                                        $null = 'Silencing a PSSA alert with this line'
                                    }
                                }
                            }
                        }
                        if ($OnboardingLookupFields) {
                            foreach ($Property in $OnboardingLookupFields.psobject.properties.name) {
                                if (-not [string]::IsNullOrEmpty($record.onboarding_context.fields.$Property)) {
                                    try {
                                        #get the value from OffboardingLookupFields Choices
                                        $PropertyValue = $OffboardingLookupFields.$Property
                                        $record.onboarding_context.fields.$Property = $PropertyValue
                                    } catch {
                                        # If the lookup field fails keep the property as is (Do nothing)
                                        $null = 'Silencing a PSSA alert with this line'
                                    }
                                }
                            }
                        }
                        if ($OffboardingLookupFields) {
                            foreach ($Property in $OffboardingLookupFields.psobject.properties.name) {
                                if (-not [string]::IsNullOrEmpty($record.offboarding_context.fields.$Property)) {
                                    try {
                                        #get the value from OffboardingLookupFields Choices
                                        $PropertyValue = $OffboardingLookupFields.$Property
                                        $record.offboarding_context.fields.$Property = $PropertyValue
                                    } catch {
                                        # If the lookup field fails keep the property as is (Do nothing)
                                        $null = 'Silencing a PSSA alert with this line'
                                    }
                                }
                            }
                        }
                        # Output record for collection into calling $results
                        $record
                    }
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
                } elseif ($result.Headers.Link) {
                    $uriFinal = [regex]::Matches($result.Headers.Link, '<(?<Uri>.*)>')[0].Groups['Uri'].Value
                    Write-Verbose ('Automatic pagination enabled with next link {0}' -f $uri)
                }
            }
            until ($loopCondition)

        } catch {
            Throw $_
        }
    } end {
        $results
    }
}