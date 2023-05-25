---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Set-FreshServiceNote

## SYNOPSIS
Updates a Freshservice Note on a Problem, Change or Release.

## SYNTAX

```
Set-FreshServiceNote [-id] <Int64> [-parent_id] <Int64> [[-body] <String>] [[-notify_emails] <String[]>]
 [-type] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Note on a Problem, Change or Release via REST API.
For Note updates on Tickets, see Set-FreshServiceConversation.

https://api.freshservice.com/#update_a_problem_note
https://api.freshservice.com/#update_a_change_note
https://api.freshservice.com/#update_a_release_note

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceNote -parent_id 2 -type Problem -id 21000071797 -body "Updated note on a problem"
```

id            : 21000071797
created_at    : 1/10/2023 7:52:26 PM
updated_at    : 1/10/2023 8:01:18 PM
body          : Updated note on a problem
body_text     : Updated note on a problem
user_id       : 21000418005
notify_emails :

Update the body on a specific note on a problem.

## PARAMETERS

### -id
Unique id of the Note.

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

### -parent_id
Unique id of the parent Problem, Change or Release.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: ParentId

Required: True
Position: 2
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
Position: 3
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
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type
Parent object type to create note (Problem, Change or Release).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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
