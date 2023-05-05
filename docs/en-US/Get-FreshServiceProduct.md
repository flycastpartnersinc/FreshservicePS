---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceProduct

## SYNOPSIS
Returns a Freshservice Product.

## SYNTAX

### default (Default)
```
Get-FreshServiceProduct [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceProduct [-Id] <Int64> [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Product via REST API.

https://api.freshservice.com/#view_a_product

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceProduct
```

id                   : 21000056898
name                 : Apple MacBook Air 13
asset_type_id        : 21000855304
manufacturer         : Apple
status               : In Production
mode_of_procurement  : Both
depreciation_type_id :
description          : \<div\>Not given.\</div\>
description_text     : Not given.
created_at           : 8/29/2022 2:17:47 PM
updated_at           : 8/29/2022 2:17:47 PM

id                   : 21000056899
name                 : Dell 22-inch Monitor
asset_type_id        : 21000855276
manufacturer         : Dell
status               : In Production
mode_of_procurement  : Both
depreciation_type_id :
description          : \<div\>Not given.\</div\>
description_text     : Not given.
created_at           : 8/29/2022 2:17:47 PM
updated_at           : 8/29/2022 2:17:47 PM

id                   : 21000056900
name                 : Logitech M705 Wireless Mouse
asset_type_id        : 21000855268
manufacturer         : Logitech
status               : In Production
mode_of_procurement  : Both
depreciation_type_id :
description          : \<div\>Not given.\</div\>
description_text     : Not given.
created_at           : 8/29/2022 2:17:47 PM
updated_at           : 8/29/2022 2:17:47 PM

Returns all Freshservice Products.

### EXAMPLE 2
```
Get-FreshServiceProduct -Id 21000056899
```

id                   : 21000056899
name                 : Dell 22-inch Monitor
asset_type_id        : 21000855276
manufacturer         : Dell
status               : In Production
mode_of_procurement  : Both
depreciation_type_id :
description          : \<div\>Not given.\</div\>
description_text     : Not given.
created_at           : 8/29/2022 2:17:47 PM
updated_at           : 8/29/2022 2:17:47 PM

Returns a Freshservice Product by Id.

## PARAMETERS

### -Id
Unique id of the Product.

```yaml
Type: Int64
Parameter Sets: id
Aliases:

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
Parameter Sets: default
Aliases:

Required: False
Position: 3
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -page
The page number to retrieve during pagination.

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 4
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
