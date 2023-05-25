---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceRequestedItem

## SYNOPSIS
Returns a Freshservice Requested Item.

## SYNTAX

```
Get-FreshServiceRequestedItem [-id] <Int64> [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Requested Item via REST API.

https://api.freshservice.com/#view_req_items_of_sr

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceRequestedItem -id 208
```

custom_fields    :
id               : 21000346032
created_at       : 3/27/2023 2:01:45 PM
updated_at       : 3/27/2023 2:01:45 PM
quantity         : 1
stage            : 1
loaned           : False
cost_per_request : 87.5
remarks          :
delivery_time    : 24
is_parent        : False
service_item_id  : 14

custom_fields    :
id               : 21000346030
created_at       : 3/27/2023 2:01:29 PM
updated_at       : 3/27/2023 2:01:29 PM
quantity         : 1
stage            : 1
loaned           : False
cost_per_request : 1099
remarks          :
delivery_time    : 48
is_parent        : True
service_item_id  : 13

Returns all Freshservice Requested Items.

## PARAMETERS

### -id
Unique id of the Service Request.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: service_request_id

Required: True
Position: 2
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
Position: 3
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
