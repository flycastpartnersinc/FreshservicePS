---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceAsset

## SYNOPSIS
Creates Freshservice asset.

## SYNTAX

```
New-FreshServiceAsset [-name] <String> [[-description] <String>] [-asset_type_id] <Int64>
 [[-asset_tag] <String>] [[-impact] <String>] [[-usage_type] <String>] [[-user_id] <Int64>]
 [[-location_id] <Int64>] [[-department_id] <Int64>] [[-agent_id] <Int64>] [[-group_id] <Int64>]
 [[-assigned_on] <DateTime>] [[-type_fields] <Hashtable>] [[-workspace_id] <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice asset via REST API.

https://api.freshservice.com/#create_an_asset

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceAsset -name 'Laptop123' -description 'Apple Laptop' -asset_type_id 21000855304 -type_fields @{product_21000855267 = 21000056898;asset_state_21000855267 = 'In Use'}
```

attachments       : {}
cloud_files       : {}
id                : 21001571617
display_id        : 40
name              : Laptop123
description       : Apple Laptop
asset_type_id     : 21000855304
impact            : low
usage_type        : permanent
asset_tag         : ASSET-40
user_id           :
department_id     :
location_id       :
agent_id          :
group_id          :
assigned_on       :
created_at        : 3/27/2023 5:39:55 PM
updated_at        : 3/27/2023 5:39:55 PM
author_type       : User
type_fields       : @{product_21000855267=21000056898; vendor_21000855267=; cost_21000855267=; warranty_21000855267=; acquisition_date_21000855267=; warranty_expiry_date_21000855267=; domain_21000855267=; asset_state_21000855267=In Use; serial_number_21000855267=; last_audit_date_21000855267=;
                    os_21000855272=; os_version_21000855272=; os_service_pack_21000855272=; memory_21000855272=; disk_space_21000855272=; cpu_speed_21000855272=; cpu_core_count_21000855272=; mac_address_21000855272=; uuid_21000855272=; hostname_21000855272=; computer_ip_address_21000855272=;
                    last_login_by_21000855272=; depreciation_id=; salvage=}
end_of_life       :
discovery_enabled : True

Create a new Freshservice Asset.

## PARAMETERS

### -name
Name of the asset.

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
Description of the asset.

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

### -asset_type_id
Unique id of the asset type.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -asset_tag
Asset tag of the asset.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -impact
Impact of the asset.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -usage_type
Usage type of the asset (Loaner / Permanent).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -user_id
Unique id of the associated user (Used By).

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -location_id
Unique id of the associated location.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -department_id
Unique id of the associated department.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -agent_id
Unique id of the associated agent (Managed By).

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -group_id
Unique id of the associated agent group (Managed By Group).

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -assigned_on
Date and time when the asset was assigned.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type_fields
Key-value pair containing the names and values of the asset type fields.
Once a asset_layer_id is assigned, all mandatory fields must be
provided or an validation error will occur to indicated the mandatory fields:

{"description":"Validation failed","errors":\[{"field":"product_21000855267","message":"This field cannot be empty","code":"missing_field"},{"field":"asset_state_21000855267","message":"This field cannot be empty","code":"missing_field"}\]}

IMPORTANT: These type fields vary on every Freshservice tenant and are represented by the layer id.
See Get-FreshServiceAssetType.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -workspace_id
Workspace ID for the Asset. The attribute is applicable only for accounts with the Workspaces feature enabled. The default value is the ID of the primary workspace of the account.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: 0
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
