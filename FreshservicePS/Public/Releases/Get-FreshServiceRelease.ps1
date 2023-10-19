<#
.SYNOPSIS
    Returns a Freshservice release.

.DESCRIPTION
    Returns a Freshservice release via REST API.

    By default only releases that have been created within the past 30 days will be returned. For older releases, use the updated_since filter.

    https://api.freshservice.com/#view_a_release

.PARAMETER Id
    Unique Id of the Release.

.PARAMETER predefined_filter
    Predefined filters. The filters available are new_and_my_open, watching, spam, deleted.

.PARAMETER Fields
    View all the built-in and custom fields for Releases in your Freshservice account.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceRelease

    id                    : 2
    agent_id              :
    description           : <div>Not given.</div>
    description_text      : Not given.
    assets                : {}
    group_id              :
    department_id         :
    subject               : Software Z-1000 v1.0
    category              :
    sub_category          :
    item_category         :
    planned_start_date    : 1/13/2023 12:00:00 AM
    planned_end_date      : 1/13/2023 3:43:24 PM
    status                : 1
    priority              : 1
    release_type          : 2
    work_start_date       : 1/13/2023 12:00:00 AM
    work_end_date         : 1/13/2023 3:43:24 PM
    created_at            : 1/12/2023 3:43:45 PM
    updated_at            : 1/12/2023 3:43:45 PM
    associated_change_ids : {}

    id                    : 1
    agent_id              :
    description           :
    description_text      :
    assets                : {}
    group_id              :
    department_id         :
    subject               : Replacing Exchange Server 3 (ES3)
    category              :
    sub_category          :
    item_category         :
    planned_start_date    : 9/12/2022 2:17:34 PM
    planned_end_date      : 9/12/2022 2:17:34 PM
    status                : 1
    priority              : 1
    release_type          : 1
    work_start_date       : 9/12/2022 2:17:34 PM
    work_end_date         : 9/12/2022 2:17:34 PM
    created_at            : 8/29/2022 2:17:34 PM
    updated_at            : 8/29/2022 2:17:34 PM
    associated_change_ids : {1}

    Return all Freshservice Releases.

.EXAMPLE
    Get-FreshServiceRelease -id 1

    id                    : 1
    agent_id              :
    description           :
    description_text      :
    assets                : {}
    group_id              :
    department_id         :
    subject               : Replacing Exchange Server 3 (ES3)
    category              :
    sub_category          :
    item_category         :
    planned_start_date    : 9/12/2022 2:17:34 PM
    planned_end_date      : 9/12/2022 2:17:34 PM
    status                : 1
    priority              : 1
    release_type          : 1
    work_start_date       : 9/12/2022 2:17:34 PM
    work_end_date         : 9/12/2022 2:17:34 PM
    created_at            : 8/29/2022 2:17:34 PM
    updated_at            : 8/29/2022 2:17:34 PM
    associated_change_ids : {1}
    custom_fields         :
    planning_fields       :

    Return specific Freshservice Release by Id.

.EXAMPLE
    Get-FreshServiceRelease -predefined_filter unassigned

    id                    : 4
    agent_id              : 21000418005
    description           : <div>Release from Pester: cdc12ab5-5beb-48cf-a931-e3bdfc16391f</div>
    description_text      : Release from Pester: cdc12ab5-5beb-48cf-a931-e3bdfc16391f
    assets                : {}
    group_id              : 21000188395
    department_id         :
    subject               : Release from Pester: cdc12ab5-5beb-48cf-a931-e3bdfc16391f
    category              : Hardware
    sub_category          : Peripherals
    item_category         : Router
    planned_start_date    : 3/1/2023 1:00:00 AM
    planned_end_date      : 3/1/2023 3:00:00 AM
    status                : 1
    priority              : 1
    release_type          : 2
    work_start_date       : 3/1/2023 1:00:00 AM
    work_end_date         : 3/1/2023 3:00:00 AM
    created_at            : 3/1/2023 3:03:45 AM
    updated_at            : 3/1/2023 3:03:45 AM
    associated_change_ids : {}

    id                    : 2
    agent_id              :
    description           : <div>Not given.</div>
    description_text      : Not given.
    assets                : {}
    group_id              :
    department_id         :
    subject               : Software Z-1000 v1.0
    category              :
    sub_category          :
    item_category         :
    planned_start_date    : 1/13/2023 12:00:00 AM
    planned_end_date      : 1/13/2023 3:43:24 PM
    status                : 1
    priority              : 1
    release_type          : 2
    work_start_date       : 1/13/2023 12:00:00 AM
    work_end_date         : 1/13/2023 3:43:24 PM
    created_at            : 1/12/2023 3:43:45 PM
    updated_at            : 1/12/2023 3:43:45 PM
    associated_change_ids : {}

    id                    : 1
    agent_id              :
    description           :
    description_text      :
    assets                : {}
    group_id              :
    department_id         :
    subject               : Replacing Exchange Server 3 (ES3)
    category              :
    sub_category          :
    item_category         :
    planned_start_date    : 9/12/2022 2:17:34 PM
    planned_end_date      : 9/12/2022 2:17:34 PM
    status                : 1
    priority              : 1
    release_type          : 1
    work_start_date       : 9/12/2022 2:17:34 PM
    work_end_date         : 9/12/2022 2:17:34 PM
    created_at            : 8/29/2022 2:17:34 PM
    updated_at            : 8/29/2022 2:17:34 PM
    associated_change_ids : {1}

    Return Freshservice Releases with a predefined filter "unassigned".  Filters available for new_and_my_open, watching, spam, deleted.

    .EXAMPLE
    Get-FreshServiceRelease -Fields

    id                   : 21000472453
    created_at           : 8/29/2022 2:17:33 PM
    updated_at           : 8/29/2022 2:17:33 PM
    name                 : subject
    label                : Subject
    description          : Release subject
    field_type           : default_subject
    required             : True
    required_for_closure : False
    position             : 1
    default_field        : True
    choices              : {}
    nested_fields        : {}

    id                   : 21000472454
    created_at           : 8/29/2022 2:17:33 PM
    updated_at           : 8/29/2022 2:17:33 PM
    name                 : description
    label                : Description
    description          : Release description
    field_type           : default_description
    required             : True
    required_for_closure : False
    position             : 2
    default_field        : True
    choices              : {}
    nested_fields        : {}

    id                   : 21000472455
    created_at           : 8/29/2022 2:17:33 PM
    updated_at           : 8/29/2022 2:17:33 PM
    name                 : planned_start_date
    label                : Planned Start Date
    description          : Planned Start Date
    field_type           : default_planned_start_date
    required             : True
    required_for_closure : False
    position             : 3
    default_field        : True
    choices              : {}
    nested_fields        : {}

    id                   : 21000472456
    created_at           : 8/29/2022 2:17:33 PM
    updated_at           : 8/29/2022 2:17:33 PM
    name                 : planned_end_date
    label                : Planned End Date
    description          : Planned End Date
    field_type           : default_planned_end_date
    required             : True
    required_for_closure : False
    position             : 4
    default_field        : True
    choices              : {}
    nested_fields        : {}

    Returns all the built-in and custom fields for Releases.

.NOTES
    This module was developed and tested with Freshservice REST API v2.

#>
function Get-FreshServiceRelease {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the release',
            ParameterSetName = 'id',
            Position = 0
        )]
        [long]$Id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Predefined filters for Release',
            ParameterSetName = 'predefined_filter',
            Position = 0
        )]
        [ValidateSet('all', 'my_open', 'unassigned', 'completed', 'incompleted', 'deleted')]
        [string]$predefined_filter,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allows you to view all the built-in and custom fields for Releases in your Freshservice account.',
            ParameterSetName = 'Form',
            Position = 0
        )]
        [Alias('Form')]
        [switch]$fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of records per page returned during pagination.  Default is 30. Max is 100.',
            ParameterSetName = 'default',
            Position = 0
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Predefined filters for Release',
            ParameterSetName = 'predefined_filter',
            Position = 1
        )]
        [int]$per_page = 100,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Page number to begin record return.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Predefined filters for Release',
            ParameterSetName = 'predefined_filter',
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
        if ($fields) {
            $uri = [System.UriBuilder]('{0}/release_form_fields' -f $PrivateData['FreshserviceBaseUri'])
            $enablePagination = $false
        }
        else {
            $uri = [System.UriBuilder]('{0}/releases' -f $PrivateData['FreshserviceBaseUri'])
            $enablePagination = $true
        }

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }

        if ($predefined_filter) {
            $qry.Add('type', '{0}' -f $predefined_filter.ToLower() )
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
                    #When using Filter, the API also returns a Total property, so we are filtering here to only return release or releases property
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
