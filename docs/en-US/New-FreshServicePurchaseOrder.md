---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# New-FreshServicePurchaseOrder

## SYNOPSIS
Creates Freshservice location.

## SYNTAX

```
New-FreshServicePurchaseOrder [-vendor_id] <Int64> [-name] <String> [-po_number] <String>
 [-vendor_details] <String> [[-expected_delivery_date] <DateTime>] [-shipping_address] <String>
 [[-billing_same_as_shipping] <Boolean>] [-billing_address] <String> [-currency_code] <String>
 [[-conversion_rate] <Decimal>] [[-department_id] <Int64>] [[-discount_percentage] <Decimal>]
 [[-tax_percentage] <Decimal>] [[-shipping_cost] <Decimal>] [[-custom_fields] <Hashtable>]
 [-purchase_items] <Object> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice location via REST API.

https://api.freshservice.com/#create_a_new_purchase_order

## EXAMPLES

### EXAMPLE 1
```
Creates a new Freshservice Purchase Order.
```

$poParams = @{
    vendor_id = 18000079644
    name = 'PO From API'
    po_number = 'PO-1234'
    vendor_details = 'Vendor details'
    shipping_address = '123 Nowhere Ave'
    billing_same_as_shipping = $true
    billing_address = '123 Nowhere Ave'
    currency_code = 'USD'
    purchase_items = @{
        item_id=18000036968
        item_type = 1 #Product = 1, Software = 2
        item_name = 'Monitor'
        description = 'Monitor'
        cost = 200.00
        quantity = 1
        tax_percentage = 5
    }
}

New-FreshServicePurchaseOrder @poParams

## PARAMETERS

### -vendor_id
Unique id of the vendor with whom the order is placed.

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

### -name
Title of the purchase order.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -po_number
Unique Purchase order number.

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

### -vendor_details
Details of the vendor with whom the order is placed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -expected_delivery_date
Expected delivery date of the purchase order.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -shipping_address
Address to which the order should be shipped.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -billing_same_as_shipping
True if Billing address is same as Shipping address.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -billing_address
Address to which the order should be billed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -currency_code
Currency unit used in the transaction.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -conversion_rate
Conversion rate to convert selected currency unit to helpdesk currency.

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -department_id
Unique ID of the department.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -discount_percentage
Percentage of discount on the order.

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tax_percentage
Percentage of tax on the order.

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -shipping_cost
Total cost of shipping the order.

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -custom_fields
Any Custom field required for purchase order.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -purchase_items
Items to be ordered.
Use helper function New-FreshServicePurchaseItem.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 16
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
