---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceChange

## SYNOPSIS
Returns a Freshservice Change.

## SYNTAX

### default (Default)
```
Get-FreshServiceChange [[-updated_since] <DateTime>] [[-include] <String[]>] [[-per_page] <Int32>]
 [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceChange [-Id] <Int64> [[-include] <String[]>] [<CommonParameters>]
```

### predefined_filter
```
Get-FreshServiceChange [[-include] <String[]>] [[-predefined_filter] <String>] [[-per_page] <Int32>]
 [[-page] <Int32>] [<CommonParameters>]
```

### Form
```
Get-FreshServiceChange [-fields] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Change via REST API.

By default only changes that have been created within the past 30 days will be returned.
For older changes, use the updated_since filter.

https://api.freshservice.com/#view_a_change

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceChange
```

agent_id           :
group_id           :
priority           : 1
impact             : 1
status             : 1
risk               : 1
change_type        : 1
planned_start_date : 3/25/2023 7:37:58 AM
planned_end_date   : 3/25/2023 9:37:58 AM
subject            : Fix Zero-day Vulnerability
department_id      : 21000351606
category           :
sub_category       :
item_category      :
description        : \<div\>We need to get critical patch on KB123456 installed ASAP.\</div\>
description_text   : We need to get critical patch on KB123456 installed ASAP.
id                 : 17
requester_id       : 21000418005
approval_status    : 4
change_window_id   :
created_at         : 3/25/2023 7:38:00 PM
updated_at         : 3/25/2023 7:38:00 PM
maintenance_window :
blackout_window    :
assets             : {}
impacted_services  : {}

agent_id           : 21000418005
group_id           : 21000188395
priority           : 1
impact             : 1
status             : 2
risk               : 1
change_type        : 1
planned_start_date : 2/28/2023 5:42:29 AM
planned_end_date   : 2/28/2023 7:42:29 AM
subject            : Test change from Pester
department_id      :
category           : Hardware
sub_category       : Computer
item_category      :
description        : \<div\>Test change from Pester: 82556a0b-60eb-49a9-8ce5-a4a7fb185d31\</div\>
description_text   : Test change from Pester: 82556a0b-60eb-49a9-8ce5-a4a7fb185d31
id                 : 10
requester_id       : 21000418005
approval_status    : 4
change_window_id   :
created_at         : 2/28/2023 5:42:30 PM
updated_at         : 2/28/2023 5:51:25 PM
maintenance_window :
blackout_window    :
assets             : {}
impacted_services  : {}

Return all Freshservice Changes.

### EXAMPLE 2
```
Get-FreshServiceChange -id 10
```

agent_id           : 21000418005
group_id           : 21000188395
priority           : 1
impact             : 1
status             : 2
risk               : 1
change_type        : 1
planned_start_date : 2/28/2023 5:42:29 AM
planned_end_date   : 2/28/2023 7:42:29 AM
subject            : Test change from Pester
department_id      :
category           : Hardware
sub_category       : Computer
item_category      :
description        : \<div\>Test change from Pester: 82556a0b-60eb-49a9-8ce5-a4a7fb185d31\</div\>
description_text   : Test change from Pester: 82556a0b-60eb-49a9-8ce5-a4a7fb185d31
id                 : 10
requester_id       : 21000418005
approval_status    : 4
change_window_id   :
created_at         : 2/28/2023 5:42:30 PM
updated_at         : 2/28/2023 5:51:25 PM
maintenance_window :
blackout_window    :
assets             : {}
impacted_services  : {}
custom_fields      :
planning_fields    : @{custom_fields=}

Return Freshservice Change by Id.

### EXAMPLE 3
```
Get-FreshServiceChange -id 3 -include stats
```

agent_id           :
group_id           :
priority           : 1
impact             : 1
status             : 1
risk               : 1
change_type        : 1
planned_start_date : 1/11/2023 7:07:09 PM
planned_end_date   : 1/12/2023 7:07:09 PM
subject            : Fix Zero-day Vulnerability
department_id      :
category           :
sub_category       :
item_category      :
description        : \<div\>We need to get critical patch on KB123456 installed ASAP.\</div\>
description_text   : We need to get critical patch on KB123456 installed ASAP.
id                 : 3
requester_id       : 21000418005
approval_status    : 4
change_window_id   :
created_at         : 1/11/2023 7:07:08 PM
updated_at         : 1/11/2023 7:07:08 PM
maintenance_window :
blackout_window    :
assets             : {}
impacted_services  : {}
custom_fields      :
planning_fields    : @{custom_fields=}
stats              : @{closed_at=; planning_at=; assigned_at=; approval_at=; pending_release_at=;
                    pending_review_at=; resolution_time_by_bhrs=}

Return Freshservice Change by Id and include stats.

### EXAMPLE 4
```
Get-FreshServiceChange -predefined_filter my_open
```

agent_id           :
group_id           :
priority           : 1
impact             : 1
status             : 1
risk               : 1
change_type        : 1
planned_start_date : 3/25/2023 7:37:58 AM
planned_end_date   : 3/25/2023 9:37:58 AM
subject            : Fix Zero-day Vulnerability
department_id      : 21000351606
category           :
sub_category       :
item_category      :
description        : \<div\>We need to get critical patch on KB123456 installed ASAP.\</div\>
description_text   : We need to get critical patch on KB123456 installed ASAP.
id                 : 17
requester_id       : 21000418005
approval_status    : 4
change_window_id   :
created_at         : 3/25/2023 7:38:00 PM
updated_at         : 3/25/2023 7:38:00 PM
maintenance_window :
blackout_window    :
assets             : {}
impacted_services  : {}

agent_id           : 21000418005
group_id           : 21000188395
priority           : 1
impact             : 1
status             : 2
risk               : 1
change_type        : 1
planned_start_date : 2/28/2023 5:42:29 AM
planned_end_date   : 2/28/2023 7:42:29 AM
subject            : Test change from Pester
department_id      :
category           : Hardware
sub_category       : Computer
item_category      :
description        : \<div\>Test change from Pester: 82556a0b-60eb-49a9-8ce5-a4a7fb185d31\</div\>
description_text   : Test change from Pester: 82556a0b-60eb-49a9-8ce5-a4a7fb185d31
id                 : 10
requester_id       : 21000418005
approval_status    : 4
change_window_id   :
created_at         : 2/28/2023 5:42:30 PM
updated_at         : 2/28/2023 5:51:25 PM
maintenance_window :
blackout_window    :
assets             : {}
impacted_services  : {}

Return Freshservice Change by predefined filter my_open.

### EXAMPLE 5
```
Get-FreshServiceChange -updated_since (Get-Date).AddDays(-10)
```

agent_id           :
group_id           :
priority           : 1
impact             : 1
status             : 1
risk               : 1
change_type        : 1
planned_start_date : 3/25/2023 7:37:58 AM
planned_end_date   : 3/25/2023 9:37:58 AM
subject            : Fix Zero-day Vulnerability
department_id      : 21000351606
category           :
sub_category       :
item_category      :
description        : \<div\>We need to get critical patch on KB123456 installed ASAP.\</div\>
description_text   : We need to get critical patch on KB123456 installed ASAP.
id                 : 17
requester_id       : 21000418005
approval_status    : 4
change_window_id   :
created_at         : 3/25/2023 7:38:00 PM
updated_at         : 3/25/2023 7:38:00 PM
maintenance_window :
blackout_window    :
assets             : {}
impacted_services  : {}

Return Freshservice Changes updated since the last 10 days.

### EXAMPLE 6
```
Get-FreshServiceChange -Fields
```

id                   : 21000472434
created_at           : 8/29/2022 2:17:30 PM
updated_at           : 8/29/2022 2:17:30 PM
name                 : requester
label                : Requester
description          : Change requester
field_type           : default_requester
required             : True
required_for_closure : False
position             : 1
default_field        : True
choices              : {}
nested_fields        : {}

id                   : 21000472435
created_at           : 8/29/2022 2:17:30 PM
updated_at           : 8/29/2022 2:17:30 PM
name                 : subject
label                : Subject
description          : Change subject
field_type           : default_subject
required             : True
required_for_closure : False
position             : 2
default_field        : True
choices              : {}
nested_fields        : {}

id                   : 21000472436
created_at           : 8/29/2022 2:17:30 PM
updated_at           : 8/29/2022 2:17:30 PM
name                 : change_type
label                : Type
description          : Change Type
field_type           : default_change_type
required             : True
required_for_closure : False
position             : 3
default_field        : True
choices              : {@{id=1; value=Minor}, @{id=2; value=Standard}, @{id=3; value=Major}, @{id=4;
                    value=Emergency}}
nested_fields        : {}

id                   : 21000472437
created_at           : 8/29/2022 2:17:30 PM
updated_at           : 8/29/2022 2:17:30 PM
name                 : status
label                : Status
description          : Change status
field_type           : default_status
required             : True
required_for_closure : False
position             : 4
default_field        : True
choices              : {@{id=1; value=Open}, @{id=2; value=Planning}, @{id=3; value=Awaiting Approval},
                    @{id=4; value=Pending Release}...}
nested_fields        : {}

Retrieve all the Fields that constitute the Change Object.

## PARAMETERS

### -Id
Unique Id of the Change.

```yaml
Type: Int64
Parameter Sets: id
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -updated_since
Filter to return changes updated since a provided date and time.

```yaml
Type: DateTime
Parameter Sets: default
Aliases: UpdateSince

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -include
By default, stats field will not be included in the response.
They can be retrieved via the embedding functionality.

Each include will consume an additional 2 credits.
For example if you embed the stats information you will be charged a total of 3 API credits (1 credit for the API call, and 2 credits for the additional stats embedding).

```yaml
Type: String[]
Parameter Sets: default, id, predefined_filter
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -predefined_filter
Predefined filters.
The filters available are new_and_my_open, watching, spam, deleted.

```yaml
Type: String
Parameter Sets: predefined_filter
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
Allows you to view all the built-in and custom fields for Change in your Freshservice account.

```yaml
Type: SwitchParameter
Parameter Sets: Form
Aliases: Form

Required: False
Position: 1
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -per_page
Number of records to return per page during pagination. 
Maximum of 100 records.

```yaml
Type: Int32
Parameter Sets: default, predefined_filter
Aliases:

Required: False
Position: 3
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -page
The page number to retrieve during pagination.

```yaml
Type: Int32
Parameter Sets: default, predefined_filter
Aliases:

Required: False
Position: 4
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
