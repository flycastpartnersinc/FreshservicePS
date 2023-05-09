---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceProjectTask

## SYNOPSIS
Returns a Freshservice Project Task.

## SYNTAX

### default (Default)
```
Get-FreshServiceProjectTask [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### memberships
```
Get-FreshServiceProjectTask [-project_id] <Int64> [-memberships] [<CommonParameters>]
```

### sprints
```
Get-FreshServiceProjectTask [-project_id] <Int64> [-sprints] [<CommonParameters>]
```

### versions
```
Get-FreshServiceProjectTask [-project_id] <Int64> [-versions] [<CommonParameters>]
```

### task_statuses
```
Get-FreshServiceProjectTask [-project_id] <Int64> [-task_statuses] [<CommonParameters>]
```

### task_priorities
```
Get-FreshServiceProjectTask [-project_id] <Int64> [-task_priorities] [<CommonParameters>]
```

### task_types
```
Get-FreshServiceProjectTask [-project_id] <Int64> [-task_types] [<CommonParameters>]
```

### fields
```
Get-FreshServiceProjectTask [-project_id] <Int64> [-fields] [-task_type_id] <Int64> [<CommonParameters>]
```

### filter
```
Get-FreshServiceProjectTask [-project_id] <Int64> [-filter] <String> [<CommonParameters>]
```

### id
```
Get-FreshServiceProjectTask [-project_id] <Int64> [[-Id] <Int64>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Project Task via REST API.

https://api.freshservice.com/#view_a_project_task_newgen

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceProjectTask -project_id 1000251723
```

id                 : 1003442491
title              : Onboarding Kickoff Call
project_id         : 1000251723
description        :
status_id          : 1000304164
priority_id        :
created_at         : 10/31/2022 3:36:08 PM
updated_at         : 10/31/2022 3:36:08 PM
display_key        : FSD-1
planned_start_date :
type_id            : 1000602500
planned_end_date   :
reporter_id        : 21000418005
assignee_id        :
planned_effort     :
planned_duration   :
custom_fields      :
version_id         :
parent_id          :
story_points       :
sprint_id          :

Return all Freshservice Project Tasks.

### EXAMPLE 2
```
Get-FreshServiceProjectTask -project_id 1000251723 -Id 1003442491
```

id                 : 1003442491
title              : Onboarding Kickoff Call
project_id         : 1000251723
description        :
status_id          : 1000304164
priority_id        :
created_at         : 10/31/2022 3:36:08 PM
updated_at         : 10/31/2022 3:36:08 PM
display_key        : FSD-1
planned_start_date :
type_id            : 1000602500
planned_end_date   :
reporter_id        : 21000418005
assignee_id        :
planned_effort     :
planned_duration   :
custom_fields      :
version_id         :
parent_id          :
story_points       :
sprint_id          :

Return a specific Freshservice Project Task by Id.

### EXAMPLE 3
```
Get-FSProjectTask -project_id 1000251723 -task_types
```

id          : 1000602501
created_at  : 8/29/2022 2:17:04 PM
updated_at  : 8/29/2022 2:17:04 PM
name        : sub_task
description : This is the description for sub_task
project_id  : 1000251723

id          : 1000602500
created_at  : 8/29/2022 2:17:04 PM
updated_at  : 8/29/2022 2:17:04 PM
name        : task
description : This is the description for task
project_id  : 1000251723

id          : 1000602497
created_at  : 8/29/2022 2:17:04 PM
updated_at  : 8/29/2022 2:17:04 PM
name        : task_list
description : This is the description for task_list
project_id  : 1000251723

Return all Task Types on a Freshservice Project.

### EXAMPLE 4
```
Get-FreshServiceProjectTask -project_id 1000251723 -Filter "type_id:1000602500"
```

id                 : 1003442491
title              : Onboarding Kickoff Call
project_id         : 1000251723
description        :
status_id          : 1000304164
priority_id        :
created_at         : 10/31/2022 3:36:08 PM
updated_at         : 10/31/2022 3:36:08 PM
display_key        : FSD-1
planned_start_date :
type_id            : 1000602500
planned_end_date   :
reporter_id        : 21000418005
assignee_id        :
planned_effort     :
planned_duration   :
custom_fields      :
version_id         :
parent_id          :
story_points       :
sprint_id          :

Return all Project Tasks on a Freshservice Project with a filtered type id of '1000602500'.

## PARAMETERS

### -project_id
Unique id of the Project.

```yaml
Type: Int64
Parameter Sets: memberships, sprints, versions, task_statuses, task_priorities, task_types, fields, filter, id
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Unique id of the Task.

```yaml
Type: Int64
Parameter Sets: id
Aliases: task_id

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -filter
Filter Project Tasks. 
See documentation for filterable properties:

https://api.freshservice.com/#filter_all_project_tasks_newgen

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -task_types
Lists all the task types that are present in a project.

```yaml
Type: SwitchParameter
Parameter Sets: task_types
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -task_priorities
Lists all priority levels that have been created in a project.

```yaml
Type: SwitchParameter
Parameter Sets: task_priorities
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -task_statuses
Lists all the task statuses that have been defined in a project.

```yaml
Type: SwitchParameter
Parameter Sets: task_statuses
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -versions
Lists all the versions that have been created in a project.

```yaml
Type: SwitchParameter
Parameter Sets: versions
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -sprints
Lists all the sprints that have been created in a project.

```yaml
Type: SwitchParameter
Parameter Sets: sprints
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -memberships
Lists all the members that are present in a project.

```yaml
Type: SwitchParameter
Parameter Sets: memberships
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
List the fields of a specifc task type from your project.
The ID of the task type can be obtained from this API.

```yaml
Type: SwitchParameter
Parameter Sets: fields
Aliases: task_fields

Required: True
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -task_type_id
Unique id of the task type to return fields.
The task type id listed using the -task_types switch.

```yaml
Type: Int64
Parameter Sets: fields
Aliases:

Required: True
Position: 3
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
Position: 3
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
