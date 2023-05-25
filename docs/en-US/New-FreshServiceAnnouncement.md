---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceAnnouncement

## SYNOPSIS
Creates Freshservice Announcement.

## SYNTAX

```
New-FreshServiceAnnouncement [-title] <String> [-body_html] <String> [-visible_from] <DateTime>
 [[-visible_till] <DateTime>] [-visibility] <String> [[-departments] <Int64[]>] [[-groups] <Int64[]>]
 [[-send_email] <Boolean>] [[-additional_emails] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice Announcement via REST API.

https://api.freshservice.com/#create_an_announcement

## EXAMPLES

### EXAMPLE 1
```
SAP IS DOWN</h1><p>No ETA on service restoration</p>' -visible_from (get-date) -visibility Everyone
```

id                : 21000035148
created_at        : 3/27/2023 5:25:29 PM
updated_at        : 3/27/2023 5:25:29 PM
title             : SAP Outtage
created_by        : 21000418005
visible_from      : 3/27/2023 5:25:29 PM
visible_till      :
body              :  SAP IS DOWN  No ETA on service restoration
body_html         : \<h1\>SAP IS DOWN\</h1\>\<p\>No ETA on service restoration\</p\>
visibility        : everyone
state             : active
groups            :
departments       :
is_read           : True
send_email        : False
additional_emails : {}

Creates a Freshservice Announcement.

## PARAMETERS

### -title
Title of the Announcement.

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

### -body_html
Body of the Announcement in HTML format.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -visible_from
Timestamp at which Announcement becomes active.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -visible_till
Timestamp until which Announcement is active.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -visibility
Who can see the announcement?
Values - everyone, agents_only, grouped_visibility

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

### -departments
Array of Department IDs that can view this Announcement (visibility must be grouped_visibility).

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -groups
Array of Group IDs that can view this Announcement (visibility must be grouped_visibility).

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -send_email
True if the announcement needs to be sent via email as well.
False, otherwise.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -additional_emails
Additional email addresses to which the announcement needs to be sent.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
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
