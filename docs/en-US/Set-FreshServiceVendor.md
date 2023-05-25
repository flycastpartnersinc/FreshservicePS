---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Set-FreshServiceVendor

## SYNOPSIS
Updates a Freshservice Vendor.

## SYNTAX

```
Set-FreshServiceVendor [-id] <String> [[-name] <String>] [[-description] <String>]
 [[-primary_contact_id] <Int64>] [[-address] <Hashtable>] [[-custom_fields] <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Vendor via REST API.

https://api.freshservice.com/#update_a_vendor

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceVendor -id 21000085371 -description 'Apple Inc.'
```

address            : @{line1=1 Infinite Loop; city=Cupertino; state=California; country=United States;
                    zipcode=95014}
id                 : 21000085371
name               : Apple
description        : Apple Inc.
contact_name       :
email              :
mobile             :
phone              :
primary_contact_id :
custom_fields      :
created_at         : 8/29/2022 2:17:31 PM
updated_at         : 3/31/2023 2:26:24 AM

Updates a description on a Freshservice Vendor.

## PARAMETERS

### -id
Unique ID of the vendor.

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

### -name
Name of the vendor.

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

### -description
Description of the vendor.

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

### -primary_contact_id
User ID of the primary contact (must be a user in Freshservice).

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
Position: 5
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
Position: 6
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
