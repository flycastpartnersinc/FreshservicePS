---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceContractType

## SYNOPSIS
Returns a Freshservice Contract Type.

## SYNTAX

### default (Default)
```
Get-FreshServiceContractType [-per_page <Int32>] [-page <Int32>] [<CommonParameters>]
```

### field
```
Get-FreshServiceContractType [-Id] <Int64> [-fields] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Contract Type via REST API.

https://api.freshservice.com/#list_all_contract_types

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceContractType
```

id             : 1
name           : Lease
description    :
needs_approval : False
is_default     : True
created_at     : 8/29/2022 2:17:54 PM
updated_at     : 8/29/2022 2:17:54 PM

id             : 2
name           : Maintenance
description    :
needs_approval : False
is_default     : True
created_at     : 8/29/2022 2:17:54 PM
updated_at     : 8/29/2022 2:17:54 PM

id             : 3
name           : Software License
description    :
needs_approval : False
is_default     : True
created_at     : 8/29/2022 2:17:54 PM
updated_at     : 8/29/2022 2:17:54 PM

id             : 4
name           : Warranty
description    :
needs_approval : False
is_default     : True
created_at     : 8/29/2022 2:17:54 PM
updated_at     : 8/29/2022 2:17:54 PM

Returns all Freshservice Contracts

### EXAMPLE 2
```
Get-FreshServiceContractType -id 1
```

id             : 1
name           : Lease
description    :
needs_approval : False
is_default     : True
created_at     : 8/29/2022 2:17:54 PM
updated_at     : 8/29/2022 2:17:54 PM

Return a Freshservice Contract by Id.

### EXAMPLE 3
```
Get-FreshserviceContractType -id 4 -fields
```

label              : Contract Name
name               : name
required           : True
field_type         : text
data_type          : string
visible_in_renewal : False
default_field      : True
created_at         : 8/29/2022 2:16:59 PM
updated_at         : 8/29/2022 2:16:59 PM

label              : Description
name               : description
required           : False
field_type         : paragraph
data_type          : string
visible_in_renewal : False
default_field      : True
created_at         : 8/29/2022 2:16:59 PM
updated_at         : 8/29/2022 2:16:59 PM

label              : Contract Number
name               : contract_number
required           : True
field_type         : text
data_type          : string
visible_in_renewal : False
default_field      : True
created_at         : 8/29/2022 2:16:59 PM
updated_at         : 8/29/2022 2:16:59 PM

...

Returns the fields for a specified contract type, by id.

## PARAMETERS

### -Id
Unique id of the FreshService Contract Type.

```yaml
Type: Int64
Parameter Sets: field
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
This operation allows you to view all fields of a contract type.

```yaml
Type: SwitchParameter
Parameter Sets: field
Aliases:

Required: True
Position: 2
Default value: False
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
Position: Named
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
Position: Named
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
