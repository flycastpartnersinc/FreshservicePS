---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceCustomObjectRecord

## SYNOPSIS
Returns a Freshservice Custom Object Record.

## SYNTAX

```
New-FreshServiceCustomObjectRecord [-custom_object_id] <Int64> [-data] <Hashtable> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Custom Object Record via REST API.

https://api.freshservice.com/#create_custom_object_record

## EXAMPLES

### EXAMPLE 1
```
$params = @{
    custom_object_id = 21000011818
    data = @{
        agent_group        = 21000188390
        approver           = 21000418009
        category_dd1       = 'Hardware'
        item_name          = 21000487364
        vendor_information = 'sales@dell.com'
    }
}
```

New-FreshServiceCustomObjectRecord @params

Create a new Custom Object Record.

## PARAMETERS

### -custom_object_id
Unique id of the Custom Object

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: id

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -data
Hashtable with data to be inserted as Custom Object Record.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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
