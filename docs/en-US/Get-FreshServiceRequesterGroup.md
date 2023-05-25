---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceRequesterGroup

## SYNOPSIS
Returns a Freshservice Requester Group.

## SYNTAX

### default (Default)
```
Get-FreshServiceRequesterGroup [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceRequesterGroup [-Id] <Int64> [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Requester Group via REST API.

https://api.freshservice.com/#view_a_requester_group

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceRequesterGroup
```

id name              description type
        -- ----              ----------- ----
21000046638 Change Requesters             rule_based
21000046637 Finance Team                  rule_based
21000046636 HR Team                       rule_based
21000046635 Managers                      rule_based

Returns all FreshService Requester Groups.

### EXAMPLE 2
```
Get-FreshServiceRequesterGroup -Id 21000046636
```

id name    description type
        -- ----    ----------- ----
21000046636 HR Team             rule_based

Returns a Freshservice Requester Group by Id.

## PARAMETERS

### -Id
Unique id of the Requester Group.

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
