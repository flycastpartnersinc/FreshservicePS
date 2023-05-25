---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceAgentGroup

## SYNOPSIS
Returns a Freshservice Agent Group.

## SYNTAX

### default (Default)
```
Get-FreshServiceAgentGroup [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### Id
```
Get-FreshServiceAgentGroup [[-Id] <Int64>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Agent Group via REST API.

https://api.freshservice.com/#view_a_group

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceAgentGroup
```

id                         : 21000188396
name                       : Capacity Management Team
description                : Capacity Management Team
escalate_to                :
unassigned_for             :
business_hours_id          :
created_at                 : 8/29/2022 2:17:01 PM
updated_at                 : 8/29/2022 2:17:01 PM
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

id                         : 21000188392
name                       : Change Team
description                : Change Management Team
escalate_to                :
unassigned_for             :
business_hours_id          :
created_at                 : 8/29/2022 2:17:01 PM
updated_at                 : 8/29/2022 2:17:01 PM
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

Returns all FreshService Agent Groups.

### EXAMPLE 2
```
Get-FreshServiceAgentGroup -id 21000188392
```

id                         : 21000188392
name                       : Change Team
description                : Change Management Team
escalate_to                :
unassigned_for             :
business_hours_id          :
created_at                 : 8/29/2022 2:17:01 PM
updated_at                 : 8/29/2022 2:17:01 PM
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

Returns a Freshservice Agent Group by Id.

## PARAMETERS

### -Id
Unique id of the agent group.

```yaml
Type: Int64
Parameter Sets: Id
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -per_page
Number of records to return per page during pagination. 
Maximum of 100 records.

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 1
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -page
The page number to retrieve during pagination.

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 2
Default value: 1
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
