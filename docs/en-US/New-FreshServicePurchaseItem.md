---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServicePurchaseItem

## SYNOPSIS
Helper function to create purchase item for New-FreshServicePurchaseOrder and Set-FreshServicePurchaseOrder.

## SYNTAX

```
New-FreshServicePurchaseItem [-item_id] <Int64> [-item_type] <Int32> [-item_name] <String>
 [[-description] <String>] [-cost] <Decimal> [-quantity] <Int32> [-tax_percentage] <Decimal> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Helper function to create purchase item for New-FreshServicePurchaseOrder and Set-FreshServicePurchaseOrder.
A
purchase order (PO) is an official document issued by a buyer to a seller indicating
the types, quantities, and agreed prices for products or services.

See: https://api.freshservice.com/#purchase-order

## EXAMPLES

### EXAMPLE 1
```
New-FreshServicePurchaseItem -item_id 21000056899 -item_type 1 -item_name "Dell 22-inch Monitor" -description 'Dell 22-inch Monitor Model DELLMON22-2023' -cost 200.00 -quantity 2 -tax_percentage 5
```

item_name      : Dell 22-inch Monitor
item_id        : 21000056899
description    : Dell 22-inch Monitor Model DELLMON22-2023
cost           : 200
quantity       : 2
item_type      : 1
tax_percentage : 5

Creates a new Freshservice purchase item for a Dell 22-inch Monitor. 
Item id references the Product Id of a Freshservice Product.

## PARAMETERS

### -item_id
Product id of the item to be ordered.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: product_id

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -item_type
Type of item to be ordered.
Product = 1 or Software = 2

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -item_name
Name of the items to be ordered.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
Item description.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -cost
Cost of the item.

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -quantity
Quantity of item to be ordered.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tax_percentage
Percentage of tax on item cost.

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
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
