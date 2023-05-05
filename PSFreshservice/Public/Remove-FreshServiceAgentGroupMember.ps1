<#
.SYNOPSIS
    Delete a Freshservice Agent Group Member.

.DESCRIPTION
    Delete a Freshservice Agent Group Member via REST API.

    This is a wrapper function for https://api.freshservice.com/#update_a_group using the Members property. The
    default behavior is to overwrite existing members with what is passed, so this wrapper function gets the
    existing members and appends them to make the default behavior adding a member.

.PARAMETER id
    Unique id of the Agent group.

.PARAMETER members
    Unique id of the Agent(s).

.PARAMETER clear
    Remove all members of the group.

.EXAMPLE
    Remove-FreshServiceAgentGroupMember -id 21000543793 -members 21001931878

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
    agent_ids                  : {21001392937}
    members                    : {21001392937}
    observers                  : {}
    leaders                    : {}
    members_pending_approval   : {}
    leaders_pending_approval   : {}
    observers_pending_approval : {}

    Delete a Freshservice Agent Group Member.

.EXAMPLE
    Remove-FreshServiceAgentGroupMember -id 21000543793 -clear

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
    agent_ids                  : {}
    members                    : {}
    observers                  : {}
    leaders                    : {}
    members_pending_approval   : {}
    leaders_pending_approval   : {}
    observers_pending_approval : {}

    Remove all Freshservice Agent Group Members.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Remove-FreshServiceAgentGroupMember {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', DefaultParameterSetName = 'default')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Agent group.',
            ValueFromPipelineByPropertyName = $false,
            ParameterSetName = 'default',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Agent group.',
            ValueFromPipelineByPropertyName = $false,
            ParameterSetName = 'clear',
            Position = 0
        )]
        [Alias('agent_group_id')]
        [string]$id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'An array of user IDs of agents to remove as members of this group. If the group is restricted and approvals-enabled, the input value for this field should also include the user IDs of agents whose member access to the group is pending approval by a group leader. The response value for this field would only contain the list of approved members. The members_pending_approval read-only attribute in the response will include the list of members whose approval is pending.',
            ParameterSetName = 'default',
            Position = 1
        )]
        [long[]]$members,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Remove all members of the group.',
            ParameterSetName = 'clear',
            Position = 1
        )]
        [switch]$clear
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/groups' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

        try {
            $agtGroup = Get-FreshServiceAgentGroup -id $id -ErrorAction Stop
        }
        catch {
            throw $_
        }

        if ($clear) {
            $remainingMembers = @()
            [void]$PSBoundParameters.Remove('clear')
        }
        else {
            $remainingMembers = $agtGroup.Members | Where-Object -FilterScript {$members -notcontains $_ }
        }

        $PSBoundParameters['members'] = @($remainingMembers)

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
            if ($PSCmdlet.ShouldProcess($id)) {

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
