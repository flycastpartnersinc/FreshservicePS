---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Remove-FreshServiceAgentGroupMember

## SYNOPSIS
Delete a Freshservice Agent Group Member.

## SYNTAX

### default (Default)
```
Remove-FreshServiceAgentGroupMember [-id] <String> [-members] <Int64[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### clear
```
Remove-FreshServiceAgentGroupMember [-id] <String> [-clear] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Delete a Freshservice Agent Group Member via REST API.

This is a wrapper function for https://api.freshservice.com/#update_a_group using the Members property.
The
default behavior is to overwrite existing members with what is passed, so this wrapper function gets the
existing members and appends them to make the default behavior adding a member.

## EXAMPLES

### EXAMPLE 1
```
Remove-FreshServiceAgentGroupMember -id 21000543793 -members 21001931878
```

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

### EXAMPLE 2
```
Remove-FreshServiceAgentGroupMember -id 21000543793 -clear
```

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

## PARAMETERS

### -id
Unique id of the Agent group.

```yaml
Type: String
Parameter Sets: (All)
Aliases: agent_group_id

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -members
Unique id of the Agent(s).

```yaml
Type: Int64[]
Parameter Sets: default
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -clear
Remove all members of the group.

```yaml
Type: SwitchParameter
Parameter Sets: clear
Aliases:

Required: False
Position: 2
Default value: False
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
