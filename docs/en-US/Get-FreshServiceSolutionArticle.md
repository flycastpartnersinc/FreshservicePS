---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceSolutionArticle

## SYNOPSIS
Returns a Freshservice Solution Article.

## SYNTAX

### default (Default)
```
Get-FreshServiceSolutionArticle [-folder_id] <Int64> [[-per_page] <Int32>] [[-page] <Int32>]
 [<CommonParameters>]
```

### Id
```
Get-FreshServiceSolutionArticle [-id] <Int64> [-folder_id] <Int64> [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Solution Article via REST API.

https://api.freshservice.com/#view_solution_article

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceSolutionArticle -id 18000063600
```

description                      : \<p\>This is how you fix stuff\</p\>
group_folder_group_ids           : {}
folder_department_ids            : {}
group_folder_requester_group_ids : {}
group_folder_department_ids      : {}
attachments                      : {}
folder_visibility                : 1
id                               : 18000063600
created_at                       : 9/30/2022 3:13:24 AM
updated_at                       : 9/30/2022 3:13:24 AM
title                            : My New Solution Article
status                           : 2
user_id                          : 18012453181
approval_status                  :
position                         : 1
folder_id                        : 18000066002
category_id                      : 18000018546
thumbs_up                        : 0
thumbs_down                      : 0
modified_by                      :
modified_at                      : 9/30/2022 3:13:24 AM
inserted_into_tickets            : 0
url                              :
article_type                     : 1
views                            : 0
description_text                 :  This is how you fix stuff
keywords                         : {}
review_date                      :
tags                             : {}
approvals                        : {}
cloud_files                      : {}

Get Freshservice Solution Article by id.

### EXAMPLE 2
```
Get-FreshServiceSolutionArticle -folder_id 18000066002
```

description                      : \<p\>This is how you fix stuff\</p\>
group_folder_group_ids           : {}
folder_department_ids            : {}
group_folder_requester_group_ids : {}
group_folder_department_ids      : {}
attachments                      : {}
folder_visibility                : 1
id                               : 18000063600
created_at                       : 9/30/2022 3:13:24 AM
updated_at                       : 9/30/2022 3:13:24 AM
title                            : My New Solution Article
status                           : 2
user_id                          : 18012453181
approval_status                  :
position                         : 1
folder_id                        : 18000066002
category_id                      : 18000018546
thumbs_up                        : 0
thumbs_down                      : 0
modified_by                      :
modified_at                      : 9/30/2022 3:13:24 AM
inserted_into_tickets            : 0
url                              :
article_type                     : 1
views                            : 0
description_text                 :  This is how you fix stuff
keywords                         : {}
review_date                      :

description                      : \<p\>Updated description on how to fix stuff.\</p\>
group_folder_group_ids           : {}
folder_department_ids            : {}
group_folder_requester_group_ids : {}
group_folder_department_ids      : {}
attachments                      : {}
folder_visibility                : 1
id                               : 18000063601
created_at                       : 9/30/2022 3:16:48 AM
updated_at                       : 9/30/2022 12:59:16 PM
title                            : My Other New Solution Article
status                           : 1
user_id                          : 18012453181
approval_status                  :
position                         : 2
folder_id                        : 18000066002
category_id                      : 18000018546
thumbs_up                        : 0
thumbs_down                      : 0
modified_by                      : 18012453181
modified_at                      : 10/10/2022 8:23:59 PM
inserted_into_tickets            : 0
url                              :
article_type                     : 1
views                            : 0
description_text                 :  Updated description on how to fix stuff.
keywords                         : {}
review_date                      :

Get solution articles by folder.

## PARAMETERS

### -id
Unique id of the Freshservice Solution Article.

```yaml
Type: Int64
Parameter Sets: Id
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -folder_id
The id of the folder to return Freshservice Solution Articles.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
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
Position: 2
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
