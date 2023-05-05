---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Remove-FreshServiceSoftwareUser

## SYNOPSIS
Delete a Freshservice Software User.

## SYNTAX

```
Remove-FreshServiceSoftwareUser [-software_id] <Int64> [-user_id] <Int64[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Delete a Freshservice Software User via REST API.

https://api.freshservice.com/#bulk_delete_users

## EXAMPLES

### EXAMPLE 1
```
Remove-FreshServiceSoftwareUser -software_id 21000240239 -user_id 21000418006
```

software_id user_ids      status
----------- --------      ------
21000240239 {21000418006} success 204

Delete a Freshservice Software User.
Default API has no response, artificial response with id and
status containing status code is returned for tracking.

## PARAMETERS

### -software_id
Unique id of the Software.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -user_id
Unique id of the Software User.

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases: id

Required: True
Position: 2
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
