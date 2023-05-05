---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# New-FreshServiceSoftware

## SYNOPSIS
Creates a new Freshservice Software.

## SYNTAX

```
New-FreshServiceSoftware [-name] <String> [[-description] <String>] [-application_type] <String>
 [[-status] <String>] [[-publisher_id] <Int64>] [[-managed_by_id] <Int64>] [[-notes] <String>]
 [[-category] <String>] [[-source] <String>] [[-custom_field] <Object>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a new Freshservice Software via REST API.

https://api.freshservice.com/#create_a_software

## EXAMPLES

### EXAMPLE 1
```
New-FreshserviceSoftware -name 'Software X1000 Platinum' -description 'Awesome software, all the time.' -application_type desktop -status ignored  -publisher_id 21000085375 -notes 'Some Notes on the Sofware' -category Internal -source 'API'
```

additional_data    : @{overview=; graph_data=; last_sync_date=}
user_count         : 0
installation_count : 0
id                 : 21001446583
name               : Software X1000 Platinum
description        : Awesome software, all the time.
notes              : Some Notes on the Sofware
publisher_id       : 21000085375
created_at         : 3/28/2023 6:40:32 PM
updated_at         : 3/28/2023 6:40:32 PM
application_type   : desktop
status             : ignored
managed_by_id      :
category           : Internal
sources            : {API}

Creates a new Freshservice Application.

## PARAMETERS

### -name
Name of the software

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -description
Description of the software

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -application_type
Type of the software.
Default is desktop, possible values:

desktop
saas
mobile

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -status
Status of the software, possible values:

blacklisted
ignored
managed

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -publisher_id
Unique id of the Vendor

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -managed_by_id
Unique id of the user managing the software (must be a user in Freshservice)

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -notes
Notes about the software

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -category
Category of the software

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -source
Name of the source from where the software details are updated (API, Okta, Google...etc).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -custom_field
Key-value pair containing the names and values of the (custom) requester fields.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
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
