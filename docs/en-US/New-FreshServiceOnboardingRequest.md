---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# New-FreshServiceOnboardingRequest

## SYNOPSIS
Creates Freshservice Onboarding Request.

## SYNTAX

```
New-FreshServiceOnboardingRequest [-fields] <Hashtable> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice Onboarding Request via REST API.

https://api.freshservice.com/#create_onboarding_request

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceOnboardingRequest -fields $fields
```

id            : 10
created_at    : 4/12/2023 3:02:11 AM
updated_at    : 4/12/2023 3:02:11 AM
status        : 1
requester_id  : 21001931878
subject       : Employee Onboarding Request
ticket_id     :
actors        : @{Employee=}
fields        : @{cf_employee_name=Frank Johnson; cf_job_title=Analyst I; cf_date_of_joining=11-04-2023;
                cf_department=21000097763; cf_location=21000159890}
lookup_values : @{cf_department=; cf_location=}

Create a new Freshservice Onboarding Request.

## PARAMETERS

### -fields
Hashtable containing the Onboarding Request fields.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
