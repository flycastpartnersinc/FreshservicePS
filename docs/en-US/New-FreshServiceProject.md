---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceProject

## SYNOPSIS
Creates Freshservice project.

## SYNTAX

```
New-FreshServiceProject [-name] <String> [[-description] <String>] [[-key] <String>] [[-priority_id] <Int32>]
 [-project_type] <Int32> [[-manager_id] <Int64>] [[-start_date] <DateTime>] [[-end_date] <DateTime>]
 [[-visibility] <Int32>] [[-sprint_duration] <Int32>] [[-custom_fields] <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice project via REST API.

https://api.freshservice.com/#create_a_project_newgen

Note: Only users with "View or Manage Projects" privilege can access this API endpoint.

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceProject -name 'My New Project' -description 'New project to fix stuff' -project_type 1 -start_date (Get-Date)
```

id              : 1000320978
name            : My New Project
key             : MNP
description     : New project to fix stuff
status_id       : 1
priority_id     : 2
sprint_duration : 14
project_type    : 1
start_date      : 2023-04-23
end_date        : 2023-05-03
archived        : False
visibility      : 1
manager_id      : 21000418005
created_at      : 4/24/2023 4:27:39 PM
updated_at      : 4/24/2023 4:27:39 PM
custom_fields   :

Creates a new Freshservice Project.

## PARAMETERS

### -name
Name of the project.
The maximum number of characters allowed is 255.

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
Description of the project in plain text or HTML format.

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

### -key
Project Key.
The key should start with a letter followed by a combination of letters, numbers or both.
The maximum length is 10 characters.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
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
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -project_type
Type of the Project.

0 = Software
1 = Business

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -manager_id
User ID of the project manager.
The default value is of the person creating the project.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -start_date
Start date of the project.
The acceptable format is yyyy-mm-dd.
The default value is the project creation date.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -end_date
End date of the project.
The acceptable format is yyyy-mm-dd.
The default value is the project creation date + 10 days.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sprint_duration
Sprint duration in days for the project.
Default is 14.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -custom_fields
Key value pairs containing the names and values of custom fields.
Read more here.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
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
