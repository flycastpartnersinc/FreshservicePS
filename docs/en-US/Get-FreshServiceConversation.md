---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceConversation

## SYNOPSIS
Returns a Freshservice Ticket conversation.

## SYNTAX

```
Get-FreshServiceConversation [-Id] <Int64> [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Ticket conversation via REST API.

https://api.freshservice.com/#list_all_conversations

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceConversation -id 5
```

id            : 21004158707
user_id       : 21000418005
to_emails     : {}
body          : \<div style="font-family: -apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Helvetica Neue,Arial,sans-serif; font-size: 14px; "\>\<div\>Customer has been down for multiple days.\</div\>\</div\>
body_text     : Customer has been down for multiple days.
ticket_id     : 5
created_at    : 11/17/2022 8:18:40 PM
updated_at    : 11/17/2022 8:18:40 PM
incoming      : False
private       : True
support_email :
source        : 2
from_email    :
cc_emails     : {}
bcc_emails    :
attachments   : {}

id            : 21004158695
user_id       : 21000418005
to_emails     : {alex@example.com}
body          : \<div style="font-family: -apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Helvetica Neue,Arial,sans-serif; font-size: 14px; "\>
                \<div\>Hi Alex,\<br\>\<br\>Ticket: \<a href="https://its-fine.freshservice.com/helpdesk/tickets/5" rel="noreferrer"\>https://its-fine.freshservice.com/helpdesk/tickets/5\</a\>
                \</div\>
                \<div\>\<br\>\</div\>
                \<div\>Working on this\</div\>
                \</div\>
body_text     : Hi Alex,  Ticket: https://its-fine.freshservice.com/helpdesk/tickets/5     Working on this
ticket_id     : 5
created_at    : 11/17/2022 8:18:18 PM
updated_at    : 11/17/2022 8:18:18 PM
incoming      : False
private       : False
support_email : helpdesk@its-fine.freshservice.com
source        : 0
from_email    : "its-fine" \<helpdesk@its-fine.freshservice.com\>
cc_emails     : {}
bcc_emails    : {}
attachments   : {}

Get all FreshService ticket conversations by ticket id.

## PARAMETERS

### -Id
Unique id of the ticket to get conversation.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: ticket_id

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -per_page
Number of records to return per page during pagination. 
Maximum of 100 records.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -page
The page number to retrieve during pagination.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 1
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
