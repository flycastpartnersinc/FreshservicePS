---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceContract

## SYNOPSIS
Returns a Freshservice Contract.

## SYNTAX

### default (Default)
```
Get-FreshServiceContract [-per_page <Int32>] [-page <Int32>] [<CommonParameters>]
```

### attachments
```
Get-FreshServiceContract [-Id] <Int64> [-attachments] [<CommonParameters>]
```

### assets
```
Get-FreshServiceContract [-Id] <Int64> [-associated_assets] [<CommonParameters>]
```

### id
```
Get-FreshServiceContract [-Id] <Int64> [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Contract via REST API.

https://api.freshservice.com/#view_a_contract

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceContract
```

id                    : 6
name                  : Microsoft O365 Contract V2
description           : Test contract from API
vendor_id             : 18000414331
auto_renew            : True
notify_expiry         : True
notify_before         : 30
approver_id           : 18012453181
start_date            : 9/21/2022 11:21:24 PM
end_date              : 9/21/2023 11:21:24 PM
cost                  : 1234
status                : draft
contract_number       : MSFT2
contract_type_id      : 3
visible_to_id         : 18000144649
notify_to             : {john.smith@company.com}
custom_fields         :
software_id           : 18001038620
license_type          : volume
billing_cycle         : annual
license_key           :
item_cost_details     : {@{id=18000043113; item_name=Installation; pricing_model=per_unit; cost=200; comments=;
                        count=1; created_at=9/21/2022 11:21:25 PM; updated_at=9/21/2022 11:21:25 PM}}
future_contract_id    :
has_associated_assets : False
has_attachments       : False
expiry_notified       : False
requester_id          : 18012453181
delegatee_id          :
created_at            : 9/21/2022 12:56:44 PM
updated_at            : 9/21/2022 11:21:25 PM

id                    : 5
name                  : Microsoft O365 Contract
description           : Test contract from API
vendor_id             : 18000414331
auto_renew            : True
notify_expiry         : True
notify_before         : 30
approver_id           : 18012453181
start_date            : 9/19/2022 7:56:40 PM
end_date              : 9/19/2023 7:56:40 PM
cost                  : 1500
status                : draft
contract_number       : MSFT1
contract_type_id      : 3
visible_to_id         : 18000144649
notify_to             : {john.smith@company.com}
custom_fields         :
software_id           : 18001038620
license_type          : volume
billing_cycle         : one_time
license_key           :
item_cost_details     : {@{id=18000043084; item_name=Installation; pricing_model=per_unit; cost=200; comments=;
                        count=1; created_at=9/19/2022 7:56:41 PM; updated_at=9/19/2022 7:56:41 PM}}
future_contract_id    :
has_associated_assets : False
has_attachments       : False
expiry_notified       : False
requester_id          : 18012453181
delegatee_id          :
created_at            : 9/19/2022 7:56:41 PM
updated_at            : 9/19/2022 7:56:41 PM

Returns all Freshservice Contracts.

### EXAMPLE 2
```
Get-FreshServiceContract -Id 5
```

id                    : 5
name                  : Microsoft O365 Contract
description           : Test contract from API
vendor_id             : 18000414331
auto_renew            : True
notify_expiry         : True
notify_before         : 30
approver_id           : 18012453181
start_date            : 9/19/2022 7:56:40 PM
end_date              : 9/19/2023 7:56:40 PM
cost                  : 1500
status                : draft
contract_number       : MSFT1
contract_type_id      : 3
visible_to_id         : 18000144649
notify_to             : {john.smith@company.com}
custom_fields         :
software_id           : 18001038620
license_type          : volume
billing_cycle         : one_time
license_key           :
item_cost_details     : {@{id=18000043084; item_name=Installation; pricing_model=per_unit; cost=200; comments=;
                        count=1; created_at=9/19/2022 7:56:41 PM; updated_at=9/19/2022 7:56:41 PM}}
future_contract_id    :
has_associated_assets : False
has_attachments       : False
expiry_notified       : False
requester_id          : 18012453181
delegatee_id          :
created_at            : 9/19/2022 7:56:41 PM
updated_at            : 9/19/2022 7:56:41 PM

Return a Freshservice Contract by Id.

## PARAMETERS

### -Id
Unique id of the FreshService Contract.

```yaml
Type: Int64
Parameter Sets: attachments, assets, id
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -associated_assets
View information about all the associated assets of a contract.

```yaml
Type: SwitchParameter
Parameter Sets: assets
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -attachments
View information about all the associated attachments of a contract.

```yaml
Type: SwitchParameter
Parameter Sets: attachments
Aliases:

Required: True
Position: 2
Default value: False
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
