<#
.SYNOPSIS
    Returns a Freshservice Requester.

.DESCRIPTION
    Returns a Freshservice Requester via REST API.

    https://api.freshservice.com/#view_a_requester

.PARAMETER Id
    Unique id of the Requester.

.PARAMETER filter
    Apply filter to requester query.

.PARAMETER include_agents
    Include agents with requester query.

.PARAMETER fields
    View all the built-in and custom fields for requesters.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshserviceRequester

    active                                          : True
    address                                         :
    background_information                          :
    can_see_all_changes_from_associated_departments : False
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 8/29/2022 2:17:01 PM
    custom_fields                                   :
    department_ids                                  : {}
    department_names                                :
    external_id                                     :
    first_name                                      : Andrea
    has_logged_in                                   : False
    id                                              : 21000418006
    is_agent                                        : False
    job_title                                       : Manager
    language                                        : en
    last_name                                       :
    location_id                                     :
    location_name                                   :
    mobile_phone_number                             :
    primary_email                                   : andrea@freshservice.com
    reporting_manager_id                            :
    secondary_emails                                : {}
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 8/29/2022 2:17:01 PM
    vip_user                                        : False
    work_phone_number                               :

    active                                          : True
    address                                         :
    background_information                          :
    can_see_all_changes_from_associated_departments : False
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 8/29/2022 2:17:02 PM
    custom_fields                                   :
    department_ids                                  : {}
    department_names                                :
    external_id                                     :
    first_name                                      : Jack
    has_logged_in                                   : False
    id                                              : 21000418009
    is_agent                                        : False
    job_title                                       : CIO
    language                                        : en
    last_name                                       :
    location_id                                     :
    location_name                                   :
    mobile_phone_number                             :
    primary_email                                   : jack@freshservice.com
    reporting_manager_id                            :
    secondary_emails                                : {}
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 8/29/2022 2:17:02 PM
    vip_user                                        : False
    work_phone_number                               :

    Returns all Freshservice Requesters.

.EXAMPLE
    Get-FreshServiceRequester -Id 21000418009

    active                                          : True
    address                                         :
    background_information                          :
    can_see_all_changes_from_associated_departments : False
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 8/29/2022 2:17:02 PM
    custom_fields                                   :
    department_ids                                  : {}
    department_names                                :
    external_id                                     :
    first_name                                      : Jack
    has_logged_in                                   : False
    id                                              : 21000418009
    is_agent                                        : False
    job_title                                       : CIO
    language                                        : en
    last_name                                       :
    location_id                                     :
    location_name                                   :
    mobile_phone_number                             :
    primary_email                                   : jack@freshservice.com
    reporting_manager_id                            :
    secondary_emails                                : {}
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 8/29/2022 2:17:02 PM
    vip_user                                        : False
    work_phone_number                               :

    Returns a Freshservice Requester by Id.

.EXAMPLE
    Get-FreshServiceRequester -filter "job_title:'Manager' AND language:'en'" -include_agents

    active                                          : True
    address                                         :
    background_information                          :
    can_see_all_changes_from_associated_departments : False
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 8/29/2022 2:17:01 PM
    custom_fields                                   :
    department_ids                                  : {}
    department_names                                :
    external_id                                     :
    first_name                                      : Andrea
    has_logged_in                                   : False
    id                                              : 21000418006
    is_agent                                        : False
    job_title                                       : Manager
    language                                        : en
    last_name                                       :
    location_id                                     :
    location_name                                   :
    mobile_phone_number                             :
    primary_email                                   : andrea@freshservice.com
    reporting_manager_id                            :
    secondary_emails                                : {}
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 8/29/2022 2:17:01 PM
    vip_user                                        : False
    work_phone_number                               :

    Returns a Freshservice Requesters, including agents, that have a job title of 'Manager' and
    Language is 'en' (English).

.EXAMPLE
    Get-FreshserviceRequester -fields

    id                       : 21000184911
    created_at               : 8/29/2022 2:17:01 PM
    updated_at               : 8/29/2022 2:17:01 PM
    editable_in_signup       : True
    name                     : first_name
    label                    : First Name
    position                 : 1
    required_for_agents      : True
    type                     : default_first_name
    default                  : True
    requesters_can_edit      : True
    label_for_requesters     : First Name
    required_for_requesters  : True
    displayed_for_requesters : True

    id                       : 21000184912
    created_at               : 8/29/2022 2:17:01 PM
    updated_at               : 8/29/2022 2:17:01 PM
    editable_in_signup       : True
    name                     : last_name
    label                    : Last Name
    position                 : 2
    required_for_agents      : False
    type                     : default_last_name
    default                  : True
    requesters_can_edit      : True
    label_for_requesters     : Last Name
    required_for_requesters  : False
    displayed_for_requesters : True

    id                       : 21000184913
    created_at               : 8/29/2022 2:17:01 PM
    updated_at               : 8/29/2022 2:17:01 PM
    editable_in_signup       : False
    name                     : job_title
    label                    : Title
    position                 : 3
    required_for_agents      : False
    type                     : default_job_title
    default                  : True
    requesters_can_edit      : True
    label_for_requesters     : Title
    required_for_requesters  : False
    displayed_for_requesters : True

    id                       : 21000184915
    created_at               : 8/29/2022 2:17:01 PM
    updated_at               : 2/9/2023 8:19:15 PM
    editable_in_signup       : False
    name                     : phone
    label                    : Work Phone
    position                 : 4
    required_for_agents      : False
    type                     : default_phone
    default                  : True
    requesters_can_edit      : True
    label_for_requesters     : Work Phone
    required_for_requesters  : False
    displayed_for_requesters : True

    id                       : 21000184916
    created_at               : 8/29/2022 2:17:01 PM
    updated_at               : 2/9/2023 8:19:15 PM
    editable_in_signup       : False
    name                     : mobile
    label                    : Mobile Phone
    position                 : 5
    required_for_agents      : False
    type                     : default_mobile
    default                  : True
    requesters_can_edit      : True
    label_for_requesters     : Mobile Phone
    required_for_requesters  : False
    displayed_for_requesters : True

    ...

    Returns all the built-in and custom fields for Freshservice Requester.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceRequester {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Product.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Apply filter to requester query.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [string]$filter,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Include agents with requester query.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [switch]$include_agents,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'View all the built-in and custom fields for requesters.',
            ParameterSetName = 'fields',
            Position = 1
        )]
        [Alias('Form')]
        [switch]$fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 2
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 3
        )]
        [int]$page = 1
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)

        if ($fields) {
            $uri = [System.UriBuilder]('{0}/requester_fields' -f $PrivateData['FreshserviceBaseUri'])
            $enablePagination = $false
        }
        else {
            $uri = [System.UriBuilder]('{0}/requesters' -f $PrivateData['FreshserviceBaseUri'])
            $enablePagination = $true
        }

        if ($id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }
        elseif ($filter) {
            $qry.Add('query', '"{0}"' -f $filter )
        }

        if ($PSBoundParameters.ContainsKey('include_agents')) {
            $qry.Add('include_agents', 'true' )
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
