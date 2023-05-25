---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceProjectTask

## SYNOPSIS
Creates Freshservice Project Task.

## SYNTAX

```
New-FreshServiceProjectTask [-project_id] <Int64> [[-title] <String>] [[-description] <String>]
 [[-type_id] <Int64>] [[-reporter_id] <Int64>] [[-assignee_id] <Int64>] [[-planned_start_date] <DateTime>]
 [[-planned_end_date] <DateTime>] [[-planned_effort] <String>] [[-planned_duration] <String>]
 [[-status_id] <Int64>] [[-priority_id] <Int64>] [[-parent_id] <Int64>] [[-story_points] <Int64>]
 [[-sprint_id] <Int64>] [[-version_id] <Int64>] [[-custom_fields] <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice Project Task via REST API.

https://api.freshservice.com/#create_a_project_task_newgen

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceProjectTask -title "My New Task" -description "Stuff to do" -type_id 1000602500 -project_id 1000320954 -planned_start_date (Get-Date).AddDays(1)
```

id                 : 1004523593
title              : My New Task
project_id         : 1000320954
description        : \<p\>Stuff to do\</p\>
status_id          : 1000304164
priority_id        :
created_at         : 4/24/2023 3:50:02 PM
updated_at         : 4/24/2023 3:50:02 PM
display_key        : P667977-2
planned_start_date : 4/25/2023 3:50:02 AM
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

Create a new Freshservice Project Task.

## PARAMETERS

### -project_id
Unique identifier of the project.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -title
Name of the task.

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

### -description
Description of the task in plain text or HTML format.

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

### -type_id
The type of task to be created .
Examples of task types are epic, user story, etc.
The id can be obtained from here.

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

### -reporter_id
User ID of the person who reported the task.
The default value is of the person creating the task.

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

### -assignee_id
User ID of the person to whom the task is to be assigned.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -planned_start_date
Planned start date of the task.
The acceptable format is yyyy-mm-ddThh:mm:ssZ.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -planned_end_date
Planned end date of the task.
The acceptable format is yyyy-mm-ddThh:mm:ssZ.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -planned_effort
Planned effort of the task.
The acceptable format is '1w 2d 3h 4m'.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -planned_duration
Planned duration of the task.
It is the difference between the planned end and start dates.
The acceptable format is '1w 2d 3h 4m'.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status_id
Status of the task.
The id can be obtained from here.
The default status is "Open".

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -priority_id
Priority of the task.
The id can be obtained from here.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -parent_id
Unique id of the parent task (if this field is applicable).
In the case of subtasks, it is the ID of the parent task it is a part of.
In the case of standard tasks, it is the ID of the Epic/Task_List it is a part of.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -story_points
Story Points of the task (if this field is applicable).

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sprint_id
Unique id of the sprint this task should be a part of (if this field is applicable).
It can be obtained from here.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -version_id
Unique id of the version this task is a part of (if this field is applicable).
It can be obtained from here.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -custom_fields
Key value pairs containing the names and values of custom fields.
Read more here.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
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
