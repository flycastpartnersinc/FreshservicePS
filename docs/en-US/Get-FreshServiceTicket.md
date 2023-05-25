---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceTicket

## SYNOPSIS
Returns a Freshservice ticket.

## SYNTAX

### default (Default)
```
Get-FreshServiceTicket [[-workspace_id] <Int64>] [[-updated_since] <DateTime>] [[-include_global] <String[]>]
 [[-predefined_filter] <String>] [[-requester_id] <Int64>] [[-email] <String>] [[-type] <String[]>]
 [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceTicket [-id] <Int64> [[-include] <String[]>] [-activities] [-csat_response]
 [<CommonParameters>]
```

### filter
```
Get-FreshServiceTicket [[-filter] <String>] [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### fields
```
Get-FreshServiceTicket [-fields] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice ticket via REST API.

https://api.freshservice.com/#view_a_ticket

## EXAMPLES

### EXAMPLE 1
```
Get-FreshserviceTicket
```

subject          : Where can I find more information about employee health benefits?
group_id         :
department_id    :
category         :
sub_category     :
item_category    :
requester_id     : 21000418007
responder_id     :
due_by           : 9/8/2022 2:17:57 PM
fr_escalated     : True
deleted          : False
spam             : False
email_config_id  :
fwd_emails       : {}
reply_cc_emails  : {}
cc_emails        : {}
is_escalated     : True
fr_due_by        : 8/31/2022 8:17:57 PM
id               : 4
priority         : 1
status           : 2
source           : 2
created_at       : 8/29/2022 2:17:57 PM
updated_at       : 11/17/2022 8:08:21 PM
requested_for_id : 21000418007
to_emails        :
type             : Incident
description      : Testing API set
description_text : Testing API set
custom_fields    : @{weather_server=}

subject          : Request for Andrea : Dell Monitor
group_id         :
department_id    :
category         :
sub_category     :
item_category    :
requester_id     : 21000418006
responder_id     :
due_by           : 8/31/2022 8:17:53 PM
fr_escalated     : True
deleted          : False
spam             : False
email_config_id  :
fwd_emails       : {}
reply_cc_emails  : {}
cc_emails        : {}
is_escalated     : True
fr_due_by        : 8/30/2022 1:17:53 PM
id               : 3
priority         : 2
status           : 2
source           : 2
created_at       : 8/29/2022 2:17:53 PM
updated_at       : 8/29/2022 2:17:53 PM
requested_for_id : 21000418006
to_emails        :
type             : Service Request
description      :
description_text :
custom_fields    : @{weather_server=}

subject          : Request for Andrea : Logitech Wireless Mouse
group_id         :
department_id    :
category         :
sub_category     :
item_category    :
requester_id     : 21000418006
responder_id     :
due_by           : 8/31/2022 8:17:53 PM
fr_escalated     : True
deleted          : False
spam             : False
email_config_id  :
fwd_emails       : {}
reply_cc_emails  : {}
cc_emails        : {}
is_escalated     : True
fr_due_by        : 8/30/2022 1:17:53 PM
id               : 2
priority         : 2
status           : 2
source           : 2
created_at       : 8/29/2022 2:17:53 PM
updated_at       : 8/29/2022 2:17:53 PM
requested_for_id : 21000418006
to_emails        :
type             : Service Request
description      :
description_text :
custom_fields    : @{weather_server=}

subject          : What's wrong with my email?
group_id         :
department_id    :
category         :
sub_category     :
item_category    :
requester_id     : 21000418006
responder_id     :
due_by           : 9/8/2022 2:17:01 PM
fr_escalated     : True
deleted          : False
spam             : False
email_config_id  :
fwd_emails       : {}
reply_cc_emails  : {}
cc_emails        : {}
is_escalated     : True
fr_due_by        : 8/31/2022 8:17:01 PM
id               : 1
priority         : 1
status           : 2
source           : 2
created_at       : 8/29/2022 2:17:01 PM
updated_at       : 8/29/2022 2:17:01 PM
requested_for_id : 21000418006
to_emails        :
type             : Incident
description      : \<div\>Hi Team,\<br/\> \<br/\>I have been unable to send any emails since this morning.
What's going
                on?\<br/\>\<br/\>Regards,\<br/\> Andrea \</div\>
description_text : Hi Team, I have been unable to send any emails since this morning.
What's going on?
Regards,
                Andrea
custom_fields    : @{weather_server=}

Return all Freshservice Tickets.

### EXAMPLE 2
```
Get-FreshserviceTicket -id 2
```

cc_emails                     :
fwd_emails                    :
reply_cc_emails               :
bcc_emails                    :
fr_escalated                  : True
spam                          : False
email_config_id               :
group_id                      :
priority                      : 2
requester_id                  : 21000418006
requested_for_id              : 21000418006
responder_id                  :
source                        : 2
status                        : 2
subject                       : Request for Andrea : Logitech Wireless Mouse
to_emails                     :
sla_policy_id                 : 21000057781
applied_business_hours        : 21000011791
department_id                 :
id                            : 2
type                          : Service Request
due_by                        : 8/31/2022 8:17:53 PM
fr_due_by                     : 8/30/2022 1:17:53 PM
is_escalated                  : True
description                   :
description_text              :
custom_fields                 : @{weather_server=}
created_at                    : 8/29/2022 2:17:53 PM
updated_at                    : 8/29/2022 2:17:53 PM
urgency                       : 1
impact                        : 1
category                      :
sub_category                  :
item_category                 :
deleted                       : False
attachments                   : {}
created_within_business_hours : True
approval_status               : 4
approval_status_name          : Not Requested

Return Freshservice Ticket by Id.

### EXAMPLE 3
```
Get-FreshServiceTicket -predefined_filter new_and_my_open
```

Return Freshservice Tickets with pre-defined filters (new_and_my_open, watching, spam, deleted)

### EXAMPLE 4
```
'2022-01-01'"
```

Return Freshservice Ticket with advanced Filter.

### EXAMPLE 5
```
Get-FreshServiceTicket -updated_since (Get-Date).AddDays(-4)
```

subject          : Attachment Test
group_id         :
department_id    : 21000351606
category         :
sub_category     :
item_category    :
requester_id     : 21000418005
responder_id     :
due_by           : 4/5/2023 9:00:00 PM
fr_escalated     : False
deleted          : False
spam             : False
email_config_id  :
fwd_emails       : {}
reply_cc_emails  : {}
cc_emails        : {}
is_escalated     : False
fr_due_by        : 3/29/2023 6:00:00 PM
id               : 210
priority         : 1
status           : 2
source           : 2
created_at       : 3/25/2023 7:24:41 PM
updated_at       : 3/25/2023 7:24:41 PM
requested_for_id : 21000418005
to_emails        :
type             : Incident
description      : \<div\>=\</div\>
description_text : =
custom_fields    : @{weather_server=}

subject          : Employee Onboarding Request
group_id         : 21000188390
department_id    : 21000351606
category         :
sub_category     :
item_category    :
requester_id     : 21000418005
responder_id     :
due_by           : 4/5/2023 9:00:00 PM
fr_escalated     : False
deleted          : False
spam             : False
email_config_id  :
fwd_emails       : {}
reply_cc_emails  : {}
cc_emails        : {}
is_escalated     : False
fr_due_by        : 3/29/2023 6:00:00 PM
id               : 208
priority         : 1
status           : 2
source           : 13
created_at       : 3/25/2023 5:32:16 PM
updated_at       : 3/25/2023 5:32:16 PM
requested_for_id : 21000418005
to_emails        :
type             : Service Request
description      :
description_text :
custom_fields    : @{weather_server=}

subject          : Create Email Address
group_id         : 21000188390
department_id    : 21000351606
category         :
sub_category     :
item_category    :
requester_id     : 21000418005
responder_id     :
due_by           : 4/5/2023 9:00:00 PM
fr_escalated     : False
deleted          : False
spam             : False
email_config_id  :
fwd_emails       : {}
reply_cc_emails  : {}
cc_emails        : {}
is_escalated     : False
fr_due_by        : 3/29/2023 6:00:00 PM
id               : 209
priority         : 1
status           : 2
source           : 13
created_at       : 3/25/2023 5:32:16 PM
updated_at       : 3/25/2023 5:32:16 PM
requested_for_id : 21000418005
to_emails        :
type             : Service Request
description      :
description_text :
custom_fields    : @{weather_server=}

Return Freshservice Tickets updated in the last 4 days.

### EXAMPLE 6
```
Get-FreshServiceTicket -type 'Service Request'
```

subject          : Request for Alex : Windows Laptop
group_id         :
department_id    :
category         :
sub_category     :
item_category    :
requester_id     : 21000418005
responder_id     :
due_by           : 3/1/2023 3:11:18 PM
fr_escalated     : True
deleted          : False
spam             : False
email_config_id  :
fwd_emails       : {}
reply_cc_emails  : {}
cc_emails        : {}
is_escalated     : True
fr_due_by        : 2/27/2023 5:11:18 PM
id               : 171
priority         : 2
status           : 2
source           : 2
created_at       : 2/24/2023 6:11:18 PM
updated_at       : 2/24/2023 6:11:18 PM
requested_for_id : 21000418005
to_emails        :
type             : Service Request
description      :
description_text :
custom_fields    : @{weather_server=}

subject          : Request for Alex : Windows Laptop
group_id         :
department_id    :
category         :
sub_category     :
item_category    :
requester_id     : 21000418005
responder_id     :
due_by           : 3/1/2023 3:09:30 PM
fr_escalated     : True
deleted          : False
spam             : False
email_config_id  :
fwd_emails       : {}
reply_cc_emails  : {}
cc_emails        : {}
is_escalated     : True
fr_due_by        : 2/27/2023 5:09:30 PM
id               : 168
priority         : 2
status           : 2
source           : 2
created_at       : 2/24/2023 6:09:30 PM
updated_at       : 2/24/2023 6:09:30 PM
requested_for_id : 21000418005
to_emails        :
type             : Service Request
description      :
description_text :
custom_fields    : @{weather_server=}

subject          : Request for Alex : Windows Laptop
group_id         :
department_id    :
category         :
sub_category     :
item_category    :
requester_id     : 21000418005
responder_id     :
due_by           : 3/1/2023 3:05:22 PM
fr_escalated     : True
deleted          : False
spam             : False
email_config_id  :
fwd_emails       : {}
reply_cc_emails  : {}
cc_emails        : {}
is_escalated     : True
fr_due_by        : 2/27/2023 5:05:22 PM
id               : 164
priority         : 2
status           : 2
source           : 2
created_at       : 2/24/2023 6:05:22 PM
updated_at       : 2/24/2023 6:05:22 PM
requested_for_id : 21000418005
to_emails        :
type             : Service Request
description      :
description_text :
custom_fields    : @{weather_server=}

Returns all Freshservice Service Requests.

### EXAMPLE 7
```
Get-FreshServiceTicket -id 2 -activities
```

actor                          content
-----                          -------
@{id=21000418007; name=System} added item Logitech Wireless Mouse
@{id=21000418006; name=Andrea} created ticket for Andrea,  set Status as Open, set Urgency as Low, set Priority as M...

Returns a Freshservice Ticket activities.

### EXAMPLE 8
```
Get-FSTicket -id 100 -include related_tickets, stats
```

cc_emails                     : {}
fwd_emails                    : {}
reply_cc_emails               : {}
bcc_emails                    :
fr_escalated                  : True
spam                          : False
email_config_id               :
group_id                      :
priority                      : 2
requester_id                  : 21000418005
requested_for_id              : 21000418005
responder_id                  :
source                        : 9
status                        : 2
subject                       : Pester test ticket 28a2496e-fb2e-48e0-b210-49ee9b1e67be
to_emails                     :
sla_policy_id                 : 21000057781
applied_business_hours        : 21000011791
department_id                 :
id                            : 100
type                          : Incident
due_by                        : 2/28/2023 7:00:00 PM
fr_due_by                     : 2/24/2023 9:00:00 PM
is_escalated                  : True
description                   : \<div\>Test ticket from Powershell Module with GUID
                                28a2496e-fb2e-48e0-b210-49ee9b1e67be\</div\>
description_text              : Test ticket from Powershell Module with GUID
                                28a2496e-fb2e-48e0-b210-49ee9b1e67be
custom_fields                 : @{weather_server=}
created_at                    : 2/24/2023 3:30:30 AM
updated_at                    : 3/28/2023 10:26:20 PM
urgency                       : 2
impact                        : 2
category                      : Software
sub_category                  :
item_category                 :
deleted                       : False
attachments                   : {}
created_within_business_hours : False
stats                         : @{ticket_id=21003880128; opened_at=; pending_since=; resolved_at=;
                                closed_at=; first_assigned_at=; assigned_at=; first_responded_at=;
                                agent_responded_at=; created_at=2/24/2023 3:30:30 AM;
                                updated_at=3/28/2023 10:26:20 PM; group_escalated=False; inbound_count=1;
                                status_updated_at=2/24/2023 3:30:30 AM; outbound_count=0;
                                first_resp_time_in_secs=; resolution_time_in_secs=745200}
related_tickets               : @{child_ids=System.Object\[\]}

Get a Freshservice Ticket and include related tickets and stats.

### EXAMPLE 9
```
Get-FreshServiceTicket -fields
```

id                     : 21000152095
label                  : Requester
description            : Ticket requester
field_type             : default_requester
created_at             : 8/29/2022 10:17:01 AM
updated_at             : 8/29/2022 10:17:01 AM
position               : 1
required_for_closure   : False
name                   : requester
default_field          : True
required_for_agents    : True
customers_can_edit     : True
label_for_customers    : Requester
required_for_customers : True
displayed_to_customers : True
belongs_to_section     : False
portal_cc              : False
portalcc_to            : company
choices                : {}
nested_fields          : {}
sections               : {}

id                     : 21000152096
label                  : Subject
description            : Ticket subject
field_type             : default_subject
created_at             : 8/29/2022 10:17:01 AM
updated_at             : 8/29/2022 10:17:01 AM
position               : 2
required_for_closure   : False
name                   : subject
default_field          : True
required_for_agents    : True
customers_can_edit     : True
label_for_customers    : Subject
required_for_customers : True
displayed_to_customers : True
belongs_to_section     : False
choices                : {}
nested_fields          : {}
sections               : {}

id                     : 21000152097
label                  : Type
description            : Ticket type
field_type             : default_ticket_type
created_at             : 8/29/2022 10:17:01 AM
updated_at             : 8/29/2022 10:17:01 AM
position               : 3
required_for_closure   : False
name                   : ticket_type
default_field          : True
required_for_agents    : False
customers_can_edit     : False
label_for_customers    : Type
required_for_customers : False
displayed_to_customers : False
belongs_to_section     : False
choices                : {@{id=21000039527; value=Incident}, @{id=21000039528; value=Service Request}}
nested_fields          : {}
sections               : {}

Returns all the built-in and custom fields for Tickets.

## PARAMETERS

### -id
Unique Id of the Ticket.

```yaml
Type: Int64
Parameter Sets: id
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -workspace_id
Workspace id is applicable only for accounts with Workspaces feature enabled.
The value 1 for workspace_id will return tickets from all workspaces, with only global level fields.

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -filter
Filter results for Ticket. 
Documentation can be found here to get the latest capabilities and examples:

https://api.freshservice.com/#filter_tickets

The function will automatically encode the url query prior to the API call.

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -updated_since
Filter to return tickets updated since a provided date and time.

```yaml
Type: DateTime
Parameter Sets: default
Aliases: UpdateSince

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -include
By default, certain fields such as conversations, tags and requester email will not be included in the response.
They can be retrieved via the embedding functionality.

Use 'include' to embed additional details in the response.
Each include will consume an additional credit.
For example,
if you embed the requester and company information you will be charged a total of 3 API credits for the call.

The include parameter is for getting ticket by ID and has the following options:

tags
conversations
requester
stats
problem
assets
change
related_tickets
requested_for
department
feedback

```yaml
Type: String[]
Parameter Sets: id
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -include_global
By default, certain fields such as conversations, tags and requester email will not be included in the response.
They can be retrieved via the embedding functionality.

Use 'include' to embed additional details in the response.
Each include will consume an additional credit.
For example,
if you embed the requester and company information you will be charged a total of 3 API credits for the call.

The include parameter is for getting all tickets and has the following options:

requester
stats
tags
requested_for
department

```yaml
Type: String[]
Parameter Sets: default
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -predefined_filter
Predefined filters.
The filters available are new_and_my_open, watching, spam, deleted.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -requester_id
Filter tickets based on provided requester id.

```yaml
Type: Int64
Parameter Sets: default
Aliases: RequesterId

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -email
Filter tickets based on provided email.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
Filter tickets based on the ticket type (i.e.
Incident, Service Request or Alert)

```yaml
Type: String[]
Parameter Sets: default
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -activities
Return ticket Activities for a specific ticket.

```yaml
Type: SwitchParameter
Parameter Sets: id
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
Allows you to view all the built-in and custom fields for Tickets in your Freshservice account.

```yaml
Type: SwitchParameter
Parameter Sets: fields
Aliases: Form

Required: False
Position: 1
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -csat_response
Retrieve a csat response of a Ticket with the given ID from Freshservice.

```yaml
Type: SwitchParameter
Parameter Sets: id
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -per_page
Number of records to return per page during pagination. 
Maximum of 100 records.

```yaml
Type: Int32
Parameter Sets: default, filter
Aliases:

Required: False
Position: 8
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -page
The page number to retrieve during pagination.

```yaml
Type: Int32
Parameter Sets: default, filter
Aliases:

Required: False
Position: 9
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
