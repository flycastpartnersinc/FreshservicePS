---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Add-FreshServiceAgentGroupMember

## SYNOPSIS
Adds a Freshservice Agent to a Agent Group.

## SYNTAX

```
Add-FreshServiceAgentGroupMember [-id] <Int64> [[-members] <Int64[]>] [-Overwrite] [<CommonParameters>]
```

## DESCRIPTION
Adds a Freshservice Agent to a Agent Group via REST API.

This is a wrapper function for https://api.freshservice.com/#update_a_group using the Members property.
The
default behavior is to overwrite existing members with what is passed, so this wrapper function gets the
existing members and appends them to make the default behavior adding a member.

## EXAMPLES

### EXAMPLE 1
```
Add-FreshServiceAgentGroupMember -id 21000543793 -members 21001392937
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
agent_ids                  : {21001392937, 21001931878}
members                    : {21001392937, 21001931878}
observers                  : {}
leaders                    : {}
members_pending_approval   : {}
leaders_pending_approval   : {}
observers_pending_approval : {}

Adds a Freshservice Agent to a Agent Group.

### EXAMPLE 2
```
Add-FreshServiceAgentGroupMember -id 21000543793 -members 21001931878 -Overwrite
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
agent_ids                  : {21001931878}
members                    : {21001931878}
observers                  : {}
leaders                    : {}
members_pending_approval   : {}
leaders_pending_approval   : {}
observers_pending_approval : {}

Removes all users except for the passed members. 
Essentially, this wipes the group and replaces the members with the passed members.

## PARAMETERS

### -id
Unique Id of the Agent group.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: Agent_group_id

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -members
An array of user IDs of agents who are members of this group.
If the group is restricted and approvals-enabled, the input value for this field should also include the user IDs of agents whose member access to the group is pending approval by a group leader.
The response value for this field would only contain the list of approved members.
The members_pending_approval read-only attribute in the response will include the list of members whose approval is pending.

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Overwrite
Overwrites all existing members with passed members.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
