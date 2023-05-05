---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Set-FreshServiceContract

## SYNOPSIS
Updates a Freshservice contract.

## SYNTAX

### Reject
```
Set-FreshServiceContract [-id] <Int64> [-Reject] [[-reason_to_reject] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Approve
```
Set-FreshServiceContract [-id] <Int64> [-Approve] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SubmitApproval
```
Set-FreshServiceContract [-id] <Int64> [-SubmitForApproval] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### default
```
Set-FreshServiceContract [-id] <Int64> [[-name] <String>] [[-description] <String>] [[-vendor_id] <Int64>]
 [[-auto_renew] <Boolean>] [[-notify_expiry] <Boolean>] [[-notify_before] <Int64>] [[-approver_id] <Int64>]
 [[-start_date] <DateTime>] [[-end_date] <DateTime>] [[-cost] <Int64>] [[-contract_number] <String>]
 [[-contract_type_id] <Int64>] [[-visible_to_id] <Int64>] [[-software_id] <Int64>] [[-notify_to] <String[]>]
 [[-custom_fields] <Hashtable>] [[-item_cost_details] <Object>] [[-billing_cycle] <String>]
 [[-attachments] <FileInfo[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice Contract via REST API.

https://api.freshservice.com/#update_a_contract

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceContract -id 8 -description 'Updated contract for MS Office'
```

id                    : 8
name                  : Microsoft O365 Contract V2
description           : Updated contract for MS Office
vendor_id             : 21000085375
auto_renew            : True
notify_expiry         : True
notify_before         : 30
approver_id           : 21000418005
start_date            : 2/12/2023 6:28:00 PM
end_date              : 2/12/2024 6:28:00 PM
cost                  : 1234
status                : draft
contract_number       : MSFT8
contract_type_id      : 3
visible_to_id         : 21000188401
notify_to             : {john.smith@company.com}
custom_fields         :
software_id           : 21000240240
license_type          : volume
billing_cycle         : annual
license_key           :
item_cost_details     : {@{id=21000069162; item_name=Installation; pricing_model=per_unit; cost=200; comments=; count=1; created_at=2/12/2023 6:28:00 PM; updated_at=2/12/2023 6:28:00 PM}}
future_contract_id    :
has_associated_assets : False
has_attachments       : False
expiry_notified       : False
requester_id          : 21000418005
delegatee_id          :
created_at            : 2/12/2023 6:28:00 PM
updated_at            : 2/12/2023 6:28:17 PM

Update the description of a Freshservice Contract.

### EXAMPLE 2
```
Set-FreshServiceContract -id 8 -attachment C:\Scripts\Attachments\attachment.txt
```

id                    : 8
name                  : Microsoft O365 Contract V2
description           : Updated contract for MS Office
vendor_id             : 21000085375
auto_renew            : True
notify_expiry         : True
notify_before         : 30
approver_id           : 21000418005
start_date            : 2/12/2023 6:28:00 PM
end_date              : 2/12/2024 6:28:00 PM
cost                  : 1234
status                : draft
contract_number       : MSFT8
contract_type_id      : 3
visible_to_id         : 21000188401
notify_to             : {john.smith@company.com}
custom_fields         :
software_id           : 21000240240
license_type          : volume
billing_cycle         : annual
license_key           :
item_cost_details     : {@{id=21000069162; item_name=Installation; pricing_model=per_unit; cost=200; comments=; count=1; created_at=2/12/2023 6:28:00 PM; updated_at=2/12/2023 6:28:00 PM}}
future_contract_id    :
has_associated_assets : False
has_attachments       : True
expiry_notified       : False
requester_id          : 21000418005
delegatee_id          :
created_at            : 2/12/2023 6:28:00 PM
updated_at            : 2/12/2023 6:28:17 PM

Add an attachment to a contract.

### EXAMPLE 3
```
Set-FreshServiceContract -id 8 -SubmitForApproval
```

id status
-- ------
8 success 200

Submit a contract for Approval.

### EXAMPLE 4
```
Set-FreshServiceContract -id 8 -Approve
```

id status
-- ------
8 success 200

Approve a contract submitted for approval.

### EXAMPLE 5
```
Set-FreshServiceContract -id 24 -Reject -reason_to_reject 'Too much money'
```

id status
-- ------
24 success 200

Reject a contract submitted for approval. 
Reason is mandatory.

## PARAMETERS

### -id
Unique Id of the Contract.

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

### -name
Name of the Contract

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
Description of the Contract

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -vendor_id
Unique id of the Vendor

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -auto_renew
Contract is set to Auto Renew.

0 - False (Default)
1 - True

```yaml
Type: Boolean
Parameter Sets: default
Aliases:

Required: False
Position: 6
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -notify_expiry
The expiration notification is set up for the contract.

0 - False (Default)
1 - True

```yaml
Type: Boolean
Parameter Sets: default
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -notify_before
Number of days before contract expiry date when the expiry notifications need to be sent.
Cannot exceed 365 days.

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -approver_id
Unique id of the agent who needs to approve the contract.
Not mandatory for software contracts.

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -start_date
Start date of the contract.
Not mandatory for software contracts.

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

### -end_date
End date of the contract.
Not mandatory for software contracts.

```yaml
Type: DateTime
Parameter Sets: default
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -cost
Cost of the contract.
Not mandatory for software contracts.

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 12
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -contract_number
User entered ID for the contract.
This has to be unique.

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -contract_type_id
Unique id of the contract type and it cannot be updated

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 14
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -visible_to_id
ID of agent group in Freshservice to control visibility of the contract

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 15
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -software_id
Unique id of the software and it cannot be updated

```yaml
Type: Int64
Parameter Sets: default
Aliases:

Required: False
Position: 16
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -notify_to
List of email addresses to notify expiry

```yaml
Type: String[]
Parameter Sets: default
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -custom_fields
Key value pairs containing the names and values of custom fields

```yaml
Type: Hashtable
Parameter Sets: default
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -item_cost_details
Item cost detail is an object array containing item cost details.
See helper function: New-FreshServiceContractItem

```yaml
Type: Object
Parameter Sets: default
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -billing_cycle
Represents the contract term period.
Default is one_time

```yaml
Type: String
Parameter Sets: default
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -attachments
Add attachment to Contract.

```yaml
Type: FileInfo[]
Parameter Sets: default
Aliases:

Required: False
Position: 22
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SubmitForApproval
This operation allows you to submit a contract for approval in the account.

```yaml
Type: SwitchParameter
Parameter Sets: SubmitApproval
Aliases: submit_for_approval

Required: True
Position: 2
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Approve
This operation allows you to approve a contract in the account.

```yaml
Type: SwitchParameter
Parameter Sets: Approve
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Reject
This operation allows you to reject a contract in the account.

```yaml
Type: SwitchParameter
Parameter Sets: Reject
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -reason_to_reject
Reason for contract rejection.

```yaml
Type: String
Parameter Sets: Reject
Aliases:

Required: False
Position: 3
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
