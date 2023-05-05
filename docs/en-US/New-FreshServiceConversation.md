---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# New-FreshServiceConversation

## SYNOPSIS
Creates a Freshservice Ticket Conversation.

## SYNTAX

### Reply (Default)
```
New-FreshServiceConversation [-Id] <Int64> [-body] <String> [[-attachments] <FileInfo[]>]
 [[-from_email] <String>] [[-user_id] <Int64>] [[-cc_emails] <String[]>] [[-bcc_emails] <String[]>]
 [-As] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Note
```
New-FreshServiceConversation [-Id] <Int64> [-body] <String> [[-attachments] <FileInfo[]>] [[-user_id] <Int64>]
 [[-incoming] <Boolean>] [[-notify_emails] <String[]>] [[-private] <Boolean>] [-As] <String> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice Ticket Conversation via REST API.

https://api.freshservice.com/#create_a_reply
https://api.freshservice.com/#create_a_note

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceConversation -Id 9 -As Reply -body 'A reply to a ticket'
```

id          : 21005968159
user_id     : 21000418005
to_emails   : {rob.simmers@flycastpartners.com}
body        : \<div\>A reply to a ticket\</div\>
body_text   : A reply to a ticket
ticket_id   : 9
created_at  : 1/6/2023 8:20:13 PM
updated_at  : 1/6/2023 8:20:13 PM
from_email  : helpdesk@its-fine.freshservice.com
cc_emails   : {}
bcc_emails  : {}
attachments : {}

Creates a Freshservice ticket reply.

### EXAMPLE 2
```
New-FreshServiceConversation -Id 9 -As Note -body 'A private note on a ticket' -private $true -incoming $true
```

id            : 21005968234
user_id       : 21000418005
to_emails     : {}
body          : \<div\>A private note on a ticket\</div\>
body_text     : A private note on a ticket
ticket_id     : 9
created_at    : 1/6/2023 8:22:25 PM
updated_at    : 1/6/2023 8:22:25 PM
incoming      : True
private       : True
support_email :
attachments   : {}

Creates a Freshservice ticket note.

## PARAMETERS

### -Id
Id for Ticket to create reply\note.

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

### -body
Content of the note in HTML format

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -attachments
Attachments.
The total size of all the ticket's attachments (not just this note) cannot exceed 15MB.

```yaml
Type: FileInfo[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -from_email
The email address from which the reply is sent.
By default the global support email will be used.

```yaml
Type: String
Parameter Sets: Reply
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -user_id
Unique id of the agent/user who is adding the note

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -cc_emails
Email address added in the 'cc' field of the outgoing ticket email.

```yaml
Type: String[]
Parameter Sets: Reply
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -bcc_emails
Email address added in the 'bcc' field of the outgoing ticket email.

```yaml
Type: String[]
Parameter Sets: Reply
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -incoming
Set to true if a particular note should appear as being created from the outside (i.e., not through the web portal).
The default value is false

```yaml
Type: Boolean
Parameter Sets: Note
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -notify_emails
Email addresses of agents/users who need to be notified about this note

```yaml
Type: String[]
Parameter Sets: Note
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -private
Set to true if the note is private.
The default value is true.

```yaml
Type: Boolean
Parameter Sets: Note
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -As
Type of conversation. 
Reply (Default) or Note.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
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
