---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServiceSolutionArticle

## SYNOPSIS
Updates a Freshservice Solution Article.

## SYNTAX

### External
```
Set-FreshServiceSolutionArticle [-id] <Int64> [[-title] <String>] [[-folder_id] <Int64>] [[-status] <Int32>]
 [[-tags] <Array>] [[-keywords] <Array>] [-url] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Approval
```
Set-FreshServiceSolutionArticle [-id] <Int64> [-send_for_approval] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### default
```
Set-FreshServiceSolutionArticle [-id] <Int64> [[-title] <String>] [[-description] <String>]
 [[-article_type] <Int64>] [[-folder_id] <Int64>] [[-status] <Int32>] [[-tags] <Array>] [[-keywords] <Array>]
 [[-attachments] <FileInfo[]>] [[-review_date] <DateTime>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Solution Article via REST API.

https://api.freshservice.com/#update_solution_article

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceSolutionArticle -id 21000399687 -description "Updated Solution for KB"
```

description                      : \<p\>Updated Solution for KB\</p\>
group_folder_group_ids           : {}
folder_department_ids            : {}
group_folder_requester_group_ids : {}
group_folder_department_ids      : {}
attachments                      : {}
folder_visibility                : 1
id                               : 21000399687
created_at                       : 3/23/2023 1:49:08 PM
updated_at                       : 3/31/2023 1:54:52 AM
title                            : VPN Issue 4
status                           : 1
user_id                          : 21000418005
approval_status                  :
position                         : 7
folder_id                        : 21000036164
category_id                      : 21000023800
thumbs_up                        : 0
thumbs_down                      : 0
modified_by                      : 21000418005
modified_at                      : 3/31/2023 1:54:52 AM
inserted_into_tickets            : 0
url                              :
article_type                     : 1
views                            : 0
description_text                 :  Updated Solution for KB
keywords                         : {VPN}
review_date                      :
tags                             : {VPN}
approvals                        : {}
cloud_files                      : {}

Update the description on a Freshservice Solution Article.

## PARAMETERS

### -id
Unique id of the solution article.

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
Title of the solution article.

```yaml
Type: String
Parameter Sets: External, default
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
Description of the solution article.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -article_type
The type of the article.

1 = permanent
2 = workaround

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -folder_id
Unique id of the folder under which the article is listed.

```yaml
Type: Int64
Parameter Sets: External, default
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status
Status of the article.

1 = draft
2 = published

```yaml
Type: Int32
Parameter Sets: External, default
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tags
Tags that have been associated with the article

```yaml
Type: Array
Parameter Sets: External, default
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -keywords
keywords that have been associated with the article

```yaml
Type: Array
Parameter Sets: External, default
Aliases:

Required: False
Position: 6
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
Position: 7
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
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -send_for_approval
Send the article for approval.

```yaml
Type: SwitchParameter
Parameter Sets: Approval
Aliases:

Required: False
Position: 2
Default value: False
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
