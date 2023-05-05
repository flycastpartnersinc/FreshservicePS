---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceProblem

## SYNOPSIS
Returns a Freshservice Problem.

## SYNTAX

### default (Default)
```
Get-FreshServiceProblem [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceProblem [-id] <String> [<CommonParameters>]
```

### Form
```
Get-FreshServiceProblem [-fields] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Problem via REST API.

https://api.freshservice.com/#view_a_problem

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceProblem
```

id               : 2
agent_id         :
description      : \<div\>A new problem\</div\>
description_text : A new problem
assets           : {}
requester_id     : 21000418005
subject          : A new problem
group_id         :
priority         : 1
impact           : 1
status           : 1
due_by           : 1/14/2023 6:55:51 PM
known_error      : False
department_id    :
category         :
sub_category     :
item_category    :
created_at       : 1/9/2023 6:55:57 PM
updated_at       : 1/9/2023 6:55:57 PM

id               : 1
agent_id         :
description      : \<div\>Hi guys, \<br/\>\<br/\>We have been facing issues when we try to reach Email Server 3.
Looks
                like there is something wrong here.\<br/\>\<br/\>Regards\<br/\> Rachel\<br/\> \</div\>
description_text :
assets           : {}
requester_id     : 21000418008
subject          : Unable to reach email server
group_id         :
priority         : 1
impact           : 1
status           : 1
due_by           : 9/12/2022 2:17:34 PM
known_error      : False
department_id    :
category         :
sub_category     :
item_category    :
created_at       : 8/29/2022 2:17:34 PM
updated_at       : 8/29/2022 2:17:34 PM

Get all Freshservice Problems.

### EXAMPLE 2
```
Get-FreshServiceProblem -id 2
```

id                : 2
agent_id          :
description       : \<div\>A new problem\</div\>
description_text  : A new problem
assets            : {}
requester_id      : 21000418005
subject           : A new problem
group_id          :
priority          : 1
impact            : 1
status            : 1
due_by            : 1/14/2023 6:55:51 PM
known_error       : False
department_id     :
category          :
sub_category      :
item_category     :
created_at        : 1/9/2023 6:55:57 PM
updated_at        : 1/9/2023 6:55:57 PM
associated_change :
custom_fields     :
analysis_fields   :

Get a specific Freshservice Problem.

### EXAMPLE 3
```
Get-FreshServiceProblem -Fields
```

id                   : 21000472464
created_at           : 8/29/2022 2:17:34 PM
updated_at           : 8/29/2022 2:17:34 PM
name                 : requester
label                : Requester
description          : Problem requester
field_type           : default_requester
required             : True
required_for_closure : False
position             : 1
default_field        : True
choices              : {}
nested_fields        : {}

id                   : 21000472465
created_at           : 8/29/2022 2:17:34 PM
updated_at           : 8/29/2022 2:17:34 PM
name                 : subject
label                : Title
description          : Problem title
field_type           : default_subject
required             : True
required_for_closure : False
position             : 2
default_field        : True
choices              : {}
nested_fields        : {}

id                   : 21000472466
created_at           : 8/29/2022 2:17:34 PM
updated_at           : 8/29/2022 2:17:34 PM
name                 : description
label                : Description
description          : Problem description
field_type           : default_description
required             : True
required_for_closure : False
position             : 3
default_field        : True
choices              : {}
nested_fields        : {}

id                   : 21000472467
created_at           : 8/29/2022 2:17:34 PM
updated_at           : 8/29/2022 2:17:34 PM
name                 : status
label                : Status
description          : Problem status
field_type           : default_status
required             : True
required_for_closure : False
position             : 4
default_field        : True
choices              : {@{id=1; value=Open}, @{id=2; value=Change Requested}, @{id=3; value=Closed}}
nested_fields        : {}

Return all the built-in and custom fields for Problem.

## PARAMETERS

### -id
Unique id of the Problem.

```yaml
Type: String
Parameter Sets: id
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
View all the built-in and custom fields for Problem.

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
Parameter Sets: default
Aliases:

Required: False
Position: 1
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
Position: 2
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
