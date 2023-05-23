---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServiceRequestApproval

## SYNOPSIS
Updates a Freshservice Product.

## SYNTAX

### default (Default)
```
Set-FreshServiceRequestApproval [-display_id] <Int64> [-id] <Int64> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### cancel
```
Set-FreshServiceRequestApproval [-display_id] <Int64> [-id] <Int64> [-cancel] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### remind
```
Set-FreshServiceRequestApproval [-display_id] <Int64> [-id] <Int64> [-remind] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Product via REST API.

https://api.freshservice.com/#update_a_product

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceRequestApproval -display_id 221 -id 21000143868 -remind
```

id display_id status
-- ---------- ------
21000143868        221 success

Send a reminder for a Freshservice Request Approval.
Default API has no response, artificial response with id and
status containing status code is returned for tracking.

### EXAMPLE 2
```
Set-FreshServiceRequestApproval -display_id 221 -id 21000143868 -cancel
```

id              : 21000143868
created_at      : 4/24/2023 7:29:38 PM
updated_at      : 4/24/2023 8:20:54 PM
approver_id     : 21001931878
approver_name   : Alex
approval_type   : 2
user_id         : 21000418005
level           : 1
user_name       : Alex
approval_status : @{id=3; name=cancelled}
delegatee       :
latest_remark   :

Cancel a Freshservice Request Approval.

## PARAMETERS

### -display_id
Unique Display id of the Service Request.

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

### -id
Unique id of the Service Request Approval.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -cancel
Cancel the approval.

```yaml
Type: SwitchParameter
Parameter Sets: cancel
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -remind
Send reminder for the approval.

```yaml
Type: SwitchParameter
Parameter Sets: remind
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: False
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
