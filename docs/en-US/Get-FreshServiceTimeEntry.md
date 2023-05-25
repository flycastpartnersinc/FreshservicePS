---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceTimeEntry

## SYNOPSIS
Returns a Freshservice Time Entry for a Ticket, Problem, Change or Release.

## SYNTAX

### default (Default)
```
Get-FreshServiceTimeEntry [-parent_id] <Int64> [[-type] <String>] [[-per_page] <Int32>] [[-page] <Int32>]
 [<CommonParameters>]
```

### id
```
Get-FreshServiceTimeEntry [-id] <Int64> [-parent_id] <Int64> [[-type] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Time Entry for a Ticket, Problem, Change or Release via REST API.

https://api.freshservice.com/#view_ticket_time_entry
https://api.freshservice.com/#view_a_problem_time_entry
https://api.freshservice.com/#view_a_time_entry
https://api.freshservice.com/#view_a_release_time_entry

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceTimeEntry -parent_id 185 -type Ticket
```

id            : 21000167654
created_at    : 3/27/2023 3:09:37 PM
updated_at    : 3/27/2023 3:09:37 PM
start_time    : 3/27/2023 3:09:37 PM
timer_running : False
billable      : True
time_spent    : 02:00
executed_at   : 3/27/2023 3:09:12 PM
task_id       :
note          : Worked on stuff
agent_id      : 21001931878
custom_fields :

Returns all Freshservice Time Entries on Ticket 185.

### EXAMPLE 2
```
Get-FreshServiceTimeEntry -parent_id 12 -type Problem
```

id            : 21000167668
created_at    : 3/27/2023 3:12:54 PM
updated_at    : 3/27/2023 3:12:54 PM
start_time    : 3/27/2023 3:12:54 PM
timer_running : False
billable      : True
time_spent    : 05:00
executed_at   : 3/27/2023 3:12:00 PM
task_id       :
note          : Trying to find the bug in the software
agent_id      : 21001931878
custom_fields :

Returns all Freshservice Time Entries on Problem 12.

### EXAMPLE 3
```
Get-FreshServiceTimeEntry -parent_id 185 -type Ticket -id 21000167654
```

id            : 21000167654
created_at    : 3/27/2023 3:09:37 PM
updated_at    : 3/27/2023 3:09:37 PM
start_time    : 3/27/2023 3:09:37 PM
timer_running : False
billable      : True
time_spent    : 02:00
executed_at   : 3/27/2023 3:09:12 PM
task_id       :
note          : Worked on stuff
agent_id      : 21001931878
custom_fields :

Returns a specific Freshservice Time Entry on a Ticket by Id.

## PARAMETERS

### -id
Unique id of the Time Entry.

```yaml
Type: Int64
Parameter Sets: id
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -parent_id
Parent Id of the ticket, problem, change or release to create the time entry.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: ParentId

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
Parent object type to create time entry.
Time Entrys can be created on Ticket, Problem, Change, or Release.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
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
