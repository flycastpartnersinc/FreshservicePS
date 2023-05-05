<#
.SYNOPSIS
    Adds a Freshservice Agent to a Agent Group.

.DESCRIPTION
    Adds a Freshservice Agent to a Agent Group via REST API.

    This is a wrapper function for https://api.freshservice.com/#update_a_group using the Members property. The
    default behavior is to overwrite existing members with what is passed, so this wrapper function gets the
    existing members and appends them to make the default behavior adding a member.

.PARAMETER id
    Unique Id of the Agent group.

.PARAMETER Agent_id
    Unique Id of the Agent.

.PARAMETER members
    An array of user IDs of agents who are members of this group. If the group is restricted and approvals-enabled, the input value for this field should also include the user IDs of agents whose member access to the group is pending approval by a group leader. The response value for this field would only contain the list of approved members. The members_pending_approval read-only attribute in the response will include the list of members whose approval is pending.

.PARAMETER Overwrite
    Overwrites all existing members with passed members.

.EXAMPLE
    Add-FreshServiceAgentGroupMember -id 21000543793 -members 21001392937

    id                         : 21000543793
    name                       : MyNewAgentGroup
    description                : New Agent group
    escalate_to                :
    unassigned_for             : 30m
    business_hours_id          :
    created_at                 : 2/2/2023 1:51:55 AM
    updated_at                 : 2/2/2023 1:51:55 AM
    auto_ticket_assign         : False
    restricted                 : False
    approval_required          : False
    ocs_schedule_id            :
    agent_ids                  : {21001392937, 21001931878}
    members                    : {21001392937, 21001931878}
    observers                  : {}
    leaders                    : {}
    members_pending_approval   : {}
    leaders_pending_approval   : {}
    observers_pending_approval : {}

    Adds a Freshservice Agent to a Agent Group.

.EXAMPLE
    Add-FreshServiceAgentGroupMember -id 21000543793 -members 21001931878 -Overwrite

    id                         : 21000543793
    name                       : MyNewAgentGroup
    description                : New Agent group
    escalate_to                :
    unassigned_for             : 30m
    business_hours_id          :
    created_at                 : 2/2/2023 1:51:55 AM
    updated_at                 : 2/2/2023 1:51:55 AM
    auto_ticket_assign         : False
    restricted                 : False
    approval_required          : False
    ocs_schedule_id            :
    agent_ids                  : {21001931878}
    members                    : {21001931878}
    observers                  : {}
    leaders                    : {}
    members_pending_approval   : {}
    leaders_pending_approval   : {}
    observers_pending_approval : {}

    Removes all users except for the passed members.  Essentially, this wipes the group and replaces the members with the passed members.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Add-FreshServiceAgentGroupMember {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the group.',
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('Agent_group_id')]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'An array of user IDs of agents who are members of this group. If the group is restricted and approvals-enabled, the input value for this field should also include the user IDs of agents whose member access to the group is pending approval by a group leader. The response value for this field would only contain the list of approved members. The members_pending_approval read-only attribute in the response will include the list of members whose approval is pending.'
        )]
        [long[]]$members,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Overwrites all existing members with passed members.'
        )]
        [switch]$Overwrite
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/groups' -f $PrivateData['FreshserviceBaseUri'])

        try {
            $agtGroup = Get-FreshServiceAgentGroup -id $id -ErrorAction Stop
        }
        catch {
            throw $_
        }

    }
    process {

        if (!$Overwrite) {
            $combinedMembers = @()
            $combinedMembers += $agtGroup.Members
            $combinedMembers += $members

            $PSBoundParameters['members'] = $combinedMembers
        }
        else {
            [void]$PSBoundParameters.Remove('Overwrite')
        }

        if ($PSBoundParameters.ContainsKey('id')) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $id
            [void]$PSBoundParameters.Remove('Id')
        }

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
        }

        try {
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
        catch {
            Throw $_
        }

    }
    end {}
}
