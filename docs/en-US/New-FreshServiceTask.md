---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceTask

## SYNOPSIS
Creates Freshservice Task.

## SYNTAX

```
New-FreshServiceTask [-parent_id] <Int64> [[-agent_id] <Int64>] [[-status] <Int32>] [[-due_date] <DateTime>]
 [[-notify_before] <Int32>] [[-title] <String>] [[-description] <String>] [[-group_id] <Int64>]
 [[-type] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice Task via REST API for Tickets, Problems, Changes and Releases.

https://api.freshservice.com/#create_ticket_task
https://api.freshservice.com/#create_problem_task
https://api.freshservice.com/#create_change_task
https://api.freshservice.com/#create_release_task

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceTask -ParentId 8 -Type Ticket -status 1 -due_date (Get-Date).AddDays(3) -title 'My Ticket Task' -description 'Do some stuff'
```

id            : 22
agent_id      :
status        : 1
due_date      : 1/2/2023 2:44:19 PM
notify_before : 0
title         : My Ticket Task
description   : Do some stuff
created_at    : 12/30/2022 2:44:19 PM
updated_at    : 12/30/2022 2:44:19 PM
closed_at     :
group_id      :
deleted       : False

Creates a Freshservice ticket task.

## PARAMETERS

### -parent_id
Parent Id of the ticket, problem, change or release to create the task.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: ParentId

Required: True
Position: 1
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
Position: 2
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
Position: 3
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
Position: 4
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
Position: 5
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
Position: 6
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
Position: 7
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
Position: 8
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

Required: False
Position: 9
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
