---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceRequestApproval

## SYNOPSIS
Returns a Freshservice Service Request Approval.

## SYNTAX

### default (Default)
```
Get-FreshServiceRequestApproval [-display_id] <Int64> [[-per_page] <Int32>] [[-page] <Int32>]
 [<CommonParameters>]
```

### id
```
Get-FreshServiceRequestApproval [-display_id] <Int64> [-id] <Int64> [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Service Request Approval via REST API.

https://api.freshservice.com/#view_all_ticket_approvals
https://api.freshservice.com/#view_a_ticket_approval

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceRequestApproval -display_id 221
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

List all Freshservice Request Approvals.

### EXAMPLE 2
```
Get-FreshServiceRequestApproval -display_id 221 -id 21000143868
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
email_content   : \<p\>Hi Alex, \<br\>
                    \<br\>A new Service Request has been submitted for your approval.\<br\>
                    \<br\>
                    \<b\>Request Summary\</b\>
                    \<br\>
                    \<br\>
                    \<b\>Request for Alex : Windows Laptop (#SR-221)\</b\>
                    \<br\>
                    \<br\>
                    \<b\>Requester:\</b\> Alex\<br\>
                    \<b\>Priority:\</b\> Medium
                    \<br\>
                    \<b\>Status:\</b\> Open
                \</p\>
                \<p\>
                    \<br\>
                \</p\>
                \<p\>
                    \<br\>

                    \<a href="mailto:helpdesk@its-fine.freshservice.com?subject=RE:%20Request%20for%20Approval%20-%20%5B#SR-221%5
                D%20Request for Alex : Windows Laptop&amp;body=Approve%0A%0A%0A%5B%23SR-221%5D%3A504523%3Afs%202100014386
                8%3A504523%3Afs%0A"\>Approve\<br\>\<br\>\</a\>
                    \<a href="mailto:helpdesk@its-fine.freshservice.com?subject=RE:%20Request%20for%20Approval%20-%20%5B#SR-221%5
                D%20Request for Alex : Windows Laptop&amp;body=Reject%3Cbr%3EENTER%20COMMENT%20HERE"\>Reject\</a\>

                    \<br\>
                    \<br\>For Approval Link \<a href="https://its-fine.freshservice.com/public/approvals/token?value=eyJ0eXAiOiJKV1
                QiLCJhbGciOiJIUzI1NiJ9.WzIxMDAwMTQzODY4LGZhbHNlLDE2ODIzNjQ1Nzhd.cNlySWJKtAquchuVhebolmXxF4Igdhu4GRWKk8SQcAM"\>
                        \<b\>click here\</b\>
                    \</a\>
                    \<br\>You can also approve/reject the request by replying to this email with only one of the following words
                as the
                    first line of the mail -\<span\>
                        \<strong\> 'Approved, Approve, Rejected, Reject.'\</strong\>
                    \</span\>
                    \<br\>While replying to the email, please add additional remarks in the second line of the email(Remarks are
                mandatory
                    while rejecting the request).\<br\>To see the complete request \<a href="https://its-fine.freshservice.com/publ
                ic/tickets/8a4a2a27e150207377a1db9073d32f5c7367183075830ef00b398e8156ab0736"\>
                        \<b\>click here\</b\>
                    \</a\>
                    \<br\>
                    \<br\>Regards,
                    \<br\>its-fine
                \</p\>
latest_remark   :

Return a specific Freshservice Request Approval.

## PARAMETERS

### -display_id
Unique id of the Service Request.

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
Parameter Sets: id
Aliases:

Required: True
Position: 2
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
Position: 3
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
Position: 4
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
