---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# New-FreshServiceContractItem

## SYNOPSIS
Helper function to create item cost detail (e.g.
item_cost_details) for New-FreshServiceContract and Set-FreshServiceContract.

## SYNTAX

```
New-FreshServiceContractItem [-item_name] <String> [[-pricing_model] <String>] [[-cost] <Decimal>]
 [[-count] <Int32>] [[-comments] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Helper function to create item cost detail (e.g.
item_cost_details) for New-FreshServiceContract and Set-FreshServiceContract.

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceContractItem -item_name License -pricing_model per_unit -cost 18.44 -count 350 -comments 'Per user licensing costs'
```

item_name     : License
comments      : Per user licensing costs
pricing_model : per_unit
count         : 350
cost          : 18.44

Creates a Freshservice Contract Item.

## PARAMETERS

### -item_name
Name of the particular line item.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pricing_model
Represents the pricing unit of a particular line item.
Values are per_unit, fixed, one_time.
The default value is "per_unit".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -cost
Represents the cost of a particular line item.

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -count
Represents the number of units of a particular line item

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -comments
To add any additional comments for a particular line item.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
