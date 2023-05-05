---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServiceProduct

## SYNOPSIS
Updates a Freshservice Product.

## SYNTAX

```
Set-FreshServiceProduct [-id] <Int64> [[-name] <String>] [[-asset_type_id] <Int64>] [[-manufacturer] <String>]
 [[-status] <String>] [[-mode_of_procurement] <String>] [[-depreciation_type_id] <Int64>]
 [[-description] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Product via REST API.

https://api.freshservice.com/#update_a_product

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceProduct -id 21000188679 -description '[RETIRED] Exploded in Flames' -status Retired
```

id                   : 21000188679
created_at           : 3/15/2023 9:29:01 PM
updated_at           : 3/31/2023 12:13:44 AM
name                 : Dell PowerConnect 2808 c328350a-2ead-4600-889e-d91f43bd5c77
manufacturer         : 21000085372
asset_type_id        : 21000855304
description          : \[RETIRED\] Exploded in Flames
description_text     : \[RETIRED\] Exploded in Flames
depreciation_type_id :
status               : Retired
mode_of_procurement  : Buy

Updates the description and status of a Freshservice Product.

## PARAMETERS

### -id
Unique ID of the product.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
Name of the Product.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -asset_type_id
Unique id of the asset type (must be a type in Freshservice).

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -status
Status of the product (In Production, In Pipeline, or Retired).

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

### -mode_of_procurement
Mode of procurement of the product.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
Position: 7
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
Position: 8
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
