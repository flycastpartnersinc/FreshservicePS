---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# New-FreshServiceRelease

## SYNOPSIS
Creates new Freshservice Release.

## SYNTAX

```
New-FreshServiceRelease [-workspace_id <Int64>] [-agent_id <Int64>] [-group_id <Int64>] -priority <Int32>
 -status <Int32> -release_type <Int32> -subject <String> [-description <String>] -planned_start_date <DateTime>
 -planned_end_date <DateTime> [-work_start_date <DateTime>] [-work_end_date <DateTime>]
 [-department_id <Int64>] [-category <String>] [-sub_category <String>] [-item_category <String>]
 [-custom_fields <Hashtable>] [-assets <Object[]>] [-attachments <FileInfo[]>] [[-build_plan] <String>]
 [[-test_plan] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates new Freshservice Release via REST API.

https://api.freshservice.com/#view_a_release

## EXAMPLES

### EXAMPLE 1
```
$newFreshServiceReleaseSplat = @{
    subject            = "Release for Software X"
    description        = "Release for Software X for version 1.2.4"
    priority           = 1
    status             = 1
    planned_start_date = Get-Date -hour 20 -Minute 0 -Second 0
    planned_end_date   = Get-Date -hour 22 -Minute 0 -Second 0
    release_type       = 2
}
```

New-FreshServiceRelease @newFreshServiceReleaseSplat

Creates a new Freshservice Release.

## PARAMETERS

### -workspace_id
Workspace ID of the ticket.
The attribute is applicable only for accounts with the 'Workspaces' feature enabled.
The default value is the ID of the primary workspace of the account.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -agent_id
Unique identifier of the agent to whom the Release is assigned

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -group_id
Unique identifier of the agent group to which the Release is assigned

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -priority
Priority of the Release:

1-Low
2-Medium
3-High
4-Urgent

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status
Status identifier of the Release:

1-Open
2-On hold
3-In Progress
4-Incomplete
5-Completed

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -release_type
Type of the Release:

1-minor
2-standard
3-major
4-emergency

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -subject
Subject of the Release.

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

### -description
HTML description of the release.
Description and description_html should not be passed together.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -planned_start_date
Timestamp at which release is starting.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -planned_end_date
Timestamp at which release is ending.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -work_start_date
Timestamp at which release work started.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -work_end_date
Timestamp at which release work ended.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -department_id
Unique ID of the department initiating the Release.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -category
Category of the Release.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sub_category
Sub-category of the Release.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -item_category
Item of the Release.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -assets
List of assets associated with the release.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -build_plan
Planning field containing the build plan.

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

### -test_plan
Planning field containing the test plan.

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
