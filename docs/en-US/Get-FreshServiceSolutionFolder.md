---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceSolutionFolder

## SYNOPSIS
Returns a Freshservice Solution Folder..

## SYNTAX

### default (Default)
```
Get-FreshServiceSolutionFolder [-category_id] <Int64> [[-per_page] <Int32>] [[-page] <Int32>]
 [<CommonParameters>]
```

### Id
```
Get-FreshServiceSolutionFolder [-Id] <Int64> [-category_id] <Int64> [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Solution Folder via REST API.

https://api.freshservice.com/#view_solution_folder

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceSolutionFolder -category_id 18000018546
```

description         : Default solution folder, feel free to edit or delete it.
id                  : 18000028049
created_at          : 3/16/2021 9:24:31 PM
updated_at          : 3/16/2021 9:24:31 PM
name                : FAQ
category_id         : 18000018546
position            : 1
visibility          : 1
approval_settings   :
default_folder      : False
manage_by_group_ids : {}

description         : Default solution folder, feel free to edit or delete it.
id                  : 18000028050
created_at          : 3/16/2021 9:24:31 PM
updated_at          : 3/16/2021 9:24:31 PM
name                : Getting Started
category_id         : 18000018546
position            : 2
visibility          : 1
approval_settings   :
default_folder      : False
manage_by_group_ids : {}

description         : Folder desc from API
id                  : 18000066001
created_at          : 9/30/2022 1:42:30 AM
updated_at          : 9/30/2022 2:05:15 AM
name                : FolderFromAPI
category_id         : 18000018546
position            : 3
visibility          : 1
approval_settings   :
default_folder      : False
manage_by_group_ids : {}

description         : Folder desc from API
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

Get all Freshservice Solution Folders by Category.

### EXAMPLE 2
```
Get-FreshServiceSolutionFolder -id 18000066002
```

description         : Folder desc from API
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

Get a Freshservice Solution Folder with id.

## PARAMETERS

### -Id
Unique Id of the Solution Folder.

```yaml
Type: Int64
Parameter Sets: Id
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -category_id
Unique category of the Solution Folder to return.

```yaml
Type: Int64
Parameter Sets: (All)
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
