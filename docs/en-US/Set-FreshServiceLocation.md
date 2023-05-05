---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServiceLocation

## SYNOPSIS
Updates a Freshservice Location.

## SYNTAX

```
Set-FreshServiceLocation [-id] <String> [[-name] <String>] [[-contact_name] <String>] [[-email] <String>]
 [[-phone] <String>] [[-parent_location_id] <Int64>] [[-primary_contact_id] <Int64>] [[-address] <Hashtable>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Location via REST API.

https://api.freshservice.com/#update_a_location

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceLocation -id 21000506386 -name 'Richmond Headquarters' -address @{line1='123 Corporate Ave';line2='Suite 100';city='Richmond';state='VA';zipcode='23223'}
```

address            : @{line1=123 Corporate Ave; line2=Suite 100; city=Richmond; state=VA; country=US; zipcode=23223}
contact_name       : John Smith
created_at         : 3/9/2023 3:28:06 AM
email              :
id                 : 21000506386
name               : Richmond Headquarters
parent_location_id :
phone              :
primary_contact_id :
updated_at         : 3/30/2023 11:53:52 PM

Update a Freshservice Location.

## PARAMETERS

### -id
Unique id of the location

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

### -name
Name of the location

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

### -contact_name
Name of the Location Contact.

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

### -email
Email of the Location Contact.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -phone
Phone number of the Location Contact.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -parent_location_id
Unique id of the parent location.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -primary_contact_id
User ID of the primary contact (must be a user in Freshservice)

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -address
Address with line1, line2, city, state, country and zip code properties'

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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
