---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServicePurchaseOrder

## SYNOPSIS
Updates a Freshservice Purchase Order.

## SYNTAX

```
Set-FreshServicePurchaseOrder [-id] <Int64> [[-vendor_id] <Int64>] [[-name] <String>] [[-po_number] <String>]
 [[-vendor_details] <String>] [[-expected_delivery_date] <DateTime>] [[-shipping_address] <String>]
 [[-billing_same_as_shipping] <Boolean>] [[-billing_address] <String>] [[-currency_code] <String>]
 [[-conversion_rate] <Decimal>] [[-department_id] <Int64>] [[-discount_percentage] <Decimal>]
 [[-tax_percentage] <Decimal>] [[-shipping_cost] <Decimal>] [[-custom_fields] <Hashtable>]
 [[-purchase_items] <Object[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Purchase Order via REST API.

https://api.freshservice.com/#_update_a_purchase_order

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServicePurchaseOrder -id 4 -shipping_address '123 North Pole'
```

id                       : 4
name                     : PO From API
po_number                : PO-2222
vendor_id                : 21000085372
vendor_details           : Vendor details
department_id            :
created_by               : 21000418005
expected_delivery_date   :
shipping_address         : 123 North Pole
billing_same_as_shipping : True
billing_address          : 123 North Pole
created_at               : 2/11/2023 6:50:15 PM
updated_at               : 2/11/2023 6:50:43 PM
custom_fields            : @{terms_and_conditions=}
status                   : 20
purchase_items           : {@{item_type=1; item_name=Monitor; id=21000070017; item_id=21000056899;
                        description=Monitor; cost=200; quantity=1; received=0; tax_percentage=5;
                        total_cost=210; created_at=2/11/2023 6:50:15 PM; updated_at=2/11/2023 6:50:15 PM}}
discount_percentage      :
tax_percentage           :
shipping_cost            :
total_cost               : 210
currency                 : @{id=USD; conversion_rate=; symbol=$; name=Dollar ($); currency_country=; separator=.}

Updates the address of a Purchase Order.

## PARAMETERS

### -id
Unique Id of the Purchase Order.

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

### -vendor_id
Unique id of the vendor with whom the order is placed.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
Title of the purchase order.

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

### -po_number
Unique Purchase order number.

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

### -vendor_details
Details of the vendor with whom the order is placed.

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

### -expected_delivery_date
Expected delivery date of the purchase order.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -shipping_address
Address to which the order should be shipped.

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

### -billing_same_as_shipping
True if Billing address is same as Shipping address.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -billing_address
Address to which the order should be billed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -currency_code
Currency unit used in the transaction.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -conversion_rate
Conversion rate to convert selected currency unit to helpdesk currency.

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -department_id
Unique ID of the department.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -discount_percentage
Percentage of discount on the order.

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -tax_percentage
Percentage of tax on the order.

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -shipping_cost
Total cost of shipping the order.

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -custom_fields
Any Custom field required for purchase order.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -purchase_items
Items to be ordered.
Use helper function New-FreshServicePurchaseItem.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
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
