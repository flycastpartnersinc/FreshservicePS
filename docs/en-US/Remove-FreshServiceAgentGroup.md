---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Remove-FreshServiceAgentGroup

## SYNOPSIS
Delete Freshservice Agent group.

## SYNTAX

```
Remove-FreshServiceAgentGroup [-id] <Int64> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Delete Freshservice Agent Group via REST API.

1.
Deleting a Group will only disband the group and not delete its members.
2.
Deleted groups cannot be restored.
3.
When deleting a group, agents who have their only role in this group being deleted will be rescoped
    to the "assigned_items" scope from "specified_groups" for this role.

https://api.freshservice.com/#delete_a_group

## EXAMPLES

### EXAMPLE 1
```
Remove-FreshServiceAgentGroup -id 21000546879
```

id status
-- ------
21000546879 success 204

Delete and Agent Group.
Default API has no response, artificial response with id and status containing
status code is returned for tracking.

## PARAMETERS

### -id
Unique id of the Agent Group.

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
