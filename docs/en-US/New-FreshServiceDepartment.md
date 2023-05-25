---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceDepartment

## SYNOPSIS
Creates a Freshservice Department.

## SYNTAX

```
New-FreshServiceDepartment [-name] <String> [[-description] <String>] [[-head_user_id] <Int64>]
 [[-prime_user_id] <Int64>] [[-domains] <String[]>] [[-custom_fields] <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice Department via REST API.

https://api.freshservice.com/#create_a_department

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceDepartment -Name "TestDeptFromApi3" -description 'Another Test dept from API call' -domains "anotherchild.acme.com" -custom_fields @{awesome=$true}
```

description   : Another Test dept from API call
custom_fields : @{address=; awesome=True; support_expires=; msp_customer=; vendor_hosted=}
id            : 18000196571
name          : TestDeptFromApi3
created_at    : 3/31/2022 12:10:50 AM
updated_at    : 3/31/2022 12:10:50 AM
prime_user_id :
head_user_id  :
domains       : {anotherchild.acme.com}

Adds a new department called TestDeptFromApi3 with email domains anotherchild.acme.com and sets a custom field "awesome"

## PARAMETERS

### -name
Name of the Department

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
Description about the department

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

### -head_user_id
Unique identifier of the agent or requester who serves as the head of the department

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

### -prime_user_id
Unique identifier of the agent or requester who serves as the prime user of the department

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

### -domains
Email domains associated with the department

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -custom_fields
Custom fields that are associated with departments

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
