---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Remove-FreshServiceSolutionCategory

## SYNOPSIS
Delete a Freshservice Solution Category.

## SYNTAX

```
Remove-FreshServiceSolutionCategory [-id] <Int64> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Delete a Freshservice Solution Category via REST API.

https://api.freshservice.com/#delete_solution_category

## EXAMPLES

### EXAMPLE 1
```
Delete a Freshservice Solution Category. Default API has no response, artificial response with id and
status containing status code is returned for tracking.
```

Remove-FreshServiceSolutionCategory -id 18000040164

id status
-- ------
18000040164 success

## PARAMETERS

### -id
Unique Id of the Solution Category.

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
