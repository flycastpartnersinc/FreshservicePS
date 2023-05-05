---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceSoftwareUser

## SYNOPSIS
Returns a Freshservice application (i.e.
software) user.

## SYNTAX

```
Get-FreshServiceSoftwareUser [-software_id] <Int64> [[-Id] <Int64>] [[-per_page] <Int32>] [[-page] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice application (i.e.
software) user via REST API.

https://api.freshservice.com/#view_user

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceSoftwareUser -software_id 21000240239
```

additional_data : @{usage=; last_sync_date=}
id              : 21000064393
user_id         : 21000418006
license_id      :
allocated_date  : 8/29/2022 4:00:00 AM
first_used      : 8/29/2022 4:00:00 AM
last_used       : 8/29/2022 4:00:00 AM
sources         : {}
created_at      : 8/29/2022 2:17:55 PM
updated_at      : 8/29/2022 2:17:55 PM

Returns all Freshservice Sofware Users.

### EXAMPLE 2
```
Get-FreshServiceSoftwareUser -software_id 21000240239 -id 21000064393
```

additional_data : @{usage=; last_sync_date=}
id              : 21000064393
user_id         : 21000418006
license_id      :
allocated_date  : 8/29/2022 4:00:00 AM
first_used      : 8/29/2022 4:00:00 AM
last_used       : 8/29/2022 4:00:00 AM
sources         : {}
created_at      : 8/29/2022 2:17:55 PM
updated_at      : 8/29/2022 2:17:55 PM

Returns a Freshservice Software User by Id.

## PARAMETERS

### -software_id
Unique id of the Software to get users.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: applicationid

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Unique id of the Software user.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
