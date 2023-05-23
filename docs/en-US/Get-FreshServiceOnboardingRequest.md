---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceOnboardingRequest

## SYNOPSIS
Returns a Freshservice Onboarding Request.

## SYNTAX

### default (Default)
```
Get-FreshServiceOnboardingRequest [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### Ticket
```
Get-FreshServiceOnboardingRequest [-id] <Int64> [-tickets] [<CommonParameters>]
```

### id
```
Get-FreshServiceOnboardingRequest [-id] <Int64> [<CommonParameters>]
```

### Form
```
Get-FreshServiceOnboardingRequest [-fields] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Onboarding Request via REST API.

https://api.freshservice.com/#create_onboarding_request

## EXAMPLES

### EXAMPLE 1
```
Get-FreshserviceOnboardingRequest
```

id           : 1
created_at   : 3/25/2023 3:55:19 PM
updated_at   : 3/25/2023 3:55:19 PM
status       : 3
requester_id : 21000418005
subject      : Employee Onboarding Request
fields       : @{cf_employee_name=John Smith; cf_job_title=Analyst I; cf_date_of_joining=25-03-2023;
            cf_department=21000097763; cf_location=21000159890}

id           : 2
created_at   : 3/25/2023 5:21:53 PM
updated_at   : 3/25/2023 5:21:54 PM
status       : 3
requester_id : 21000418005
subject      : Employee Onboarding Request
fields       : @{cf_employee_name=Frank Johnson; cf_job_title=Analyst I; cf_date_of_joining=25-03-2023;
            cf_department=21000097763; cf_location=21000159890}

Returns all FreshService Onboarding Requests.

### EXAMPLE 2
```
Get-FreshserviceOnboardingRequest -id 1
```

id            : 1
created_at    : 3/25/2023 3:55:19 PM
updated_at    : 3/25/2023 3:55:19 PM
status        : 3
requester_id  : 21000418005
subject       : Employee Onboarding Request
ticket_id     : 192
actors        : @{Employee=}
fields        : @{cf_employee_name=John Smith; cf_job_title=Analyst I; cf_date_of_joining=25-03-2023;
                cf_department=21000097763; cf_location=21000159890}
lookup_values : @{cf_department=; cf_location=}

Returns a specific FreshService Onboarding Request by id.

### EXAMPLE 3
```
Get-FreshserviceOnboardingRequest -id 1 -tickets
```

id              : 192
created_at      : 3/25/2023 3:55:19 PM
updated_at      : 3/25/2023 3:55:19 PM
subject         : Employee Onboarding Request
responder_email :
status          : 2
parent          : True

id                    : 193
created_at            : 3/25/2023 3:55:19 PM
updated_at            : 3/25/2023 3:55:19 PM
subject               : Create Email Address
responder_email       :
status                : 2
parent                : False
predecessor_ticket_id :
successor_ticket_ids  : {}

Returns tickets associated with a specific FreshService Onboarding Request by id.

### EXAMPLE 4
```
Get-FreshServiceOnboardingRequest -fields
```

placeholder : Enter employee name
label       : Employee Name
name        : cf_employee_name
position    : 1
required    : False
default     : False
field_type  : custom_text

placeholder :
label       : Job Title
name        : cf_job_title
position    : 2
required    : False
default     : False
field_type  : custom_text

placeholder : Enter joining date
label       : Date of joining
name        : cf_date_of_joining
position    : 3
required    : False
default     : False
field_type  : custom_date

placeholder : Select department
label       : Department
name        : cf_department
position    : 4
required    : False
default     : False
field_type  : custom_lookup_bigint
data_source : 6

placeholder : Select Location
label       : Location
name        : cf_location
position    : 5
required    : False
default     : False
field_type  : custom_lookup_bigint
data_source : 1

Returns all the built-in and custom fields for the Onboarding Request.

## PARAMETERS

### -id
Unique id of the Onboarding Request.

```yaml
Type: Int64
Parameter Sets: Ticket, id
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -tickets
Retrieve and view the Onboarding Tickets associated with an Onboarding Request.

```yaml
Type: SwitchParameter
Parameter Sets: Ticket
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
Allows you to view all the built-in and custom fields for the Onboarding Request in your Freshservice account.

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
