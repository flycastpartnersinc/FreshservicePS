---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Remove-FreshServiceCustomObjectRecord

## SYNOPSIS
Delete a Freshservice Custom Object Record.

## SYNTAX

```
Remove-FreshServiceCustomObjectRecord [-custom_object_id] <Int64> [-id] <Int64> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Delete a Freshservice Custom Object Record via REST API.

https://api.freshservice.com/#delete_custom_object_record

## EXAMPLES

### EXAMPLE 1
```
Remove-FreshServiceCustomObjectRecord -custom_object_id 21000011818 -id 6
```

id status
-- ------
6 success 202

Delete a Freshservice Custom Object Record (i.e.
6) from a Custom Object (i.e.
21000011818).
Default API
has no response, artificial response with id and status containing status code is returned for tracking.

## PARAMETERS

### -custom_object_id
Unique ID of the Custom Object.

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

### -id
Unique id of the Freshservice Custom Object Record.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: record_id

Required: True
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
