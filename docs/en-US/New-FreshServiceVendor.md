---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceVendor

## SYNOPSIS
Creates a new Freshservice Vendor.

## SYNTAX

```
New-FreshServiceVendor [-name] <String> [[-description] <String>] [[-primary_contact_id] <Int64>]
 [[-address] <Hashtable>] [[-custom_fields] <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new Freshservice Vendor via REST API.

https://api.freshservice.com/#create_a_vendor

## EXAMPLES

### EXAMPLE 1
```
$venParams = @{
    name = MyNewVendor
    description = "My vendor description"
    address = @{
        line1 = "123 Corporate Avenue"
        city = "Jacksonville"
        state = "Florida"
        country = "USA"
        zipcode = "32217"
    }
}
```

New-FreshServiceVendor @venParams

Creates a new Freshservice Vendor.

## PARAMETERS

### -name
Name of the vendor.

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

### -description
Description of the vendor.

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

### -primary_contact_id
User ID of the primary contact (must be a user in Freshservice)

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

### -address
Key-value pair containing the names and values of the address fields with line1, city, state, country and zip code properties.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -custom_fields
Key-value pair containing the names and values of the (custom) vendor fields.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
