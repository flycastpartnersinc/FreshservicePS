---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# New-FreshServiceContract

## SYNOPSIS
Creates Freshservice contract.

## SYNTAX

```
New-FreshServiceContract [-name] <String> [[-description] <String>] [-vendor_id] <Int64>
 [[-auto_renew] <Boolean>] [[-notify_expiry] <Boolean>] [[-notify_before] <Int64>] [-approver_id] <Int64>
 [-start_date] <DateTime> [-end_date] <DateTime> [-cost] <Int64> [-contract_number] <String>
 [-contract_type_id] <Int64> [[-visible_to_id] <Int64>] [[-software_id] <Int64>] [[-notify_to] <String[]>]
 [[-custom_fields] <Hashtable>] [[-item_cost_details] <Object>] [[-billing_cycle] <String>]
 [[-associated_asset_ids] <Int32[]>] [[-attachments] <FileInfo[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates Freshservice contract via REST API.

https://api.freshservice.com/#create_a_contract

## EXAMPLES

### EXAMPLE 1
```
$contractParams = @{
    name               = 'Microsoft O365 Contract'
    description        = 'Test contract from API'
    vendor_id          = 18000414331 #Get-FreshServiceVendor
    auto_renew         = $true
    notify_expiry      = $true
    notify_before      = 30
    approver_id        = 18012453181 #Get-FSRequester
    start_date         = Get-Date
    end_date           = (Get-Date).AddDays(365)
    cost               = 1233.67
    contract_number    = 'MSFT2'
    contract_type_id   = 3
    visible_to_id      = 18000144649 #Get-FSAgentGroup
    notify_to          = 'john.smith@company.com'
    software_id        = 18001038620 #Get-FSSoftware
    billing_cycle      = 'annual'
    item_cost_details  = @([pscustomobject]@{item_name='Installation'; pricing_model='per_unit'; cost=200; count=1})
}
```

New-FreshserviceContract @contractParams

Creates a new Freshservice Contract.

## PARAMETERS

### -name
Name of the Contract

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -description
Description of the Contract

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vendor_id
Unique id of the Vendor

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -auto_renew
True (1) if the contract is set to Auto Renew.
Default is False (0)

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -notify_expiry
True (1) if the expiry notification is set up for the contract.
Default is False (0)

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -notify_before
Number of days before contract expiry date when the expiry notifications need to be sent.
Cannot exceed 365 days

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -approver_id
Unique id of the agent who needs to approve the contract.
Not mandatory for software contracts

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -start_date
Start date of the contract.
Not mandatory for software contracts

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -end_date
End date of the contract.
Not mandatory for software contracts

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cost
Cost of the contract.
Not mandatory for software contracts

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 10
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -contract_number
User entered ID for the contract.
This has to be unique.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contract_type_id
Unique id of the contract type.
Cannot be changed once set.

1 = Lease
2 = Maintenance
3 = Software License
4 = Warranty

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: True
Position: 12
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -visible_to_id
ID of agent group in Freshservice to control visibility of the contract

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -software_id
Unique id of the software.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -notify_to
List of email addresses to notify expiry

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -custom_fields
Key value pairs containing the names and values of custom fields

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -item_cost_details
Key value pairs containing the names and values of item cost details.
See helper function New-FreshServiceContractItem.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billing_cycle
Represents the contract term period.
Default is one_time

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -associated_asset_ids
Display Id(s) of the Assets to associate to contract.

Note:  Not applicable to contract type Software (3)

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -attachments
Contract attachments.
The total size of these attachments cannot exceed 15MB.

```yaml
Type: FileInfo[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
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
