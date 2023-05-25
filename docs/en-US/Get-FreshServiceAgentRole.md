---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceAgentRole

## SYNOPSIS
Returns a Freshservice Agent Role.

## SYNTAX

### default (Default)
```
Get-FreshServiceAgentRole [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceAgentRole [-Id] <Int64> [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Agent Role via REST API.

https://api.freshservice.com/#view_a_role

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceAgentRole
```

description : Has complete control over the help desk including access to Account or Billing related information, and
            receives Invoices.
id          : 21000150292
name        : Account Admin
created_at  : 8/29/2022 2:16:59 PM
updated_at  : 9/29/2022 10:19:47 AM
default     : True
scopes      : @{ticket=; problem=; change=; release=; asset=; solution=; contract=}

description : Can configure all features through the Admin tab, but is restricted from viewing Account or Billing
            related information.
id          : 21000150293
name        : Admin
created_at  : 8/29/2022 2:16:59 PM
updated_at  : 9/29/2022 10:19:47 AM
default     : True
scopes      : @{ticket=; problem=; change=; release=; asset=; solution=; contract=}

Returns all Freshservice Agent Roles.

### EXAMPLE 2
```
Get-FreshServiceAgentRole -Id 21000150293
```

description : Can configure all features through the Admin tab, but is restricted from viewing Account or Billing
            related information.
id          : 21000150293
name        : Admin
created_at  : 8/29/2022 2:16:59 PM
updated_at  : 9/29/2022 10:19:47 AM
default     : True
scopes      : @{ticket=; problem=; change=; release=; asset=; solution=; contract=}

Returns a Freshservice Agent Role by Id.

## PARAMETERS

### -Id
Unique id of the agent role.

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
Position: 1
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
Position: 2
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
