---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServiceRequestedItem

## SYNOPSIS
Updates Freshservice Service Request Requested Item.

## SYNTAX

```
Set-FreshServiceRequestedItem [-service_request_id] <Int64> [-id] <Int64> [[-quantity] <Int32>]
 [[-stage] <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates Freshservice Service Request Requested Item via REST API.

https://api.freshservice.com/#update_req_items_of_sr

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceRequestedItem -id 95 -id 21000277486 -quantity 1
```

id                 : 21000277486
from_date          :
to_date            :
item_id            : 2
location           :
quantity           : 1
service_request_id : 21003879652
remarks            :
is_parent          : True
fulfilled_quantity : 0
stage              : @{id=2; name=Delivered}
fulfilled          : False
cost               : 699.00
ticket_id          : 95
custom_fields      :
item               : @{id=21000487352; name=Windows Laptop; display_id=2; deleted=False; item_type=; cost_visibility=True; quantity_visibility=True; icon_detail=; ci_type=; product=; short_description=Request for a new Laptop; description=\<div class="fixture-sitem"\>Windows Laptops are the corporate
                    standard laptop for employees.
Request for a
                                                                                                        new Windows laptop.
\<div\>
                                                                                                        \<div\>PRODUCT FEATURES\</div\>
                                                                                                        \<p\>2.5 GHz Intel Core i5 Processor\</p\>
                                                                                                        \<p\>750 GB Hard Drive\</p\>
                                                                                                        \<p\>8 GB RAM\</p\>
                                                                                                        \<p\>Microsoft Windows 8\</p\>
                                                                                                        \<p\>Microsoft Office\</p\> \</div\>\</div\>}
Update the quantity requested on a Requested Item of a Service Request.

## PARAMETERS

### -service_request_id
Unique display id of the service item.

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
Unique id of the requested item.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -quantity
Number of units of the item needed by the requester.
By default it is 1

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -stage
Current stage of the requested item

1 = Requested
2 = Delivered
3 = Cancelled
4 = Fulfilled
5 = Partially Fulfilled

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
