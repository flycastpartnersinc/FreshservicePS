---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Set-FreshServiceProject

## SYNOPSIS
Updates a Freshservice Project.

## SYNTAX

### default (Default)
```
Set-FreshServiceProject [-id] <Int64> [[-name] <String>] [[-description] <String>] [[-key] <String>]
 [[-status_id] <Int32>] [[-priority_id] <Int32>] [[-manager_id] <Int64>] [[-start_date] <DateTime>]
 [[-end_date] <DateTime>] [[-visibility] <Int32>] [[-sprint_duration] <Int32>] [[-custom_fields] <Hashtable>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Archive
```
Set-FreshServiceProject [-id] <Int64> [-Archive] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Project via REST API.

https://api.freshservice.com/#create_a_project_newgen

Only users with "View or Manage Projects" privilege can access this API endpoint.

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceProject -id 1000320954 -priority 3
```

id              : 1000320954
name            : Project 1e49df30-7850-4a5b-a9b0-aefafdac192b
key             : P667977
description     : Project 1e49df30-7850-4a5b-a9b0-aefafdac192b
status_id       : 2
priority_id     : 3
sprint_duration : 14
project_type    : 1
start_date      : 2023-04-23
end_date        : 2023-05-03
archived        : False
visibility      : 1
manager_id      : 21000418005
created_at      : 4/24/2023 3:47:13 PM
updated_at      : 4/24/2023 3:47:16 PM
custom_fields   :

Update a Freshservice Project status.

## PARAMETERS

### -id
Unique identifier of the project.

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

### -name
Name of the project.
The maximum number of characters allowed is 255.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
Description of the project in plain text or HTML format.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -key
Project Key.
The key should start with a letter followed by a combination
of letters, numbers or both.
The maximum length is 10 characters.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status_id
Status of the project.

1 = Yet to Start
2 = In Progress
3 = Completed

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -priority_id
Priority of the project.
Default is Medium (2).

1 = Low
2 = Medium
3 = High
4 = Urgent

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -manager_id
User ID of the project manager.

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -start_date
Start date of the project.
The acceptable format is yyyy-mm-dd.

```yaml
Type: DateTime
Parameter Sets: default
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -end_date
End date of the project.
The acceptable format is yyyy-mm-dd.

```yaml
Type: DateTime
Parameter Sets: default
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -visibility
Visibility of the project.
Default is Public (1).

0 = Private
1 = Public

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 10
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sprint_duration
Sprint duration in days for the project.
Default is 14.

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -custom_fields
Key value pairs containing the names and values of custom fields.

```yaml
Type: Hashtable
Parameter Sets: default
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Archive
Archive the project.

```yaml
Type: SwitchParameter
Parameter Sets: Archive
Aliases:

Required: False
Position: 2
Default value: False
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
