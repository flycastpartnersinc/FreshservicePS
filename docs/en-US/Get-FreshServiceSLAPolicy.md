---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceSLAPolicy

## SYNOPSIS
Returns a Freshservice SLA Policy.

## SYNTAX

```
Get-FreshServiceSLAPolicy [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice SLA Policy via REST API.

https://api.freshservice.com/#list_all_sla

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceSLAPolicy
```

id            : 21000057781
name          : Default SLA Policy
position      : 1
is_default    : True
active        : True
deleted       : False
description   : default policy
sla_targets   : {@{priority=4; escalation_enabled=True; respond_within=3600; resolve_within=14400;
                business_hours=True}, @{priority=3; escalation_enabled=True; respond_within=14400;
                resolve_within=43200; business_hours=True}, @{priority=2; escalation_enabled=True;
                respond_within=28800; resolve_within=86400; business_hours=True}, @{priority=1;
                escalation_enabled=True; respond_within=86400; resolve_within=259200; business_hours=True}}
applicable_to :
escalation    :
created_at    : 8/29/2022 2:17:01 PM
updated_at    : 8/29/2022 2:17:01 PM

Returns all Freshservice SLA Policies.

## PARAMETERS

### -per_page
Number of records to return per page during pagination. 
Maximum of 100 records.

```yaml
Type: Int32
Parameter Sets: (All)
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
Parameter Sets: (All)
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
