---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceRelease

## SYNOPSIS
Returns a Freshservice release.

## SYNTAX

### default (Default)
```
Get-FreshServiceRelease [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceRelease [-Id] <Int64> [<CommonParameters>]
```

### predefined_filter
```
Get-FreshServiceRelease [[-predefined_filter] <String>] [[-per_page] <Int32>] [[-page] <Int32>]
 [<CommonParameters>]
```

### Form
```
Get-FreshServiceRelease [-fields] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice release via REST API.

By default only releases that have been created within the past 30 days will be returned.
For older releases, use the updated_since filter.

https://api.freshservice.com/#view_a_release

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceRelease
```

id                    : 2
agent_id              :
description           : \<div\>Not given.\</div\>
description_text      : Not given.
assets                : {}
group_id              :
department_id         :
subject               : Software Z-1000 v1.0
category              :
sub_category          :
item_category         :
planned_start_date    : 1/13/2023 12:00:00 AM
planned_end_date      : 1/13/2023 3:43:24 PM
status                : 1
priority              : 1
release_type          : 2
work_start_date       : 1/13/2023 12:00:00 AM
work_end_date         : 1/13/2023 3:43:24 PM
created_at            : 1/12/2023 3:43:45 PM
updated_at            : 1/12/2023 3:43:45 PM
associated_change_ids : {}

id                    : 1
agent_id              :
description           :
description_text      :
assets                : {}
group_id              :
department_id         :
subject               : Replacing Exchange Server 3 (ES3)
category              :
sub_category          :
item_category         :
planned_start_date    : 9/12/2022 2:17:34 PM
planned_end_date      : 9/12/2022 2:17:34 PM
status                : 1
priority              : 1
release_type          : 1
work_start_date       : 9/12/2022 2:17:34 PM
work_end_date         : 9/12/2022 2:17:34 PM
created_at            : 8/29/2022 2:17:34 PM
updated_at            : 8/29/2022 2:17:34 PM
associated_change_ids : {1}

Return all Freshservice Releases.

### EXAMPLE 2
```
Get-FreshServiceRelease -id 1
```

id                    : 1
agent_id              :
description           :
description_text      :
assets                : {}
group_id              :
department_id         :
subject               : Replacing Exchange Server 3 (ES3)
category              :
sub_category          :
item_category         :
planned_start_date    : 9/12/2022 2:17:34 PM
planned_end_date      : 9/12/2022 2:17:34 PM
status                : 1
priority              : 1
release_type          : 1
work_start_date       : 9/12/2022 2:17:34 PM
work_end_date         : 9/12/2022 2:17:34 PM
created_at            : 8/29/2022 2:17:34 PM
updated_at            : 8/29/2022 2:17:34 PM
associated_change_ids : {1}
custom_fields         :
planning_fields       :

Return specific Freshservice Release by Id.

### EXAMPLE 3
```
Get-FreshServiceRelease -predefined_filter unassigned
```

id                    : 4
agent_id              : 21000418005
description           : \<div\>Release from Pester: cdc12ab5-5beb-48cf-a931-e3bdfc16391f\</div\>
description_text      : Release from Pester: cdc12ab5-5beb-48cf-a931-e3bdfc16391f
assets                : {}
group_id              : 21000188395
department_id         :
subject               : Release from Pester: cdc12ab5-5beb-48cf-a931-e3bdfc16391f
category              : Hardware
sub_category          : Peripherals
item_category         : Router
planned_start_date    : 3/1/2023 1:00:00 AM
planned_end_date      : 3/1/2023 3:00:00 AM
status                : 1
priority              : 1
release_type          : 2
work_start_date       : 3/1/2023 1:00:00 AM
work_end_date         : 3/1/2023 3:00:00 AM
created_at            : 3/1/2023 3:03:45 AM
updated_at            : 3/1/2023 3:03:45 AM
associated_change_ids : {}

id                    : 2
agent_id              :
description           : \<div\>Not given.\</div\>
description_text      : Not given.
assets                : {}
group_id              :
department_id         :
subject               : Software Z-1000 v1.0
category              :
sub_category          :
item_category         :
planned_start_date    : 1/13/2023 12:00:00 AM
planned_end_date      : 1/13/2023 3:43:24 PM
status                : 1
priority              : 1
release_type          : 2
work_start_date       : 1/13/2023 12:00:00 AM
work_end_date         : 1/13/2023 3:43:24 PM
created_at            : 1/12/2023 3:43:45 PM
updated_at            : 1/12/2023 3:43:45 PM
associated_change_ids : {}

id                    : 1
agent_id              :
description           :
description_text      :
assets                : {}
group_id              :
department_id         :
subject               : Replacing Exchange Server 3 (ES3)
category              :
sub_category          :
item_category         :
planned_start_date    : 9/12/2022 2:17:34 PM
planned_end_date      : 9/12/2022 2:17:34 PM
status                : 1
priority              : 1
release_type          : 1
work_start_date       : 9/12/2022 2:17:34 PM
work_end_date         : 9/12/2022 2:17:34 PM
created_at            : 8/29/2022 2:17:34 PM
updated_at            : 8/29/2022 2:17:34 PM
associated_change_ids : {1}

Return Freshservice Releases with a predefined filter "unassigned". 
Filters available for new_and_my_open, watching, spam, deleted.

### EXAMPLE 4
```
Get-FreshServiceRelease -Fields
```

id                   : 21000472453
created_at           : 8/29/2022 2:17:33 PM
updated_at           : 8/29/2022 2:17:33 PM
name                 : subject
label                : Subject
description          : Release subject
field_type           : default_subject
required             : True
required_for_closure : False
position             : 1
default_field        : True
choices              : {}
nested_fields        : {}

id                   : 21000472454
created_at           : 8/29/2022 2:17:33 PM
updated_at           : 8/29/2022 2:17:33 PM
name                 : description
label                : Description
description          : Release description
field_type           : default_description
required             : True
required_for_closure : False
position             : 2
default_field        : True
choices              : {}
nested_fields        : {}

id                   : 21000472455
created_at           : 8/29/2022 2:17:33 PM
updated_at           : 8/29/2022 2:17:33 PM
name                 : planned_start_date
label                : Planned Start Date
description          : Planned Start Date
field_type           : default_planned_start_date
required             : True
required_for_closure : False
position             : 3
default_field        : True
choices              : {}
nested_fields        : {}

id                   : 21000472456
created_at           : 8/29/2022 2:17:33 PM
updated_at           : 8/29/2022 2:17:33 PM
name                 : planned_end_date
label                : Planned End Date
description          : Planned End Date
field_type           : default_planned_end_date
required             : True
required_for_closure : False
position             : 4
default_field        : True
choices              : {}
nested_fields        : {}

Returns all the built-in and custom fields for Releases.

## PARAMETERS

### -Id
Unique Id of the Release.

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

### -predefined_filter
Predefined filters.
The filters available are new_and_my_open, watching, spam, deleted.

```yaml
Type: String
Parameter Sets: predefined_filter
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
View all the built-in and custom fields for Releases in your Freshservice account.

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
Position: 1
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
