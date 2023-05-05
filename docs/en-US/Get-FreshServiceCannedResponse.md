---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceCannedResponse

## SYNOPSIS
Returns a Freshservice Canned Response.

## SYNTAX

### default (Default)
```
Get-FreshServiceCannedResponse [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceCannedResponse [-Id] <Int64> [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Canned Response via REST API.

https://api.freshservice.com/#list_all_canned_responses

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceCannedResponse
```

id           : 21000011594
title        : Test Response
content      : Sorry about that!
content_html : \<div\>Sorry about that!\</div\>

folder_id    : 21000067834
created_at   : 2/21/2023 10:07:47 PM
updated_at   : 2/21/2023 10:07:47 PM
attachments  : {}

Returns all Freshservice Canned Responses.

### EXAMPLE 2
```
Get-FreshServiceCannedResponse -id 21000011594
```

id           : 21000011594
title        : Test Response
content      : Sorry about that!
content_html : \<div\>Sorry about that!\</div\>

folder_id    : 21000067834
created_at   : 2/21/2023 10:07:47 PM
updated_at   : 2/21/2023 10:07:47 PM
attachments  : {}

Returns a Freshservice Canned Response by Id.

## PARAMETERS

### -Id
Unique id of the Canned Response.

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
