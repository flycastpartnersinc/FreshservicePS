---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Remove-FreshServiceTask

## SYNOPSIS
Delete a Freshservice Task for a Ticket, Problem, Change, or Release.

## SYNTAX

```
Remove-FreshServiceTask [-id] <Int64> [-parent_id] <Int64> [-type] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Delete a Freshservice Task for a Ticket, Problem, Change, or Release via REST API.

https://api.freshservice.com/#delete_a_ticket_task
https://api.freshservice.com/#delete_a_problem_task
https://api.freshservice.com/#delete_a_change_task
https://api.freshservice.com/#delete_a_release_task

## EXAMPLES

### EXAMPLE 1
```
Remove-FreshServiceTask -parent_id 8 -id 23 -Type Ticket
```

id parent_id type   status
-- --------- ----   ------
23         8 Ticket success 204

Delete a Freshservice Task.
Default API has no response, artificial response with id and
status containing status code is returned for tracking.

## PARAMETERS

### -id
Unique id of the Freshservice Task.

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
Parent Id of the ticket, problem, change or release to delete the task.

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

### -type
Parent object type to delete task.
Tasks can be created on Ticket, Problem, Change, or Release.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
