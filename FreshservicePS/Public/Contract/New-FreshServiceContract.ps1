<#
.SYNOPSIS
    Creates Freshservice contract.

.DESCRIPTION
    Creates Freshservice contract via REST API.

    https://api.freshservice.com/#create_a_contract

.PARAMETER name
    Name of the Contract

.PARAMETER description
    Description of the Contract

.PARAMETER vendor_id
    Unique id of the Vendor

.PARAMETER auto_renew
    True (1) if the contract is set to Auto Renew. Default is False (0)

.PARAMETER notify_expiry
    True (1) if the expiry notification is set up for the contract. Default is False (0)

.PARAMETER notify_before
    Number of days before contract expiry date when the expiry notifications need to be sent. Cannot exceed 365 days

.PARAMETER approver_id
    Unique id of the agent who needs to approve the contract. Not mandatory for software contracts

.PARAMETER start_date
    Start date of the contract. Not mandatory for software contracts

.PARAMETER end_date
    End date of the contract. Not mandatory for software contracts

.PARAMETER cost
    Cost of the contract. Not mandatory for software contracts

.PARAMETER status
    Status of the contract. Allowed values: draft, pending, approved, active, expired, rejected, cancelled, pending_esign, esigned, decline_esignREAD ONLY

.PARAMETER contract_number
    User entered ID for the contract. This has to be unique.

.PARAMETER contract_type_id
    Unique id of the contract type. Cannot be changed once set.

    1 = Lease
    2 = Maintenance
    3 = Software License
    4 = Warranty

.PARAMETER visible_to_id
    ID of agent group in Freshservice to control visibility of the contract

.PARAMETER notify_to
    List of email addresses to notify expiry

.PARAMETER custom_fields
    Key value pairs containing the names and values of custom fields

.PARAMETER custom_fields
    Key value pairs containing the names and values of item cost details

.PARAMETER billing_cycle
    Represents the contract term period. Default is one_time

.PARAMETER software_id
    Unique id of the software.

.PARAMETER item_cost_details
    Key value pairs containing the names and values of item cost details. See helper function New-FreshServiceContractItem.

.PARAMETER associated_asset_ids
    Display Id(s) of the Assets to associate to contract.

    Note:  Not applicable to contract type Software (3)

.PARAMETER attachments
    Contract attachments. The total size of these attachments cannot exceed 15MB.

.EXAMPLE
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

    New-FreshserviceContract @contractParams

    Creates a new Freshservice Contract.

.NOTES
    This module was developed and tested with Freshservice REST API v2.
#>
function New-FreshServiceContract {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]

    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the Contract'
        )]
        [string]$name,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Description of the Contract'
        )]
        [string]$description,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the Vendor'
        )]
        [long]$vendor_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'True (1) if the contract is set to Auto Renew. Default is False (0)'
        )]
        [boolean]$auto_renew,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'True (1) if the expiry notification is set up for the contract. Default is False (0)'
        )]
        [boolean]$notify_expiry,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Number of days before contract expiry date when the expiry notifications need to be sent. Cannot exceed 365 days'
        )]
        [long]$notify_before,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the agent who needs to approve the contract. Not mandatory for software contracts'
        )]
        [long]$approver_id,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Start date of the contract. Not mandatory for software contracts'
        )]
        [datetime]$start_date,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'End date of the contract. Not mandatory for software contracts'
        )]
        [datetime]$end_date,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Cost of the contract. Not mandatory for software contracts'
        )]
        [long]$cost,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'User entered ID for the contract. This has to be unique. '
        )]
        [string]$contract_number,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Unique id of the contract type and it cannot be updated'
        )]
        [long]$contract_type_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of agent group in Freshservice to control visibility of the contract'
        )]
        [long]$visible_to_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Unique id of the software'
        )]
        [long]$software_id,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'List of email addresses to notify expiry'
        )]
        [string[]]$notify_to,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of custom fields'
        )]
        [hashtable]$custom_fields,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Key value pairs containing the names and values of item cost details'
        )]
        [object[]]$item_cost_details,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Represents the contract term period. Default is one_time'
        )]
        [ValidateSet('monthly', 'quarterly', 'half_yearly', 'annual', 'one_time')]
        [string]$billing_cycle,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Display Id(s) of the Assets to associate to contract.'
        )]
        [int[]]$associated_asset_ids,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Ticket attachments. The total size of these attachments cannot exceed 15MB.',
            ValueFromPipelineByPropertyName = $true
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
        [System.IO.FileInfo[]]$attachments
    )
    begin {

        $PrivateData  = $MyInvocation.MyCommand.Module.PrivateData

        if (!$PrivateData.FreshserviceBaseUri) {
            throw "No connection found!  Setup a new Freshservice connection with New-FreshServiceConnection and then Connect-FreshService. Set a default connection with New-FreshServiceConnection or Set-FreshConnection to automatically connect when importing the module."
        }

        $uri = [System.UriBuilder]('{0}/contracts' -f $PrivateData['FreshserviceBaseUri'])

    }
    process {

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
                    Method      = 'POST'
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

                if ($result.Content) {
                    $content = $result.Content |
                                    ConvertFrom-Json

                    #API returns singluar or plural property based on the number of records, parse to get property returned.
                    $objProperty = $content[0].PSObject.Properties.Name
                    Write-Verbose -Message ("Returning {0} property with count {1}" -f $objProperty, $content."$($objProperty)".Count)
                    $content."$($objProperty)"
                }

            }
        }
        catch {
            Throw $_
        }

    }
    end {}
}
