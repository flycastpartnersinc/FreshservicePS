---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Set-FreshServiceCustomObjectRecord

## SYNOPSIS
Updates a Freshservice Custom Object Record.

## SYNTAX

```
Set-FreshServiceCustomObjectRecord [-custom_object_id] <Int64> [-id] <Int64> [-data] <Hashtable> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Custom Object Record via REST API.

https://api.freshservice.com/#put_custom_object_record

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceCustomObjectRecord -custom_object_id 21000011818 -id 4 -data @{vendor_information='sales@dell.com'}
```

agent_group        : 21000188390
approver           : 21000418009
bo_created_at      : 8/29/2022 2:17:58 PM
bo_created_by      : 21000418007
bo_display_id      : 4
bo_updated_at      : 3/30/2023 7:41:23 PM
bo_updated_by      : 21000418005
category_dd1       : Software
category_dd2       :
category_dd3       :
item_name          : 21000487354
vendor_information : sales@dell.com

Updates a FreshService Custom Object Record.
The data is passed as a hashtable. 
Any dropdown lookups on Freshservice objects are the object id of the selected item.

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
Unique ID of the Custom Object Record.

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

### -data
Hashtable containing the data to update on Custom Object Record.

```yaml
Type: Hashtable
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
