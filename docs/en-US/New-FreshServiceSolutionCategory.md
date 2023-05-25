---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceSolutionCategory

## SYNOPSIS
Creates a Freshservice Solution Category.

## SYNTAX

```
New-FreshServiceSolutionCategory [-name] <String> [[-description] <String>] [[-visible_in_portals] <Int64[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a Freshservice Solution Category via REST API.

https://api.freshservice.com/#create_solution_category

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceSolutionCategory -name MyCategory
```

id                 : 18000040165
created_at         : 9/29/2022 1:29:35 PM
updated_at         : 9/29/2022 1:29:35 PM
name               : MyCategory
description        :
default_category   : False
position           : 4
translations       :
visible_in_portals : {18000009042}

Creates a new Freshservice Solution category.

## PARAMETERS

### -name
Name of the Solution Category.
The maximum number of characters allowed is 255.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
Description of the Solution Category in plain text or HTML format.

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

### -visible_in_portals
List of Unique portal IDs where this category is visible.
Allowed only if the account is configured with multiple portals.

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
