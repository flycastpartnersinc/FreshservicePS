---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Set-FreshServiceTimeEntry

## SYNOPSIS
Updates a Freshservice Time Entry on a Ticket, Problem, Change or Release.

## SYNTAX

```
Set-FreshServiceTimeEntry [-id] <Int64> [-parent_id] <Int64> [[-timer_running] <Boolean>]
 [[-billable] <Boolean>] [[-time_spent] <TimeSpan>] [[-executed_at] <DateTime>] [[-task_id] <Int64>]
 [[-note] <String>] [[-agent_id] <Int64>] [-type] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Time Entry on a Ticket, Problem, Change or Release via REST API.

https://api.freshservice.com/#update_ticket_time_entry
https://api.freshservice.com/#update_problem_time_entry
https://api.freshservice.com/#update_time_entry
https://api.freshservice.com/#update_release_time_entry

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceTimeEntry -parent_id 9 -type Ticket -id 21000056011 -note "Detailed Notes"
```

id            : 21000056011
created_at    : 1/4/2023 1:53:41 PM
updated_at    : 1/5/2023 5:51:01 PM
start_time    : 1/4/2023 1:53:41 PM
timer_running : False
billable      : True
time_spent    : 01:00
executed_at   : 1/4/2023 1:53:41 PM
time entry_id       :
note          : Detailed Notes
agent_id      : 21000418005
custom_fields :

Update a description on a Time Entry on a Freshservice Ticket.

## PARAMETERS

### -id
Unique id of the Time Entry.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -timer_running
Set to true if timer is currently running.
Default value is false.
At a time, only one timer can be running for an agent across the account.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -billable
Set as true if the time-entry is billable.
Default value is true.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -time_spent
The total amount of time spent by the timer in hh::mm format.
This field cannot be set if timer_running is true.
Mandatory if timer_running is false.

```yaml
Type: TimeSpan
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -executed_at
Time at which the timer is executed.
Default value (unless given in request) is the time at which timer is added.
Should be less than or equal to current date_time.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -task_id
Unique id of the task assigned to the time-entry.
Task should be valid on the given ticket and assigned to agent_id.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -note
Description of the time-entry.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -agent_id
The user/agent to whom this time-entry is assigned.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type
Parent object type to create time entry. 
Time Entrys can be created on Ticket, Problem, Change, or Release.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 10
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
