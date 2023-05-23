<#
.SYNOPSIS
    Updates a Freshservice contract.

.DESCRIPTION
    Updates a Freshservice Contract via REST API.

    https://api.freshservice.com/#update_a_contract

.PARAMETER id
    Unique Id of the Contract.

.PARAMETER name
    Name of the Contract

.PARAMETER description
    Description of the Contract

.PARAMETER vendor_id
    Unique id of the Vendor

.PARAMETER auto_renew
    Contract is set to Auto Renew.

    0 - False (Default)
    1 - True

.PARAMETER notify_expiry
    The expiration notification is set up for the contract.

    0 - False (Default)
    1 - True

.PARAMETER notify_before
    Number of days before contract expiry date when the expiry notifications need to be sent. Cannot exceed 365 days.

.PARAMETER approver_id
    Unique id of the agent who needs to approve the contract. Not mandatory for software contracts.

.PARAMETER start_date
    Start date of the contract. Not mandatory for software contracts.

.PARAMETER end_date
    End date of the contract. Not mandatory for software contracts.

.PARAMETER cost
    Cost of the contract. Not mandatory for software contracts.

.PARAMETER contract_number
    User entered ID for the contract. This has to be unique.

.PARAMETER contract_type_id
    Unique id of the contract type and it cannot be updated

.PARAMETER visible_to_id
    ID of agent group in Freshservice to control visibility of the contract

.PARAMETER notify_to
    List of email addresses to notify expiry

.PARAMETER custom_fields
    Key value pairs containing the names and values of custom fields

.PARAMETER billing_cycle
    Represents the contract term period. Default is one_time

.PARAMETER attachments
    Add attachment to Contract.

.PARAMETER software_id
    Unique id of the software and it cannot be updated

.PARAMETER item_cost_details
    Item cost detail is an object array containing item cost details. See helper function: New-FreshServiceContractItem

.PARAMETER SubmitForApproval
    This operation allows you to submit a contract for approval in the account.

.PARAMETER Approve
    This operation allows you to approve a contract in the account.

.PARAMETER Reject
    This operation allows you to reject a contract in the account.

.PARAMETER reason_to_reject
    Reason for contract rejection.

.EXAMPLE
    Set-FreshServiceContract -id 8 -description 'Updated contract for MS Office'

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

.EXAMPLE
    Set-FreshServiceContract -id 8 -attachment C:\Scripts\Attachments\attachment.txt

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

.EXAMPLE
    Set-FreshServiceContract -id 8 -SubmitForApproval

    id status
    -- ------
    8 success 200

    Submit a contract for Approval.

.EXAMPLE
    Set-FreshServiceContract -id 8 -Approve

    id status
    -- ------
    8 success 200

    Approve a contract submitted for approval.

.EXAMPLE
    Set-FreshServiceContract -id 24 -Reject -reason_to_reject 'Too much money'

    id status
    -- ------
    24 success 200

    Reject a contract submitted for approval.  Reason is mandatory.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function Set-FreshServiceContract {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique Id of the contract',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique Id of the contract',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'SubmitApproval',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique Id of the contract',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Approve',
            Position = 0
        )]
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique Id of the contract',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Reject',
            Position = 0
        )]
        [long]$id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the Contract',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 1
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the Contract',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 3
        )]
        [string]$description,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the Vendor',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 4
        )]
        [long]$vendor_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'True (1) if the contract is set to Auto Renew. Default is False (0)',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 5
        )]
        [boolean]$auto_renew,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'True (1) if the expiry notification is set up for the contract. Default is False (0)',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 6
        )]
        [boolean]$notify_expiry,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of days before contract expiry date when the expiry notifications need to be sent. Cannot exceed 365 days',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 7

        )]
        [long]$notify_before,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the agent who needs to approve the contract. Not mandatory for software contracts',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 8
        )]
        [long]$approver_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Start date of the contract. Not mandatory for software contracts',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 9
        )]
        [datetime]$start_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'End date of the contract. Not mandatory for software contracts',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 10
        )]
        [datetime]$end_date,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Cost of the contract. Not mandatory for software contracts',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 11
        )]
        [long]$cost,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'User entered ID for the contract. This has to be unique. ',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 12
        )]
        [string]$contract_number,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the contract type and it cannot be updated',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 13
        )]
        [long]$contract_type_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of agent group in Freshservice to control visibility of the contract',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 14
        )]
        [long]$visible_to_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the software',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 15
        )]
        [long]$software_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'List of email addresses to notify expiry',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 16
        )]
        [string[]]$notify_to,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of custom fields',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 17
        )]
        [hashtable]$custom_fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of item cost details',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 18
        )]
        [object[]]$item_cost_details,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Represents the contract term period. Default is one_time',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 19
        )]
        [ValidateSet('monthly', 'quarterly', 'half_yearly', 'annual', 'one_time')]
        [string]$billing_cycle,
        # [Parameter(
        #     Mandatory = $false,
        #     HelpMessage = 'Unique id of the software',
        #     ValueFromPipelineByPropertyName = $true,
        #     ParameterSetName = 'default',
        #     Position = 20
        # )]
        # [long[]]$associated_asset_ids,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket attachments. The total size of these attachments cannot exceed 15MB.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'default',
            Position = 21
        )]
        [ValidateScript({
            if(-Not ($_ | Test-Path) ){
                throw ("Cannot find path {0} because it does not exist." -f $_.FullName)
            }
            if(-Not ($_ | Test-Path -PathType Leaf) ){
                throw ("{0} is not a valid file. Folder paths are not allowed." -f $_.FullName)
            }
            if($_.Length/1MB -gt 15 ) {
                throw ("{0} exceeds the file size limit. Files must be under 15MB." -f $_.FullName)
            }
            return $true
        })]
        [System.IO.FileInfo[]]$attachments,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'This operation allows you to approve a contract in the account.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'SubmitApproval',
            Position = 1
        )]
        [Alias('submit_for_approval')]
        [switch]$SubmitForApproval,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'This operation allows you to approve a contract in the account.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Approve',
            Position = 1
        )]
        [switch]$Approve,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'This operation allows you to reject a contract in the account.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Reject',
            Position = 1
        )]
        [switch]$Reject,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Reason for rejection.',
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Reject',
            Position = 2
        )]
        [string]$reason_to_reject
    )
    begin {
        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

    }
    process {

        $qry = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
        $uri = [System.UriBuilder]('{0}/contracts' -f $PrivateData['FreshserviceBaseUri'])

        if ($PSBoundParameters.ContainsKey('id')) {
            $uri.Path = "{0}/{1}" -f $uri.Path, $id
            [void]$PSBoundParameters.Remove('Id')
        }

        if ($PSBoundParameters.ContainsKey('SubmitForApproval')){
            $qry.Add('operation', 'submit-for-approval')
            [void]$PSBoundParameters.Remove('SubmitForApproval')
        }

        if ($PSBoundParameters.ContainsKey('approve')){
            $qry.Add('operation', 'approve')
            [void]$PSBoundParameters.Remove('approve')
        }

        if ($PSBoundParameters.ContainsKey('reject')){
            $qry.Add('operation', 'reject')
            [void]$PSBoundParameters.Remove('reject')
        }

        $uri.Query = $qry.ToString()

        $jsonBody = @{}
        $PSBoundParameters.keys.where{
            $PSItem -notin $PrivateData.FreshserviceBodyExclusions
        }.foreach{
            if ( 'contract_type','status' -contains $PSItem ) {
                $jsonBody[$PSItem.ToLower()] = ($PSBoundParameters[$PSItem]).ToLower()
            }
            elseif ($PSBoundParameters[$PSItem] -is [datetime]) {
                $jsonBody[$PSItem.ToLower()] = Get-Date -Date $PSBoundParameters[$PSItem] -Format "o"
            }
            else {
                $jsonBody[$PSItem.ToLower()] = $PSBoundParameters[$PSItem]
            }
        }

        try {
            if ($PSCmdlet.ShouldProcess($uri.Uri.AbsoluteUri)) {

                $params = @{
                    Uri         = $uri.Uri.AbsoluteUri
                    Method      = 'PUT'
                    ErrorAction = 'Stop'
                }

                if ( $attachments ) {
                    if ( $PSVersionTable.PSVersion.Major -lt 7 ) {
                        Write-Warning "Sorry! Attachments are not currently supported in versions earlier than Powershell 7.x due to multipart/form-data requirements. Attachment parameter will be ignored."
                        $jsonBody.Remove('attachments')
                        $params.Body = $jsonBody | ConvertTo-Json
                    }
                    else {
                        #Invoke-WebRequest -Form is supported in 7+
                        $jsonBody.Add('attachments[]',$attachments)
                        $jsonBody.Remove('attachments')
                        $params.Form = $jsonBody
                    }
                }
                else {
                    $params.Body = $jsonBody | ConvertTo-Json
                }

                $result = Invoke-FreshworksRestMethod @params

                if ( $SubmitForApproval -or $Approve -or $Reject ) {

                    [PSCustomObject]@{
                        id = $id
                        status = "success {0}" -f $result.StatusCode
                    }

                }
                else {

                    $content = $result.Content |
                                    ConvertFrom-Json

                    if ($content) {
                        #API returns singluar or plural property based on the number of records, parse to get property returned.
                        $objProperty = $content[0].PSObject.Properties.Name
                        Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                        $content."$($objProperty)"
                    }

                }

            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
