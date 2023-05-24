<#
.SYNOPSIS
    Returns a Freshservice ticket.

.DESCRIPTION
    Returns a Freshservice ticket via REST API.

    https://api.freshservice.com/#create_a_requester

.PARAMETER external_id
    External Id of the requester.

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
    Unique IDs of the departments associated with the requester.

.PARAMETER can_see_all_tickets_from_associated_departments
    Set to true if the requester must be allowed to view tickets filed by other members of the department, and false otherwise.

.PARAMETER can_see_all_changes_from_associated_departments
    Set to true if the requester must be allowed to view changes filed by other members of the department, and false otherwise.

.PARAMETER reporting_manager_id
    User ID of the requester's reporting manager.

.PARAMETER address
    Address of the requester.

.PARAMETER time_zone
    Time zone of the requester.

.PARAMETER time_format
    Time format for the requester.Possible values:12h (12 hour format)24h (24 hour format)

.PARAMETER language
    Language used by the requester. The default language is "en" (English).

.PARAMETER location_id
    Unique ID of the location associated with the requester.

.PARAMETER background_information
    Background information of the requester.

.PARAMETER custom_fields
    Key-value pair containing the names and values of the (custom) requester fields.

.EXAMPLE
    New-FreshServicerequester -first_name 'John' -last_name 'Smith' -job_title 'QA Tester' -primary_email 'jsmith@company.com'

    active                                          : True
    address                                         :
    background_information                          :
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 3/31/2022 1:23:36 AM
    custom_fields                                   : @{ad_location1=; ad_location2=}
    department_ids                                  : {}
    external_id                                     :
    first_name                                      : John
    has_logged_in                                   : False
    id                                              : 18012783346
    is_agent                                        : False
    job_title                                       : QA Tester
    language                                        : en
    last_name                                       : Smith
    location_id                                     :
    mobile_phone_number                             :
    primary_email                                   : jsmith@company.com
    reporting_manager_id                            :
    secondary_emails                                : {}
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 3/31/2022 1:23:36 AM
    vip_user                                        : False
    work_phone_number                               :

    Creates a a new Freshservice Requester.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceRequester {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'External Id of the requester.'
        )]
        [string]$external_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'First name of the requester.'
        )]
        [string]$first_name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Last name of the requester.'
        )]
        [string]$last_name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Job title of the requester.'
        )]
        [string]$job_title,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Primary email address of the requester.'
        )]
        [string]$primary_email,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Additional/secondary emails associated with the requester.'
        )]
        [string[]]$secondary_emails,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Work phone number of the requester.'
        )]
        [string]$work_phone_number,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Mobile phone number of the requester.'
        )]
        [string]$mobile_phone_number,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique IDs of the departments associated with the requester'
        )]
        [long[]]$department_ids,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set to true if the requester must be allowed to view changes filed by other members of the department, and false otherwise'
        )]
        [boolean]$can_see_all_changes_from_associated_departments,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set to true if the requester must be allowed to view tickets filed by other members of the department, and false otherwise'
        )]
        [boolean]$can_see_all_tickets_from_associated_departments,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User ID of the requesters reporting manager.'
        )]
        [int]$reporting_manager_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Address of the requester.'
        )]
        [string]$address,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Time zone of the requester. Read more here.'
        )]
        [string]$time_zone,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Time format for the requester.Possible values:12h (12 hour format)24h (24 hour format)'
        )]
        [string]$time_format,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Language used by the requester. The default language is "en" (English). Read more here.'
        )]
        [string]$language,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique ID of the location associated with the requester.'
        )]
        [int]$location_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Background information of the requester.'
        )]
        [string]$background_information,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key-value pair containing the names and values of the (custom) requester fields.'
        )]
        [object[]]$custom_fields
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/requesters' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            #if ($PSBoundParameters[$PSItem] -is [boolean]) {
            #    $jsonBody[$PSItem.ToLower()] = [int]$PSBoundParameters[$PSItem]
            #}
            #else {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            #}
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'POST'
                    Body        = $jsonBody | ConvertTo-Json
                    ErrorAction = 'Stop'
                }

                $result = Invoke-FreshworksRestMethod @params

                $content = $result.Content |
                                ConvertFrom-Json -Depth 5

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
