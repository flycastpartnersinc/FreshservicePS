---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceRequester

## SYNOPSIS
Returns a Freshservice Requester.

## SYNTAX

### default (Default)
```
Get-FreshServiceRequester [[-filter] <String>] [-include_agents] [[-per_page] <Int32>] [[-page] <Int32>]
 [<CommonParameters>]
```

### id
```
Get-FreshServiceRequester [-Id] <Int64> [<CommonParameters>]
```

### fields
```
Get-FreshServiceRequester [-fields] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Requester via REST API.

https://api.freshservice.com/#view_a_requester

## EXAMPLES

### EXAMPLE 1
```
Get-FreshserviceRequester
```

active                                          : True
address                                         :
background_information                          :
can_see_all_changes_from_associated_departments : False
can_see_all_tickets_from_associated_departments : False
created_at                                      : 8/29/2022 2:17:01 PM
custom_fields                                   :
department_ids                                  : {}
department_names                                :
external_id                                     :
first_name                                      : Andrea
has_logged_in                                   : False
id                                              : 21000418006
is_agent                                        : False
job_title                                       : Manager
language                                        : en
last_name                                       :
location_id                                     :
location_name                                   :
mobile_phone_number                             :
primary_email                                   : andrea@freshservice.com
reporting_manager_id                            :
secondary_emails                                : {}
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 8/29/2022 2:17:01 PM
vip_user                                        : False
work_phone_number                               :

active                                          : True
address                                         :
background_information                          :
can_see_all_changes_from_associated_departments : False
can_see_all_tickets_from_associated_departments : False
created_at                                      : 8/29/2022 2:17:02 PM
custom_fields                                   :
department_ids                                  : {}
department_names                                :
external_id                                     :
first_name                                      : Jack
has_logged_in                                   : False
id                                              : 21000418009
is_agent                                        : False
job_title                                       : CIO
language                                        : en
last_name                                       :
location_id                                     :
location_name                                   :
mobile_phone_number                             :
primary_email                                   : jack@freshservice.com
reporting_manager_id                            :
secondary_emails                                : {}
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 8/29/2022 2:17:02 PM
vip_user                                        : False
work_phone_number                               :

Returns all Freshservice Requesters.

### EXAMPLE 2
```
Get-FreshServiceRequester -Id 21000418009
```

active                                          : True
address                                         :
background_information                          :
can_see_all_changes_from_associated_departments : False
can_see_all_tickets_from_associated_departments : False
created_at                                      : 8/29/2022 2:17:02 PM
custom_fields                                   :
department_ids                                  : {}
department_names                                :
external_id                                     :
first_name                                      : Jack
has_logged_in                                   : False
id                                              : 21000418009
is_agent                                        : False
job_title                                       : CIO
language                                        : en
last_name                                       :
location_id                                     :
location_name                                   :
mobile_phone_number                             :
primary_email                                   : jack@freshservice.com
reporting_manager_id                            :
secondary_emails                                : {}
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 8/29/2022 2:17:02 PM
vip_user                                        : False
work_phone_number                               :

Returns a Freshservice Requester by Id.

### EXAMPLE 3
```
Get-FreshServiceRequester -filter "job_title:'Manager' AND language:'en'" -include_agents
```

active                                          : True
address                                         :
background_information                          :
can_see_all_changes_from_associated_departments : False
can_see_all_tickets_from_associated_departments : False
created_at                                      : 8/29/2022 2:17:01 PM
custom_fields                                   :
department_ids                                  : {}
department_names                                :
external_id                                     :
first_name                                      : Andrea
has_logged_in                                   : False
id                                              : 21000418006
is_agent                                        : False
job_title                                       : Manager
language                                        : en
last_name                                       :
location_id                                     :
location_name                                   :
mobile_phone_number                             :
primary_email                                   : andrea@freshservice.com
reporting_manager_id                            :
secondary_emails                                : {}
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 8/29/2022 2:17:01 PM
vip_user                                        : False
work_phone_number                               :

Returns a Freshservice Requesters, including agents, that have a job title of 'Manager' and
Language is 'en' (English).

### EXAMPLE 4
```
Get-FreshserviceRequester -fields
```

id                       : 21000184911
created_at               : 8/29/2022 2:17:01 PM
updated_at               : 8/29/2022 2:17:01 PM
editable_in_signup       : True
name                     : first_name
label                    : First Name
position                 : 1
required_for_agents      : True
type                     : default_first_name
default                  : True
requesters_can_edit      : True
label_for_requesters     : First Name
required_for_requesters  : True
displayed_for_requesters : True

id                       : 21000184912
created_at               : 8/29/2022 2:17:01 PM
updated_at               : 8/29/2022 2:17:01 PM
editable_in_signup       : True
name                     : last_name
label                    : Last Name
position                 : 2
required_for_agents      : False
type                     : default_last_name
default                  : True
requesters_can_edit      : True
label_for_requesters     : Last Name
required_for_requesters  : False
displayed_for_requesters : True

id                       : 21000184913
created_at               : 8/29/2022 2:17:01 PM
updated_at               : 8/29/2022 2:17:01 PM
editable_in_signup       : False
name                     : job_title
label                    : Title
position                 : 3
required_for_agents      : False
type                     : default_job_title
default                  : True
requesters_can_edit      : True
label_for_requesters     : Title
required_for_requesters  : False
displayed_for_requesters : True

id                       : 21000184915
created_at               : 8/29/2022 2:17:01 PM
updated_at               : 2/9/2023 8:19:15 PM
editable_in_signup       : False
name                     : phone
label                    : Work Phone
position                 : 4
required_for_agents      : False
type                     : default_phone
default                  : True
requesters_can_edit      : True
label_for_requesters     : Work Phone
required_for_requesters  : False
displayed_for_requesters : True

id                       : 21000184916
created_at               : 8/29/2022 2:17:01 PM
updated_at               : 2/9/2023 8:19:15 PM
editable_in_signup       : False
name                     : mobile
label                    : Mobile Phone
position                 : 5
required_for_agents      : False
type                     : default_mobile
default                  : True
requesters_can_edit      : True
label_for_requesters     : Mobile Phone
required_for_requesters  : False
displayed_for_requesters : True

...

Returns all the built-in and custom fields for Freshservice Requester.

## PARAMETERS

### -Id
Unique id of the Requester.

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

### -filter
Apply filter to requester query.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -include_agents
Include agents with requester query.

```yaml
Type: SwitchParameter
Parameter Sets: default
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
View all the built-in and custom fields for requesters.

```yaml
Type: SwitchParameter
Parameter Sets: fields
Aliases: Form

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
Parameter Sets: default
Aliases:

Required: False
Position: 3
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -page
The page number to retrieve during pagination.

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 4
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
