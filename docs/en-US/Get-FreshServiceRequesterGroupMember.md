---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceRequesterGroupMember

## SYNOPSIS
Returns a Freshservice Requester Group members.

## SYNTAX

```
Get-FreshServiceRequesterGroupMember [-id] <Int64> [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Requester Group members via REST API.

https://api.freshservice.com/#list_members_of_requester_group

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceRequesterGroupMember -requester_group_id 21000046638
```

id first_name last_name email
     -- ---------- --------- -----
21000418006 Andrea     Smith     andrea@freshservice.com

Returns members of a Freshservice Requester Group.

## PARAMETERS

### -id
Unique id of the Requester Group to get members from.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: requester_group_id

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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
