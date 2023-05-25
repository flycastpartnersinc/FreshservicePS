---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceRelationshipType

## SYNOPSIS
Returns a Freshservice Asset Relationship Types.

## SYNTAX

```
Get-FreshServiceRelationshipType [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Asset via REST API.

https://api.freshservice.com/#view_an_asset

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceRelationshipType
```

id                  : 21000356894
is_default          : True
description         :
created_at          : 8/29/2022 2:17:32 PM
updated_at          : 8/29/2022 2:17:32 PM
downstream_relation : Depends On
upstream_relation   : Used By

id                  : 21000356895
is_default          : True
description         :
created_at          : 8/29/2022 2:17:32 PM
updated_at          : 8/29/2022 2:17:32 PM
downstream_relation : Uses
upstream_relation   : Used By

id                  : 21000356896
is_default          : True
description         :
created_at          : 8/29/2022 2:17:32 PM
updated_at          : 8/29/2022 2:17:32 PM
downstream_relation : Sends Data To
upstream_relation   : Receives Data From

id                  : 21000356897
is_default          : True
description         :
created_at          : 8/29/2022 2:17:32 PM
updated_at          : 8/29/2022 2:17:32 PM
downstream_relation : Runs on
upstream_relation   : Runs

Returns a Freshservice Asset Relationship Types.

## PARAMETERS

### -per_page
Number of records to return per page during pagination. 
Maximum of 100 records.

```yaml
Type: Int32
Parameter Sets: (All)
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
Parameter Sets: (All)
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
