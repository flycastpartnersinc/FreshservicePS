---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceCannedResponseFolder

## SYNOPSIS
Returns a Freshservice Canned Response Folder.

## SYNTAX

### default (Default)
```
Get-FreshServiceCannedResponseFolder [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceCannedResponseFolder [-Id] <Int64> [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Canned Response Folder via REST API.

https://api.freshservice.com/#list_all_canned_response_folders

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceCannedResponseFolder
```

id              : 21000067834
created_at      : 2/21/2023 10:06:23 PM
updated_at      : 2/21/2023 10:06:23 PM
name            : Test
type            : Custom
responses_count : 1

Returns all Freshservice Canned Response Folders.

### EXAMPLE 2
```
Get-FreshServiceCannedResponseFolder -id 21000067834
```

id              : 21000067834
created_at      : 2/21/2023 10:06:23 PM
updated_at      : 2/21/2023 10:06:23 PM
name            : Test
type            : Custom
responses_count : 1

Returns all Freshservice Canned Response Folder by Id.

## PARAMETERS

### -Id
Unique id of the Canned Response Folder.

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
