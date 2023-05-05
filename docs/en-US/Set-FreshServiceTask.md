---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServiceTask

## SYNOPSIS
Updates a Freshservice Ticket Task on a Ticket, Problem, Change or Release.

## SYNTAX

```
Set-FreshServiceTask [-id] <Int64> [-parent_id] <Int64> [[-agent_id] <Int64>] [[-status] <Int32>]
 [[-due_date] <DateTime>] [[-notify_before] <Int32>] [[-title] <String>] [[-description] <String>]
 [[-group_id] <Int64>] [-type] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Ticket Task on a Ticket, Problem, Change or Release via REST API.

https://api.freshservice.com/#update_a_ticket_task
https://api.freshservice.com/#update_a_problem_task
https://api.freshservice.com/#update_a_change_task
https://api.freshservice.com/#update_a_release_task

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceTask -parent_id 8 -id 21 -Type Ticket -description "Update my description"
```

id            : 21
agent_id      :
status        : 1
due_date      : 1/2/2023 2:43:45 PM
notify_before : 0
title         : My Ticket Task
description   : Update my description
created_at    : 12/30/2022 2:43:45 PM
updated_at    : 1/3/2023 6:10:07 PM
closed_at     :
group_id      :
deleted       : False

Update a description on a Freshservice Task on a Freshservice Ticket.

## PARAMETERS

### -id
Unique id of the Task.

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

### -parent_id
Unique id of the parent Ticket, Problem, Change or Release.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: ParentId

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -agent_id
Unique id of the agent to whom the task is assigned.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status
Status of the task:

1 = Open
2 = In Progress
3 = Completed

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -due_date
Due date of the task.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -notify_before
Time in seconds before which notification is sent prior to due date.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -title
Title of the task

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
Description of the task

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -group_id
Unique ID of the group to which the task is assigned

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type
Parent object type to create task. 
Tasks can be created on Ticket, Problem, Change, or Release.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 10
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
