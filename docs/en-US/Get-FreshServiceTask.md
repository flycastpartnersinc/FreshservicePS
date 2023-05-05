---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceTask

## SYNOPSIS
Returns a Freshservice Task for a Ticket, Problem, Change or Release.

## SYNTAX

```
Get-FreshServiceTask [-parent_id] <Int64> [-type] <String> [[-id] <String>] [[-per_page] <Int32>]
 [[-page] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Task for a Ticket, Problem, Change or Release via REST API.

https://api.freshservice.com/#view_a_ticket_task
https://api.freshservice.com/#view_a_problem_task
https://api.freshservice.com/#view_a_change_task
https://api.freshservice.com/#view_a_release_task

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceTask -ParentId 4 -Type Ticket
```

id            : 20
agent_id      :
status        : 1
due_date      : 11/15/2022 10:00:00 PM
notify_before : 0
title         : My ticket task
description   :
created_at    : 11/14/2022 6:34:04 PM
updated_at    : 11/14/2022 6:34:04 PM
closed_at     :
group_id      : 21000188395
deleted       : False

Get all Freshservice Tasks of a Ticket.

### EXAMPLE 2
```
Get-FreshServiceTask -parent_id 4 -type Ticket -id 20
```

id            : 20
agent_id      :
status        : 1
due_date      : 11/15/2022 10:00:00 PM
notify_before : 0
title         : My ticket task
description   :
created_at    : 11/14/2022 6:34:04 PM
updated_at    : 11/14/2022 6:34:04 PM
closed_at     :
group_id      : 21000188395
deleted       : False

Get a specific Freshservice Task on a Ticket.

## PARAMETERS

### -parent_id
Unique id of the Ticket, Problem, Change or Release.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: ParentId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
Type of container (Tickets, Problems, Changes or Releases)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
Unique id of the Task.

```yaml
Type: String
Parameter Sets: (All)
Aliases: TaskId, ChildId

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -per_page
Number of records to return per page during pagination. 
Maximum of 100 records.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -page
The page number to retrieve during pagination.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
