---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceLocation

## SYNOPSIS
Returns a Freshservice Location.

## SYNTAX

### default (Default)
```
Get-FreshServiceLocation [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceLocation [[-Id] <Int64>] [<CommonParameters>]
```

### ByName
```
Get-FreshServiceLocation [[-Name] <String>] [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Location via REST API.

https://api.freshservice.com/#view_a_location

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceLocation
```

address            : @{line1=; line2=; city=; state=; country=; zipcode=}
contact_name       :
created_at         : 8/29/2022 2:17:48 PM
email              :
id                 : 21000159902
name               : Japan
parent_location_id : 21000159892
phone              :
primary_contact_id :
updated_at         : 8/29/2022 2:17:48 PM

address            : @{line1=; line2=; city=; state=; country=; zipcode=}
contact_name       :
created_at         : 8/29/2022 2:17:48 PM
email              :
id                 : 21000159901
name               : China
parent_location_id : 21000159892
phone              :
primary_contact_id :
updated_at         : 8/29/2022 2:17:48 PM

address            : @{line1=; line2=; city=; state=; country=; zipcode=}
contact_name       :
created_at         : 8/29/2022 2:17:48 PM
email              :
id                 : 21000159900
name               : India
parent_location_id : 21000159892
phone              :
primary_contact_id :
updated_at         : 8/29/2022 2:17:48 PM

Returns all Freshservice Locations

### EXAMPLE 2
```
Get-FreshServiceLocation -Id 21000159902
```

address            : @{line1=; line2=; city=; state=; country=; zipcode=}
contact_name       :
created_at         : 8/29/2022 2:17:48 PM
email              :
id                 : 21000159902
name               : Japan
parent_location_id : 21000159892
phone              :
primary_contact_id :
updated_at         : 8/29/2022 2:17:48 PM

Returns a Freshservice Location by Id.

### EXAMPLE 3
```
Get-FreshServiceLocation -Name Japan
```

address            : @{line1=; line2=; city=; state=; country=; zipcode=}
contact_name       :
created_at         : 8/29/2022 2:17:48 PM
email              :
id                 : 21000159902
name               : Japan
parent_location_id : 21000159892
phone              :
primary_contact_id :
updated_at         : 8/29/2022 2:17:48 PM

Returns a Freshservice Location By Name.

## PARAMETERS

### -Id
Unique id of the Location.

```yaml
Type: Int64
Parameter Sets: id
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Return by Location Name.

```yaml
Type: String
Parameter Sets: ByName
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
Parameter Sets: default, ByName
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
Parameter Sets: default, ByName
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
