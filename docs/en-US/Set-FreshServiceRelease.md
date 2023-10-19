---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Set-FreshServiceRelease

## SYNOPSIS
Updates a Freshservice Release.

## SYNTAX

### default (Default)
```
Set-FreshServiceRelease [-id] <Int64> [[-agent_id] <Int64>] [[-group_id] <Int64>] [[-priority] <Int32>]
 [[-status] <Int32>] [[-release_type] <Int32>] [[-subject] <String>] [[-description] <String>]
 [[-planned_start_date] <DateTime>] [[-planned_end_date] <DateTime>] [[-work_start_date] <DateTime>]
 [[-work_end_date] <DateTime>] [[-department_id] <Int64>] [[-category] <String>] [[-sub_category] <String>]
 [[-item_category] <String>] [[-custom_fields] <Hashtable>] [[-assets] <Object[]>]
 [[-attachments] <FileInfo[]>] [[-build_plan] <String>] [[-test_plan] <String>] [[-workspace_id] <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### workspace
```
Set-FreshServiceRelease [-id] <Int64> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Release via REST API.

https://api.freshservice.com/#update_release_priority

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceRelease -id 4 -priority 3
```

id                    : 4
agent_id              : 21000418005
description           : \<div\>Release from Pester: cdc12ab5-5beb-48cf-a931-e3bdfc16391f\</div\>
description_text      : Release from Pester: cdc12ab5-5beb-48cf-a931-e3bdfc16391f
assets                : {}
group_id              : 21000188395
department_id         :
subject               : Release from Pester: cdc12ab5-5beb-48cf-a931-e3bdfc16391f
category              : Hardware
sub_category          : Peripherals
item_category         : Router
planned_start_date    : 3/1/2023 1:00:00 AM
planned_end_date      : 3/1/2023 3:00:00 AM
status                : 1
priority              : 3
release_type          : 2
work_start_date       : 3/1/2023 1:00:00 AM
work_end_date         : 3/1/2023 3:00:00 AM
created_at            : 3/1/2023 3:03:45 AM
updated_at            : 3/31/2023 1:07:21 AM
associated_change_ids : {}
custom_fields         :
planning_fields       :

Update the priority of a Freshservice Release.

## PARAMETERS

### -id
Unique identifier of the Release.

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
Unique identifier of the agent to whom the Release is assigned.

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

### -group_id
Unique identifier of the agent group to which the Release is assigned.

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

### -priority
Priority of the Release:

1 = Low
2 = Medium
3 = High
4 = Urgent

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status
Status identifier of the Release:

1 = Open
2 = On hold
3 = In Progress
4 = Incomplete
5 = Completed

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -release_type
Type of the Release:

1 = minor
2 = standard
3 = major
4 = emergency

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

### -subject
Subject of the Release.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
HTML description of the release.
Description and description_html should not be passed together.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -planned_start_date
Timestamp at which release is starting.

```yaml
Type: DateTime
Parameter Sets: default
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -planned_end_date
Timestamp at which release is ending.

```yaml
Type: DateTime
Parameter Sets: default
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -work_start_date
Timestamp at which release work started.

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

### -work_end_date
Timestamp at which release work ended.

```yaml
Type: DateTime
Parameter Sets: default
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -department_id
Unique ID of the department initiating the Release.

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 13
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -category
Category of the Release.

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

### -sub_category
Sub-category of the Release.

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

### -item_category
Item of the Release.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 16
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
Position: 17
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -assets
List of assets associated with the release.

```yaml
Type: Object[]
Parameter Sets: default
Aliases:

Required: False
Position: 18
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
Position: 19
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -build_plan
Planning field containing the build plan.

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

### -test_plan
Planning field containing the test plan.

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

### -workspace_id
Workspace ID to move ticket. The attribute is applicable only for accounts with the Workspaces feature enabled. The default value is the ID of the primary workspace of the account.

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 2
Default value: 0
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
