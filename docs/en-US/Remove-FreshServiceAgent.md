---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Remove-FreshServiceAgent

## SYNOPSIS
Deactivate or Forget Freshservice Agent.

## SYNTAX

```
Remove-FreshServiceAgent [-id] <Int64> [-Forget] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deactivate or Forget Freshservice Agent via REST API.
Default action is Deactivation (soft delete) of agent.

https://api.freshservice.com/#delete_an_agent
https://api.freshservice.com/#forget_an_agent

## EXAMPLES

### EXAMPLE 1
```
Deactivate an Agent. Default API has no response, artificial response with id and status containing
status code is returned for tracking.
```

Remove-FreshServiceAgent -id 21001941406

id status
-- ------
21001941406 success 200

### EXAMPLE 2
```
Remove-FreshServiceAgent -id 21001941406 -forget
```

id status
-- ------
21001941406 success 204

Permanently delete a Agent and the tickets that they requested.
Default API has no response, artificial response with id and status containing
status code is returned for tracking.

## PARAMETERS

### -id
Unique id of the Agent.

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
Permanently delete a Agent and the tickets that they requested.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
