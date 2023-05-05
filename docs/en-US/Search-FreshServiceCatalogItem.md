---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Search-FreshServiceCatalogItem

## SYNOPSIS
Search for Freshservice Catalog Item.

## SYNTAX

```
Search-FreshServiceCatalogItem [[-search_term] <String>] [[-user_email] <String>] [[-per_page] <Int32>]
 [[-page] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Search for Freshservice Catalog Item via REST API.

https://api.freshservice.com/#search_service_item

## EXAMPLES

### EXAMPLE 1
```

```

## PARAMETERS

### -search_term
The keywords for which the solution articles have to be searched.
Example: "Vpn issue"

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

### -user_email
By default, the API will search the articles for the user whose API key is provided.
If you want to search articles for a different user, please provide their user_email.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
Position: 3
Default value: 5
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
Position: 4
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
