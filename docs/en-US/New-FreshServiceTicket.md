---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceTicket

## SYNOPSIS
Creates a Freshservice Ticket.

## SYNTAX

```
New-FreshServiceTicket [[-name] <String>] [[-workspace_id] <Int64>] [[-requester_id] <Int64>] [-email] <String>
 [[-phone] <String>] [[-subject] <String>] [[-type] <String>] [-status] <Int32> [-priority] <Int32>
 [[-description] <String>] [[-responder_id] <Int64>] [[-attachments] <FileInfo[]>]
 [[-custom_fields] <Object[]>] [[-due_by] <DateTime>] [[-email_config_id] <Int64>] [[-fr_due_by] <DateTime>]
 [[-group_id] <Int64>] [[-source] <String>] [[-tags] <String[]>] [[-assets] <Object[]>] [[-urgency] <Int32>]
 [[-impact] <Int32>] [[-category] <String>] [[-sub_category] <String>] [[-item_category] <String>]
 [[-department_id] <Int64>] [[-problem] <Object[]>] [[-change_initiating_ticket] <Object[]>]
 [[-change_initiated_by_ticket] <Object[]>] [[-parent_id] <Int64>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a Freshservice Ticket via REST API.

https://api.freshservice.com/#create_ticket

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceTicket -email "rob.smith@company.com" -subject "VPN no worky" -description "Getting an error that VPN version not supported." -priority 2 -status 2 -tags 'VPN',"Version"
```

cc_emails        : {}
fwd_emails       : {}
reply_cc_emails  : {}
fr_escalated     : False
spam             : False
email_config_id  :
group_id         :
priority         : 1
requester_id     : 21000418005
requested_for_id : 21000418005
responder_id     :
source           : 2
status           : 2
subject          : VPN no worky
to_emails        :
department_id    :
id               : 8
type             : Incident
due_by           : 1/6/2023 8:29:51 PM
fr_due_by        : 12/30/2022 5:29:51 PM
is_escalated     : False
description      : \<div\>Getting an error that VPN version not supported.\</div\>
description_text : Getting an error that VPN version not supported.
category         :
sub_category     :
item_category    :
custom_fields    : @{my_custom_dropdown=}
created_at       : 12/27/2022 8:29:51 PM
updated_at       : 12/27/2022 8:29:51 PM
tags             : {VPN, Version}
attachments      : {}

Creates a new ticket for requester rob.smith@company.com with a Priority of 2 and Status of 2 with tags VPN and Version.

### EXAMPLE 2
```
New-FreshServiceTicket -email "rob.smith@company.com" -subject "Need help with HR forms" -description "What is a W4?" -priority 3 -status 3 -workspace_id 3
```

cc_emails          : {}
fwd_emails         : {}
reply_cc_emails    : {}
fr_escalated       : False
spam               : False
email_config_id    :
group_id           :
priority           : 3
requester_id       : 22000068599
requested_for_id   : 22000068599
responder_id       :
source             : 2
status             : 3
subject            : Need help with HR forms
to_emails          :
department_id      :
id                 : 8
type               : Case
due_by             : 3/1/2023 2:53:48 PM
fr_due_by          : 2/28/2023 3:53:48 PM
is_escalated       : False
description        : \<div\>What is a W4?\</div\>
description_text   : What is a W4?
category           :
sub_category       :
item_category      :
custom_fields      :
created_at         : 2/27/2023 8:53:48 PM
updated_at         : 2/27/2023 8:53:48 PM
tags               : {}
attachments        : {}
workspace_id       : 3
planned_start_date :
planned_end_date   :
planned_effort     :

Create ticket in a specific workspace.

## PARAMETERS

### -name
Name of the requester

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -workspace_id
Workspace ID of the ticket.
The attribute is applicable only for accounts with the 'Workspaces' feature enabled.
The default value is the ID of the primary workspace of the account.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -requester_id
User ID of the requester.
For existing contacts, the requester_id can be passed instead of the requester's email.

```yaml
Type: Int64
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases:

Required: True
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status
Status of the ticket.

'Open'     = 2
'Pending'  = 3
'Resolved' = 4
'Closed'   = 5

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -priority
Priority of the ticket.

'Urgent' = 4
'High'   = 3
'Medium' = 2
'Low'    = 1

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 9
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
HTML content of the ticket.

```yaml
Type: String
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Type: Object[]
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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

'Email'           = 1
'Portal'          = 2
'Phone'              = 3
'Chat'              = 4
'Feedback widget' = 5
'Yammer'          = 6
'AWS Cloudwatch'  = 7
'Pagerduty'       = 8
'Walkup'          = 9
'Slack'              = 10

```yaml
Type: String
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -assets
List of assets associated with the ticket

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -urgency
Ticket urgency

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -impact
Ticket impact

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -category
Ticket category

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sub_category
Ticket sub category

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -item_category
Ticket item category

```yaml
Type: String
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -problem
Problem that need to be associated with ticket (problem display id)

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -change_initiating_ticket
Change causing the ticket that needs to be associated with ticket (change display id)

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -change_initiated_by_ticket
Change needed for the ticket to be fixed that needs to be associated with ticket (change display id)

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -parent_id
The parent id to create a child ticket. 
Create child ticket under parent ticket X.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: ParentId, AsChildOf

Required: False
Position: 30
Default value: 0
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
