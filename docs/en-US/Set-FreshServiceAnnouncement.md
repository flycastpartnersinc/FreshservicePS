---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServiceAnnouncement

## SYNOPSIS
Updates a Freshservice Announcement.

## SYNTAX

```
Set-FreshServiceAnnouncement [-id] <Int64> [[-title] <String>] [[-body_html] <String>]
 [[-visible_from] <DateTime>] [[-visible_till] <DateTime>] [[-visibility] <String>] [[-departments] <Int64[]>]
 [[-groups] <Int64[]>] [[-send_email] <Boolean>] [[-additional_emails] <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Announcement via REST API.

https://api.freshservice.com/#edit_an_announcement

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceAnnouncement -id 21000034874 -body_html 'Updated Announcement Content'
```

id                : 21000034874
created_at        : 2/22/2023 7:54:58 PM
updated_at        : 2/22/2023 7:54:58 PM
title             : Test Announcement
created_by        : 21000418005
visible_from      : 2/22/2023 7:52:08 PM
visible_till      :
body              : Updated Announcement Content
body_html         : Updated Announcement Content
visibility        : everyone
state             : active
groups            :
departments       :
is_read           : True
send_email        : False
additional_emails : {}

Update a description on a specific note on a problem.

## PARAMETERS

### -id
Unique id of the Announcement

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

### -title
Title of the Announcement

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

### -body_html
Body of the Announcement in HTML format

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

### -visible_from
Timestamp at which Announcement becomes active

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

### -visible_till
Timestamp until which Announcement is active

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -departments
Array of Department IDs that can view this Announcement (visibility must be grouped_visibility)

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

### -groups
Array of Group IDs that can view this Announcement (visibility must be grouped_visibility)

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -send_email
True if the announcement needs to be sent via email as well.
False, otherwise

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -additional_emails
Additional email addresses to which the announcement needs to be sent

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
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
