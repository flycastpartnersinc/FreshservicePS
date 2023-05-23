---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Invoke-FreshServiceAuditLogExport

## SYNOPSIS
Invokes an export of the Freshservice Audit Log.

## SYNTAX

```
Invoke-FreshServiceAuditLogExport [-since] <DateTime> [-before] <DateTime> [[-type] <String[]>]
 [[-actor] <Int64>] [[-workflow_id] <Int64>] [[-sla_policy_id] <Int64>] [[-change_lifecycle_id] <Int64>]
 [[-group_id] <Int64>] [[-agent_id] <Int64>] [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Invokes an export of the Freshservice Audit Log via REST API.

https://api.freshservice.com/#audit-logs

## EXAMPLES

### EXAMPLE 1
```
Invoke-FreshServiceAuditLogExport -since (Get-Date -Date (Get-Date).AddDays(-5)) -before (Get-Date)
```

Your export is on its way.
It will be in alex@example.com's inbox soon

Request audit log email export for last 5 days.

## PARAMETERS

### -since
Timestamp from which the logs are needed.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -before
Timestamp to which the logs are needed.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
Denotes the type of module:

account
agent
group
change_field
change_lifecycle
sandbox_job
sla_policy
workflow
plans & billing

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -actor
Id of the agent who performed the changes.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -workflow_id
Id of the workflow.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -sla_policy_id
Id of the sla policy.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -change_lifecycle_id
Id of the change lifecycle.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -group_id
Id of the Group.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -agent_id
Id of the Agent.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
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
Position: 1
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
Position: 2
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
