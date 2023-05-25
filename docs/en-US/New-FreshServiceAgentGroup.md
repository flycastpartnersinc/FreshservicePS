---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceAgentGroup

## SYNOPSIS
Creates a new Freshservice Agent Group.

## SYNTAX

```
New-FreshServiceAgentGroup [-name] <String> [[-description] <String>] [[-unassigned_for] <String>]
 [[-business_hours_id] <Int64>] [[-escalate_to] <Int64>] [[-observers] <Int64[]>] [[-restricted] <Boolean>]
 [[-leaders] <Int64[]>] [[-approval_required] <Boolean>] [[-auto_ticket_assign] <Boolean>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a new Freshservice Agent Group via REST API.

https://api.freshservice.com/#create_a_group

For 'members', use Add-FreshServiceAgentGroupMember and Remove-FreshServiceAgentGroupMember.

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceAgentGroup -name Development -description 'Agent group for Developers'
```

id                         : 21000546879
name                       : Development
description                : Agent group for Developers
escalate_to                :
unassigned_for             : 30m
business_hours_id          :
created_at                 : 3/27/2023 3:45:12 PM
updated_at                 : 3/27/2023 3:45:12 PM
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

Creates a new Freshservice Agent Group.

## PARAMETERS

### -name
Name of the group.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
Description of the group.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -unassigned_for
The time after which an escalation email is sent if a ticket in the group remains unassigned.
The accepted values are "30m" for 30 minutes, "1h" for 1 hour, "2h" for 2 hours", "4h" for 4
hours, "8h" for 8 hours, "12h" for 12 hours, "1d" for 1 day, "2d" for 2 days, and "3d" for 3 days.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -business_hours_id
Unique ID of the business hours configuration associated with the group.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -escalate_to
The Unique ID of the user to whom an escalation email is sent if a ticket in this group is unassigned.
To create/update a group with an escalate_to value of 'none', please set the value of this parameter
to 'null'.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -observers
A comma separated array of user IDs of agents who are observers of this group.
If the group is restricted
and approvals-enabled, the input value for this field should also include the user IDs of agents whose
observer access to the group is pending approval by a group leader.
The response value for this field
would only contain the list of approved observers.
The observers_pending_approval read-only attribute
in the response will include the list of observers whose approval is pending.
This attribute is only
applicable for accounts which have the "Access Controls Pro" feature enabled.

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -restricted
Signifies whether a group is marked as restricted.
This attribute won't be supported if the "Access Controls Pro"
feature is unavailable for the account.
Set to true if the group is restricted, and false otherwise.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -leaders
A comma separated array of user IDs of agents who are leaders of this group.
If the group is restricted
and approvals-enabled, the input value for this field should also include the user IDs of agents whose
leader access to the group is pending approval by another group leader.
The response value for this field
would only contain the list of approved leaders.
The leaders_pending_approval read-only attribute n the
response will include the list of leaders whose approval is pending.
This attribute is only applicable for
accounts which have the "Access Controls Pro" feature enabled.

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -approval_required
Signifies whether the restricted group requires approvals for membership changes.
This attribute is only
applicable for accounts which have the "Access Controls Pro" feature enabled.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -auto_ticket_assign
Describes the automatic ticket assignment type.
Will not be supported if the "Round Robin" feature is
disabled for the account.
Set to true if automatic ticket assignment is enabled, and false otherwise.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: False
Accept pipeline input: True (ByPropertyName)
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
