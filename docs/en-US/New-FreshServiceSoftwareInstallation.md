---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# New-FreshServiceSoftwareInstallation

## SYNOPSIS
Creates a new Freshservice Software Installation.

## SYNTAX

```
New-FreshServiceSoftwareInstallation [-id] <Int64> [-installation_machine_id] <Int64>
 [[-installation_path] <String>] [[-version] <String>] [[-installation_date] <DateTime>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a new Freshservice Software Installation via REST API.

https://api.freshservice.com/#create_an_installations

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceSoftwareInstallation -id 21000240239 -installation_machine_id 1 -installation_path 'C:\Program Files\Freshservice' -version '13.5.1211' -Verbose
```

id                      : 21024172801
created_at              : 3/28/2023 6:44:09 PM
updated_at              : 3/28/2023 6:44:09 PM
installation_path       : C:\Program Files\Freshservice
version                 : 13.5.1211
installation_machine_id : 1
user_id                 : 21000418006
department_id           :
installation_date       :

Associate a installation with a device.

## PARAMETERS

### -id
Unique ID of the software installation.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: software_id

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -installation_machine_id
Display ID (display_id) of device where the software is installed in.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: display_id, machine_id

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -installation_path
Path where the software is installed.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Path, Fullname

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -version
Version of the installed software.

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

### -installation_date
Date and time when the application was installed.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
