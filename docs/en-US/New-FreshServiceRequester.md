---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# New-FreshServiceRequester

## SYNOPSIS
Returns a Freshservice ticket.

## SYNTAX

```
New-FreshServiceRequester [-external_id] <String> [-first_name] <String> [[-last_name] <String>]
 [[-job_title] <String>] [[-primary_email] <String>] [[-secondary_emails] <String[]>]
 [[-work_phone_number] <String>] [[-mobile_phone_number] <String>] [[-department_ids] <Int64[]>]
 [[-can_see_all_changes_from_associated_departments] <Boolean>]
 [[-can_see_all_tickets_from_associated_departments] <Boolean>] [[-reporting_manager_id] <Int32>]
 [[-address] <String>] [[-time_zone] <String>] [[-time_format] <String>] [[-language] <String>]
 [[-location_id] <Int32>] [[-background_information] <String>] [[-custom_fields] <Object>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice ticket via REST API.

https://api.freshservice.com/#create_a_requester

## EXAMPLES

### EXAMPLE 1
```
New-FreshServicerequester -first_name 'John' -last_name 'Smith' -job_title 'QA Tester' -primary_email 'jsmith@company.com'
```

active                                          : True
address                                         :
background_information                          :
can_see_all_tickets_from_associated_departments : False
created_at                                      : 3/31/2022 1:23:36 AM
custom_fields                                   : @{ad_location1=; ad_location2=}
department_ids                                  : {}
external_id                                     :
first_name                                      : John
has_logged_in                                   : False
id                                              : 18012783346
is_agent                                        : False
job_title                                       : QA Tester
language                                        : en
last_name                                       : Smith
location_id                                     :
mobile_phone_number                             :
primary_email                                   : jsmith@company.com
reporting_manager_id                            :
secondary_emails                                : {}
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 3/31/2022 1:23:36 AM
vip_user                                        : False
work_phone_number                               :

Creates a a new Freshservice Requester.

## PARAMETERS

### -external_id
External Id of the requester.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -first_name
First name of the requester.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -last_name
Last name of the requester.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -job_title
Job title of the requester.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -primary_email
Primary email address of the requester.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -secondary_emails
Additional/secondary emails associated with the requester.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -work_phone_number
Work phone number of the requester.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobile_phone_number
Mobile phone number of the requester.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -department_ids
Unique IDs of the departments associated with the requester.

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -can_see_all_changes_from_associated_departments
Set to true if the requester must be allowed to view changes filed by other members of the department, and false otherwise.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -can_see_all_tickets_from_associated_departments
Set to true if the requester must be allowed to view tickets filed by other members of the department, and false otherwise.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -reporting_manager_id
User ID of the requester's reporting manager.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -address
Address of the requester.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -time_zone
Time zone of the requester.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -time_format
Time format for the requester.Possible values:12h (12 hour format)24h (24 hour format)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -language
Language used by the requester.
The default language is "en" (English).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -location_id
Unique ID of the location associated with the requester.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -background_information
Background information of the requester.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -custom_fields
Key-value pair containing the names and values of the (custom) requester fields.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
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
