---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceSolutionCategory

## SYNOPSIS
Returns a Freshservice Solution Category.

## SYNTAX

```
Get-FreshServiceSolutionCategory [[-Id] <String>] [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Solution Category via REST API.

https://api.freshservice.com/#view_solution_category

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceSolutionCategory
```

id                 : 18000018545
created_at         : 3/16/2021 9:24:31 PM
updated_at         : 3/16/2021 9:31:04 PM
name               : Default Category
description        : All emails sent to kbase@company.com will be stored here as drafts
default_category   : True
position           : 1
translations       :
visible_in_portals : {18000009042}

id                 : 18000018546
created_at         : 3/16/2021 9:24:31 PM
updated_at         : 3/16/2021 9:24:31 PM
name               : General
description        : Default solution category, feel free to edit or delete it.
default_category   : False
position           : 2
translations       :
visible_in_portals : {18000009042, 18000010161}

id                 : 18000040164
created_at         : 9/29/2022 1:24:27 PM
updated_at         : 9/29/2022 1:32:41 PM
name               : CategoryFromApi
description        : My category description
default_category   : False
position           : 3
translations       :
visible_in_portals : {18000009042}

id                 : 18000040165
created_at         : 9/29/2022 1:29:35 PM
updated_at         : 9/29/2022 1:29:35 PM
name               : MyCategory
description        :
default_category   : False
position           : 4
translations       :
visible_in_portals : {18000009042}

Get all Freshservice Solution Categories.

### EXAMPLE 2
```
Get-FreshServiceSolutionCategory -id 18000040164
```

id                 : 18000040164
created_at         : 9/29/2022 1:24:27 PM
updated_at         : 9/29/2022 1:32:41 PM
name               : CategoryFromApi
description        : My category description
default_category   : False
position           : 3
translations       :
visible_in_portals : {18000009042}

Get a Freshservice Solution Category with id 18000040164.

## PARAMETERS

### -Id
Unique Id of the Solution Category.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
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
Position: 2
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
Position: 3
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
