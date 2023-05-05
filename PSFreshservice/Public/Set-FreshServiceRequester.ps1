<#
.SYNOPSIS
    Updates a Freshservice Requester.

.DESCRIPTION
    Updates a Freshservice Requester via REST API.

    https://api.freshservice.com/#requesters

.PARAMETER id
    Unique Id of the requester.

.PARAMETER first_name
    First name of the requester.

.PARAMETER last_name
    Last name of the requester.

.PARAMETER job_title
    Job title of the requester.

.PARAMETER primary_email
    Primary email address of the requester.

.PARAMETER secondary_emails
    Additional/secondary emails associated with the requester.

.PARAMETER work_phone_number
    Work phone number of the requester.

.PARAMETER mobile_phone_number
    Mobile phone number of the requester.

.PARAMETER department_ids
    Unique IDs of the departments associated with the requester

.PARAMETER can_see_all_tickets_from_associated_departments
    Set to true if the requester must be allowed to view tickets filed by other members of the department,
    and false otherwise.

    can_see_all_tickets_from_associated_departments will automatically be set to false unless it is explicitly set to true in the payload,
    irrespective of the previous value of the field.

.PARAMETER reporting_manager_id
    User ID of the requester's reporting manager.

.PARAMETER address
    Address of the requester.

.PARAMETER time_zone
    Time zone of the requester. Read more here.

.PARAMETER time_format
    Time format for the requester.Possible values:12h (12 hour format)24h (24 hour format)

.PARAMETER language
    Language used by the requester. The default language is "en" (English). Read more here.

.PARAMETER location_id
    Unique ID of the location associated with the requester.

.PARAMETER background_information
    Background information of the requester.

.PARAMETER custom_fields
    Key-value pair containing the names and values of the (custom) requester fields.

.PARAMETER convert_to_agent
    Convert a requester to an occasional agent with SD Agent role and no group memberships.

    https://api.freshservice.com/#convert_to_agent

.PARAMETER reactivate
    This operation allows you to reactivate a particular deactivated requester.

    https://api.freshservice.com/#reactivate_a_requester

.PARAMETER merge
    Merge secondary requesters into a primary requester.

    https://api.freshservice.com/#merge_requesters

.PARAMETER secondary_requesters
    Secondary requester ids for Merge operation.

.EXAMPLE
    Set-FreshServiceRequester -id 21001799737 -job_title 'Analyst II'

    active                                          : True
    address                                         : 123 Anywhere Lane
    background_information                          : Technical Wizard Lvl 1000.
    can_see_all_changes_from_associated_departments : False
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 3/3/2023 2:27:49 PM
    custom_fields                                   : @{employee_id=}
    department_ids                                  : {}
    department_names                                :
    external_id                                     : 33359e1c-153f-4e67-a66f-cafdd5949a2e
    first_name                                      : Rob
    has_logged_in                                   : False
    id                                              : 21001799737
    is_agent                                        : False
    job_title                                       : Analyst II
    language                                        : en
    last_name                                       : Simmers
    location_id                                     :
    location_name                                   :
    mobile_phone_number                             : 800-555-9999
    primary_email                                   : rasimmers.test1@gmail.com
    reporting_manager_id                            :
    secondary_emails                                : {rasimmers.test2@gmail.com}
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 3/31/2023 1:15:40 AM
    vip_user                                        : False
    work_phone_number                               :

    Updates the title of a Freshservice Requester.

.EXAMPLE
    Set-FreshServiceRequester -id 21001799737 -reactivate

    active                                          : True
    address                                         : 123 Anywhere Lane
    background_information                          : Technical Wizard Lvl 1000.
    can_see_all_changes_from_associated_departments : False
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 3/3/2023 2:27:49 PM
    custom_fields                                   : @{employee_id=}
    department_ids                                  : {}
    department_names                                :
    external_id                                     : 33359e1c-153f-4e67-a66f-cafdd5949a2e
    first_name                                      : Rob
    has_logged_in                                   : False
    id                                              : 21001799737
    is_agent                                        : False
    job_title                                       : Analyst II
    language                                        : en
    last_name                                       : Simmers
    location_id                                     :
    location_name                                   :
    mobile_phone_number                             : 800-555-9999
    primary_email                                   : rasimmers.test1@gmail.com
    reporting_manager_id                            :
    secondary_emails                                : {rasimmers.test2@gmail.com}
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 3/31/2023 1:19:07 AM
    vip_user                                        : False
    work_phone_number                               :

    Reactivates a deactivated requester.

.EXAMPLE
    Set-FreshServiceRequester -id 21001799737 -merge -secondary_requesters 21001941828

    active                                          : True
    address                                         : 123 Anywhere Lane
    background_information                          : Technical Wizard Lvl 1000.
    can_see_all_changes_from_associated_departments : False
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 3/3/2023 2:27:49 PM
    custom_fields                                   : @{employee_id=}
    department_ids                                  : {}
    department_names                                :
    external_id                                     : 33359e1c-153f-4e67-a66f-cafdd5949a2e
    first_name                                      : Rob
    has_logged_in                                   : False
    id                                              : 21001799737
    is_agent                                        : False
    job_title                                       : Analyst II
    language                                        : en
    last_name                                       : Simmers
    location_id                                     :
    location_name                                   :
    mobile_phone_number                             : 800-555-9999
    primary_email                                   : rasimmers.test1@gmail.com
    reporting_manager_id                            :
    secondary_emails                                : {rasimmers.agent2@gmail.com, rasimmers.test2@gmail.com}
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 3/31/2023 1:22:44 AM
    vip_user                                        : False
    work_phone_number                               :

    Merge secondary requesters with a primary Freshservice Requester.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceRequester {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'default',
            HelpMessage = 'Unique Id of the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'reactivate',
            HelpMessage = 'Unique Id of the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'convert_to_agent',
            HelpMessage = 'Unique Id of the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'merge',
            HelpMessage = 'Unique Id of the Primary requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'First name of the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$first_name,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Last name of the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$last_name,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Job title of the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$job_title,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Primary email address of the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$primary_email,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Additional/secondary emails associated with the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string[]]$secondary_emails,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Work phone number of the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$work_phone_number,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Mobile phone number of the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$mobile_phone_number,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Unique IDs of the departments associated with the requester',
            ValueFromPipelineByPropertyName = $true
        )]
        [long[]]$department_ids,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Set to true if the requester must be allowed to view tickets filed by other members of the department, and false otherwise',
            ValueFromPipelineByPropertyName = $true
        )]
        [boolean]$can_see_all_tickets_from_associated_departments,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'User ID of the requesters reporting manager.',
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$reporting_manager_id,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Address of the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$address,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Time zone of the requester. Read more here.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$time_zone,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Time format for the requester.Possible values:12h (12 hour format)24h (24 hour format)',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$time_format,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Language used by the requester. The default language is "en" (English). Read more here.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$language,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Unique ID of the location associated with the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$location_id,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Background information of the requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$background_information,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'default',
            HelpMessage = 'Key-value pair containing the names and values of the (custom) requester fields.',
            ValueFromPipelineByPropertyName = $true
        )]
        [hashtable]$custom_fields,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'convert_to_agent',
            HelpMessage = 'Convert a requester to an occasional agent with SD Agent role and no group memberships.',
            ValueFromPipelineByPropertyName = $true
        )]
        [switch]$convert_to_agent,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'reactivate',
            HelpMessage = 'This operation allows you to reactivate a particular deactivated requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [switch]$reactivate,
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'merge',
            HelpMessage = 'Merge secondary requesters into a primary requester.',
            ValueFromPipelineByPropertyName = $true
        )]
        [switch]$merge,
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'merge',
            HelpMessage = ' Secondary requester ids for Merge operation..',
            ValueFromPipelineByPropertyName = $true
        )]
        [long[]]$secondary_requesters

    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/requesters' -f $PrivateData['FreshserviceBaseUri'])

        if ($Id) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $Id
            [void]$PSBoundParameters.Remove('id')
        }

        if ($PSBoundParameters.ContainsKey('convert_to_agent')) {
            $uri.Path = '{0}/convert_to_agent' -f $uri.Path
            [void]$PSBoundParameters.Remove('convert_to_agent')
        }
        elseif ($PSBoundParameters.ContainsKey('reactivate')) {
            $uri.Path = '{0}/reactivate' -f $uri.Path
            [void]$PSBoundParameters.Remove('reactivate')
        }
        elseif ($PSBoundParameters.ContainsKey('merge')) {
            $uri.Path = '{0}/merge' -f $uri.Path
            $qry.Add('secondary_requesters', ($secondary_requesters -join ','))
            [void]$PSBoundParameters.Remove('merge')
            [void]$PSBoundParameters.Remove('secondary_requesters')
        }

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
        }

        try {
            if ($PSCmdlet.ShouldProcess($id)) {

                $uri.Query = $qry.ToString()

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'PUT'
                    Body        = $jsonBody | ConvertTo-Json
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

            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
