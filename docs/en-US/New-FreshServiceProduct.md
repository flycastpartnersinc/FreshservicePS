---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# New-FreshServiceProduct

## SYNOPSIS
Creates Freshservice Product.

## SYNTAX

```
New-FreshServiceProduct [-name] <String> [-asset_type_id] <Int64> [[-manufacturer] <String>]
 [[-status] <String>] [[-mode_of_procurement] <String>] [[-depreciation_type_id] <Int64>]
 [[-description] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice Product via REST API.

https://api.freshservice.com/#products

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceProduct -name ProductFromAPI -description 'A product from the API' -asset_type_id 21000855284 -manufacturer 'Other' -status 'In Production' -mode_of_procurement Buy
```

id                   : 21000194694
created_at           : 4/12/2023 3:09:14 AM
updated_at           : 4/12/2023 3:09:14 AM
name                 : ProductFromAPI
manufacturer         : Other
asset_type_id        : 21000855284
description          : \<div\>A product from the API\</div\>
description_text     : A product from the API
depreciation_type_id :
status               : In Production
mode_of_procurement  : Buy

Creates a new Freshservice Product.

## PARAMETERS

### -name
Name of the Product.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -asset_type_id
Unique id of the asset type(must be a type in Freshservice).

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -manufacturer
Manufacturer of the product

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -status
Status of the product.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mode_of_procurement
Mode of procurement of the product.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -depreciation_type_id
Unique id of the depreciation type.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -description
HTML Content of the product.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
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
