---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Add-FreshServiceRequesterGroupMember

## SYNOPSIS
Adds a Freshservice Requester to a Requester Group.

## SYNTAX

```
Add-FreshServiceRequesterGroupMember [-id] <Int64> [-requester_id] <Int64> [<CommonParameters>]
```

## DESCRIPTION
Adds a Freshservice Requester to a Requester Group via REST API.

https://api.freshservice.com/#add_member_to_requester_group

## EXAMPLES

### EXAMPLE 1
```
Add-FSRequesterGroupMember -id 21000137988 -requester_id 21001799737
```

id status
-- ------
21000137988 success 200

Adds a Freshservice Requester to a Requester Group.

## PARAMETERS

### -id
Unique Id of the requester group.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: requester_group_id

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -requester_id
Unique Id of the requester.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
This module was developed and tested with Freshservice REST API v2.

## RELATED LINKS
