---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceWorkspace

## SYNOPSIS
Returns a Freshservice Workspace.

## SYNTAX

### default (Default)
```
Get-FreshServiceWorkspace [-per_page <Int32>] [-page <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceWorkspace [-Id] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Workspace via REST API.

https://api.freshservice.com/#view_a_workspace

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceWorkspace
```

created_at    : 7/25/2023 1:25:30 PM
description   :
id            : 2
logo          :
name          : My Team
primary       : True
restricted    : False
state         : 1
template_name : it
updated_at    : 7/25/2023 1:25:30 PM

created_at    : 8/25/2023 8:58:25 PM
description   :
id            : 3
logo          : https://tenant.attachments.freshservice.com/data/helpdesk/attachments/production/21019153239/original/it.png?Expires=1697659317&Signature=gEfmrtaiQWqSCQFvyPGRezeoz9z~rrtZQ5yoNb3ssaCiFlFLJKGAzqXhftFD8v4vk-WQn6gZXVNtbuj
                a0kVOof0p0D2p3ojHX7xNqzVmtWrIqozOcwmohDKz8ZFqZ3oD0pGclO4Qy9KxPGmMW4nJ09aI7eUG7QH76gmxN-C4biqwE2w1QVkg1cjrNXT-3iMPs18ZEb3e1OsfKhHg7fnX2oSlYsZnR0oTLpSFvOUndKdklRMpMq7xQeL4X-VbV~9thZrJ8CEkwyBomhdUxz0jiN4Lpo6~2gR0kqmMvh999Q
                H0RFlXb25UOWilCK6VAxHKUpwO29H0qsKLe5GFa5Gz~Q__&Key-Pair-Id=APKAIPHBXWY2KT5RCMPQ
name          : IT Custom
primary       : False
restricted    : False
state         : 1
template_name : it
updated_at    : 8/25/2023 8:59:09 PM

Returns all Freshservice Workspaces.

### EXAMPLE 2
```
Get-FreshServiceWorkspace -id 2
```

created_at    : 7/25/2023 1:25:30 PM
description   :
id            : 2
logo          :
name          : My Team
primary       : True
restricted    : False
state         : 1
template_name : it
updated_at    : 7/25/2023 1:25:30 PM

Return a Freshservice Workspace by Id.

## PARAMETERS

### -Id
Unique id of the FreshService Workspace.

```yaml
Type: Int32
Parameter Sets: id
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
Position: Named
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
Position: Named
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
