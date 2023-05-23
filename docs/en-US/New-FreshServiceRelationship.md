---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# New-FreshServiceRelationship

## SYNOPSIS
Creates Freshservice Relationship.

## SYNTAX

```
New-FreshServiceRelationship [-relationship_item] <Object[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice Relationship via REST API..

https://api.freshservice.com/#create_relationships

## EXAMPLES

### EXAMPLE 1
```
Create a new FreshService Relationship.
```

PS C:\PSFreshservice\>

$newFreshServiceRelationshipItemSplat = @{
    relationship_type_id = 21000356921 #Get-FreshServiceRelationshipType
    primary_id           = 42
    primary_type         = 'asset'
    secondary_id         = 41
    secondary_type       = 'asset'
}

$relationship_item = New-FreshServiceRelationshipItem @newFreshServiceRelationshipItemSplat

$newFreshServiceRelationship = New-FreshServiceRelationship -relationship_item $relationship_item

$newFreshServiceRelationship

job_id                               href                                                                               relationship_items
------                               ----                                                                               ------------------
bce1461a-617d-938a-bb73-87d46525e2fc https://its-fine.freshservice.com/api/v2/jobs/bce1461a-617d-938a-bb73-87d46525e2fc @{secondary_type=asset; secondary_id=41;...

## PARAMETERS

### -relationship_item
Object containing the relationship items to process.
Helper function New-FreshServiceRelationshipItem
can be used to create records based on documentation here: https://api.freshservice.com/#create_relationships

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: ri

Required: True
Position: 1
Default value: None
Accept pipeline input: False
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
