---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceProject

## SYNOPSIS
Returns a Freshservice Project.

## SYNTAX

### default (Default)
```
Get-FreshServiceProject [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceProject [-Id] <Int64> [<CommonParameters>]
```

### Form
```
Get-FreshServiceProject [-fields] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Project via REST API.

https://api.freshservice.com/#projects-newgen

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceProject
```

id              : 1000240162
name            : Test Api Project
key             : TAP
description     : test project from API
status_id       : 2
priority_id     : 1
sprint_duration : 14
project_type    : 1
start_date      : 2022-09-20
end_date        : 2022-09-30
archived        : False
visibility      : 1
manager_id      : 21000418005
created_at      : 9/22/2022 2:36:00 AM
updated_at      : 9/22/2022 2:36:03 AM
custom_fields   :

id              : 1000233530
name            : New application rollout (sample project)
key             : NARSP
description     :
status_id       : 1
priority_id     : 2
sprint_duration : 14
project_type    : 1
start_date      : 2022-08-28
end_date        : 2022-09-29
archived        : False
visibility      : 1
manager_id      : 21000418005
created_at      : 8/29/2022 2:17:05 PM
updated_at      : 8/29/2022 2:17:11 PM
custom_fields   :

Return all Freshservice Projects.

### EXAMPLE 2
```
Get-FreshServiceProject -id 1000240162
```

id              : 1000240162
name            : Test Api Project
key             : TAP
description     : test project from API
status_id       : 2
priority_id     : 1
sprint_duration : 14
project_type    : 1
start_date      : 2022-09-20
end_date        : 2022-09-30
archived        : False
visibility      : 1
manager_id      : 21000418005
created_at      : 9/22/2022 2:36:00 AM
updated_at      : 9/22/2022 2:36:03 AM
custom_fields   :

Return Freshservice Project by Id.

### EXAMPLE 3
```
Get-FreshServiceProject -Fields
```

label      : Name
name       : name
type       : default_name
default    : True
choices    : {}
mandatory  : True
created_at : 2022-08-29 14:17:04
updated_at : 2022-08-29 14:17:04

label      : Description
name       : description
type       : default_description
default    : True
choices    : {}
mandatory  : False
created_at : 2022-08-29 14:17:04
updated_at : 2022-08-29 14:17:04

label      : Project Manager
name       : manager_id
type       : default_manager_id
default    : True
choices    : {}
mandatory  : False
created_at : 2022-08-29 14:17:04
updated_at : 2022-08-29 14:17:04

label      : Project Key
name       : key
type       : default_key
default    : True
choices    : {}
mandatory  : True
created_at : 2022-08-29 14:17:04
updated_at : 2022-08-29 14:17:04

Return all the built-in and custom fields for Projects.

## PARAMETERS

### -Id
Unique id of the Project.

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

### -fields
View all the built-in and custom fields for Projects.

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
Parameter Sets: default
Aliases:

Required: False
Position: 3
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
Position: 4
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
