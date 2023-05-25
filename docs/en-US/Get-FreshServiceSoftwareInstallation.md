---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceSoftwareInstallation

## SYNOPSIS
Returns a Freshservice Software installation.

## SYNTAX

```
Get-FreshServiceSoftwareInstallation [-software_id] <Int64> [[-per_page] <Int32>] [[-page] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Software installation via REST API.

https://api.freshservice.com/#list_installations

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceSoftwareinstallation -software_id 21000240240
```

id                      : 21002218412
created_at              : 8/29/2022 2:17:55 PM
updated_at              : 8/29/2022 2:17:55 PM
installation_path       :
version                 :
installation_machine_id : 1
user_id                 : 21000418006
department_id           :
installation_date       :

Returns all Freshservice Sofware installations.

## PARAMETERS

### -software_id
Unique id of the Software to get installations.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: id

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
