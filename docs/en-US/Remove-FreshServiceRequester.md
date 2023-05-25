---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Remove-FreshServiceRequester

## SYNOPSIS
Deactivate or Forget Freshservice Requester.

## SYNTAX

```
Remove-FreshServiceRequester [-id] <Int64> [-Forget] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deactivate or Forget Freshservice Requester.
Default action is Deactivation of requester via REST API.

https://api.freshservice.com/#deactivate_a_requester
https://api.freshservice.com/#forget_a_requester

## EXAMPLES

### EXAMPLE 1
```
Remove-FreshServiceRequester -id 21001841985
```

id status
-- ------
21001841985 success 204

Deactivate a new Requester.
Default API has no response, artificial response with id and
status containing status code is returned for tracking.

### EXAMPLE 2
```
Remove-FreshServiceRequester -id 21001841985 -forget
```

id status
-- ------
21001841985 success 204

Permanently delete a Requester and the tickets that they requested.
Default API has no response, artificial response with id and
status containing status code is returned for tracking.

## PARAMETERS

### -id
Unique id of the Requester.

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

### -Forget
Permanently delete a Requester and the tickets that they requested

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

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
