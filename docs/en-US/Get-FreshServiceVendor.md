---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceVendor

## SYNOPSIS
Returns a Freshservice Vendor.

## SYNTAX

### default (Default)
```
Get-FreshServiceVendor [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceVendor [-Id] <Int64> [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Vendor via REST API.

https://api.freshservice.com/#view_a_vendor

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceVendor
```

address            : @{line1=1 Infinite Loop; city=Cupertino; state=California; country=United States; zipcode=95014}
id                 : 21000085371
name               : Apple
description        :
contact_name       :
email              :
mobile             :
phone              :
primary_contact_id :
custom_fields      :
created_at         : 8/29/2022 2:17:31 PM
updated_at         : 8/29/2022 2:17:31 PM

address            : @{line1=1 Dell Way; city=Round Rock; state=Texas; country=United States; zipcode=78664}
id                 : 21000085372
name               : Dell
description        :
contact_name       :
email              :
mobile             :
phone              :
primary_contact_id :
custom_fields      :
created_at         : 8/29/2022 2:17:31 PM
updated_at         : 8/29/2022 2:17:31 PM

address            : @{line1=2950 S Delaware St Suite 201; city=San Mateo; state=California; country=United States; zipcode=94401}
id                 : 21000085374
name               : Freshworks
description        :
contact_name       :
email              :
mobile             :
phone              :
primary_contact_id :
custom_fields      :
created_at         : 8/29/2022 2:17:31 PM
updated_at         : 8/29/2022 2:17:31 PM

Get all Freshservice Vendors.

### EXAMPLE 2
```
Get-FreshServiceVendor -Id 21000085375
```

address            : @{line1=; city=; state=; country=; zipcode=}
id                 : 21000085375
name               : Microsoft
description        :
contact_name       :
email              :
mobile             :
phone              :
primary_contact_id :
custom_fields      :
created_at         : 8/29/2022 2:17:31 PM
updated_at         : 8/29/2022 2:17:31 PM

Get FreshService Vendor by Id.

## PARAMETERS

### -Id
Unique id of the Vendor.

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
Position: 2
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
Position: 3
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
