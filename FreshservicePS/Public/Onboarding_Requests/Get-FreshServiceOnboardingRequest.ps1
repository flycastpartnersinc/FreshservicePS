<#
.SYNOPSIS
    Returns a Freshservice Onboarding Request.

.DESCRIPTION
    Returns a Freshservice Onboarding Request via REST API.

    https://api.freshservice.com/#create_onboarding_request

.PARAMETER id
    Unique id of the Onboarding Request.

.PARAMETER tickets
    Retrieve and view the Onboarding Tickets associated with an Onboarding Request.

.PARAMETER fields
    Allows you to view all the built-in and custom fields for the Onboarding Request in your Freshservice account.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshserviceOnboardingRequest

    id           : 1
    created_at   : 3/25/2023 3:55:19 PM
    updated_at   : 3/25/2023 3:55:19 PM
    status       : 3
    requester_id : 21000418005
    subject      : Employee Onboarding Request
    fields       : @{cf_employee_name=John Smith; cf_job_title=Analyst I; cf_date_of_joining=25-03-2023;
                cf_department=21000097763; cf_location=21000159890}

    id           : 2
    created_at   : 3/25/2023 5:21:53 PM
    updated_at   : 3/25/2023 5:21:54 PM
    status       : 3
    requester_id : 21000418005
    subject      : Employee Onboarding Request
    fields       : @{cf_employee_name=Frank Johnson; cf_job_title=Analyst I; cf_date_of_joining=25-03-2023;
                cf_department=21000097763; cf_location=21000159890}

    Returns all FreshService Onboarding Requests.

.EXAMPLE
    Get-FreshserviceOnboardingRequest -id 1

    id            : 1
    created_at    : 3/25/2023 3:55:19 PM
    updated_at    : 3/25/2023 3:55:19 PM
    status        : 3
    requester_id  : 21000418005
    subject       : Employee Onboarding Request
    ticket_id     : 192
    actors        : @{Employee=}
    fields        : @{cf_employee_name=John Smith; cf_job_title=Analyst I; cf_date_of_joining=25-03-2023;
                    cf_department=21000097763; cf_location=21000159890}
    lookup_values : @{cf_department=; cf_location=}

    Returns a specific FreshService Onboarding Request by id.

.EXAMPLE
    Get-FreshserviceOnboardingRequest -id 1 -tickets

    id              : 192
    created_at      : 3/25/2023 3:55:19 PM
    updated_at      : 3/25/2023 3:55:19 PM
    subject         : Employee Onboarding Request
    responder_email :
    status          : 2
    parent          : True

    id                    : 193
    created_at            : 3/25/2023 3:55:19 PM
    updated_at            : 3/25/2023 3:55:19 PM
    subject               : Create Email Address
    responder_email       :
    status                : 2
    parent                : False
    predecessor_ticket_id :
    successor_ticket_ids  : {}

    Returns tickets associated with a specific FreshService Onboarding Request by id.

.EXAMPLE
    Get-FreshServiceOnboardingRequest -fields

    placeholder : Enter employee name
    label       : Employee Name
    name        : cf_employee_name
    position    : 1
    required    : False
    default     : False
    field_type  : custom_text

    placeholder :
    label       : Job Title
    name        : cf_job_title
    position    : 2
    required    : False
    default     : False
    field_type  : custom_text

    placeholder : Enter joining date
    label       : Date of joining
    name        : cf_date_of_joining
    position    : 3
    required    : False
    default     : False
    field_type  : custom_date

    placeholder : Select department
    label       : Department
    name        : cf_department
    position    : 4
    required    : False
    default     : False
    field_type  : custom_lookup_bigint
    data_source : 6

    placeholder : Select Location
    label       : Location
    name        : cf_location
    position    : 5
    required    : False
    default     : False
    field_type  : custom_lookup_bigint
    data_source : 1

    Returns all the built-in and custom fields for the Onboarding Request.
.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceOnboardingRequest {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Onboarding Request.',
            ParameterSetName = 'id',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Onboarding Request.',
            ParameterSetName = 'Ticket',
            Position = 0
        )]
        [long]$id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Retrieve and view the Onboarding Tickets associated with an Onboarding Request.',
            ParameterSetName = 'Ticket',
            Position = 1
        )]
        [switch]$tickets,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allows you to view all the built-in and custom fields for the Onboarding Request in your Freshservice account.',
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
        $PrivateData = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/onboarding_requests' -f $PrivateData['FreshserviceBaseUri'])
        $enablePagination = $true

    }
    process {

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            $enablePagination = $false
        }

        If ($tickets) {
            $uri.Path = "{0}/tickets" -f $uri.Path
            $enablePagination = $true
        }

        if ($fields) {
            $uri.Path = "{0}/form" -f $uri.Path
            $enablePagination = $true
        }

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
                    $uri = [regex]::Matches($result.Headers.Link, '<(?<Uri>.*)>')[0].Groups['Uri'].Value
                    Write-Verbose ('Automatic pagination enabled with next link {0}' -f $uri)
                }

            }
            until (!$result.Headers.Link)

        } catch {
            Throw $_
        }
    }
    end {

        $results

    }
}