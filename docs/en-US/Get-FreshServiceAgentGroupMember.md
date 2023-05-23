---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceAgentGroupMember

## SYNOPSIS
Returns a Freshservice Agent Group Member.

## SYNTAX

```
Get-FreshServiceAgentGroupMember [-id] <Int64> [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Agent Group Member via REST API.

This is a wrapper function for https://api.freshservice.com/#view_a_group using the Members property.
The
default behavior is to overwrite existing members with what is passed, so this wrapper function gets the
existing members and appends them to make the default behavior adding a member.

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceAgentGroupMember -id 21000543793
```

id first_name last_name   email
        -- ---------- ---------   -----
21001392937 Dana        Franks dana@example.com
21001931878 Alex       Smith     Alex@example.com

Returns members of a Freshservice Agent Group.

## PARAMETERS

### -id
Unique id of the Agent Group to get members from.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: Agent_group_id

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
