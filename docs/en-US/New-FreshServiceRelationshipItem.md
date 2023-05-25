---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceRelationshipItem

## SYNOPSIS
Helper function to create item relationship types for New-FreshServiceRelationship.

## SYNTAX

```
New-FreshServiceRelationshipItem [-relationship_type_id] <Int64> [-primary_id] <Int32> [-primary_type] <String>
 [-secondary_id] <Int32> [-secondary_type] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Helper function to create item relationship types for New-FreshServiceRelationship.
Relationships can be created between
Asset, Requester, Agent, Department or Software.
This helper function assists with generation of the PSObject within the confines
of the documentation for the -relationship_item parameter.

## EXAMPLES

### EXAMPLE 1
```
$newFreshServiceRelationshipItemSplat = @{
    relationship_type_id = 21000356921 #Get-FreshServiceRelationshipType
    primary_id           = 42
    primary_type         = 'asset'
    secondary_id         = 41
    secondary_type       = 'asset'
}
```

New-FreshServiceRelationshipItem @newFreshServiceRelationshipItemSplat

secondary_type       : asset
secondary_id         : 41
relationship_type_id : 21000356921
primary_type         : asset
primary_id           : 42

Create a relationship item.

## PARAMETERS

### -relationship_type_id
Unique id of the relationship type.
See Get-FreshserviceRelationshipType.

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

### -primary_id
Display ID of the entity from which the relationship will be created.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -primary_type
Type of the entity from which the relationship will be created.
Supported values are asset, requester, agent, department or software.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secondary_id
Display ID of the entity from which the relationship will be created.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secondary_type
Type of the entity from which the relationship will be created.
Supported values are asset, requester, agent, department or software.

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
