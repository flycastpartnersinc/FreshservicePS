---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceRelationship

## SYNOPSIS
Returns a Freshservice Relationship.

## SYNTAX

### default (Default)
```
Get-FreshServiceRelationship [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### ByAsset
```
Get-FreshServiceRelationship [-Id] <Int64> [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Relationship via REST API.

https://api.freshservice.com/#list_relationships_of_an_asset

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceRelationship
```

id                   : 21000035237
relationship_type_id : 21000356921
primary_id           : 37
primary_type         : asset
secondary_id         : 36
secondary_type       : asset
created_at           : 3/17/2023 1:05:06 PM
updated_at           : 3/17/2023 1:05:06 PM

id                   : 21000035236
relationship_type_id : 21000356921
primary_id           : 35
primary_type         : asset
secondary_id         : 34
secondary_type       : asset
created_at           : 3/17/2023 1:03:15 PM
updated_at           : 3/17/2023 1:03:15 PM

id                   : 21000035235
relationship_type_id : 21000356921
primary_id           : 33
primary_type         : asset
secondary_id         : 32
secondary_type       : asset
created_at           : 3/17/2023 1:00:41 PM
updated_at           : 3/17/2023 1:00:41 PM

id                   : 21000035205
relationship_type_id : 21000356921
primary_id           : 31
primary_type         : asset
secondary_id         : 30
secondary_type       : asset
created_at           : 3/16/2023 9:22:45 PM
updated_at           : 3/16/2023 9:22:45 PM

Lists all relationships on the Freshservice tenant.

### EXAMPLE 2
```
Get-FreshServiceRelationship -id 21000035237
```

id                   : 21000035237
relationship_type_id : 21000356921
primary_id           : 37
primary_type         : asset
secondary_id         : 36
secondary_type       : asset
created_at           : 3/17/2023 1:05:06 PM
updated_at           : 3/17/2023 1:05:06 PM

Get a Freshservice Relationship by id.

## PARAMETERS

### -Id
Unique id of the Relationship.

```yaml
Type: Int64
Parameter Sets: ByAsset
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
