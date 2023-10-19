---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceAsset

## SYNOPSIS
Returns a Freshservice Asset.

## SYNTAX

### default (Default)
```
Get-FreshServiceAsset [[-workspace_id] <Int32[]>] [-IncludeTypeFields] [[-per_page] <Int32>] [[-page] <Int32>]
 [<CommonParameters>]
```

### relationships
```
Get-FreshServiceAsset [-display_id] <Int64> [-relationships] [<CommonParameters>]
```

### contracts
```
Get-FreshServiceAsset [-display_id] <Int64> [-contracts] [<CommonParameters>]
```

### requests
```
Get-FreshServiceAsset [-display_id] <Int64> [-requests] [<CommonParameters>]
```

### components
```
Get-FreshServiceAsset [-display_id] <Int64> [-components] [<CommonParameters>]
```

### id
```
Get-FreshServiceAsset [-display_id] <Int64> [-IncludeTypeFields] [<CommonParameters>]
```

### Filter
```
Get-FreshServiceAsset [[-filter] <String>] [-IncludeTypeFields] [<CommonParameters>]
```

### ByName
```
Get-FreshServiceAsset [-name] <String> [-IncludeTypeFields] [<CommonParameters>]
```

### ByAssetTag
```
Get-FreshServiceAsset [-asset_tag] <String> [-IncludeTypeFields] [<CommonParameters>]
```

### BySerialNumber
```
Get-FreshServiceAsset [-serial_number] <String> [-IncludeTypeFields] [<CommonParameters>]
```

### Trash
```
Get-FreshServiceAsset [-SearchTrash] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Asset via REST API.

https://api.freshservice.com/#view_an_asset

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceAsset
```

id            : 21000460190
display_id    : 4
name          : Asset1234
description   : ABC1234
asset_type_id : 21000855272
impact        : low
author_type   : User
usage_type    : permanent
asset_tag     : ASSET-4
user_id       :
department_id :
location_id   :
agent_id      :
group_id      :
assigned_on   :
created_at    : 9/30/2022 5:12:04 PM
updated_at    : 9/30/2022 5:12:04 PM
end_of_life   :

id            : 21000207685
display_id    : 3
name          : Logitech Mouse
description   :
asset_type_id : 21000855268
impact        : low
author_type   : User
usage_type    : permanent
asset_tag     : ASSET-3
user_id       :
department_id :
location_id   :
agent_id      :
group_id      :
assigned_on   :
created_at    : 8/29/2022 2:17:48 PM
updated_at    : 8/29/2022 2:17:48 PM
end_of_life   :

id            : 21000207684
display_id    : 2
name          : Dell Monitor
description   :
asset_type_id : 21000855276
impact        : low
author_type   : User
usage_type    : permanent
asset_tag     : ASSET-2
user_id       :
department_id :
location_id   :
agent_id      :
group_id      :
assigned_on   :
created_at    : 8/29/2022 2:17:48 PM
updated_at    : 8/29/2022 2:17:48 PM
end_of_life   :

id            : 21000207683
display_id    : 1
name          : Andrea's Laptop
description   :
asset_type_id : 21000855304
impact        : medium
author_type   : User
usage_type    : permanent
asset_tag     : ASSET-1
user_id       : 21000418006
department_id :
location_id   :
agent_id      :
group_id      :
assigned_on   :
created_at    : 8/29/2022 2:17:48 PM
updated_at    : 8/29/2022 2:17:48 PM
end_of_life   :

Returns all FreshService Assets.

### EXAMPLE 2
```
Get-FreshServiceAsset -Id 4
```

id            : 21000460190
display_id    : 4
name          : Asset1234
description   : ABC1234
asset_type_id : 21000855272
impact        : low
author_type   : User
usage_type    : permanent
asset_tag     : ASSET-4
user_id       :
department_id :
location_id   :
agent_id      :
group_id      :
assigned_on   :
created_at    : 9/30/2022 5:12:04 PM
updated_at    : 9/30/2022 5:12:04 PM
attachments   : {}
cloud_files   : {}
end_of_life   :

Returns a Freshservice Asset by Display Id.

### EXAMPLE 3
```
Get-FreshServiceAsset -display_id 4 -IncludeTypeFields
```

id            : 21000460190
display_id    : 4
name          : Asset1234
description   : ABC1234
asset_type_id : 21000855272
impact        : low
author_type   : User
usage_type    : permanent
asset_tag     : ASSET-4
user_id       :
department_id :
location_id   :
agent_id      :
group_id      :
assigned_on   :
created_at    : 9/30/2022 5:12:04 PM
updated_at    : 9/30/2022 5:12:04 PM
attachments   : {}
cloud_files   : {}
end_of_life   :
type_fields   : @{product_21000855267=21000056898; vendor_21000855267=; cost_21000855267=; warranty_21000855267=;
                acquisition_date_21000855267=; warranty_expiry_date_21000855267=; domain_21000855267=;
                asset_state_21000855267=In Use; serial_number_21000855267=ABC1234; last_audit_date_21000855267=;
                os_21000855272=; os_version_21000855272=; os_service_pack_21000855272=; memory_21000855272=;
                disk_space_21000855272=; cpu_speed_21000855272=; cpu_core_count_21000855272=; mac_address_21000855272=;
                uuid_21000855272=; hostname_21000855272=Asset1234; computer_ip_address_21000855272=;
                last_login_by_21000855272=; depreciation_id=; salvage=}

Returns a Freshservice Asset by Id and Include Type Fields.

### EXAMPLE 4
```
Get-FreshServiceAsset -Filter "asset_state:'In Stock' and asset_type_id:21000855276"
```

id            : 21000207684
display_id    : 2
name          : Dell Monitor
description   :
asset_type_id : 21000855276
impact        : low
author_type   : User
usage_type    : permanent
asset_tag     : ASSET-2
user_id       :
department_id :
location_id   :
agent_id      :
group_id      :
assigned_on   :
created_at    : 8/29/2022 2:17:48 PM
updated_at    : 8/29/2022 2:17:48 PM
end_of_life   :

Get Freshservice Asset(s) using filter criteria that the asset state is 'In Stock' and has a Asset Type Id of '21000855276'.
See https://api.freshservice.com/#filter_assets
for examples and available filter parameters. 
The passed filter is automatically url encoded at runtime.

## PARAMETERS

### -display_id
The display Id of the asset.

```yaml
Type: Int64
Parameter Sets: relationships, contracts, requests, components, id
Aliases: DisplayId, id

Required: True
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

### -filter
Custom filters supported by the api can be found here: https://api.freshservice.com/#filter_assets. 
The filter is automatically url encoded at runtime.

```yaml
Type: String
Parameter Sets: Filter
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
Quick filter Assets by Name.
Tokenized search appears to be supported.

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

### -asset_tag
Quick filter Assets by Asset Tag.
Tokenized search appears to be supported.

```yaml
Type: String
Parameter Sets: ByAssetTag
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serial_number
Quick filter Assets by Serial Number

```yaml
Type: String
Parameter Sets: BySerialNumber
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchTrash
Will return all the assets that are in trash.
Does not return active asset in addition to trash, assets in trash only.

```yaml
Type: SwitchParameter
Parameter Sets: Trash
Aliases: deleted, trash

Required: False
Position: 1
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeTypeFields
Will return all fields that are specific to each asset type.
For example, for Hardware Asset Type, including type_fields will return fields such as Product_ID, Vendor_ID and Serial_number.

IMPORTANT:  Each include will consume an additional two (2) credits.
For example, if you embed the 'type_fields' information you will be charged a total of 3 API credits for each call.

```yaml
Type: SwitchParameter
Parameter Sets: default, id, Filter, ByName, ByAssetTag, BySerialNumber
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -components
This operation allows you to view information about all the components of an asset in the account.

```yaml
Type: SwitchParameter
Parameter Sets: components
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -requests
This operation allows you to view a list of all the requests associated to the asset in the account.

```yaml
Type: SwitchParameter
Parameter Sets: requests
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -contracts
This operation allows you to get a list of all the contracts that an asset has been associated to.

```yaml
Type: SwitchParameter
Parameter Sets: contracts
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -relationships
This operation allows you to create new relationships in bulk.

```yaml
Type: SwitchParameter
Parameter Sets: relationships
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
