---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceSolutionArticle

## SYNOPSIS
Creates a new Freshservice Solution Article.

## SYNTAX

### default (Default)
```
New-FreshServiceSolutionArticle [-title] <String> [-folder_id] <Int64> [-status] <Int32>
 [-description] <String> [[-article_type] <Int64>] [[-tags] <String[]>] [[-keywords] <String[]>]
 [[-attachments] <FileInfo[]>] [[-review_date] <DateTime>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Language
```
New-FreshServiceSolutionArticle [-title] <String> [-folder_id] <Int64> [-status] <Int32>
 [-description] <String> [[-article_type] <Int64>] [-language] <String> [-parent_id] <Int64> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### External
```
New-FreshServiceSolutionArticle [-title] <String> [-folder_id] <Int64> [-status] <Int32> [[-tags] <String[]>]
 [[-keywords] <String[]>] [-url] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new Freshservice Solution Article via REST API.

https://api.freshservice.com/#create_solution_article

## EXAMPLES

### EXAMPLE 1
```
<li>Restart computer</li></ol>' -folder_id 21000036164 -status 1
```

description                      : \<ol\>\<li\>Restart computer\</li\>\</ol\>
group_folder_group_ids           : {}
folder_department_ids            : {}
group_folder_requester_group_ids : {}
group_folder_department_ids      : {}
attachments                      : {}
folder_visibility                : 1
id                               : 21000434337
created_at                       : 3/28/2023 7:02:40 PM
updated_at                       : 3/28/2023 7:02:40 PM
title                            : How to fix the internet.
status                           : 1
user_id                          : 21000418005
approval_status                  :
position                         : 75
folder_id                        : 21000036164
category_id                      : 21000023800
thumbs_up                        : 0
thumbs_down                      : 0
modified_by                      :
modified_at                      : 3/28/2023 7:02:40 PM
inserted_into_tickets            : 0
url                              :
article_type                     : 1
views                            : 0
description_text                 :   Restart computer
keywords                         : {}
review_date                      :
tags                             : {}
approvals                        : {}
cloud_files                      : {}

Creates a new Freshservice Solution Article.

### EXAMPLE 2
```
New-FreshServiceSolutionArticle -title 'Freshservice API Documentation' -folder_id 21000036164 -url 'https://api.freshservice.com/' -tags API -keywords API
```

description                      :
group_folder_group_ids           : {}
folder_department_ids            : {}
group_folder_requester_group_ids : {}
group_folder_department_ids      : {}
attachments                      : {}
folder_visibility                : 1
id                               : 21000434371
created_at                       : 3/28/2023 7:09:09 PM
updated_at                       : 3/28/2023 7:09:09 PM
title                            : Freshservice API Documentation
status                           : 2
user_id                          : 21000418005
approval_status                  :
position                         : 76
folder_id                        : 21000036164
category_id                      : 21000023800
thumbs_up                        : 0
thumbs_down                      : 0
modified_by                      :
modified_at                      : 3/28/2023 7:09:09 PM
inserted_into_tickets            : 0
url                              : https://api.freshservice.com/
article_type                     : 1
views                            : 0
description_text                 :
keywords                         : {API}
review_date                      :
tags                             : {API}
approvals                        : {}
cloud_files                      : {}

Creates a Freshservice Solution article for External Url.

### EXAMPLE 3
```
<li>Redemarrer lordinateur</li></ol>' -parent_id 21000434337 -folder_id 21000036164 -language 'fr' -status 1
```

Creates a Secondary Language Freshservice Solution article.

## PARAMETERS

### -title
Title of the solution article.

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

### -folder_id
Unique id of the folder under which the article is listed.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status
Status of the article.

1 - Draft
2 - Published

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
Description of the solution article.

```yaml
Type: String
Parameter Sets: default, Language
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -article_type
The type of the article.

1 - Permanent
2 - Workaround

```yaml
Type: Int64
Parameter Sets: default, Language
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tags
Tags that have been associated with the article.

```yaml
Type: String[]
Parameter Sets: default, External
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -keywords
keywords that have been associated with the article.

```yaml
Type: String[]
Parameter Sets: default, External
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -attachments
Article attachments.
The total size of these attachments cannot exceed 25MB.

```yaml
Type: FileInfo[]
Parameter Sets: default
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -url
Article from external url link.

```yaml
Type: String
Parameter Sets: External
Aliases:

Required: True
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -review_date
Date in future when this article would need to be reviewed again.

```yaml
Type: DateTime
Parameter Sets: default
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -language
Language of secondary solution article.
For example: French -\> "fr"
For other language code please refer here:
https://support.freshservice.com/en/support/solutions/articles/50000003971-how-to-upgrade-your-multilingual-knowledge-base

```yaml
Type: String
Parameter Sets: Language
Aliases:

Required: True
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -parent_id
Unique ID of the primary language (Solution) article.

```yaml
Type: Int64
Parameter Sets: Language
Aliases:

Required: True
Position: 12
Default value: 0
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
