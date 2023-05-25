---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Set-FreshServiceAsset

## SYNOPSIS
Updates a Freshservice Asset.

## SYNTAX

```
Set-FreshServiceAsset [-display_id] <String> [[-name] <String>] [[-description] <String>]
 [[-asset_type_id] <Int64>] [[-asset_tag] <String>] [[-impact] <String>] [[-usage_type] <String>]
 [[-user_id] <Int64>] [[-location_id] <Int64>] [[-department_id] <Int64>] [[-agent_id] <Int64>]
 [[-group_id] <Int64>] [[-assigned_on] <DateTime>] [[-type_fields] <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Asset via REST API.

https://api.freshservice.com/#update_an_asset

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceAsset -display_id 1 -description 'Updated description'
```

attachments       : {}
cloud_files       : {}
id                : 21000207683
display_id        : 1
name              : Andrea's Laptop
description       : Updated description
asset_type_id     : 21000855304
impact            : medium
usage_type        : permanent
asset_tag         : ASSET-1
user_id           : 21000418006
department_id     :
location_id       :
agent_id          :
group_id          :
assigned_on       :
created_at        : 8/29/2022 2:17:48 PM
updated_at        : 3/30/2023 3:13:48 AM
author_type       : User
type_fields       : @{product_21000855267=21000056898; vendor_21000855267=21000085371; cost_21000855267=1099;
                    warranty_21000855267=; acquisition_date_21000855267=8/29/2022 2:17:48 PM;
                    warranty_expiry_date_21000855267=8/29/2025 2:17:48 PM; domain_21000855267=;
                    asset_state_21000855267=In Use; serial_number_21000855267=FRSHW1234;
                    last_audit_date_21000855267=; os_21000855272=Mac; os_version_21000855272=OS X;
                    os_service_pack_21000855272=10.13.5; memory_21000855272=16; disk_space_21000855272=512;
                    cpu_speed_21000855272=2.2; cpu_core_count_21000855272=4;
                    mac_address_21000855272=1g:23:57:1d:c2:e7; uuid_21000855272=; hostname_21000855272=;
                    computer_ip_address_21000855272=192.168.55.254; last_login_by_21000855272=; depreciation_id=;
                    salvage=}
end_of_life       :
discovery_enabled : True

Update a Freshservice asset.

## PARAMETERS

### -display_id
Unique Display Id of the Asset.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
Name of the asset.

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
Description of the asset.

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

### -asset_type_id
Unique id of the asset type.

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

### -asset_tag
Asset tag of the asset.

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

### -impact
Impact of the asset.

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

### -usage_type
Usage type of the asset (Loaner / Permanent).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
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
Position: 8
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
Position: 9
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
Position: 10
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
Position: 11
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
Position: 12
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
Position: 13
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type_fields
Key-value pair containing the names and values of the asset type fields.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
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
