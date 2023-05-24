<#
.SYNOPSIS
    Updates a Freshservice Agent Group.

.DESCRIPTION
    Updates a Freshservice Agent Group via REST API.

    https://api.freshservice.com/#update_a_group

    For 'members', use Add-FreshServiceAgentGroupMember and Remove-FreshServiceAgentGroupMember.

.PARAMETER id
    Unique id of the group.

.PARAMETER name
    Name of the group.

.PARAMETER description
    Description of the group.

.PARAMETER unassigned_for
    The time after which an escalation email is sent if a ticket in the group remains unassigned. The accepted values are "30m" for 30 minutes, "1h" for 1 hour, "2h" for 2 hours", "4h" for 4 hours, "8h" for 8 hours, "12h" for 12 hours, "1d" for 1 day, "2d" for 2 days, and "3d" for 3 days.

.PARAMETER business_hours_id
    Unique ID of the business hours configuration associated with the group.

.PARAMETER escalate_to
    The Unique ID of the user to whom an escalation email is sent if a ticket in this group is unassigned. To create/update a group with an escalate_to value of 'none', please set the value of this parameter to 'null'.

.PARAMETER agent_ids
    Array of agent user IDs separated by commas.DEPRECATED Use members attribute instead.

.PARAMETER observers
    A comma separated array of user IDs of agents who are observers of this group. If the group is restricted and approvals-enabled, the input value for this field should also include the user IDs of agents whose observer access to the group is pending approval by a group leader. The response value for this field would only contain the list of approved observers. The observers_pending_approval read-only attribute in the response will include the list of observers whose approval is pending. This attribute is only applicable for accounts which have the "Access Controls Pro" feature enabled.

.PARAMETER restricted
    Signifies whether a group is marked as restricted. This attribute won't be supported if the "Access Controls Pro" feature is unavailable for the account. Set to true if the group is restricted, and false otherwise.

.PARAMETER leaders
    A comma separated array of user IDs of agents who are leaders of this group. If the group is restricted and approvals-enabled, the input value for this field should also include the user IDs of agents whose leader access to the group is pending approval by another group leader. The response value for this field would only contain the list of approved leaders. The leaders_pending_approval read-only attribute n the response will include the list of leaders whose approval is pending. This attribute is only applicable for accounts which have the "Access Controls Pro" feature enabled.

.PARAMETER approval_required
    Signifies whether the restricted group requires approvals for membership changes. This attribute is only applicable for accounts which have the "Access Controls Pro" feature enabled.

.PARAMETER auto_ticket_assign
    Describes the automatic ticket assignment type. Will not be supported if the "Round Robin" feature is disabled for the account. Set to true if automatic ticket assignment is enabled, and false otherwise.

.EXAMPLE
    Set-FreshServiceAgentGroup -id 21000188401 -description 'Updated Description'

    id                         : 21000188401
    name                       : Software Team
    description                : Updated Description
    escalate_to                :
    unassigned_for             : 30m
    business_hours_id          :
    created_at                 : 8/29/2022 2:17:58 PM
    updated_at                 : 3/30/2023 2:29:06 AM
    auto_ticket_assign         : False
    restricted                 : False
    approval_required          : False
    ocs_schedule_id            :
    agent_ids                  : {21000418005}
    members                    : {21000418005}
    observers                  : {}
    leaders                    : {}
    members_pending_approval   : {}
    leaders_pending_approval   : {}
    observers_pending_approval : {}

    Update a Freshservice Agent Group.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceAgentGroup {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the group.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the group.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the group.',
            ValueFromPipelineByPropertyName = $true
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The time after which an escalation email is sent if a ticket in the group remains unassigned. The accepted values are "30m" for 30 minutes, "1h" for 1 hour, "2h" for 2 hours", "4h" for 4 hours, "8h" for 8 hours, "12h" for 12 hours, "1d" for 1 day, "2d" for 2 days, and "3d" for 3 days.',
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet('30m','1h','2h','4h','8h','12h','1d','2d','3d')]
        [string]$unassigned_for,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique ID of the business hours configuration associated with the group.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$business_hours_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The Unique ID of the user to whom an escalation email is sent if a ticket in this group is unassigned. To create/update a group with an escalate_to value of none, please set the value of this parameter to null.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long]$escalate_to,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'A comma separated array of user IDs of agents who are observers of this group. If the group is restricted and approvals-enabled, the input value for this field should also include the user IDs of agents whose observer access to the group is pending approval by a group leader. The response value for this field would only contain the list of approved observers. The observers_pending_approval read-only attribute in the response will include the list of observers whose approval is pending. This attribute is only applicable for accounts which have the "Access Controls Pro" feature enabled.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long[]]$observers,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Signifies whether a group is marked as restricted. This attribute will not be supported if the "Access Controls Pro" feature is unavailable for the account. Set to true if the group is restricted, and false otherwise.',
            ValueFromPipelineByPropertyName = $true
        )]
        [boolean]$restricted,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'A comma separated array of user IDs of agents who are leaders of this group. If the group is restricted and approvals-enabled, the input value for this field should also include the user IDs of agents whose leader access to the group is pending approval by another group leader. The response value for this field would only contain the list of approved leaders. The leaders_pending_approval read-only attribute n the response will include the list of leaders whose approval is pending. This attribute is only applicable for accounts which have the "Access Controls Pro" feature enabled.',
            ValueFromPipelineByPropertyName = $true
        )]
        [long[]]$leaders,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Signifies whether the restricted group requires approvals for membership changes. This attribute is only applicable for accounts which have the "Access Controls Pro" feature enabled.',
            ValueFromPipelineByPropertyName = $true
        )]
        [boolean]$approval_required,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Describes the automatic ticket assignment type. Will not be supported if the "Round Robin" feature is disabled for the account. Set to true if automatic ticket assignment is enabled, and false otherwise.',
            ValueFromPipelineByPropertyName = $true
        )]
        [boolean]$auto_ticket_assign
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $uri = [System.UriBuilder]('{0}/groups' -f $PrivateData['FreshserviceBaseUri'])

        if ($PSBoundParameters.ContainsKey('id')) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $id
            [void]$PSBoundParameters.Remove('Id')
        }

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
    end {
    }
}
