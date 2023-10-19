---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceChange

## SYNOPSIS
Returns a Freshservice change.

## SYNTAX

```
New-FreshServiceChange [[-workspace_id] <Int32>] [[-agent_id] <Int64>] [[-description] <String>]
 [-requester_id] <Int64> [[-group_id] <Int64>] [[-priority] <Int64>] [[-impact] <Int64>] [[-status] <Int64>]
 [[-risk] <Int64>] [[-change_type] <Int64>] [[-approval_status] <Int64>] [[-planned_start_date] <DateTime>]
 [[-planned_end_date] <DateTime>] [[-subject] <String>] [[-department_id] <Int64>] [[-category] <String>]
 [[-sub_category] <String>] [[-item_category] <String>] [[-custom_fields] <Hashtable>]
 [[-maintenance_window] <Hashtable>] [[-assets] <Object[]>] [[-impacted_services] <Hashtable>]
 [[-attachments] <FileInfo[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice change via REST API.

https://api.freshservice.com/#create_change

## EXAMPLES

### EXAMPLE 1
```
Creates a new change for requester rob.smith@company.com with a Priority of 2 and Status of 2 with tags VPN and Version.
```

New-FreshServiceChange -email "rob.smith@company.com" -subject "VPN no worky" -description "Getting an error that VPN version not supported." -priority 2 -status 2 -tags 'VPN',"Version"

## PARAMETERS

### -workspace_id
Workspace ID of the ticket.
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
Unique identifier of the agent to whom the change is assigned.

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

### -description
HTML content of the change.
Description and description_html should not be passed together

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -requester_id
Unique identifier of the initiator of the change.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -group_id
Unique identifier of the agent group to which the change is assigned.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -priority
Priority of the change.

Low    = 1
Medium = 2
High   = 3
Urgent = 4

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -impact
Impact of the change.

Low    = 1
Medium = 2
High   = 3

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

### -status
Status of the change.

Open            = 1
Planning        = 2
Approval        = 3
Pending Release    = 4
Pending Review  = 5
closed          = 6

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -risk
Risk of the change.

Minor     = 1
Standard  = 2
Major     = 3
Emergency = 4

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

### -change_type
Type of the change.

Minor     = 1
Standard  = 2
Major     = 3
Emergency = 4

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -approval_status
Approval status of the change.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -planned_start_date
Timestamp at which change is starting.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -planned_end_date
Timestamp at which change is ending.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -subject
change subject.

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

### -department_id
Unique ID of the department initiating the change.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -category
Category of the change

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sub_category
Sub-category of the change

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -item_category
Item of the change

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
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
Position: 19
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -maintenance_window
Details about the associated Maintenance Window.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -assets
List of assets associated with the change

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -impacted_services
List of Impacted Services associated with the change

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
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
Position: 23
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
