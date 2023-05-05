---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServiceSolutionCategory

## SYNOPSIS
Updates a Freshservice Solution Category.

## SYNTAX

```
Set-FreshServiceSolutionCategory [-id] <Int64> [[-name] <String>] [[-description] <String>]
 [[-visible_in_portals] <Int64[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Solution Category via REST API.

https://api.freshservice.com/#update_solution_category

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceSolutionCategory -id 21000070438 -name 'Widget' -description 'Fixes for Widgets'
```

id               : 21000070438
created_at       : 2/14/2023 2:22:36 PM
updated_at       : 3/31/2023 2:01:49 AM
name             : Widget
description      : Fixes for Widgets
default_category : False
position         : 5
translations     :

Updates the name and description of a Freshservice Solution Category.

## PARAMETERS

### -id
Unique id of the Solution Category.

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

### -name
Name of the solution category.
The maximum number of characters allowed is 255.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
Description of the solution category in plain text or HTML format.

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

### -visible_in_portals
List of Unique portal IDs where this category is visible.
Allowed only if the account is configured with multiple portals.

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
