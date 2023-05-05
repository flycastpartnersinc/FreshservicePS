---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Remove-FreshServiceAsset

## SYNOPSIS
Delete a Freshservice Asset.

## SYNTAX

```
Remove-FreshServiceAsset [-display_id] <Int64> [-delete_forever] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Delete a Freshservice Asset via REST API.

https://api.freshservice.com/#delete_an_asset
https://api.freshservice.com/#delete_forever_an_asset

## EXAMPLES

### EXAMPLE 1
```
Remove-FreshServiceAsset -display_id 30
```

id status
-- ------
30 success 204

Delete a Freshservice Asset.
Default API has no response, artificial response with id and status containing
status code is returned for tracking.

### EXAMPLE 2
```
Remove-FreshServiceAsset -display_id 30 -delete_forever
```

id status
-- ------
30 success 204

Permanently delete an Freshservice Asset which cannot be restored later.
Default API has no response, artificial response with id and status containing
status code is returned for tracking.

## PARAMETERS

### -display_id
Unique display_id of the Freshservice Asset.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: id

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -delete_forever
Permanently delete an asset which cannot be restored later.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: Permanent

Required: False
Position: Named
Default value: False
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
