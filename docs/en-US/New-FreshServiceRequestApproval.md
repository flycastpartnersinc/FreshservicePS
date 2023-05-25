---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceRequestApproval

## SYNOPSIS
Creates new Freshservice Service Request Approval.

## SYNTAX

```
New-FreshServiceRequestApproval [-display_id] <Int64> [-approver_id] <Int64> [-approval_type] <Int32>
 [[-email_content] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates new Freshservice Service Request Approval via REST API.

https://api.freshservice.com/#create_ticket_approval

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceRequestApproval -display_id 221 -approver_id 21001931878 -approval_type 2
```

id              : 21000143868
created_at      : 4/24/2023 7:29:38 PM
updated_at      : 4/24/2023 7:29:38 PM
approver_id     : 21001931878
approver_name   : Alex
approval_type   : 2
user_id         : 21000418005
level           : 1
user_name       : Alex
approval_status : @{id=0; name=requested}
delegatee       :
latest_remark   :

Create a new Freshservice Service Request Approval.

## PARAMETERS

### -display_id
Display Id of the Service Request.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: SRID, DisplayId

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -approver_id
User ID of the approver.

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

### -approval_type
Helps define the type of approval in case there are more than one approvers:

1 = To be approved by Everyone
2 = To be approved by Anyone
3 = To be approved by Majority
4 = To be approved by First Responder

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

### -email_content
HTML content of the approval email.
Overrides the default approval notification will be sent to approvers.

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
