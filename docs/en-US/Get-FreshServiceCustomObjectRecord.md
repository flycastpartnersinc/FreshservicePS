---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceCustomObjectRecord

## SYNOPSIS
Returns a Freshservice Custom Object Record.

## SYNTAX

### default (Default)
```
Get-FreshServiceCustomObjectRecord [-custom_object_id] <Int64> [[-per_page] <Int32>] [[-page] <Int32>]
 [<CommonParameters>]
```

### filter
```
Get-FreshServiceCustomObjectRecord [-custom_object_id] <Int64> [[-per_page] <Int32>] [[-page] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Custom Object Record via REST API.

https://api.freshservice.com/#list_all_custom_object_records

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceCustomObjectRecord -custom_object_id 21000011818
```

agent_group        : @{id=21000188395; value=Hardware Team}
approver           : @{id=21000418006; value=Andrea Smith \<andrea@freshservice.com\>}
bo_created_at      : 8/29/2022 2:17:58 PM
bo_created_by      : @{id=21000418007}
bo_display_id      : 2
bo_updated_at      : 8/29/2022 2:17:58 PM
bo_updated_by      : @{id=21000418007}
category_dd1       : Hardware
category_dd2       :
category_dd3       :
item_name          : @{id=21000487361; value=Apple MacBook}
vendor_information : Apple-sales@apple.com

agent_group        : @{id=21000188395; value=Hardware Team}
approver           : @{id=21000418006; value=Andrea Smith \<andrea@freshservice.com\>}
bo_created_at      : 8/29/2022 2:17:58 PM
bo_created_by      : @{id=21000418007}
bo_display_id      : 1
bo_updated_at      : 8/29/2022 2:17:58 PM
bo_updated_by      : @{id=21000418007}
category_dd1       : Hardware
category_dd2       :
category_dd3       :
item_name          : @{id=21000487352; value=Windows Laptop}
vendor_information : Microsoft - sales@microsoft.com

...

Returns all Freshservice Custom Objects.

## PARAMETERS

### -custom_object_id
Unique id of the Custom Object.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: id

Required: True
Position: 1
Default value: 0
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
Position: 5
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
Position: 6
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
