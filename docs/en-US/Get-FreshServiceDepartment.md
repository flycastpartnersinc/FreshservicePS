---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceDepartment

## SYNOPSIS
Returns a Freshservice Department.

## SYNTAX

### default (Default)
```
Get-FreshServiceDepartment [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceDepartment [-Id] <Int64> [<CommonParameters>]
```

### ByName
```
Get-FreshServiceDepartment [-Name] <String> [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### Form
```
Get-FreshServiceDepartment [-fields] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Department via REST API.

https://api.freshservice.com/#view_a_department

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceDepartment
```

description   : Support Team
custom_fields :
id            : 21000097759
name          : Customer Support
created_at    : 8/29/2022 2:17:32 PM
updated_at    : 8/29/2022 2:17:32 PM
prime_user_id :
head_user_id  :
domains       : {}

description   : Development Team
custom_fields :
id            : 21000097757
name          : Development
created_at    : 8/29/2022 2:17:32 PM
updated_at    : 8/29/2022 2:17:32 PM
prime_user_id :
head_user_id  :
domains       : {}

description   : Finance Team
custom_fields :
id            : 21000097760
name          : Finance
created_at    : 8/29/2022 2:17:32 PM
updated_at    : 8/29/2022 2:17:32 PM
prime_user_id :
head_user_id  :
domains       : {}

Returns all Freshservice Departments.

### EXAMPLE 2
```
Get-FreshServiceDepartment -Id 21000097759
```

description   : Support Team
custom_fields :
id            : 21000097759
name          : Customer Support
created_at    : 8/29/2022 2:17:32 PM
updated_at    : 8/29/2022 2:17:32 PM
prime_user_id :
head_user_id  :
domains       : {}

Return Freshservice Department by Id.

### EXAMPLE 3
```
Get-FreshServiceDepartment -Name 'Customer Support'
```

description   : Support Team
custom_fields :
id            : 21000097759
name          : Customer Support
created_at    : 8/29/2022 2:17:32 PM
updated_at    : 8/29/2022 2:17:32 PM
prime_user_id :
head_user_id  :
domains       : {}

Return Freshservice Department By Name.

### EXAMPLE 4
```
Get-FreshServiceDepartment -Fields
```

created_at       : 2022-08-29 14:17:31
updated_at       : 2022-08-29 14:17:31
name             : name
label            : Department Name
mandatory        : True
is_default_field : True

created_at       : 2022-08-29 14:17:31
updated_at       : 2022-08-29 14:17:31
name             : description
label            : Description
mandatory        : False
is_default_field : True

created_at       : 2022-08-29 14:17:31
updated_at       : 2022-08-29 14:17:31
name             : domain_names
label            : Domains for this Department
mandatory        : False
is_default_field : True

created_at       : 2022-08-29 14:17:31
updated_at       : 2022-08-29 14:17:31
name             : head_name
label            : Department Head
mandatory        : False
is_default_field : True

created_at       : 2022-08-29 14:17:31
updated_at       : 2022-08-29 14:17:31
name             : prime_user_name
label            : Prime User
mandatory        : False
is_default_field : True

Return all the built-in and custom fields for Department.

## PARAMETERS

### -Id
Unique id of the Department.

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

### -Name
Return by Department Name.

```yaml
Type: String
Parameter Sets: ByName
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
Allows you to view all the built-in and custom fields for Department in your Freshservice account.

```yaml
Type: SwitchParameter
Parameter Sets: Form
Aliases: Form

Required: False
Position: 1
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -per_page
Number of records to return per page during pagination. 
Maximum of 100 records.

```yaml
Type: Int32
Parameter Sets: default, ByName
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
Parameter Sets: default, ByName
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
