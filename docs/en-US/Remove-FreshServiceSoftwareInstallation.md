---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Remove-FreshServiceSoftwareInstallation

## SYNOPSIS
Delete a Freshservice Software Installation.

## SYNTAX

```
Remove-FreshServiceSoftwareInstallation [-software_id] <Int64> -installation_machine_id <Int64> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Delete a Freshservice Software Installation via REST API.

https://api.freshservice.com/#bulk_delete_installations

## EXAMPLES

### EXAMPLE 1
```
Remove-FreshServiceSoftwareInstallation -software_id 21000240239 -installation_machine_id 1
```

software_id installation_machine_id status
----------- ----------------------- ------
21000240239                       1 success 204

Delete a Freshservice Software Installation.
Default API has no response, artificial response with id and
status containing status code is returned for tracking.

## PARAMETERS

### -software_id
Unique id of the software installation.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: softwareid, id

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -installation_machine_id
Unique id of the machine using the Software.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: machine_id, device_id

Required: True
Position: Named
Default value: 0
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
