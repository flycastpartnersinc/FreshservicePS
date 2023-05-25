---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceSoftwareUser

## SYNOPSIS
Creates a new Freshservice Software User.

## SYNTAX

```
New-FreshServiceSoftwareUser [-id] <Int64> [-user_id] <Int64> [[-license_id] <Int64>]
 [[-allocated_date] <DateTime>] [[-first_used] <DateTime>] [[-last_used] <DateTime>] [[-source] <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new Freshservice Software User via REST API.

https://api.freshservice.com/#bulk_create_users

## EXAMPLES

### EXAMPLE 1
```
$suParams = @{
    software_id    = 21000240239 #Get-FreshworksSoftware
    user_id        = 21000418006 #Get-FreshServiceRequester
    license_id     = 23 #Get-FreshserviceContract
    allocated_date = (Get-Date -Date '10/10/2019 12:00:00 AM')
    first_used     = (Get-Date -Date '11/10/2019 12:00:00 AM')
    last_used      = Get-Date
    source         = 'API'
}
```

New-FSSoftwareUser @suParams

api/v2/applications/21000240239/users/21000064393

Associate a user with software and a specific contract license.

## PARAMETERS

### -id
Unique Id of the software to add the user.

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

### -user_id
Unique id of the User using the Software.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -license_id
Display ID of the allocated Software License Contract.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -allocated_date
Date and time when the license was allocated.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -first_used
Date and time when the application was first used by the user.

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

### -last_used
Date and time when the application was last used by the user.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -source
Name of the source from where the user details are updated (API, Okta, Google...etc).

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
