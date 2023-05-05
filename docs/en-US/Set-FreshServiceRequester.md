---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServiceRequester

## SYNOPSIS
Updates a Freshservice Requester.

## SYNTAX

### default (Default)
```
Set-FreshServiceRequester -id <Int64> [-first_name <String>] [-last_name <String>] [-job_title <String>]
 [-primary_email <String>] [-secondary_emails <String[]>] [-work_phone_number <String>]
 [-mobile_phone_number <String>] [-department_ids <Int64[]>]
 [-can_see_all_tickets_from_associated_departments <Boolean>] [-reporting_manager_id <Int32>]
 [-address <String>] [-time_zone <String>] [-time_format <String>] [-language <String>] [-location_id <Int32>]
 [-background_information <String>] [-custom_fields <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### merge
```
Set-FreshServiceRequester -id <Int64> [-merge] -secondary_requesters <Int64[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### convert_to_agent
```
Set-FreshServiceRequester -id <Int64> [-convert_to_agent] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### reactivate
```
Set-FreshServiceRequester -id <Int64> [-reactivate] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Requester via REST API.

https://api.freshservice.com/#requesters

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceRequester -id 21001799737 -job_title 'Analyst II'
```

active                                          : True
address                                         : 123 Anywhere Lane
background_information                          : Technical Wizard Lvl 1000.
can_see_all_changes_from_associated_departments : False
can_see_all_tickets_from_associated_departments : False
created_at                                      : 3/3/2023 2:27:49 PM
custom_fields                                   : @{employee_id=}
department_ids                                  : {}
department_names                                :
external_id                                     : 33359e1c-153f-4e67-a66f-cafdd5949a2e
first_name                                      : Rob
has_logged_in                                   : False
id                                              : 21001799737
is_agent                                        : False
job_title                                       : Analyst II
language                                        : en
last_name                                       : Simmers
location_id                                     :
location_name                                   :
mobile_phone_number                             : 800-555-9999
primary_email                                   : rasimmers.test1@gmail.com
reporting_manager_id                            :
secondary_emails                                : {rasimmers.test2@gmail.com}
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 3/31/2023 1:15:40 AM
vip_user                                        : False
work_phone_number                               :

Updates the title of a Freshservice Requester.

### EXAMPLE 2
```
Set-FreshServiceRequester -id 21001799737 -reactivate
```

active                                          : True
address                                         : 123 Anywhere Lane
background_information                          : Technical Wizard Lvl 1000.
can_see_all_changes_from_associated_departments : False
can_see_all_tickets_from_associated_departments : False
created_at                                      : 3/3/2023 2:27:49 PM
custom_fields                                   : @{employee_id=}
department_ids                                  : {}
department_names                                :
external_id                                     : 33359e1c-153f-4e67-a66f-cafdd5949a2e
first_name                                      : Rob
has_logged_in                                   : False
id                                              : 21001799737
is_agent                                        : False
job_title                                       : Analyst II
language                                        : en
last_name                                       : Simmers
location_id                                     :
location_name                                   :
mobile_phone_number                             : 800-555-9999
primary_email                                   : rasimmers.test1@gmail.com
reporting_manager_id                            :
secondary_emails                                : {rasimmers.test2@gmail.com}
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 3/31/2023 1:19:07 AM
vip_user                                        : False
work_phone_number                               :

Reactivates a deactivated requester.

### EXAMPLE 3
```
Set-FreshServiceRequester -id 21001799737 -merge -secondary_requesters 21001941828
```

active                                          : True
address                                         : 123 Anywhere Lane
background_information                          : Technical Wizard Lvl 1000.
can_see_all_changes_from_associated_departments : False
can_see_all_tickets_from_associated_departments : False
created_at                                      : 3/3/2023 2:27:49 PM
custom_fields                                   : @{employee_id=}
department_ids                                  : {}
department_names                                :
external_id                                     : 33359e1c-153f-4e67-a66f-cafdd5949a2e
first_name                                      : Rob
has_logged_in                                   : False
id                                              : 21001799737
is_agent                                        : False
job_title                                       : Analyst II
language                                        : en
last_name                                       : Simmers
location_id                                     :
location_name                                   :
mobile_phone_number                             : 800-555-9999
primary_email                                   : rasimmers.test1@gmail.com
reporting_manager_id                            :
secondary_emails                                : {rasimmers.agent2@gmail.com, rasimmers.test2@gmail.com}
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 3/31/2023 1:22:44 AM
vip_user                                        : False
work_phone_number                               :

Merge secondary requesters with a primary Freshservice Requester.

## PARAMETERS

### -id
Unique Id of the requester.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -first_name
First name of the requester.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -last_name
Last name of the requester.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -job_title
Job title of the requester.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -primary_email
Primary email address of the requester.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secondary_emails
Additional/secondary emails associated with the requester.

```yaml
Type: String[]
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -work_phone_number
Work phone number of the requester.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -mobile_phone_number
Mobile phone number of the requester.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -department_ids
Unique IDs of the departments associated with the requester

```yaml
Type: Int64[]
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -can_see_all_tickets_from_associated_departments
Set to true if the requester must be allowed to view tickets filed by other members of the department,
and false otherwise.

can_see_all_tickets_from_associated_departments will automatically be set to false unless it is explicitly set to true in the payload,
irrespective of the previous value of the field.

```yaml
Type: Boolean
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -reporting_manager_id
User ID of the requester's reporting manager.

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -address
Address of the requester.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -time_zone
Time zone of the requester.
Read more here.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -time_format
Time format for the requester.Possible values:12h (12 hour format)24h (24 hour format)

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -language
Language used by the requester.
The default language is "en" (English).
Read more here.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -location_id
Unique ID of the location associated with the requester.

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -background_information
Background information of the requester.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -custom_fields
Key-value pair containing the names and values of the (custom) requester fields.

```yaml
Type: Hashtable
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -convert_to_agent
Convert a requester to an occasional agent with SD Agent role and no group memberships.

https://api.freshservice.com/#convert_to_agent

```yaml
Type: SwitchParameter
Parameter Sets: convert_to_agent
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -reactivate
This operation allows you to reactivate a particular deactivated requester.

https://api.freshservice.com/#reactivate_a_requester

```yaml
Type: SwitchParameter
Parameter Sets: reactivate
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -merge
Merge secondary requesters into a primary requester.

https://api.freshservice.com/#merge_requesters

```yaml
Type: SwitchParameter
Parameter Sets: merge
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secondary_requesters
Secondary requester ids for Merge operation.

```yaml
Type: Int64[]
Parameter Sets: merge
Aliases:

Required: True
Position: Named
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
