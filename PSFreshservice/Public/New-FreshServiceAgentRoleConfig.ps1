<#
.SYNOPSIS
    Helper function for agent roles for New-FreshServiceAgent.

.DESCRIPTION
    Helper function for agent roles that generates a PSObject to be passed to -roles parameter for New-FreshServiceAgent. Each individual role is a hash in the
    roles array that contains the attributes.

        * role_id: Unique ID of the role assigned.
        * assignment_scope: The scope in which the agent can use the permissions granted by this role. Possible values include
                            entire_helpdesk (all plans), member_groups (all plans; in the Pro and Enterprise plans, this also
                            includes groups that the agent is an observer of), specified_groups (Pro and Enterprise only), and assigned_items (all plans).
        * groups: Unique IDs of Groups in which the permissions granted by the role applies. Mandatory only when the assignment_scope is specified_groups,
                    and should be ignored otherwise.

        To get role_id, see Get-FreshServiceAgentRole
        To get group_id, see Get-FreshServiceAgentGroup

.PARAMETER role_id
    Unique ID of the role assigned

.PARAMETER assignment_scope
    The scope in which the agent can use the permissions granted by this role. Possible values include entire_helpdesk (all plans), member_groups (all plans;
    in the Pro and Enterprise plans, this also includes groups that the agent is an observer of), specified_groups (Pro and Enterprise only), and assigned_items (all plans).

.PARAMETER groups
    Unique IDs of Groups in which the permissions granted by the role applies. Mandatory only when the assignment_scope is specified_groups, and should be ignored otherwise.

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

    $agentRoles

    role_id assignment_scope groups
    ------- ---------------- ------
    21000150301 specified_groups {21000188388, 21000188389}
    21000150294 specified_groups {21000188403}

    Add multiple roles to an agent. First, add a role as IT Ops Agent for the Incident Team and Major Incident team as a specified group.
    Second add a role as SD Supervisor for the Helpdesk Monitoring Team.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceAgentRoleConfig {
         [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'The role id'
        )]
        [long]$role_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'The scope in which the agent can use the permissions granted by this role. Possible values include entire_helpdesk (all plans), member_groups (all plans; in the Pro and Enterprise plans, this also includes groups that the agent is an observer of), specified_groups (Pro and Enterprise only), and assigned_items (all plans)'
        )]
        [ValidateSet('entire_helpdesk','member_groups','specified_groups','assigned_items')]
        [string]$assignment_scope,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique IDs of Groups in which the permissions granted by the role applies. Mandatory only when the assignment_scope is specified_groups, and should be ignored otherwise.'
        )]
        [long[]]$groups

    )
    begin {

    }
    process {
        if ($PSCmdlet.ShouldProcess($id)) {

            $jsonBody = @{}
            $PSBoundParameters.keys.where{
                $PSItem -notin $PrivateData.FreshserviceBodyExclusions
            }.foreach{
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            }

            [pscustomobject]$jsonBody

        }
    }
    end {
        $results
    }
}
