---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# New-FreshServiceRequest

## SYNOPSIS
Creates new Freshservice Service Request.

## SYNTAX

```
New-FreshServiceRequest [-display_id] <Int64> [[-quantity] <Int32>] [[-requested_for] <String>]
 [[-email] <String>] [[-child_items] <Object[]>] [[-custom_fields] <Object>] [[-parent_ticket_id] <Int64>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates new Freshservice Service Request via REST API.

The service requested will be created with the requester specified in "email" attribute.
If no email is provided, the request is created on behalf of the agent

Fields in the API behave like the agent portal's new service request page.
If a field is not visible in self service portal, you can still provide a value for
that field using the api.
If a field is marked mandatory but not visible in portal in service item, you must provide a value for it in the api.

https://api.freshservice.com/#create_service_request

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceRequest -display_id 2 -email 'rob.simmers@flycastpartners.com'
```

subject              : Request for Rob Simmers : Windows Laptop
group_id             :
department_id        :
category             :
sub_category         :
item_category        :
requester_id         : 21000418005
responder_id         :
due_by               : 1/10/2023 12:14:43 PM
fr_escalated         : False
deleted              : False
spam                 : False
email_config_id      :
fwd_emails           : {}
reply_cc_emails      : {}
cc_emails            : {}
is_escalated         : False
fr_due_by            : 1/6/2023 2:14:43 PM
created_at           : 1/5/2023 8:14:43 PM
updated_at           : 1/5/2023 8:14:43 PM
status               : 2
source               : 2
priority             : 2
urgency              : 1
impact               : 1
sla_policy_id        : 21000057781
id                   : 12
type                 : Service Request
description          :
description_text     :
to_emails            :
approval_status      : not_requested
approval_status_name : Not Requested
custom_fields        : @{my_custom_dropdown=}
attachments          : {}

Creates a new Freshservice Service Request.

### EXAMPLE 2
```
New-FreshServiceRequest -parent_ticket_id 221 -display_id 3 -quantity 2 -email 'rob.simmers@flycastpartners.com'
```

subject              : Request for Rob Simmers : Microsoft Office 2013
group_id             :
department_id        :
category             :
sub_category         :
item_category        :
requester_id         : 21000418005
responder_id         :
due_by               : 4/27/2023 3:40:04 PM
fr_escalated         : False
deleted              : False
spam                 : False
email_config_id      :
fwd_emails           : {}
reply_cc_emails      : {}
cc_emails            : {}
is_escalated         : False
fr_due_by            : 4/25/2023 5:40:04 PM
created_at           : 4/24/2023 6:40:04 PM
updated_at           : 4/24/2023 6:40:04 PM
status               : 2
source               : 2
priority             : 2
urgency              : 1
impact               : 1
sla_policy_id        : 21000057781
id                   : 227
type                 : Service Request
description          :
description_text     :
to_emails            :
approval_status      : not_requested
approval_status_name : Not Requested
custom_fields        : @{weather_server=}
attachments          : {}

Create a Freshservice child ticket for a parent ticket.

Note 1:
    Association of child Service Requests to an Incident is not possible

Note 2:
    Association of child Service Request to a deleted or a spammed ticket is not allowed.

Note 3:
    Nesting of a child Service Request under another child Service Request is not supported.

## PARAMETERS

### -display_id
The Display Id of the Service Request to be requested.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: SRID, DisplayId

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -quantity
Quantity needed by the requested

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -requested_for
Email id of the requester on whose behalf the service request is created

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -email
Email id of the requester

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -child_items
Service items that are included as child items.
Provide the display id as service_item_id for each child item.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -custom_fields
Values of custom fields present in the service item form

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -parent_ticket_id
Create as a child request.
Display ID of the parent Service Request

Note 1:
    Association of child Service Requests to an Incident is not possible

Note 2:
    Association of child Service Request to a deleted or a spammed ticket is not allowed.

Note 3:
    Nesting of a child Service Request under another child Service Request is not supported.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: parent_id

Required: False
Position: 7
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
