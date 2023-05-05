---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# New-FreshServiceAgentRoleConfig

## SYNOPSIS
Helper function for agent roles for New-FreshServiceAgent.

## SYNTAX

```
New-FreshServiceAgentRoleConfig [-role_id] <Int64> [-assignment_scope] <String> [[-groups] <Int64[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Helper function for agent roles that generates a PSObject to be passed to -roles parameter for New-FreshServiceAgent.
Each individual role is a hash in the
roles array that contains the attributes.

    * role_id: Unique ID of the role assigned.
    * assignment_scope: The scope in which the agent can use the permissions granted by this role.
Possible values include
                        entire_helpdesk (all plans), member_groups (all plans; in the Pro and Enterprise plans, this also
                        includes groups that the agent is an observer of), specified_groups (Pro and Enterprise only), and assigned_items (all plans).
    * groups: Unique IDs of Groups in which the permissions granted by the role applies.
Mandatory only when the assignment_scope is specified_groups,
                and should be ignored otherwise.

    To get role_id, see Get-FreshServiceAgentRole
    To get group_id, see Get-FreshServiceAgentGroup

## EXAMPLES

### EXAMPLE 1
```
$newFreshServiceAgentRoleConfigSplat1 = @{
    role_id          = 21000150301 #IT Ops Agent - Get-FreshServiceAgentRole
    assignment_scope = 'specified_groups'
    groups           = 21000188388,21000188389 #Incident Team and Major Incident Team- Get-FreshServiceAgentGroup
}
```

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

Add multiple roles to an agent.
First, add a role as IT Ops Agent for the Incident Team and Major Incident team as a specified group.
Second add a role as SD Supervisor for the Helpdesk Monitoring Team.

## PARAMETERS

### -role_id
Unique ID of the role assigned

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -assignment_scope
The scope in which the agent can use the permissions granted by this role.
Possible values include entire_helpdesk (all plans), member_groups (all plans;
in the Pro and Enterprise plans, this also includes groups that the agent is an observer of), specified_groups (Pro and Enterprise only), and assigned_items (all plans).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -groups
Unique IDs of Groups in which the permissions granted by the role applies.
Mandatory only when the assignment_scope is specified_groups, and should be ignored otherwise.

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
This module was developed and tested with Freshservice REST API v2.

## RELATED LINKS
