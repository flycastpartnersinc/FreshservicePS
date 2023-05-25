---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceNote

## SYNOPSIS
Creates Freshservice Note on Problems, Changes and Releases

## SYNTAX

```
New-FreshServiceNote [-parent_id] <Int64> [[-body] <String>] [[-notify_emails] <String[]>] [-type] <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice Note via REST API for Problems, Changes and Releases. 
For Ticket, see New-FreshServiceConversation.

https://api.freshservice.com/#create_problem_note
https://api.freshservice.com/#create_change_note
https://api.freshservice.com/#create_release_note

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceNote -parent_id 2 -type Problem -body "A note added to a Problem."
```

id            : 21000071797
created_at    : 1/10/2023 7:52:26 PM
updated_at    : 1/10/2023 7:52:26 PM
body          : \<div\>A note added to a Problem.\</div\>
body_text     : A note added to a Problem.
user_id       : 21000418005
notify_emails :

Creates a Freshservice Note on a Problem.

## PARAMETERS

### -parent_id
Unique id of the parent Problem, Change or Release.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: ParentId

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -body
The body of the note in HTML format.

```yaml
Type: String
Parameter Sets: (All)
Aliases: note

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -notify_emails
Addresses to which the note must be notified to.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type
Parent object type to create note (e.g.
Problem, Change, Release)'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
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
