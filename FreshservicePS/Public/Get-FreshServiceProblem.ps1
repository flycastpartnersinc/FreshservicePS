<#
.SYNOPSIS
    Returns a Freshservice Problem.

.DESCRIPTION
    Returns a Freshservice Problem via REST API.

    https://api.freshservice.com/#view_a_problem

.PARAMETER Id
    Unique id of the Problem.

.PARAMETER Fields
    View all the built-in and custom fields for Problem.

.PARAMETER per_page
    Number of records to return per page during pagination.  Maximum of 100 records.

.PARAMETER page
    The page number to retrieve during pagination.

.EXAMPLE
    Get-FreshServiceProblem

    id               : 2
    agent_id         :
    description      : <div>A new problem</div>
    description_text : A new problem
    assets           : {}
    requester_id     : 21000418005
    subject          : A new problem
    group_id         :
    priority         : 1
    impact           : 1
    status           : 1
    due_by           : 1/14/2023 6:55:51 PM
    known_error      : False
    department_id    :
    category         :
    sub_category     :
    item_category    :
    created_at       : 1/9/2023 6:55:57 PM
    updated_at       : 1/9/2023 6:55:57 PM

    id               : 1
    agent_id         :
    description      : <div>Hi guys, <br/><br/>We have been facing issues when we try to reach Email Server 3. Looks
                    like there is something wrong here.<br/><br/>Regards<br/> Rachel<br/> </div>
    description_text :
    assets           : {}
    requester_id     : 21000418008
    subject          : Unable to reach email server
    group_id         :
    priority         : 1
    impact           : 1
    status           : 1
    due_by           : 9/12/2022 2:17:34 PM
    known_error      : False
    department_id    :
    category         :
    sub_category     :
    item_category    :
    created_at       : 8/29/2022 2:17:34 PM
    updated_at       : 8/29/2022 2:17:34 PM

    Get all Freshservice Problems.

.EXAMPLE
    Get-FreshServiceProblem -id 2

    id                : 2
    agent_id          :
    description       : <div>A new problem</div>
    description_text  : A new problem
    assets            : {}
    requester_id      : 21000418005
    subject           : A new problem
    group_id          :
    priority          : 1
    impact            : 1
    status            : 1
    due_by            : 1/14/2023 6:55:51 PM
    known_error       : False
    department_id     :
    category          :
    sub_category      :
    item_category     :
    created_at        : 1/9/2023 6:55:57 PM
    updated_at        : 1/9/2023 6:55:57 PM
    associated_change :
    custom_fields     :
    analysis_fields   :

    Get a specific Freshservice Problem.

.EXAMPLE
    Get-FreshServiceProblem -Fields

    id                   : 21000472464
    created_at           : 8/29/2022 2:17:34 PM
    updated_at           : 8/29/2022 2:17:34 PM
    name                 : requester
    label                : Requester
    description          : Problem requester
    field_type           : default_requester
    required             : True
    required_for_closure : False
    position             : 1
    default_field        : True
    choices              : {}
    nested_fields        : {}

    id                   : 21000472465
    created_at           : 8/29/2022 2:17:34 PM
    updated_at           : 8/29/2022 2:17:34 PM
    name                 : subject
    label                : Title
    description          : Problem title
    field_type           : default_subject
    required             : True
    required_for_closure : False
    position             : 2
    default_field        : True
    choices              : {}
    nested_fields        : {}

    id                   : 21000472466
    created_at           : 8/29/2022 2:17:34 PM
    updated_at           : 8/29/2022 2:17:34 PM
    name                 : description
    label                : Description
    description          : Problem description
    field_type           : default_description
    required             : True
    required_for_closure : False
    position             : 3
    default_field        : True
    choices              : {}
    nested_fields        : {}

    id                   : 21000472467
    created_at           : 8/29/2022 2:17:34 PM
    updated_at           : 8/29/2022 2:17:34 PM
    name                 : status
    label                : Status
    description          : Problem status
    field_type           : default_status
    required             : True
    required_for_closure : False
    position             : 4
    default_field        : True
    choices              : {@{id=1; value=Open}, @{id=2; value=Change Requested}, @{id=3; value=Closed}}
    nested_fields        : {}

    Return all the built-in and custom fields for Problem.
.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Get-FreshServiceProblem {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the the Problem on the Ticket',
            ParameterSetName = 'id',
            Position = 0
        )]
        [string]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allows you to view all the built-in and custom fields for Problem in your Freshservice account.',
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

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)

        if ($fields){
            $uri = [System.UriBuilder]('{0}/problem_form_fields' -f $PrivateData['FreshserviceBaseUri'])
        }
        else {
            $uri = [System.UriBuilder]('{0}/problems' -f $PrivateData['FreshserviceBaseUri'])
        }

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
