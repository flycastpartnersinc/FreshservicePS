---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceAnnouncement

## SYNOPSIS
Returns a Freshservice Announcement.

## SYNTAX

### default (Default)
```
Get-FreshServiceAnnouncement [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceAnnouncement [[-Id] <Int64>] [<CommonParameters>]
```

### ByName
```
Get-FreshServiceAnnouncement [[-State] <String>] [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Announcement via REST API.

https://api.freshservice.com/#view_an_announcement

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceAnnouncement
```

id                : 21000035135
created_at        : 3/25/2023 5:34:21 PM
updated_at        : 3/25/2023 5:34:21 PM
title             : SAP Outtage
created_by        : 21000418005
visible_from      : 3/25/2023 5:34:20 PM
visible_till      :
body              :  SAP IS DOWN  No ETA on service restoration
body_html         : \<h1\>SAP IS DOWN\</h1\>\<p\>No ETA on service restoration\</p\>
visibility        : everyone
state             : active
groups            :
departments       :
is_read           : False
send_email        : False
additional_emails : {Alex@example.com}

id                : 21000034874
created_at        : 2/22/2023 7:54:58 PM
updated_at        : 2/22/2023 7:54:58 PM
title             : Test Announcement
created_by        : 21000418005
visible_from      : 2/22/2023 7:52:08 PM
visible_till      :
body              :  Test Announcement from Alex's FreshService Instance!
body_html         : \<p\>Test Announcement from Alex's FreshService Instance!\</p\>
visibility        : everyone
state             : active
groups            :
departments       :
is_read           : True
send_email        : False
additional_emails : {mymsteamsemail.mycompany.com@amer.teams.ms}

id                : 21000011768
created_at        : 8/29/2022 2:17:30 PM
updated_at        : 8/29/2022 2:17:30 PM
title             : Welcome to Freshservice
created_by        : 21000418005
visible_from      : 8/29/2022 2:17:30 PM
visible_till      :
body              :  Your Freshservice account has been activated and is now ready to use.
During your free 21-day
                    trial period, your account will be on the highest trial plan - Enterprise (Trial) and you will
                    have access to all of the features and capabilities of Freshservice.
Here are a few quick links
                    to help you set up your service desk:       1.
Getting Started with Freshservice      2.
Admin's
                    guide to managing a service desk      3.
Agent's guide to simplifying tasks and automating
                    tickets      4.
Go-live handbook      5.
Network and engage with peers in the Freshservice
                    Community  You can also explore the Admin settings to get started with your service desk. 
If
                    you have any questions or concerns, please contact us at support@freshservice.com and a
                    representative will get in touch with you. 
Please note: This is a default announcement banner
                    and can be dismissed by clicking on the cancel icon.
body_html         : \<div\>Your Freshservice account has been activated and is now ready to use.
During your free
                    21-day trial period, your account will be on the \<a
                    href="https://freshservice.com/pricing"\>highest trial plan - Enterprise (Trial)\</a\> and you will
                    have access to all of the features and capabilities of Freshservice.
Here are a few quick links
                    to help you set up your service desk:\<pre\>\<br\>     1.\<a
                    href="https://support.freshservice.com/en/support/solutions/82979"\> Getting Started with
                    Freshservice\</a\>\<br\>     2.\<a
                    href="https://support.freshservice.com/en/support/solutions#agentguidepage"\> Admin's guide to
                    managing a service desk\</a\>\<br\>     3.\<a
                    href="https://support.freshservice.com/en/support/solutions#agentguidepage"\> Agent's guide to
                    simplifying tasks and automating tickets\</a\>\<br\>     4.\<a
                    href="https://freshservice.com/resources/ebooks/itsm-cheat-sheet"\> Go-live handbook\</a\>\<br\>
                    5.\<a href="https://community.freshworks.com/freshservice-11247"\> Network and engage with peers
                    in the Freshservice Community\</a\>\</pre\>\<br\>You can also explore the Admin settings to get
                    started with your service desk.\<br\>\<br\>If you have any questions or concerns, please contact us
                    at support@freshservice.com and a representative will get in touch with
                    you.\<br\>\<br\>\<strong\>Please note:\</strong\> This is a default announcement banner and can be
                    dismissed by clicking on the cancel icon.\</div\>
visibility        : everyone
state             : active
groups            :
departments       :
is_read           : True
send_email        : False
additional_emails : {}

Returns all Freshservice Announcements.

### EXAMPLE 2
```
Get-FreshServiceAnnouncement -id 21000035135
```

id                : 21000035135
created_at        : 3/25/2023 5:34:21 PM
updated_at        : 3/25/2023 5:34:21 PM
title             : SAP Outtage
created_by        : 21000418005
visible_from      : 3/25/2023 5:34:20 PM
visible_till      :
body              :  SAP IS DOWN  No ETA on service restoration
body_html         : \<h1\>SAP IS DOWN\</h1\>\<p\>No ETA on service restoration\</p\>
visibility        : everyone
state             : active
groups            :
departments       :
is_read           : True
send_email        : False
additional_emails : {Alex@example.com}

Returns all Freshservice Announcement by Id.

## PARAMETERS

### -Id
Unique id of the Announcement.

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

### -State
State of Announcement (archived | active | scheduled | unread ).

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
