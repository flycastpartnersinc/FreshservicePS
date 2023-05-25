---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceAssetType

## SYNOPSIS
Returns a Freshservice Asset Type.

## SYNTAX

### default (Default)
```
Get-FreshServiceAssetType [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceAssetType [-Id] <Int64> [-fields] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Asset Type via REST API.

https://api.freshservice.com/#view_an_asset_type

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceAssetType
```

id                   : 21000855265
name                 : Services
description          :
parent_asset_type_id :
visible              : True
created_at           : 8/29/2022 2:17:36 PM
updated_at           : 8/29/2022 2:17:36 PM

id                   : 21000855285
name                 : Business Service
description          :
parent_asset_type_id : 21000855265
visible              : True
created_at           : 8/29/2022 2:17:37 PM
updated_at           : 8/29/2022 2:17:37 PM

id                   : 21000855311
name                 : Sales Service
description          :
parent_asset_type_id : 21000855285
visible              : True
created_at           : 8/29/2022 2:17:39 PM
updated_at           : 8/29/2022 2:17:39 PM

Return Freshservice Asset Types.

### EXAMPLE 2
```
Get-FreshServiceAssetType -Id 21000855285
```

id                   : 21000855285
name                 : Business Service
description          :
parent_asset_type_id : 21000855265
visible              : True
created_at           : 8/29/2022 2:17:37 PM
updated_at           : 8/29/2022 2:17:37 PM

Return Freshservice Asset Type by Id.

### EXAMPLE 3
```
Get-FreshServiceAssetType -Id 21000855285 -Fields
```

field_header     fields
------------     ------
General          {@{id=; created_at=; updated_at=; asset_type_id=; name=name; label=Display Name; required=True; is_uni...
Assignment       {@{id=; created_at=; updated_at=; asset_type_id=; name=location_id; label=Location; required=False; is...
Services         {}
Business Service {@{id=21003895909; created_at=8/29/2022 2:17:42 PM; updated_at=8/29/2022 2:17:42 PM; asset_type_id=210...

Return Freshservice Asset Type Fields by Id.

## PARAMETERS

### -Id
Unique id of the Asset Type.

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
Retrieve Fields for Asset Type for a spefic asset type id.

```yaml
Type: SwitchParameter
Parameter Sets: id
Aliases:

Required: False
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
Position: 1
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
