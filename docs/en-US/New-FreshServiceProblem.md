---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceProblem

## SYNOPSIS
Creates a new Freshservice Problem.

## SYNTAX

```
New-FreshServiceProblem [[-workspace_id] <Int32>] [[-agent_id] <Int64>] [-requester_id] <Int64>
 [[-group_id] <Int64>] [-description] <String> [[-priority] <Int32>] [-status] <Int32> [-impact] <Int32>
 [[-known_error] <Boolean>] [-subject] <String> [-due_by] <DateTime> [[-department_id] <Int64>]
 [[-category] <String>] [[-sub_category] <String>] [[-item_category] <String>] [[-custom_fields] <Hashtable>]
 [[-assets] <Object[]>] [[-attachments] <FileInfo[]>] [[-problem_cause] <String>] [[-problem_symptom] <String>]
 [[-problem_impact] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new Freshservice Problem via REST API.

https://api.freshservice.com/#create_problem

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceProblem -requester_id 21000418005 -description "A new problem" -status 1 -impact 1 -priority 1 -subject "A new problem" -due_by (Get-Date).AddDays(5) -problem_impact "This is the impact of this problem" -known_error $true -category "Hardware" -sub_category 'Peripherals' -item_category 'Router' -problem_cause "The cause of the problem" -problem_symptom "The symptom of the problem"
```

id                : 14
agent_id          :
description       : \<div\>A new problem\</div\>
description_text  : A new problem
assets            : {}
requester_id      : 21000418005
subject           : A new problem
group_id          :
priority          : 1
impact            : 1
status            : 1
due_by            : 4/17/2023 3:05:29 AM
known_error       : True
department_id     :
category          : Hardware
sub_category      : Peripherals
item_category     : Router
created_at        : 4/12/2023 3:05:29 AM
updated_at        : 4/12/2023 3:05:29 AM
associated_change :
custom_fields     :
analysis_fields   : @{problem_cause=; problem_impact=; problem_symptom=}

Creates a Freshservice Problem.

## PARAMETERS

### -workspace_id
Workspace ID of the Problem.
The attribute is applicable only for accounts with the 'Workspaces' feature enabled.
The default value is the ID of the primary workspace of the account.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -agent_id
Unique identifier of the agent to whom the Problem is assigned

```yaml
Type: Int64
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -group_id
Unique identifier of the agent group to which the Problem is assigned

```yaml
Type: Int64
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -priority
Priority of the Problem 1-Low, 2-Medium, 3-High, 4-Urgent

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status
Status identifier of the Problem.
1-Open, 2-Change Requested, 3-Closed

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -impact
Impact of the Problem.
1-Low, 2-Medium, 3-High

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
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
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases:

Required: True
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -due_by
Timestamp at which Problem due ends

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -department_id
Unique ID of the department initiating the Problem

```yaml
Type: Int64
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -assets
List of assets associated with the problem.

```yaml
Type: Object[]
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
