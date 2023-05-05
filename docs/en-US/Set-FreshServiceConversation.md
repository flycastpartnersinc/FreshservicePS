---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServiceConversation

## SYNOPSIS
Updates a Freshservice Conversation.

## SYNTAX

```
Set-FreshServiceConversation -id <Int64> [-body <String>] [[-attachments] <FileInfo[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Conversation via REST API.

https://api.freshservice.com/#update_a_conversations

IMPORTANT - Only public & private notes can be edited (i.e.
cannot edit a reply).

## EXAMPLES

### EXAMPLE 1
```
<div>Test Note</div></div>'
```

id            : 21009827673
user_id       : 21001931878
to_emails     : {}
body          : \<div style="font-family: -apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Helvetica Neue,Arial,sans-serif; font-size: 18px; "\>\<div\>Test Note\</div\>\</div\>
body_text     : Test Note
ticket_id     : 209
created_at    : 3/30/2023 7:29:30 PM
updated_at    : 3/30/2023 7:32:03 PM
incoming      : False
private       : True
support_email :
attachments   : {}

Updates the body on a Freshservice Conversation.

## PARAMETERS

### -id
Unique id of the conversation.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: note_id

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -body
Content of the note in HTML format.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -attachments
Conversation attachments.
The total size of these attachments cannot exceed 15MB.

```yaml
Type: FileInfo[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
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
