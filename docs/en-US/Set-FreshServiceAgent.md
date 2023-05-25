---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Set-FreshServiceAgent

## SYNOPSIS
Updates a Freshservice Agent.

## SYNTAX

### default (Default)
```
Set-FreshServiceAgent -id <Int64> [-first_name <String>] [-last_name <String>] [-occasional <Boolean>]
 [-job_title <String>] [-email <String>] [-work_phone_number <String>] [-mobile_phone_number <String>]
 [-department_ids <Int64[]>] [-can_see_all_tickets_from_associated_departments <Boolean>]
 [-reporting_manager_id <Int64>] [-address <String>] [-time_zone <String>] [-time_format <String>]
 [-language <String>] [-location_id <Int64>] [-background_information <String>] [-scoreboard_level_id <Int32>]
 [-member_of <Int64[]>] [-observer_of <Int64[]>] [-roles <Object[]>] [-signature <String>]
 [-custom_fields <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### reactivate
```
Set-FreshServiceAgent -id <Int64> [-reactivate] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### convert_to_requester
```
Set-FreshServiceAgent -id <Int64> [-convert_to_requester] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Agent via REST API.

https://api.freshservice.com/#update_an_agent
https://api.freshservice.com/#reactivate_an_agent
https://api.freshservice.com/#convert_an_agent_to_requester

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceAgent -Id 21001392937 -scoreboard_level_id 2 -address '123 Anywhere Ln'
```

active                                          : True
address                                         : 123 Anywhere Ln
auto_assign_status_changed_at                   :
auto_assign_tickets                             : True
background_information                          :
can_see_all_tickets_from_associated_departments : False
created_at                                      : 12/22/2022 6:11:57 PM
custom_fields                                   : @{employee_id=}
department_ids                                  : {}
department_names                                :
email                                           : dana@example.com
external_id                                     :
first_name                                      : Dana
has_logged_in                                   : True
id                                              : 21001392937
job_title                                       : Purveyor of code
language                                        : en
last_active_at                                  : 3/28/2023 11:31:21 PM
last_login_at                                   : 2/28/2023 11:16:03 PM
last_name                                       : Franks
location_id                                     :
location_name                                   :
mobile_phone_number                             :
occasional                                      : False
reporting_manager_id                            :
role_ids                                        : {21000150292}
roles                                           : {@{role_id=21000150292; assignment_scope=entire_helpdesk;
                                                groups=System.Object\[\]}}
scopes                                          : @{ticket=; problem=; change=; release=; asset=; solution=;
                                                contract=}
scoreboard_level_id                             : 2
scoreboard_points                               : 2600
signature                                       : \<p\>\<br\>\</p\>

time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 2/2/2023 1:40:03 AM
vip_user                                        : False
work_phone_number                               :
group_ids                                       : {}
member_of                                       : {}
observer_of                                     : {}
member_of_pending_approval                      : {}
observer_of_pending_approval                    : {}

Update a Freshservice Agent.

### EXAMPLE 2
```
Set-FreshServiceAgent -id 21001941828 -reactivate
```

active                                          : True
address                                         :
auto_assign_status_changed_at                   :
auto_assign_tickets                             : True
background_information                          : Awesome helpdesk training
can_see_all_tickets_from_associated_departments : False
created_at                                      : 3/27/2023 5:10:31 PM
custom_fields                                   : @{employee_id=}
department_ids                                  : {}
department_names                                :
email                                           : Alex.agent2@example.com
external_id                                     :
first_name                                      : Ralph
has_logged_in                                   : False
id                                              : 21001941828
job_title                                       : Code Monkey
language                                        : en
last_active_at                                  :
last_login_at                                   :
last_name                                       : Smith
location_id                                     :
location_name                                   :
mobile_phone_number                             :
occasional                                      : True
reporting_manager_id                            :
role_ids                                        : {21000150301, 21000150294}
roles                                           : {@{role_id=21000150294; assignment_scope=specified_groups;
                                                groups=System.Object\[\]}, @{role_id=21000150301;
                                                assignment_scope=specified_groups; groups=System.Object\[\]}}
scopes                                          : @{ticket=; problem=; change=; asset=; solution=; contract=}
scoreboard_level_id                             :
scoreboard_points                               :
signature                                       :
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 3/30/2023 2:06:51 AM
vip_user                                        : False
work_phone_number                               :
group_ids                                       : {}
member_of                                       : {}
observer_of                                     : {}
member_of_pending_approval                      : {}
observer_of_pending_approval                    : {}

Reactivate an agent.

### EXAMPLE 3
```
Set-FreshServiceAgent -id 21001941828 -convert_to_requester
```

active                                          : True
address                                         :
background_information                          : Awesome helpdesk training
can_see_all_changes_from_associated_departments : False
can_see_all_tickets_from_associated_departments : False
created_at                                      : 3/27/2023 5:10:30 PM
custom_fields                                   : @{employee_id=}
department_ids                                  : {}
department_names                                :
external_id                                     :
first_name                                      : Ralph
has_logged_in                                   : False
id                                              : 21001941828
is_agent                                        : False
job_title                                       : Code Monkey
language                                        : en
last_name                                       : Smith
location_id                                     :
location_name                                   :
mobile_phone_number                             :
primary_email                                   : Alex.agent2@example.com
reporting_manager_id                            :
secondary_emails                                : {}
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 3/30/2023 2:11:19 AM
vip_user                                        : False
work_phone_number                               :

Convert an agent to a requester.

## PARAMETERS

### -id
Unique id of the Agent.

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
First name of the agent

```yaml
Type: String
Parameter Sets: default
Aliases: FirstName

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -last_name
Last name of the agent.

```yaml
Type: String
Parameter Sets: default
Aliases: LastName

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -occasional
True if the agent is an occasional agent, and false if full-time agent.

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

### -job_title
Job title of the agent.

```yaml
Type: String
Parameter Sets: default
Aliases: JobTitle

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -email
Email address of the agent

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

### -work_phone_number
Work phone number of the agent.

```yaml
Type: String
Parameter Sets: default
Aliases: WorkNumber, WorkPhoneNumber

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -mobile_phone_number
Mobile phone number of the agent.

```yaml
Type: String
Parameter Sets: default
Aliases: MobilePhone, MobilePhoneNumber

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -department_ids
Unique IDs of the departments associated with the agent

```yaml
Type: Int64[]
Parameter Sets: default
Aliases: DepartmentId

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -can_see_all_tickets_from_associated_departments
Set to true if the agent must be allowed to view tickets filed by other members of the department, and false otherwise

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
User ID of the agent's reporting manager.

```yaml
Type: Int64
Parameter Sets: default
Aliases: ReportingManagerId

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -address
Address of the agent.

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
Time zone of the agent.

```yaml
Type: String
Parameter Sets: default
Aliases: TimeZone

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -time_format
Time format for the agent.Possible values: --12h (12 hour format) --24h (24 hour format)

```yaml
Type: String
Parameter Sets: default
Aliases: TimeFormat

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -language
Language used by the agent.
The default language is "en" (English).

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
Unique ID of the location associated with the agent.

```yaml
Type: Int64
Parameter Sets: default
Aliases: LocationId

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -background_information
Background information of the agent.

```yaml
Type: String
Parameter Sets: default
Aliases: BackgroundInformation

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -scoreboard_level_id
Unique ID of the level of the agent in the Arcade.
Possible values:--1 (Beginner)--2 (Intermediate)--3 (Professional)--4 (Expert)--5 (Master)--6 (Guru)

```yaml
Type: Int32
Parameter Sets: default
Aliases: ScoreboardLevel

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -member_of
Unique IDs of the groups that the agent is a member of.
The response value for this field would only contain the list of groups that the agent is an
approved member of.
The member_of_pending_approval read-only attribute in the response will include the list of groups for which the agent's member
access is pending approval by a group leader.

```yaml
Type: Int64[]
Parameter Sets: default
Aliases: MemberOf

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -observer_of
Unique IDs of the groups that the agent is an observer of.
The response value for this field would only contain the list of groups that the agent
is an approved observer of.
The observer_of_pending_approval read-only attribute in the response will include the list of groups for which the agent's
observer access is pending approval by a group leader.

```yaml
Type: Int64[]
Parameter Sets: default
Aliases: ObserverOf

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -roles
Each individual role is a hash in the roles array that contains the attributes.role_id: Unique ID of the role assigned"assignment_scope:
The scope in which the agent can use the permissions granted by this role.
Possible values include entire_helpdesk (all plans)

```yaml
Type: Object[]
Parameter Sets: default
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -signature
Signature of the agent in HTML format.

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
Key-value pair containing the names and values of the (custom) agent fields.

```yaml
Type: Hashtable
Parameter Sets: default
Aliases: CustomFields

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -convert_to_requester
This operation allows you to convert a particular agent into a requester.

```yaml
Type: SwitchParameter
Parameter Sets: convert_to_requester
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -reactivate
This operation allows you to reactivate a particular deactivated requester.

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
