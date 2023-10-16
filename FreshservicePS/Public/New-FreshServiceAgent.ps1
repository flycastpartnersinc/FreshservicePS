<#
.SYNOPSIS
    Creates a new Freshservice Agent.

.DESCRIPTION
    Creates a new Freshservice Agent via REST API.

    https://api.freshservice.com/#create_an_agent

.PARAMETER first_name
    First name of the agent.

.PARAMETER last_name
    Last name of the agent.

.PARAMETER occasional
    True if the agent is an occasional agent, and false if full-time agent.

.PARAMETER job_title
    Job title of the agent.

.PARAMETER email
    Email address of the agent.

.PARAMETER work_phone_number
    Work phone number of the agent.

.PARAMETER mobile_phone_number
    Mobile phone number of the agent.

.PARAMETER department_ids
    Unique IDs of the departments associated with the agent.

.PARAMETER can_see_all_tickets_from_associated_departments
    Set to true if the agent must be allowed to view tickets filed by other members of the department, and false otherwise.

.PARAMETER reporting_manager_id
    User ID of the agent's reporting manager.

.PARAMETER address
    Address of the agent.

.PARAMETER time_zone
    Time zone of the agent.

.PARAMETER time_format
    Time format for the agent. Possible values:

        12h (12 hour format)
        24h (24 hour format)

.PARAMETER language
    Language used by the agent. The default language is "en" (English).

.PARAMETER location_id
    Unique ID of the location associated with the agent.

.PARAMETER background_information
    Background information of the agent.

.PARAMETER scoreboard_level_id
    Unique ID of the level of the agent in the Arcade. Possible values:--1 (Beginner)--2 (Intermediate)--3 (Professional)--4 (Expert)--5 (Master)--6 (Guru)

.PARAMETER member_of
    Unique IDs of the groups that the agent is a member of. The response value for this field would only contain the list of groups that the agent is an approved member of.
    The member_of_pending_approval read-only attribute in the response will include the list of groups for which the agent's member access is pending approval by a group leader.

.PARAMETER observer_of
    Unique IDs of the groups that the agent is an observer of. The response value for this field would only contain the list of groups that the agent is an approved observer
    of. The observer_of_pending_approval read-only attribute in the response will include the list of groups for which the agent's observer access is pending approval by a group leader.

.PARAMETER roles
    Each individual role is a hash in the roles array that contains the attributes.role_id: Unique ID of the role assigned"assignment_scope: The scope in which the
    agent can use the permissions granted by this role. Possible values include entire_helpdesk (all plans)

.PARAMETER license_type
    The type of license, IT or Business.

.PARAMETER signature
    Signature of the agent in HTML format.

.PARAMETER custom_fields
    Key-value pair containing the names and values of the (custom) agent fields.

.EXAMPLE
     $newFreshServiceAgentRoleConfigSplat1 = @{
        role_id          = 21000150301 #IT Ops Agent - Get-FreshServiceAgentRole
        assignment_scope = 'specified_groups'
        groups           = 21000188388,21000188389 #Incident Team and Major Incident Team- Get-FreshServiceAgentGroup
    }

    $newFreshServiceAgentRoleConfigSplat2 = @{
        role_id          = 21000150294 #SD Supervisor - Get-FreshServiceAgentRole
        assignment_scope = 'specified_groups'
        groups           = 21000188403 #Helpdesk Monitoring Team - Get-FreshServiceAgentGroup
    }

    $agentRoles = foreach ($splat in @($newFreshServiceAgentRoleConfigSplat1, $newFreshServiceAgentRoleConfigSplat2)) {
        New-FreshServiceAgentRoleConfig @splat
    }

    $newFreshServiceAgentSplat = @{
        first_name             = 'Ralph'
        last_name              = 'smith'
        job_title              = 'Code Monkey'
        email                  = 'Alex.agent@example.com'
        background_information = 'Awesome helpdesk training'
        roles = $agentRoles
    }

    New-FreshServiceAgent @newFreshServiceAgentSplat

    active                                          : True
    address                                         :
    auto_assign_status_changed_at                   :
    auto_assign_tickets                             : True
    background_information                          : Awesome helpdesk training
    can_see_all_tickets_from_associated_departments : False
    created_at                                      : 3/27/2023 5:10:31 PM
    custom_fields                                   : @{employee_id=}
    department_ids                                  : {}
    department_names                                :
    email                                           : Alex.agent2@example.com
    external_id                                     :
    first_name                                      : Ralph
    has_logged_in                                   : False
    id                                              : 21001941828
    job_title                                       : Code Monkey
    language                                        : en
    last_active_at                                  :
    last_login_at                                   :
    last_name                                       : Smith
    location_id                                     :
    location_name                                   :
    mobile_phone_number                             :
    occasional                                      : False
    reporting_manager_id                            :
    role_ids                                        : {21000150301, 21000150294}
    roles                                           : {@{role_id=21000150294; assignment_scope=specified_groups;
                                                    groups=System.Object[]}, @{role_id=21000150301;
                                                    assignment_scope=specified_groups; groups=System.Object[]}}
    scopes                                          : @{ticket=; problem=; change=; asset=; solution=; contract=}
    scoreboard_level_id                             : 1
    scoreboard_points                               :
    signature                                       :
    time_format                                     : 12h
    time_zone                                       : Eastern Time (US & Canada)
    updated_at                                      : 3/27/2023 5:10:31 PM
    vip_user                                        : False
    work_phone_number                               :
    group_ids                                       : {}
    member_of                                       : {}
    observer_of                                     : {}
    member_of_pending_approval                      : {}
    observer_of_pending_approval                    : {}

    Adds a new Freshservice Agent. There is a helper function New-FreshServiceAgentRoleConfig to assist with creating roles
    based on the documentation format, which generates a PSObject. Note there are dependent ids that can be obtained from other cmdlets
    (e.g. Get-FreshServiceAgentRole and Get-FreshServiceAgentGroup) Multiple roles can be mapped to a single Agent.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>

function New-FreshServiceAgent {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'First name of the agent.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('FirstName')]
        [string]$first_name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Last name of the agent.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('LastName')]
        [string]$last_name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'True if the agent is an occasional agent, and false if full-time agent.',
            ValueFromPipelineByPropertyName = $true
        )]
        [boolean]$occasional,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Job title of the agent.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('JobTitle')]
        [string]$job_title,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Email address of the agent.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$email,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Work phone number of the agent.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('WorkNumber','WorkPhoneNumber')]
        [string]$work_phone_number,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Mobile phone number of the agent.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('MobilePhone','MobilePhoneNumber')]
        [string]$mobile_phone_number,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique IDs of the departments associated with the agent',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('DepartmentId')]
        [long[]]$department_ids,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set to true if the agent must be allowed to view tickets filed by other members of the department, and false otherwise',
            ValueFromPipelineByPropertyName = $true
        )]
        [boolean]$can_see_all_tickets_from_associated_departments,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User ID of the agents reporting manager.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('ReportingManagerId')]
        [long]$reporting_manager_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Address of the agent.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$address,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Time zone of the agent.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('TimeZone')]
        [string]$time_zone,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Time format for the agent.Possible values: --12h (12 hour format) --24h (24 hour format)',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet('12h','24h')]
        [Alias('TimeFormat')]
        [string]$time_format,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Language used by the agent. The default language is "en" (English). Read more here.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$language,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique ID of the location associated with the agent.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('LocationId')]
        [long]$location_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Background information of the agent.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('BackgroundInformation')]
        [string]$background_information,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique ID of the level of the agent in the Arcade. Possible values:--1 (Beginner)--2 (Intermediate)--3 (Professional)--4 (Expert)--5 (Master)--6 (Guru)',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(1,6)]
        [Alias('ScoreboardLevel')]
        [int]$scoreboard_level_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique IDs of the groups that the agent is a member of. The response value for this field would only contain the list of groups that the agent is an approved member of. The member_of_pending_approval read-only attribute in the response will include the list of groups for which the agents member access is pending approval by a group leader.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('MemberOf')]
        [long[]]$member_of,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique IDs of the groups that the agent is an observer of. The response value for this field would only contain the list of groups that the agent is an approved observer of. The observer_of_pending_approval read-only attribute in the response will include the list of groups for which the agents observer access is pending approval by a group leader.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('ObserverOf')]
        [long[]]$observer_of,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Each individual role is a hash in the roles array that contains the attributes.role_id: Unique ID of the role assigned"assignment_scope: The scope in which the agent can use the permissions granted by this role. Possible values include entire_helpdesk (all plans)',
            ValueFromPipelineByPropertyName = $true
        )]
        [object[]]$roles,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Signature of the agent in HTML format.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet('it','business')]
        [string]$license_type,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Signature of the agent in HTML format.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$signature,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key-value pair containing the names and values of the (custom) agent fields.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('CustomFields')]
        [hashtable]$custom_fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Workspace Ids',
            ValueFromPipelineByPropertyName = $true
        )]
        [int[]]$workspace_ids
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/agents' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            # switch ($PSItem) {
            #     'roles' {
            #         #Force into array for JSON
            #         $jsonBody[$PSItem.ToLower()] = @($PSBoundParameters[$PSItem])
            #     }
                # default {
                    $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            #     }
            # }
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {
                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'POST'
                    Body        = $jsonBody | ConvertTo-Json -Depth 5
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
            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
