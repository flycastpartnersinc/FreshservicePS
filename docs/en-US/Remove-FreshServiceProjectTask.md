---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Remove-FreshServiceProjectTask

## SYNOPSIS
Delete a Freshservice Project Task.

## SYNTAX

```
Remove-FreshServiceProjectTask [[-project_id] <Int64>] [[-Id] <Int64>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Delete a Freshservice Project Task via REST API.

https://api.freshservice.com/#delete_a_project_task_newgen

## EXAMPLES

### EXAMPLE 1
```
Remove-FreshServiceProjectTask -Id 1004523593 -project_id 1000320954
```

id project_id status
        -- ---------- ------
1004523593 1000320954 success 204

Delete a Freshservice Project Task.
Default API has no response, artificial response with id and
status containing status code is returned for tracking.

## PARAMETERS

### -project_id
Unique id of the Project Task.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Id
Unique id of the Freshservice Project.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: task_id

Required: False
Position: 2
Default value: 0
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
