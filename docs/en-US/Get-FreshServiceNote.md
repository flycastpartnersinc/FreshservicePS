---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceNote

## SYNOPSIS
Returns a Freshservice Note on Problem, Change or Release.

## SYNTAX

```
Get-FreshServiceNote [[-Id] <Int64>] -parent_id <Int64> -type <String> [[-per_page] <Int32>] [[-page] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Note on Problem, Change or Release via REST API.
For Tickets,
see Get-FreshServiceConversation.

https://api.freshservice.com/#view_a_problem_note
https://api.freshservice.com/#view_a_change_note
https://api.freshservice.com/#view_a_release

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceNote -parent_id 2 -type Problem
```

id            : 21000071787
created_at    : 1/10/2023 6:24:23 PM
updated_at    : 1/10/2023 6:24:23 PM
body          : \<div\>A note added to a Problem.\</div\>
body_text     : A note added to a Problem.
user_id       : 21000418005
notify_emails :

Return all Freshservice Notes on Problem id 2.

### EXAMPLE 2
```
Get-FreshServiceNote -parent_id 2 -type Problem -id 21000071797
```

id            : 21000071797
created_at    : 1/10/2023 7:52:26 PM
updated_at    : 1/10/2023 8:01:18 PM
body          : Updated note on a problem
body_text     : Updated note on a problem
user_id       : 21000418005
notify_emails :

Return a specific Freshservice Note on Problem id 2 by id 21000071797.

## PARAMETERS

### -Id
Unique id of the note.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -parent_id
Unique id of the parent Ticket, Problem, Change or Release.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: ParentId

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type
Parent object type to create time entry (e.g.
Ticket, Problem, Change, Release).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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
Position: 2
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
Position: 3
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
