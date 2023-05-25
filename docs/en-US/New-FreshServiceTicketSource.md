---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceTicketSource

## SYNOPSIS
Creates Freshservice Ticket Source.

## SYNTAX

```
New-FreshServiceTicketSource [-name] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice Ticket Source via REST API.

https://api.freshservice.com/#create_custom_ticket_source

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceTicketSource -name 'Magic'
```

id         : 21000466443
created_at : 1/5/2023 6:08:44 PM
updated_at : 1/5/2023 6:08:44 PM
choice_id  : 1001
value      : Magic
position   : 16
visible    : True
default    : False

Creates a Freshservice Ticket Source.

## PARAMETERS

### -name
Name of the ticket source.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

There are no GET, SET (PUT) or REMOVE (DELETE) methods currently available for this API endpoint.

## RELATED LINKS
