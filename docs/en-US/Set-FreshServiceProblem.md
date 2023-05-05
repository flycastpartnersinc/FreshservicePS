---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServiceProblem

## SYNOPSIS
Updates a Freshservice Problem.

## SYNTAX

### default (Default)
```
Set-FreshServiceProblem [-id] <Int64> [[-agent_id] <Int64>] [[-requester_id] <Int64>] [[-group_id] <Int64>]
 [[-description] <String>] [[-priority] <Int32>] [[-status] <Int32>] [[-impact] <Int32>]
 [[-known_error] <Boolean>] [[-subject] <String>] [[-due_by] <DateTime>] [[-department_id] <Int64>]
 [[-category] <String>] [[-sub_category] <String>] [[-item_category] <String>] [[-custom_fields] <Hashtable>]
 [[-assets] <Object>] [[-attachments] <FileInfo[]>] [[-problem_cause] <String>] [[-problem_symptom] <String>]
 [[-problem_impact] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Restore
```
Set-FreshServiceProblem [-id] <Int64> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Problem via REST API.

https://api.freshservice.com/#update_problem_priority

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceProblem -id 3 -description "Updated description for the problem" -attachments 'C:\Scripts\automation_icon.jpg'
```

id                : 3
agent_id          :
description       : Updated description for the problem
description_text  : Updated description for the problem
assets            : {}
requester_id      : 21000418005
subject           : A new problem
group_id          :
priority          : 1
impact            : 1
status            : 1
due_by            : 1/14/2023 7:23:41 PM
known_error       : False
department_id     :
category          :
sub_category      :
item_category     :
created_at        : 1/9/2023 7:23:47 PM
updated_at        : 1/9/2023 7:23:47 PM
associated_change :
custom_fields     :
analysis_fields   :

Update the description on a problem and add an attachment.

## PARAMETERS

### -id
Unique identifier of the Problem.

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

### -agent_id
Unique identifier of the agent to whom the Problem is assigned

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -requester_id
Unique identifier of the initiator of the problem.

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -group_id
Unique identifier of the agent group to which the Problem is assigned

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
HTML content of the problem.
Description and description_html should not be passed together

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -priority
Priority of the Problem

1-Low
2-Medium
3-High
4-Urgent

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status
Status identifier of the Problem.

1-Open
2-Change Requested
3-Closed

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -impact
Impact of the Problem.

1-Low
2-Medium
3-High

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -known_error
States that the problem is known issue or not.
true or false

```yaml
Type: Boolean
Parameter Sets: default
Aliases:

Required: False
Position: 9
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -subject
Subject of the Problem

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -due_by
Timestamp at which Problem due ends

```yaml
Type: DateTime
Parameter Sets: default
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -department_id
Unique ID of the department initiating the Problem

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 12
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -category
Category of the Problem

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sub_category
Sub-category of the Problem

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -item_category
Item of the Problem

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -custom_fields
Key value pairs containing the names and values of custom fields.

```yaml
Type: Hashtable
Parameter Sets: default
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -assets
Array of assets (display_id) associated with the problem.

```yaml
Type: Object
Parameter Sets: default
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -attachments
Path to attachment(s).

```yaml
Type: FileInfo[]
Parameter Sets: default
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -problem_cause
Problem cause description.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -problem_symptom
Problem symptom description

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -problem_impact
Problem impact description

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 21
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
