---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceCatalogCategory

## SYNOPSIS
Returns a Freshservice Service Catalog Category.

## SYNTAX

### default (Default)
```
Get-FreshServiceCatalogCategory [[-workspace_id] <Int32[]>] [[-per_page] <Int32>] [[-page] <Int32>]
 [<CommonParameters>]
```

### Id
```
Get-FreshServiceCatalogCategory [[-Id] <Int64>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Service Catalog Category via REST API.

https://api.freshservice.com/#list_all_service_categories

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceCatalogCategory
```

description :
id          : 21000104299
created_at  : 8/29/2022 2:17:48 PM
updated_at  : 8/29/2022 2:17:48 PM
name        : Hardware Provisioning
position    : 1

description :
id          : 21000104300
created_at  : 8/29/2022 2:17:48 PM
updated_at  : 8/29/2022 2:17:48 PM
name        : Software Installation
position    : 2

description :
id          : 21000104301
created_at  : 8/29/2022 2:17:48 PM
updated_at  : 8/29/2022 2:17:48 PM
name        : HR Management
position    : 3

description :
id          : 21000104302
created_at  : 8/29/2022 2:17:48 PM
updated_at  : 8/29/2022 2:17:48 PM
name        : Data Services
position    : 4

Returns all Freshservice Catalog Categories.

### EXAMPLE 2
```
Get-FreshServiceCatalogCategory -id 21000104303
```

description :
id          : 21000104303
created_at  : 8/29/2022 2:17:48 PM
updated_at  : 8/29/2022 2:17:48 PM
name        : Application Access
position    : 5

Returns a Freshservice Catalog Category by Id.

## PARAMETERS

### -Id
Unique id of the Service Catalog Category.

```yaml
Type: Int64
Parameter Sets: Id
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -workspace_id
Workspace id filter is applicable only for accounts with Workspaces feature enabled. Providing a Workspace_id will return tickets from a specific workspace.

If the workspace_id(s) parameter is NOT provided, data will only be returned for the Default\Primary Workspace.
If the workspace_id(s) parameter is provided, data will be returned from the specified Workspaces.
If the workspace_id value is 0, data will be returned from all workspaces (the user has access to), with only global level fields.

```yaml
Type: Int32[]
Parameter Sets: default
Aliases:

Required: False
Position: 1
Default value: None
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
