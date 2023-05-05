---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceBackgroundJob

## SYNOPSIS
Returns a Freshservice Background Job Status.

## SYNTAX

```
Get-FreshServiceBackgroundJob [-Id] <Guid> [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Background Job Status created by New-FreshServiceRelationship via REST API.

https://api.freshservice.com/#create_relationships

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceBackgroundJob -id bce1461a-617d-938a-bb73-87d46525e2fc
```

relationships                    status
-------------                    ------
{@{success=True; relationship=}} success

Return a background job status by guid created by New-FreshServiceRelationship.

## PARAMETERS

### -Id
Unique id of the Job.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
