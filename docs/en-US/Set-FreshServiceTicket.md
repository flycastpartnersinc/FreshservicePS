---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServiceTicket

## SYNOPSIS
Updates a Freshservice Ticket.

## SYNTAX

### default (Default)
```
Set-FreshServiceTicket [-id] <Int64> [[-name] <String>] [[-requester_id] <Int64>] [[-email] <String>]
 [[-phone] <String>] [[-subject] <String>] [[-type] <String>] [[-status] <Int32>] [[-priority] <Int32>]
 [[-description] <String>] [[-responder_id] <Int64>] [[-attachments] <FileInfo[]>] [[-custom_fields] <Object>]
 [[-due_by] <DateTime>] [[-email_config_id] <Int64>] [[-fr_due_by] <DateTime>] [[-group_id] <Int64>]
 [[-source] <String>] [[-tags] <String[]>] [[-assets] <Object>] [[-urgency] <Int32>] [[-impact] <Int32>]
 [[-category] <String>] [[-sub_category] <String>] [[-item_category] <String>] [[-department_id] <Int64>]
 [[-problem] <Object>] [[-change_initiating_ticket] <Object>] [[-change_initiated_by_ticket] <Object>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Restore
```
Set-FreshServiceTicket [-id] <Int64> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Ticket via REST API.

https://api.freshservice.com/#update_ticket_priority

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceTicket -id 7 -status 3 -attachments 'C:\Scripts\automation_icon.jpg'
```

cc_emails        : {}
fwd_emails       : {}
reply_cc_emails  : {}
spam             : False
email_config_id  :
fr_escalated     : True
group_id         :
priority         : 1
requester_id     : 21000418005
requested_for_id : 21000418005
responder_id     :
source           : 2
status           : 3
subject          : VPN no worky
description      : \<div\>Getting an error that VPN version not supported.\</div\>
description_text : Getting an error that VPN version not supported.
category         : Hardware
sub_category     :
item_category    :
custom_fields    : @{my_custom_dropdown=}
id               : 7
type             : Incident
to_emails        :
department_id    :
is_escalated     : False
tags             : {VPN, Version}
due_by           : 12/30/2022 9:30:49 PM
fr_due_by        : 12/23/2022 6:30:49 PM
created_at       : 12/20/2022 9:30:48 PM
updated_at       : 12/28/2022 3:56:40 PM
attachments      : {@{id=21006244756; content_type=image/jpeg; size=14119; name=automation_icon.jpg; attachment_url=https://its-fine.attachments.freshservice.com/data/helpdesk/attachments/production/21006244756/original/automation_icon.jpg?response-content-type=image/jpeg&Expires=1672329400&Signature=PHZ3Hms9A
                6L4gBGmyRAbaF1ghtfGgFwNSTAYXrQfa-FFI3ukYf7d3Y6ru0PcBNQACcqhGASsc~Q9F8M3JcljLfqZ839paJT7B0u7dC4LYi4ULz7~3zya48gs1JHvN5M-BlR1jd2Bx0g5EfLoGP~Y9WzulFe-QzbEK8iWmnJKPlsxUj4jEzVnbp7PaH-Uk~R8alIinCV0kTSP85YU1nc7plngg2Pjm27yQCzU7nQZWwFCVfXrtnQRKMe8UY4NrNpirpK71zwH4w6t5YvFA54wMVYBJjAMNv1KQLXunilbzVdb~
                vy3pqAn81g4LhqjDgjvMIJLGTszwrUbL9PFmkGGYQ__&Key-Pair-Id=APKAIPHBXWY2KT5RCMPQ; created_at=12/28/2022 3:56:39 PM; updated_at=12/28/2022 3:56:39 PM}}

Updates a Freshservice ticket 7 with a status of 3 (Pending) and attaches a jpg image.

## PARAMETERS

### -id
Unique id of the ticket.

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

### -name
Name of the requester

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -requester_id
User ID of the requester.
For existing contacts, the requester_id can be passed instead of the requester's email.

```yaml
Type: Int64
Parameter Sets: default
Aliases: RequesterId

Required: False
Position: 3
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -email
Email address of the requester.
If no contact exists with this email address in Freshservice, it will be added as a new contact.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -phone
Phone number of the requester.
If no contact exists with this phone number in Freshservice, it will be added as a new contact.
If the phone number is set and the email address is not, then the name attribute is mandatory.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -subject
Subject of the ticket.
The default value is null.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type
Helps categorize the ticket according to the different kinds of issues your support team deals with.
The default Value is
incident.
As of now, API v2 supports only type 'incident'

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status
Status of the ticket.

2 = Open
3 = Pending
4 = Resolved
5 = Closed

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -priority
Priority of the ticket.

4 = Urgent
3 = High
2 = Medium
1 = Low

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
HTML content of the ticket.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -responder_id
Unique id of the agent to whom the ticket has been assigned

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -attachments
Ticket attachments.
The total size of these attachments cannot exceed 15MB.

```yaml
Type: FileInfo[]
Parameter Sets: default
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -custom_fields
Key value pairs containing the names and values of custom fields.
Read more here.

```yaml
Type: Object
Parameter Sets: default
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -due_by
Timestamp that denotes when the ticket is due to be resolved.

```yaml
Type: DateTime
Parameter Sets: default
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -email_config_id
ID of email config which is used for this ticket.
(i.e., support@yourcompany.com/sales@yourcompany.com)

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 15
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -fr_due_by
Timestamp that denotes when the first response is due

```yaml
Type: DateTime
Parameter Sets: default
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -group_id
Unique id of the group to which the ticket has been assigned.
The default value is the ID of the group that is
associated with the given email_config_id

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 17
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -source
The channel through which the ticket was created.
The default value is 2.

1  = Email
2  = Portal
3  = Phone
4  = Chat
5  = Feedback widget
6  = Yammer
7  = AWS Cloudwatch
9  = Pagerduty
10 = Walkup
11 = Slack

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tags
Tags that have been associated with the ticket

```yaml
Type: String[]
Parameter Sets: default
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -assets
List of assets associated with the ticket.

```yaml
Type: Object
Parameter Sets: default
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -urgency
Ticket urgency.

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 21
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -impact
Ticket impact.

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 22
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -category
Ticket category.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sub_category
Ticket sub category.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -item_category
Ticket item category.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -department_id
Department ID of the requester.

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 26
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -problem
Problem that need to be associated with ticket (problem display id).

```yaml
Type: Object
Parameter Sets: default
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -change_initiating_ticket
Change causing the ticket that needs to be associated with ticket (change display id).

```yaml
Type: Object
Parameter Sets: default
Aliases:

Required: False
Position: 28
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -change_initiated_by_ticket
Change needed for the ticket to be fixed that needs to be associated with ticket (change display id).

```yaml
Type: Object
Parameter Sets: default
Aliases:

Required: False
Position: 29
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
