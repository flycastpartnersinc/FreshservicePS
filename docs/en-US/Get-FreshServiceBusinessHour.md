---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceBusinessHour

## SYNOPSIS
Returns a Freshservice Business Hours.

## SYNTAX

### default (Default)
```
Get-FreshServiceBusinessHour [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceBusinessHour [[-Id] <Int64>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Business Hours via REST API.

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceBusinessHour
```

id                 : 21000011791
created_at         : 8/29/2022 2:17:01 PM
updated_at         : 8/29/2022 2:17:01 PM
name               : Default
description        : Default Business Calendar
is_default         : True
time_zone          : Eastern Time (US & Canada)
service_desk_hours : @{monday=; tuesday=; wednesday=; thursday=; friday=}
list_of_holidays   : {@{holiday_date=--01-16; holiday_name=Birthday of Martin Luther King Jr}, @{holiday_date=--02-20;
                    holiday_name=Washington's Birthday}, @{holiday_date=--05-28; holiday_name=Memorial Day},
                    @{holiday_date=--07-04; holiday_name=Independence Day}...}

Return all Freshservice Business Hours.

### EXAMPLE 2
```
Get-FreshServiceBusinessHour -Id 21000011791
```

id                 : 21000011791
created_at         : 8/29/2022 2:17:01 PM
updated_at         : 8/29/2022 2:17:01 PM
name               : Default
description        : Default Business Calendar
is_default         : True
time_zone          : Eastern Time (US & Canada)
service_desk_hours : @{monday=; tuesday=; wednesday=; thursday=; friday=}
list_of_holidays   : {@{holiday_date=--01-16; holiday_name=Birthday of Martin Luther King Jr}, @{holiday_date=--02-20;
                    holiday_name=Washington's Birthday}, @{holiday_date=--05-28; holiday_name=Memorial Day},
                    @{holiday_date=--07-04; holiday_name=Independence Day}...}

Returns a Freshservice Business Hour by Id.

## PARAMETERS

### -Id
Unique id of the specific Business Hour.

https://api.freshservice.com/#business-hours

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

### -per_page
Number of records to return per page during pagination. 
Maximum of 100 records.

```yaml
Type: Int32
Parameter Sets: default
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
Parameter Sets: default
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
