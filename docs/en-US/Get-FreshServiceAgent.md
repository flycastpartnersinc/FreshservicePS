---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceAgent

## SYNOPSIS
Returns a Freshservice Agent.

## SYNTAX

### default (Default)
```
Get-FreshServiceAgent [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceAgent [[-Id] <Int64>] [<CommonParameters>]
```

### Filter
```
Get-FreshServiceAgent [[-Filter] <String>] [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### State
```
Get-FreshServiceAgent [[-State] <String>] [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### Form
```
Get-FreshServiceAgent [-fields] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Agent via REST API.

https://api.freshservice.com/#view_an_agent

## EXAMPLES

### EXAMPLE 1
```
Get-FreshserviceAgent
```

active                                          : False
address                                         :
auto_assign_status_changed_at                   :
auto_assign_tickets                             : True
background_information                          :
can_see_all_tickets_from_associated_departments : False
created_at                                      : 8/29/2022 2:17:02 PM
custom_fields                                   :
department_ids                                  : {}
department_names                                :
email                                           : rachel@freshservice.com
external_id                                     :
first_name                                      : Rachel
has_logged_in                                   : False
id                                              : 21000418008
job_title                                       :
language                                        : en
last_active_at                                  :
last_login_at                                   :
last_name                                       :
location_id                                     :
location_name                                   :
mobile_phone_number                             :
occasional                                      : False
reporting_manager_id                            :
role_ids                                        : {21000150295}
roles                                           : {@{role_id=21000150295; assignment_scope=entire_helpdesk;
                                                groups=System.Object\[\]}}
scopes                                          : @{ticket=; problem=; change=; asset=; solution=; contract=}
scoreboard_level_id                             :
scoreboard_points                               :
signature                                       :
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 8/29/2022 2:17:02 PM
vip_user                                        : False
work_phone_number                               :
group_ids                                       : {}
member_of                                       : {}
observer_of                                     : {}
member_of_pending_approval                      : {}
observer_of_pending_approval                    : {}

active                                          : True
address                                         :
auto_assign_status_changed_at                   : 10/31/2022 3:20:53 PM
auto_assign_tickets                             : True
background_information                          :
can_see_all_tickets_from_associated_departments : False
created_at                                      : 8/29/2022 2:17:01 PM
custom_fields                                   :
department_ids                                  : {}
department_names                                :
email                                           : alex@example.com
external_id                                     :
first_name                                      : Alex
has_logged_in                                   : True
id                                              : 21000418005
job_title                                       :
language                                        : en
last_active_at                                  : 11/2/2022 1:40:09 AM
last_login_at                                   : 9/29/2022 12:49:59 PM
last_name                                       : Smith
location_id                                     :
location_name                                   :
mobile_phone_number                             :
occasional                                      : False
reporting_manager_id                            :
role_ids                                        : {21000150292}
roles                                           : {@{role_id=21000150292; assignment_scope=entire_helpdesk;
                                                groups=System.Object\[\]}}
scopes                                          : @{ticket=; problem=; change=; release=; asset=; solution=; contract=}
scoreboard_level_id                             :
scoreboard_points                               :
signature                                       :
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 8/29/2022 2:17:01 PM
vip_user                                        : False
work_phone_number                               :
group_ids                                       : {}
member_of                                       : {}
observer_of                                     : {}
member_of_pending_approval                      : {}
observer_of_pending_approval                    : {}

Returns all Freshservice Agents.

### EXAMPLE 2
```
Get-FreshserviceAgent -Id 21000418005
```

active                                          : True
address                                         :
auto_assign_status_changed_at                   : 10/31/2022 3:20:53 PM
auto_assign_tickets                             : True
background_information                          :
can_see_all_tickets_from_associated_departments : False
created_at                                      : 8/29/2022 2:17:01 PM
custom_fields                                   :
department_ids                                  : {}
department_names                                :
email                                           : alex@example.com
external_id                                     :
first_name                                      : Alex
has_logged_in                                   : True
id                                              : 21000418005
job_title                                       :
language                                        : en
last_active_at                                  : 11/2/2022 1:40:09 AM
last_login_at                                   : 9/29/2022 12:49:59 PM
last_name                                       : Smith
location_id                                     :
location_name                                   :
mobile_phone_number                             :
occasional                                      : False
reporting_manager_id                            :
role_ids                                        : {21000150292}
roles                                           : {@{role_id=21000150292; assignment_scope=entire_helpdesk;
                                                groups=System.Object\[\]}}
scopes                                          : @{ticket=; problem=; change=; release=; asset=; solution=; contract=}
scoreboard_level_id                             :
scoreboard_points                               :
signature                                       :
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 8/29/2022 2:17:01 PM
vip_user                                        : False
work_phone_number                               :
group_ids                                       : {}
member_of                                       : {}
observer_of                                     : {}
member_of_pending_approval                      : {}
observer_of_pending_approval                    : {}

Returns a Freshservice Agent by Id.

### EXAMPLE 3
```
Get-FreshserviceAgent -Filter "email:'alex@example.com'"
```

active                                          : True
address                                         :
auto_assign_status_changed_at                   : 10/31/2022 3:20:53 PM
auto_assign_tickets                             : True
background_information                          :
can_see_all_tickets_from_associated_departments : False
created_at                                      : 8/29/2022 2:17:01 PM
custom_fields                                   :
department_ids                                  : {}
department_names                                :
email                                           : alex@example.com
external_id                                     :
first_name                                      : Alex
has_logged_in                                   : True
id                                              : 21000418005
job_title                                       :
language                                        : en
last_active_at                                  : 11/2/2022 1:40:09 AM
last_login_at                                   : 9/29/2022 12:49:59 PM
last_name                                       : Smith
location_id                                     :
location_name                                   :
mobile_phone_number                             :
occasional                                      : False
reporting_manager_id                            :
role_ids                                        : {21000150292}
roles                                           : {@{role_id=21000150292; assignment_scope=entire_helpdesk;
                                                groups=System.Object\[\]}}
scopes                                          : @{ticket=; problem=; change=; release=; asset=; solution=; contract=}
scoreboard_level_id                             :
scoreboard_points                               :
signature                                       :
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 8/29/2022 2:17:01 PM
vip_user                                        : False
work_phone_number                               :
group_ids                                       : {}
member_of                                       : {}
observer_of                                     : {}
member_of_pending_approval                      : {}
observer_of_pending_approval                    : {}

Returns a Freshservice Agent based on Filter for Email Address. 
For filter options see:

https://api.freshservice.com/#filter_agents

### EXAMPLE 4
```
Get-FreshserviceAgent -State Fulltime
```

active                                          : False
address                                         :
auto_assign_status_changed_at                   :
auto_assign_tickets                             : True
background_information                          :
can_see_all_tickets_from_associated_departments : False
created_at                                      : 8/29/2022 2:17:02 PM
custom_fields                                   :
department_ids                                  : {}
department_names                                :
email                                           : rachel@freshservice.com
external_id                                     :
first_name                                      : Rachel
has_logged_in                                   : False
id                                              : 21000418008
job_title                                       :
language                                        : en
last_active_at                                  :
last_login_at                                   :
last_name                                       :
location_id                                     :
location_name                                   :
mobile_phone_number                             :
occasional                                      : False
reporting_manager_id                            :
role_ids                                        : {21000150295}
roles                                           : {@{role_id=21000150295; assignment_scope=entire_helpdesk;
                                                groups=System.Object\[\]}}
scopes                                          : @{ticket=; problem=; change=; asset=; solution=; contract=}
scoreboard_level_id                             :
scoreboard_points                               :
signature                                       :
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 8/29/2022 2:17:02 PM
vip_user                                        : False
work_phone_number                               :
group_ids                                       : {}
member_of                                       : {}
observer_of                                     : {}
member_of_pending_approval                      : {}
observer_of_pending_approval                    : {}

active                                          : True
address                                         :
auto_assign_status_changed_at                   : 10/31/2022 3:20:53 PM
auto_assign_tickets                             : True
background_information                          :
can_see_all_tickets_from_associated_departments : False
created_at                                      : 8/29/2022 2:17:01 PM
custom_fields                                   :
department_ids                                  : {}
department_names                                :
email                                           : alex@example.com
external_id                                     :
first_name                                      : Alex
has_logged_in                                   : True
id                                              : 21000418005
job_title                                       :
language                                        : en
last_active_at                                  : 11/2/2022 1:40:09 AM
last_login_at                                   : 9/29/2022 12:49:59 PM
last_name                                       : Smith
location_id                                     :
location_name                                   :
mobile_phone_number                             :
occasional                                      : False
reporting_manager_id                            :
role_ids                                        : {21000150292}
roles                                           : {@{role_id=21000150292; assignment_scope=entire_helpdesk;
                                                groups=System.Object\[\]}}
scopes                                          : @{ticket=; problem=; change=; release=; asset=; solution=; contract=}
scoreboard_level_id                             :
scoreboard_points                               :
signature                                       :
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 8/29/2022 2:17:01 PM
vip_user                                        : False
work_phone_number                               :
group_ids                                       : {}
member_of                                       : {}
observer_of                                     : {}
member_of_pending_approval                      : {}
observer_of_pending_approval                    : {}

Returns all Freshservice agents by State (e.g.
FullTime).

## PARAMETERS

### -Id
Unique id of the agent.

```yaml
Type: Int64
Parameter Sets: id
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter
Use Agent attributes to filter results.
See https://api.freshservice.com/#filter_agents.

```yaml
Type: String
Parameter Sets: Filter
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -State
State of the agent.
Fulltime or Occasional.

```yaml
Type: String
Parameter Sets: State
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
Allows you to view all the built-in and custom fields for agents in your Freshservice account.

```yaml
Type: SwitchParameter
Parameter Sets: Form
Aliases: Form

Required: False
Position: 1
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -per_page
Number of records to return per page during pagination. 
Maximum of 100 records.

```yaml
Type: Int32
Parameter Sets: default, Filter, State
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
Parameter Sets: default, Filter, State
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
