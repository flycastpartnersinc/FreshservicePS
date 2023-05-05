---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServiceSolutionFolder

## SYNOPSIS
Creates Freshservice solution folder.

## SYNTAX

```
Set-FreshServiceSolutionFolder [-id] <Int64> [[-name] <String>] [[-description] <String>]
 [[-category_id] <Int64>] [[-visibility] <Int32>] [[-approval_settings] <Hashtable>]
 [[-department_ids] <Int64[]>] [[-group_ids] <Int64[]>] [[-requester_group_ids] <Int64[]>]
 [[-manage_by_group_ids] <Int64[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice solution folder via REST API.

https://api.freshservice.com/#solution-folder

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceSolutionFolder -id 18000066002 -description "Shiny new folder"
```

description         : Shiny new folder
id                  : 18000066002
created_at          : 9/30/2022 2:16:32 AM
updated_at          : 9/30/2022 2:19:18 AM
name                : MyNewSolutionFolder
category_id         : 18000018546
position            : 4
visibility          : 1
approval_settings   :
default_folder      : False
manage_by_group_ids : {}

Updates a description on a Freshservice Solution folder.

## PARAMETERS

### -id
Unique ID of the folder.

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
Name of the solution folder.
The maximum number of characters allowed is 255.

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

### -description
Description of the solution folder in plain text or HTML format.

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

### -category_id
Unique id of the category under which the folder is listed.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -visibility
Accessibility of this folder

'All'             =    1
'Logged_in_Users' = 2
'Agents_Only'     = 3
'Departments'     =    4
'Agent_groups'    = 5
'Contact_groups'  = 6

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -approval_settings
Approval settings that have been associated with the folder.
Key-value pair containing the approval_type, approval_ids and its values.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -department_ids
Unique id of the department to which this solution folder is visible.
( Mandatory if visibility is set to '4')

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -group_ids
Unique id of the Agent Groups to which this solution folder is visible.
( Mandatory if visibility is set to '5')

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -requester_group_ids
Unique id of the Contact Groups to which this solution folder is visible.
( Mandatory if visibility is set to '6')

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -manage_by_group_ids
Unique ID of the Groups to which this solution folder is managed by.

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
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
